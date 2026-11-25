# The platform module owns the merge rules and `code_pattern`

Status: needs-triage
Notes: Live bug. The two `code_pattern` regexes disagree today.

## What

- `templates/docs/agents/workflow-settings.md:21` includes `^\.github/`. `tools/New-AzurePr.ps1:19` has its own default, which adds `.sln` and `.editorconfig` and leaves out `.github/`. The `pr_command` in `platforms/azure.md:10` never passes `-CodePattern`, although `CUSTOMISING.md:30` says to keep them the same.
- Make the settings file the one source: `New-AzurePr.ps1` reads `code_pattern` from `docs/agents/workflow-settings.md` and keeps no default of its own.
- The platform file (`platforms/<platform>.md`, copied to `docs/agents/platform.md`) owns `pr_command`, the merge type and the text rules. `skills/open-pr` (was `ship`) and `skills/end-session` call `pr_command` and point at the project's `docs/agents/platform.md`, not at "the Workflow repo" (`open-pr:7`, `end-session:16`).
- Cut the restatements: `pr_list_command` appears in 12 files, "squash" in 15 and the ASCII rule in 8. Keep one home for each.

## Done when

- [ ] One `code_pattern`, defined only in the settings file. The Azure script reads it, and a dry-run shows the files that matched.
- [ ] `ship` and `end-session` name no toolbox path.
- [ ] The merge type and the ASCII rule are stated once each, in the platform file.
- [ ] CHANGELOG line.

Related: issue #16, which asks `/ship` to skip review on docs-only changes and needs a correct `code_pattern`.

## Comments
- 2026-11-24: fixed on `fix/code-pattern`, PR #18. Left: merge type still restated in AGENTS.md, DEVELOPING.md, USING.md, CUSTOMISING.md:49, tools/gh-pr.md, platform risk tables; this repo's docs/agents/platform.md still says "add .github/ to code_pattern".
