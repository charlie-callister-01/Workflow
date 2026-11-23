# Loops, sandboxes and session hooks

## Question

1. What is the Ralph Wiggum loop, how is it run with Claude Code, what does it need, and when does it fail?
2. How do you keep an agent off the owner's PC: Claude Code's sandbox, dev containers, cloud sessions? What should a good sandbox ship with, and what suits a Windows user?
3. Could `/start-session` and `/end-session` be replaced or backed by hooks (SessionStart, SessionEnd, Stop, PreCompact, PreToolUse)? What can each hook do, what are the limits, and which parts must stay a skill? Example: enforce "never commit to `main`" with a PreToolUse hook.
4. Briefly: what does Claude Code expose for observability? (Measurement is in `2026-11-22 What can be measured.md`; not repeated here.)

## Sources

Read 2026-11-23.

- Geoffrey Huntley, [Ralph Wiggum as a "software engineer"](https://ghuntley.com/ralph/) (14 July 2025): origin of the technique.
- Anthropic, [`ralph-loop` plugin](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/ralph-loop) in `claude-plugins-official`: `README.md`, `hooks/hooks.json`, `hooks/stop-hook.sh` (read via `gh api`). Older links to `anthropics/claude-code/plugins/ralph-wiggum` now 404.
- Claude Code docs: [Keep Claude working toward a goal (`/goal`)](https://code.claude.com/docs/en/goal), [Hooks reference](https://code.claude.com/docs/en/hooks), [Hooks guide](https://code.claude.com/docs/en/hooks-guide) (block cap)
- Claude Code docs: [Sandboxing](https://code.claude.com/docs/en/sandboxing), [Choose a sandbox environment](https://code.claude.com/docs/en/sandbox-environments), [Development containers](https://code.claude.com/docs/en/devcontainer), [Use Claude Code in the cloud](https://code.claude.com/docs/en/claude-code-on-the-web), [Configure cloud environments](https://code.claude.com/docs/en/cloud-environments)
- Reference dev container: [`anthropics/claude-code/.devcontainer`](https://github.com/anthropics/claude-code/tree/main/.devcontainer) (`devcontainer.json`, `Dockerfile`, `init-firewall.sh`); [`@anthropic-ai/sandbox-runtime`](https://github.com/anthropics/sandbox-runtime)
- Claude Code docs: [Monitoring (OpenTelemetry)](https://code.claude.com/docs/en/monitoring-usage) (named only; see the earlier note)

## What I learned

### 1. The Ralph Wiggum loop

- **What it is.** Huntley: "in its purest form, Ralph is a Bash loop": `while :; do cat PROMPT.md | claude-code ; done`. The same prompt is fed again and again; each run starts with a **fresh context** and finds its state on disk (specs, a plan file, the code, git history). He calls it "deterministically bad in an undeterministic world": failures are predictable, so you tune the prompt.
- **What it needs** (Huntley):
  - **Specs**, one per file in a specs folder, written after a long conversation with the agent.
  - **`fix_plan.md`**, a prioritised to-do list the agent rewrites each loop (he often throws it away and regenerates it).
  - **One item per loop**, the most important one, to keep context small.
  - **Back-pressure**: build, tests, typecheck, static analysis for dynamic languages. Without them the loop happily ships broken code. Only one subagent runs build/tests at a time.
  - **`AGENT.md`**: how to build and run the project; Ralph appends brief learnings.
  - **"Signs"**: each time Ralph does something wrong, add a line to the prompt ("tuned like a guitar"). Includes rules like "don't assume it's unimplemented, search first" and "no placeholder implementations".
- **When it fails** (Huntley): it concludes from a search that code is missing and writes it twice; it leans towards "minimal and placeholder implementations"; it goes off track or leaves a codebase that doesn't compile, at which point the operator does `git reset --hard` and re-prompts. He would not use it "in an existing code base": it is for greenfield bootstrapping, and still needs "senior expertise" steering it.
- **Claude Code, official plugin.** `ralph-loop` (formerly `ralph-wiggum`) in `claude-plugins-official`. `/ralph-loop "<prompt>" --max-iterations N --completion-promise "DONE"`, and `/cancel-ralph`. It runs **inside the current session**: a **Stop hook** (`hooks/stop-hook.sh`) reads a state file `.claude/ralph-loop.local.md` (iteration, max, promise, session id, the prompt), checks the last assistant text for `<promise>DONE</promise>`, and if absent blocks the stop and feeds the same prompt back. The promise is an exact string match, so `--max-iterations` is "your primary safety mechanism". README "good for": clear success criteria, automatic verification (tests, linters), greenfield; "not good for": human judgement, design decisions, unclear success criteria, production debugging.
  - Difference from Huntley's loop (my reading of the hook): the plugin keeps **one context** that grows and gets compacted, rather than a fresh context each pass. State on disk still matters, but the "clean slate each loop" property is lost.
  - **Windows:** the hook is `bash` plus `jq` and `perl`. The README says it needs Git for Windows and may pick up WSL's `bash` by mistake; the fix is to point `hooks.json` at `C:/Program Files/Git/bin/bash.exe`.
- **Built-in alternative: `/goal <condition>`.** A session-scoped, **prompt-based Stop hook**: after each turn a small fast model judges the condition from the transcript (met / not yet / impossible). It cannot run commands itself, so the condition must be something Claude's own output shows ("`npm test` exits 0"). Clears on met, impossible, or an error you must fix; up to 4,000 characters; add "or stop after 20 turns" to bound it. Works with `claude -p "/goal ..."`. It doesn't change the permission mode, so unattended use means auto mode. Evaluator tokens are billed on top.
- **Stop-hook mechanics** (hooks reference): a Stop hook returns `{"decision":"block","reason":"..."}` (or exits 2) to keep Claude going. Input has `stop_hook_active` (true when already continuing because of a stop hook) and `last_assistant_message`. Claude Code caps it at **8 consecutive continuations with no tool call in between** (`CLAUDE_CODE_STOP_HOOK_BLOCK_CAP`), so a loop that keeps doing work is fine, a loop that just talks is cut off.
- **`/loop`** is different: it re-runs a prompt on a **time interval**, not until a condition holds.
- **What a loop needs, summed up:** a written finish condition checkable from output; specs and a plan on disk; tests or other back-pressure; an iteration cap; and a sandbox, because it runs unattended (next section).

### 2. Sandboxing agents off the owner's PC

The docs compare six approaches ([sandbox environments](https://code.claude.com/docs/en/sandbox-environments)):

| Approach | Isolates | Windows |
|---|---|---|
| Built-in sandboxed Bash tool (`/sandbox`, `sandbox.enabled`) | Bash, PowerShell and Monitor commands and their children; file tools, MCP servers and hooks run on the host | **Not on native Windows**: commands run unsandboxed. Works in WSL2 (bubblewrap + socat) |
| Sandbox runtime (`srt claude`, beta) | The whole Claude Code process | macOS, Linux, WSL2 |
| Dev container | Full dev environment in Docker | Docker Desktop + VS Code Dev Containers |
| Custom container / VM | Full environment / full OS | Any |
| Cloud session (claude.ai/code, `claude --cloud`) | Shell and file edits in an Anthropic-managed VM | No local setup at all |

- **Built-in sandbox.** Writes limited to the working directory, temp and added dirs; reads most of the machine (including `~/.ssh`) unless you add `filesystem.denyRead`; network via a local proxy against `network.allowedDomains` (empty to start). Auto-allow mode runs sandboxed commands without prompts. Escape hatch: Claude may retry with `dangerouslyDisableSandbox`; `allowUnsandboxedCommands: false` removes it ("strict sandbox mode"). Docker and Chromium don't work inside it. The docs say it alone is **not enough for unattended runs**.
- **The rule for unattended runs:** "Always run `--dangerously-skip-permissions` sessions inside a container, a VM, or the sandbox runtime", as a non-root user. Auto mode (a classifier) is a per-action check, not an isolation boundary.
- **Dev containers.** Add the feature `ghcr.io/anthropics/devcontainer-features/claude-code:1.0` to `.devcontainer/devcontainer.json`, or copy Anthropic's reference container (Dockerfile, a default-deny `init-firewall.sh` needing `NET_ADMIN`/`NET_RAW`, a volume for `~/.claude` with `CLAUDE_CONFIG_DIR`). Warning from the docs: with `--dangerously-skip-permissions` a malicious repo can still exfiltrate anything in the container, including Claude's own credentials; don't mount `~/.ssh` or cloud credentials; edits land in the bind-mounted repo on the host. Also works in GitHub Codespaces.
- **Cloud sessions.** Pro/Max/Team plans; counts against plan usage, no VM charge. Fresh Ubuntu 24.04 x86_64 VM per session, 4 vCPU, 16 GB RAM. Network **Limited** by default (package registries, GitHub, cloud SDKs), or None/Full. GitHub credentials never enter the VM (a proxy attaches them). **The proxy blocks GitHub GraphQL, so `gh pr` and `gh issue` fail; use `gh api` REST or the built-in GitHub tools.** Setup scripts (cloud only, cached ~7 days if under ~5 minutes) vs SessionStart hooks (every session, local and cloud). User-level `~/.claude/settings.json` hooks don't reach the cloud; repo `.claude/settings.json` does. `claude --teleport` pulls a session back to the terminal; `/autofix-pr` watches a PR. On native Windows, `--cloud` bundles uncommitted changes **without** filtering `.env`/key files (macOS/Linux/WSL do filter).
- **What a good sandbox ships with.** Anthropic's default cloud image is a fair checklist: Python (pip, uv, poetry, pytest, ruff, mypy), Node 20/21/22 (npm, pnpm, yarn, bun, eslint, prettier), Ruby, PHP, Java (Maven, Gradle), Go, Rust, C/C++ (cmake), Docker + compose, PostgreSQL 16 and Redis 7 (not started), **Chrome for Testing** (`CHROME_PATH`) for headless browser checks, and git, gh, jq, yq, ripgrep, tmux. Missing toolchains (e.g. .NET) go in a setup script. Plus: an egress allowlist, no host secrets, short-lived repo-scoped tokens, a non-root user, a pinned Claude Code version.
- **Best fit for a Windows user** (my judgement from the above):
  1. **Cloud sessions** for unattended or long work on GitHub repos: zero setup, real VM, credentials kept outside. Catch: `gh pr create` fails behind the proxy, and .NET/Windows-only builds don't fit the Linux VM.
  2. **Dev container via Docker Desktop (WSL2 backend)** for local unattended runs with the project's own toolchain; the reference firewall gives a default-deny network.
  3. **WSL2 + built-in sandbox** for everyday work with fewer prompts. Native Windows has no built-in sandbox at all.

### 3. Session hooks vs the session skills

What each hook can do (hooks reference):

| Hook | Fires | Can block? | Talks to the model? | Limits |
|---|---|---|---|---|
| **SessionStart** (`startup`, `resume`, `clear`, `compact`, `fork`) | Session begins or resumes; again after `/clear` or compaction | No | Yes: stdout or `additionalContext` added before the first prompt (cap 10,000 chars, longer goes to a file plus a 2,000-char preview) | Keep fast: first reply waits for it. `CLAUDE_ENV_FILE` persists env vars. `initialUserMessage` only in `-p` mode. `mcp_tool` hooks skipped at launch |
| **SessionEnd** (`clear`, `resume`, `logout`, `prompt_input_exit`, `other`) | Session ends | No | **No**: JSON output discarded | **1.5 s** budget by default (per-hook `timeout` raises it, max 60 s; or `CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS`). Cleanup and logging only |
| **Stop** | Claude finishes a turn (not on user interrupt; API errors fire StopFailure) | Yes: `decision: "block"` + `reason`, or exit 2 | Yes: the reason / `additionalContext` | `stop_hook_active`; 8-continuation cap |
| **PreCompact** (`manual`, `auto`) | Before compaction | Yes | Its stdout becomes **instructions for the compaction summary** | Blocking an auto-compact at the context limit fails the request |
| **PreToolUse** (matcher on tool name) | Before a tool call | Yes: `permissionDecision` `allow`/`deny`/`ask`/`defer`, or exit 2 | Deny reason shown to Claude | Optional `if` field, one permission rule per handler, e.g. `Bash(git commit *)`. On Windows match `Bash\|PowerShell`, or a Bash-only hook never fires without Git Bash |

General: hooks run with the user's full permissions and **outside** the built-in sandbox; in interactive sessions they wait for workspace trust, but in `-p`/SDK runs a repo's hooks run untrusted. Hook types: `command` (600 s default), `http`, `mcp_tool`, `prompt` (30 s), `agent` (experimental, 60 s). `"shell": "powershell"` runs a command hook in `pwsh.exe`, falling back to Windows PowerShell 5.1; write `$env:CLAUDE_PROJECT_DIR`, not bare `$CLAUDE_PROJECT_DIR`. Hooks live in `~/.claude/settings.json`, `.claude/settings.json`, `.claude/settings.local.json`, a plugin's `hooks/hooks.json`, or **skill/subagent frontmatter** (active only while that skill or agent runs). Debug with `claude --debug` (log in `~/.claude/debug/<session-id>.txt`).

**Mapping the session skills onto hooks:**

| Part | Hook? | Why |
|---|---|---|
| `/start-session` step 1: fetch, status, last commits, behind `origin/main`, newer remote branches | **Yes, SessionStart** (`startup\|resume`) | Pure facts; a script can print 5 lines as context. Must stay fast (`git fetch` over a slow network delays the first reply; could use `async`, but then nothing is injected) |
| Step 2: read STATUS/HANDOFF (lite: README + last 5 commits) | Partly | A hook could inject a short file; full reads are better left to the model on demand (10k cap, token cost every session) |
| Step 3: wayfinder map frontier | Possibly | Listing open tickets is scriptable; choosing which to propose isn't |
| Step 4: open PRs | Yes | `gh pr list` in the same script (slow-ish; network) |
| Steps 5-6: propose the next step, wait for the owner | **Skill** | Judgement and a conversation |
| `/end-session` step 1: facts from git and the platform | Could be a script the skill calls | |
| LOG line, STATUS/HANDOFF rewrite, phase re-slice, commit on a yes | **Skill** | Needs the model's summary of the session and the owner's yes. **SessionEnd can't talk to the model** and has 1.5 s, so it can't write these |
| Safety net if the owner forgets `/end-session` | SessionEnd | Could append a raw line (date, branch, last commit, `session_id`) to a log for the next session to notice. Not a substitute |
| Survive compaction | PreCompact + SessionStart `compact` | PreCompact stdout can tell the summariser "keep the ticket, branch and next step"; SessionStart `compact` can re-inject the branch facts |

So: hooks can **back** `/start-session` (deliver the facts automatically, so the skill only reasons), and can **guard** what the session skills only describe, but **neither skill can be replaced**: proposing, summarising and getting a yes need the model and the owner.

**Example: guard "never commit to `main`" with PreToolUse** (PowerShell 5.1, written for this note, untested):

`.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash|PowerShell",
        "hooks": [
          {
            "type": "command",
            "shell": "powershell",
            "command": "& \"$env:CLAUDE_PROJECT_DIR\\.claude\\hooks\\guard-main.ps1\""
          }
        ]
      }
    ]
  }
}
```

`.claude/hooks/guard-main.ps1`:

```powershell
# Reads the PreToolUse JSON on stdin; exit 2 blocks the call and shows stderr to Claude.
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
$data = [Console]::In.ReadToEnd() | ConvertFrom-Json
$cmd  = [string]$data.tool_input.command
if ($cmd -notmatch '\bgit\b[^;|&]*\b(commit|push|merge)\b') { exit 0 }
$branch = (git -C $data.cwd branch --show-current) 2>$null
if ($branch -eq 'main' -or $cmd -match '\bpush\b.*\b(main|HEAD:main)\b') {
  [Console]::Error.WriteLine("Blocked: never commit or push to main. Create a feature/, chore/ or fix/ branch first (AGENTS.md).")
  exit 2
}
exit 0
```

Notes: exit 2 overrides even an `allow` rule; matching both `Bash` and `PowerShell` matters on Windows. A simple `permissions.deny` rule such as `Bash(git push origin main)` covers the push case without a script, but only a hook can check the current branch before a commit. The real backstop is GitHub branch protection on `main`, which no local agent can bypass.

### 4. Observability (brief)

Covered in `2026-11-22 What can be measured.md`: transcripts under `~/.claude/projects/`, OpenTelemetry (`CLAUDE_CODE_ENABLE_TELEMETRY=1`), status line JSON, `/usage`, `/context`. New here: hook runs are logged only in the debug log (`--debug` / `--debug-file`); a `SessionEnd` hook gets `transcript_path`, so it can copy or summarise the transcript before the 30-day cleanup; cloud sessions expose `CLAUDE_CODE_REMOTE_SESSION_ID`, so a PR body can link to the run that made it; `/goal` reports turns, time and token spend.

## What the toolbox might change

1. **A small hooks kit as an option** (fits the harness note's idea 3): `templates/.claude/settings.json` plus `templates/.claude/hooks/guard-main.ps1` (PreToolUse, above) and `session-facts.ps1` (SessionStart: branch, behind/ahead, last 3 commits, open PR count, in under 10 lines). Trial on the beta track first; PowerShell 5.1 and `"shell": "powershell"`.
2. **Slim `/start-session`** once the SessionStart hook exists: the skill reads the injected facts instead of running git itself, and keeps only "where we are, next step, wait for a yes".
3. **Keep `/end-session` a skill.** Optionally add a SessionEnd hook that appends a raw "session ended without `/end-session`" line (date, branch, last commit) for `/start-session` to flag. Must finish in 1.5 s or set a `timeout`.
4. **A PreCompact hook** printing "keep: current ticket, branch, next step, open questions" so long sessions don't lose the thread.
5. **Loops: prefer `/goal` over a Ralph plugin** for this owner. It is built in, has no bash/jq dependency on Windows, and its condition maps onto a ticket's acceptance criteria ("all tests in X pass and `git status` is clean, or stop after 20 turns"). An `/implement` variant could set a goal per ticket. Huntley's fresh-context loop (`claude -p` in a PowerShell `while`) only for greenfield spikes, and only inside a sandbox.
6. **Sandbox guidance in `SETUP.md`/`CUSTOMISING.md`:** on native Windows there is no built-in sandbox, so unattended runs (`/goal` in auto mode, loops, `--dangerously-skip-permissions`) go to a cloud session or a dev container. A `templates/.devcontainer/` based on Anthropic's feature could be an optional knob.
7. **`/ship` in cloud sessions:** `gh pr create` fails behind the GitHub proxy (GraphQL blocked). If the toolbox is to work in the cloud, `platforms/github.md` needs a REST fallback (`gh api repos/{owner}/{repo}/pulls -f ...`) or to rely on the session's built-in PR tools.
8. **Recommend branch protection on `main`** in `SETUP.md` as the hard guard behind the hook and the prose rule.
