# Setup

How to put this workflow into a project. About 15 minutes.

## 1. Once per machine

0. **Clone this repo** to any folder: `gh repo clone charlie-callister-01/Workflow <folder>`. Projects never get a clone of it: the skills copy files into a project from this local clone, so `git pull` here before every `/setup-workflow` or `/refit-workflow`. If you move the clone, re-run step 5.
1. **Claude Code**, signed in.
2. **Matt Pocock's skills plugin.** In Claude Code: `/plugin install mattpocock-skills@claude-plugins-official`, then restart. If that marketplace is missing: `/plugin marketplace add mattpocock/skills`, then `/plugin install mattpocock-skills@mattpocock`. Skills are then called as `/mattpocock-skills:<name>`.
3. **Platform CLI.**
   - GitHub: `winget install GitHub.cli`, then `gh auth login`.
   - Azure DevOps: `winget install -e --id Microsoft.AzureCLI`, then `az login` and `az extension add --name azure-devops`. Open a new terminal afterwards so `az` is on PATH.
4. **Optional, for `pr-explainer`:** the Claude Code Artifact tool (claude.ai account) and the `artifact-design` / `artifact-diagramming` skills.
5. **Global skills:** from this repo, `powershell -File tools/Install-GlobalSkills.ps1`. Installs `/setup-workflow` and `/refit-workflow` into `~/.claude/skills/` and records where this repo is. Re-run after pulling changes.
6. **Optional, for skills on every project:** copy any other skill you always want into `~/.claude/skills/` instead of each project.

> Don't run `/mattpocock-skills:setup-matt-pocock-skills` on a primed repo: `/setup-workflow` already writes the `docs/agents/*` files his skills read. Re-run his only to switch issue tracker.

## 2. Per project

**Quick way:** open Claude Code in the project and run `/setup-workflow`. It does the steps below for you, and offers `/refit-workflow` if the repo already has its own workflow. The manual steps are kept for reference.

1. **Pick a preset and a platform** (`presets/`, `platforms/`). Unsure: `lite` + `github` for personal, `full` + `azure` for work.
2. **Copy the skills** you want into the project's `.claude/skills/`:
   - always: `start-session`, `end-session`, `open-pr`
   - optional: `pr-explainer`, `thermo-nuclear-code-quality-review`, `day-log`, `vault-note`
3. **Copy the templates:**
   - `templates/AGENTS.md` -> project root; fill in the `<...>` parts. Keep it under ~120 lines.
   - `templates/CLAUDE.md` -> project root, as is: the single line `@AGENTS.md`, so Claude Code imports the same rules other agents read.
   - `templates/docs/agents/*` -> `docs/agents/`.
   - `platforms/<platform>.md` -> `docs/agents/platform.md`.
   - Preset `full`: `templates/docs/STATUS.md`, `HANDOFF.md`, `LOG.md`, `PLAN.md`, `phases/P-NN.md`, `adr/0000-template.md` -> `docs/`.
   - Preset `lite`: only `LOG.md`.
4. **Fill in `docs/agents/workflow-settings.md`**: owner, preset, platform, test and format commands, `code_pattern`, PR commands. Leave `vault_folder` empty unless you use an Obsidian vault.
5. **Platform tools:** `azure` -> copy `tools/New-AzurePr.ps1` into the project's `tools/`. `pr-explainer` with a vault -> also copy `tools/Export-StandaloneHtml.ps1`.
6. **Coding standards:** add a short `CODING_STANDARDS.md` (the code-review skill reads it).
7. **Protect `main`:** require CI on PRs (branch protection on GitHub, branch policy on Azure).
8. Commit on a `chore/workflow-setup` branch and open the first PR with `/open-pr`. That tests the whole chain.

## 3. Check it works

- `/start-session` reports the branch, open PRs and the next step in under 10 lines.
- `/open-pr` on a docs-only change opens a PR and says "squash".
- `/end-session` writes a LOG line.

## Agent memory habits (optional)

Habits worth saving in Claude Code's memory on a new machine (they are general, not project facts):
- Archive, don't delete: move files to an archive folder; delete only when asked.
- PowerShell 5.1: read and write text as UTF-8 explicitly; `Get-Content -Raw` mangles non-ASCII.
- Azure PR text is ASCII only.
- Verify before claiming: check git and the platform for what a branch or PR holds; STATUS can be wrong.
- Stay inside the project: never change platform items or settings the workflow did not create.
