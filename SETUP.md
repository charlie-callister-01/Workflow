# Setup

How to put this workflow into a project. About 15 minutes.

## 1. Once per machine

1. **Claude Code**, signed in.
2. **Matt Pocock's skills plugin.** In Claude Code: `/plugin`, add the marketplace that carries `mattpocock-skills` (or follow <https://github.com/mattpocock/skills>), install it. Skills are then called as `/mattpocock-skills:<name>`.
3. **Platform CLI.**
   - GitHub: `winget install GitHub.cli`, then `gh auth login`.
   - Azure DevOps: `winget install -e --id Microsoft.AzureCLI`, then `az login` and `az extension add --name azure-devops`. Open a new terminal afterwards so `az` is on PATH.
4. **Optional, for `pr-explainer`:** the Claude Code Artifact tool (claude.ai account) and the `artifact-design` / `artifact-diagramming` skills.
5. **Optional, for skills on every project:** copy the skills you always want into `~/.claude/skills/` instead of each project.

## 2. Per project

1. **Pick a preset and a platform** (`presets/`, `platforms/`). Unsure: `lite` + `github` for personal, `full` + `azure` for work.
2. **Copy the skills** you want into the project's `.claude/skills/`:
   - always: `start-session`, `end-session`, `ship`
   - optional: `pr-explainer`, `thermo-nuclear-code-quality-review`, `day-log`, `vault-note`
3. **Copy the templates:**
   - `templates/CLAUDE.md` -> project root; fill in the `<...>` parts. Keep it under ~120 lines.
   - `templates/docs/agents/*` -> `docs/agents/`.
   - `platforms/<platform>.md` -> `docs/agents/platform.md`.
   - Preset `full`: `templates/docs/STATUS.md`, `HANDOFF.md`, `LOG.md`, `PLAN.md`, `phases/P-NN.md`, `adr/0000-template.md` -> `docs/`.
   - Preset `lite`: only `LOG.md`.
4. **Fill in `docs/agents/workflow-settings.md`**: owner, preset, platform, test and format commands, `code_pattern`, PR commands. Leave `vault_folder` empty unless you use an Obsidian vault.
5. **Platform tools:** `azure` -> copy `tools/New-AzurePr.ps1` into the project's `tools/`. `pr-explainer` with a vault -> also copy `tools/Export-StandaloneHtml.ps1`.
6. **Coding standards:** add a short `CODING_STANDARDS.md` (the code-review skill reads it).
7. **Protect `main`:** require CI on PRs (branch protection on GitHub, branch policy on Azure).
8. Commit on a `chore/workflow-setup` branch and open the first PR with `/ship`. That tests the whole chain.

## 3. Check it works

- `/start-session` reports the branch, open PRs and the next step in under 10 lines.
- `/ship` on a docs-only change opens a PR and says "squash".
- `/end-session` writes a LOG line.

## Agent memory habits (optional)

Habits worth saving in Claude Code's memory on a new machine (they are general, not project facts):
- Archive, don't delete: move files to an archive folder; delete only when asked.
- PowerShell 5.1: read and write text as UTF-8 explicitly; `Get-Content -Raw` mangles non-ASCII.
- Azure PR text is ASCII only.
- Verify before claiming: check git and the platform for what a branch or PR holds; STATUS can be wrong.
- Stay inside the project: never change platform items or settings the workflow did not create.
