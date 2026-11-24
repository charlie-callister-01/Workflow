# Platform: azure

For: work projects on Azure DevOps, and later team work with Boards. Heavier process.

Copy this file into the project as `docs/agents/platform.md`.

## Settings for `workflow-settings.md`

- azure_org, azure_project, azure_repo: your organisation URL, project and repo names.
- pr_command: `powershell -File tools/New-AzurePr.ps1 -Organization <azure_org> -Project "<azure_project>" -Repository "<azure_repo>" -Title "<title>" -BodyFile <file>` (copy `tools/New-AzurePr.ps1` into the project's `tools/`). The script reads `code_pattern` from `docs/agents/workflow-settings.md`; add `-DryRun` to see the merge type and matched files without opening a PR.
- pr_list_command: `az repos pr list --organization <azure_org> --project "<azure_project>" --status active --query "[].[pullRequestId,title,sourceRefName]" -o tsv` (PowerShell; Git Bash may need a new terminal to find `az`).
- CI: `azure-pipelines.yml`, required as build validation on `main` by a branch policy.
- Merge type: the script sets squash for docs-only diffs and a normal merge for code, and deletes the source branch on completion.
- Text: **ASCII only** in PR titles and bodies; the `az` CLI drops other characters. `az` is a `.cmd`: avoid double quotes inside arguments.

## Boards (current: one-way mirror, by hand)
- Markdown in `.scratch/` is the truth; Boards mirrors phases (Epics) and specs (Issues) by hand when a phase is sliced. Tickets stay off Boards.
- `/end-session` reminds you to mirror a new or finished spec or phase.
- Never change Boards items, wiki pages or settings that this workflow did not create.

## To develop (team use)
- Script the Boards mirror (`az boards work-item create/update`) instead of doing it by hand.
- Link PRs to work items (`--work-items`) so Boards shows progress.
- Required reviewers by path or risk level; environment approvals for deploys.
- Pipeline secrets in variable groups, one per environment, never available to PR builds.

## Risk levels (to develop)

| Level | Examples | Process |
|---|---|---|
| 0 trivial | typo, docs | fast lane, squash, self-approve |
| 1 low | config, small fix | fast lane, CI, self-approve |
| 2 normal | feature work | full lane, code-review, explainer, CI |
| 3 high | pipeline, secrets, data access, deploy | full lane + ADR + second reviewer (team) + environment approval |
