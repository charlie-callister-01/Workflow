# Agents, instruction files and skill folders

## Question

For ticket 06 (multi-agent projects): which instruction file each coding agent reads, which skill folders it loads, whether it reads a sibling folder, whether one agent can call another from its shell, and which `SKILL.md` frontmatter keys port. Plus the owner's first impressions of Antigravity CLI from the `AGENTS.md` trial (decision 0006), and how Matt Pocock's skills reach other agents.

## Sources

All read 2026-11-24 by subagents; vendor docs, not blog posts. "Unconfirmed" = not found in a primary source.

- Claude Code: [Memory](https://code.claude.com/docs/en/memory), [Skills](https://code.claude.com/docs/en/skills)
- Codex: [AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md), [Build skills](https://learn.chatgpt.com/docs/build-skills), [Non-interactive](https://developers.openai.com/codex/noninteractive)
- Cursor: [Rules](https://cursor.com/docs/context/rules), [Skills](https://cursor.com/docs/context/skills), [CLI](https://cursor.com/docs/cli/using)
- GitHub Copilot: [Custom instructions support](https://docs.github.com/en/copilot/reference/custom-instructions-support), [CLI skills](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-skills), [VS Code settings](https://code.visualstudio.com/docs/copilot/reference/copilot-settings), [VS Code agent skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- Gemini CLI: [GEMINI.md](https://geminicli.com/docs/cli/gemini-md/), [Skills](https://geminicli.com/docs/cli/skills/), [Headless](https://geminicli.com/docs/cli/headless/)
- Antigravity: [Customization discovery](https://antigravity.google/docs/customization-discovery), [Skills](https://antigravity.google/docs/skills.md), [Headless CLI](https://antigravity.google/docs/cli/headless.md)
- [Agent Skills specification](https://agentskills.io/specification)
- [mattpocock/skills README](https://github.com/mattpocock/skills) and its `setup-matt-pocock-skills` skill

## What I learned

### Instruction file

| Agent | Reads `AGENTS.md`? | Notes |
|---|---|---|
| Claude Code | Yes (v2.1.277+), but only when there is no `CLAUDE.md` in the folder or above | A setting loads both; `@AGENTS.md` import still works |
| Codex CLI | Yes | `~/.codex/AGENTS.md`, then git root down to cwd; 32 KiB cap |
| Cursor | Yes, root and subfolders | CLI also reads root `CLAUDE.md` |
| Copilot CLI / cloud agent | Yes (also `CLAUDE.md`, `GEMINI.md`) | |
| Copilot in VS Code | Yes, root | `chat.useClaudeMdFile` on by default |
| Gemini CLI | No (`GEMINI.md`) | One user setting: `context.fileName: ["AGENTS.md","GEMINI.md"]` |
| Antigravity | Yes (or `GEMINI.md`) | Workspace and parents up to the repo root |

### Skill folders

| Agent | Project | User | Reads another vendor's folder |
|---|---|---|---|
| Claude Code | `.claude/skills` | `~/.claude/skills` | `.agents/skills` not documented |
| Codex | `.agents/skills` | `~/.agents/skills` | |
| Cursor | `.agents/skills`, `.cursor/skills` | `~/.agents/skills`, `~/.cursor/skills` | Yes: `.claude/skills`, `.codex/skills` |
| Copilot CLI / cloud | `.github/skills`, `.claude/skills`, `.agents/skills` | `~/.copilot/skills`, `~/.agents/skills` | Yes |
| Copilot in VS Code | `.github/skills` | `~/.copilot/skills` | Only in the deprecated Local harness |
| Gemini CLI | `.gemini/skills` or `.agents/skills` | `~/.gemini/skills`, `~/.agents/skills` | |
| Antigravity | `.agents/skills` | `~/.gemini/config/skills` | |

`.agents/skills` is the shared folder for everyone except Claude Code. Cursor and Copilot CLI read both `.claude/skills` and `.agents/skills`, so filling both may show them every skill twice (unconfirmed whether they de-duplicate by name).

### Test: one skill folder plus a junction (2026-11-24)

Layout tested on Windows 11: the skill only in `.agents/skills`, `.claude/skills` a directory junction to it (`mklink /J`, no admin).

| Agent | Result |
|---|---|
| Claude Code 2.1.331 (`claude -p`) | Lists the skill through a junction (whole folder, or one skill folder); once only; two real same-name copies also listed once. Docs: a skill entry "can be a symlink… loads the skill once even if several locations point at the same target". Past issues: #41177 (junctioned skill listed but failed to invoke, closed), so invoke one once in a real session. |
| Copilot CLI 1.0.104 (`copilot skill list`, `copilot -p -s`) | Reads through the junction; shows the skill **once** in every layout, even two real same-name copies (de-duplicates by name; observed, not documented). |
| Codex | Docs: reads `.agents/skills`, supports symlinked skill folders, does not de-duplicate same names; doesn't read `.claude/skills` (unconfirmed). Junctions unconfirmed. |
| Cursor | Reads both folders; de-duplication and junctions unconfirmed (forum: CLI symlink discovery bug, fixed). |
| Gemini CLI, Antigravity | Read `.agents/skills`; junctions unconfirmed (Gemini: higher-precedence location wins on a name clash). |

Git (Git for Windows 2.56, `core.symlinks=false`): git does not see a junction as a link; `git add -A` stages the skill twice, so the junction folder **must be gitignored**. `git clean -fdX` removed the ignored junction and left the target intact. Open git-for-windows issues where git follows a junction and deletes the target: #6545 (`git worktree remove`), #4361 (checkout or merge), #5320 (`git clean`, duplicate of #3358/#4383). So the script recreates the junction on every run and the real files sit only in `.agents/skills`.

### Sibling folders

Only Claude Code (`--add-dir`: skills yes, `CLAUDE.md` with an env var, `AGENTS.md` never) and Antigravity (`--add-dir` folders count as workspace) document loading customisations from another folder. Others: unconfirmed or write access only. So a session in home must read the project's `AGENTS.md` itself (ticket 36).

### One agent calling another

Every agent has a non-interactive mode: `claude -p`, `codex exec` (read-only sandbox by default), `agent -p` (Cursor), `copilot -p`, `gemini -p`, `agy -p` (reported hangs when piped: GitHub issues #76, #318).

### Frontmatter

Portable: `name`, `description` (required), `license`, `compatibility`, `metadata`; `allowed-tools` experimental. Claude-only: `when_to_use`, `argument-hint`, `disable-model-invocation` (also Cursor, VS Code), `user-invocable`, `model`, `effort`, `context`, `agent`, `hooks`, `paths` (also Cursor). Codex turns off auto-invocation in `agents/openai.yaml`, not frontmatter. Claude.ai and the API reject non-spec keys; whether CLI agents ignore them is undocumented.

### Matt Pocock's skills

MIT; layout `skills/<group>/<name>/SKILL.md` (`engineering`, `productivity`). Installs: Claude Code, Codex and Copilot as a plugin (self-updating); Gemini CLI via `gemini skills install ... --path skills/engineering`; any other agent via `npx skills@latest add mattpocock/skills -a <agent>` (copies, updated by hand). "Pick one per agent, because installing both gives you every skill twice." README: the skills "work with any model". No releases published; `CHANGELOG.md` and changesets in the repo. His `setup-matt-pocock-skills` writes its block into `CLAUDE.md` if present, else `AGENTS.md`.

### Antigravity CLI trial (owner, preliminary)

From the decision 0006 trial on a personal project; first impressions, not a full write-up:

- Decent overall; a little slow, but ran well and followed the shared `AGENTS.md`.
- Main problem: it asked for permission too often, then waited too long for an answer, and the session "exploded" (ran away or broke down while waiting). Likely its permission model and how it treats wildcard (`*`) allow rules differ from Claude Code's, so allow-lists written for Claude don't carry over.
- Open: whether `.agents/skills/` loaded, and a fair permission setup for Antigravity before judging it further.

## What I might change

- Projects carry only `AGENTS.md`; agent-specific setup (Gemini's file name, permission allow-lists) lives with each agent in the home repo (ticket 06).
- Home's copy script writes `.agents/skills` for everyone plus `.claude/skills` for Claude Code; check the duplicate-listing risk in Cursor and Copilot CLI.
- Per-agent permission starters as part of home's harness; test Antigravity again with one.
- A cross-vendor second-opinion skill (`codex exec`) as a trial (05's `/interrogate`).
