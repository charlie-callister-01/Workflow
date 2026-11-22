# Platform: github

For: personal projects. Light on process; GitHub is the code, PR and CI home.

Copy this file into the project as `docs/agents/platform.md`.

## Settings for `workflow-settings.md`

- pr_command: `gh pr create --base main --title "<title>" --body-file <file>` (see `tools/gh-pr.md`)
- pr_list_command: `gh pr list --state open --json number,title,headRefName --jq '.[] | [.number,.title,.headRefName] | @tsv'`
- CI: `.github/workflows/*.yml`; add `.github/` to `code_pattern`.
- Merge type: squash for docs-only, merge commit for code. GitHub sets the merge method when the PR is merged, not when it is opened: choose it in the merge button (or `gh pr merge --squash|--merge`).
- Text: GitHub keeps Unicode, so no ASCII rule.

## Optional extras
- Branch protection on `main`: require the CI check; self-approval is fine solo.
- `gh pr merge --auto --squash` for docs-only PRs once CI passes.
- GitHub Projects as a one-way mirror of phases and specs (only if you want a board).

## Risk levels (to develop)

How much process a change gets, by type and risk. Draft:

| Level | Examples | Process |
|---|---|---|
| 0 trivial | typo, docs | commit on a branch, squash merge, no review |
| 1 low | config, small fix | PR, CI, quick self-review |
| 2 normal | feature work | code-review skill, PR, CI |
| 3 high | auth, data migration, secrets, deletes | grill first, code-review, explainer, wait a day before merge |
