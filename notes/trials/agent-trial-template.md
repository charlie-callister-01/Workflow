# Agent trial: <agent> on <project>

Guide and findings sheet for trying a second agent beside Claude Code. Copy this file into the trial project as `.scratch/<agent>-trial.md` and fill it in there as you go. When the trial ends, copy a cleaned-up summary (no project details) back to the Workflow repo as `notes/research/YYYY-MM-DD <agent> trial.md`, set the verdict in `notes/trials.md`, and add a line to roadmap decision ticket 06.

First use: Antigravity CLI (`agy`), for the trial "AGENTS.md as the main file" in `notes/trials.md`.

## 1. Setup (once)

**Before you start:**
- **The workflow is in the project.** Machine set up (toolbox cloned, global skills installed) and the project primed with `/setup-workflow`, or `/refit-workflow` if it had its own workflow: see `SETUP.md` in the Workflow repo. The project has `CLAUDE.md`, `.claude/skills/` and `docs/agents/workflow-settings.md`, and that PR is merged.
- **The agent is installed.** Antigravity CLI (`agy`): install and sign in following Google's guide, https://codelabs.developers.google.com/antigravity-cli-hands-on. Check with `agy --version`.

Antigravity reads `AGENTS.md` (and `GEMINI.md`, `.agents/rules/*.md`) and skills from `.agents/skills/<name>/SKILL.md`. It does not read `CLAUDE.md` or `.claude/skills/`. Its global files live in `~/.gemini/`.

1. **Instruction file.** If the project still has `CLAUDE.md` only, run `/refit-workflow` (it moves the file), or switch it by hand on a `chore/` branch, then `/ship` it:
   ```powershell
   git mv CLAUDE.md AGENTS.md
   git commit -m "chore(workflow): move CLAUDE.md to AGENTS.md"   # alone, so git records a rename
   [IO.File]::WriteAllText("$PWD\CLAUDE.md", "@AGENTS.md`n")   # no BOM, so Claude sees the import
   ```
   In `docs/agents/workflow-settings.md`, add `workflow_track: beta` under `workflow_version`. In a new Claude Code session, ask it a rule that's only in `AGENTS.md` (e.g. the branch naming) to check the import works.
2. **Skills for Antigravity, local only.** Copy the project's skills to where Antigravity looks, and keep the copy out of git:
   ```powershell
   New-Item -ItemType Directory -Force .agents\skills | Out-Null
   Copy-Item -Recurse -Force .claude\skills\* .agents\skills\
   Add-Content -Path .git\info\exclude -Value '.agents/'
   ```
   Re-copy whenever `.claude/skills/` changes. In `agy`, run `/skills reload`, then `/skills` to check they're listed.
3. **No second instruction file.** Don't add `GEMINI.md` or `.agents/rules/`; Antigravity combines every file it finds.
4. **Global rules.** Note anything in `~/.gemini/AGENTS.md`, `~/.gemini/GEMINI.md` or `~/.gemini/config/rules/` here; it applies to every session and can skew the results:
   - <none / what's there>

**Rollback:** `git rm CLAUDE.md`, `git mv AGENTS.md CLAUDE.md`, remove `workflow_track: beta`, delete `.agents/`.

## 2. Each session

- Start and end the same way in both agents: `/start-session` ... `/end-session`.
- The LOG line carries the agent: `## YYYY-MM-DD [antigravity]: ...` or `## YYYY-MM-DD [claude]: ...`. Tell the agent if it forgets.
- Add a row below for every session, especially when you switch agents.

| Date | Agent | What I did | Handover friction (what it missed, redid or got wrong from the other agent's work) |
|---|---|---|---|
| | | | |

## 3. Skills

One row per skill used in Antigravity. Typical breakers: Claude tool names (`AskUserQuestion`, `Agent`, `Artifact`), `mattpocock-skills:*` plugin calls, `gh`/`az` assumptions, PowerShell vs bash.

| Skill | Works / partly / broken | Why | Fix idea |
|---|---|---|---|
| start-session | | | |
| end-session | | | |
| ship | | | |

## 4. Instruction file

- Did Antigravity follow `AGENTS.md`? Rules it ignored or misread:
  - 
- Lines that only make sense to one agent (candidates for a per-agent section):
  - 
- Did Claude Code behave the same as before the switch?
  - 

## 5. Markers

- Cost or usage per session where `agy` shows it, against Claude for similar work:
- Corrections: how often you had to stop or redirect it:
- Only possible in one agent (features, tools, speed):
- Anything else worth measuring (see roadmap ticket 21):

## 6. Verdict (for decision 06)

- Keep `AGENTS.md` as the main file? **keep / tune / drop**, because:
- Should the toolbox install `.agents/skills/` (or a neutral skills folder) for other agents? Why:
- Run the two agents side by side, one per kind of task, or not at all? Why:
- What 06 should decide next:
