---
name: ship
description: Open a pull request the one approved way: PR body via /mattpocock-skills:pr, an explainer only for code changes, then the platform's PR command. Use whenever a branch is ready for a PR.
tier: core
---

Read `docs/agents/workflow-settings.md` first; names in `backticks` below are its settings. Platform detail: `platforms/<platform>.md` in the Workflow repo (copied into the project as `docs/agents/platform.md`).

1. **Check.** Branch is not `main_branch`, the tree is clean, and the branch is pushed (`git push -u origin <branch>`). For code changes, `/mattpocock-skills:code-review` has run and its fixes are in.
2. **Kind of change.** `git diff --name-only origin/<main_branch>...HEAD`. Code PR = any file matching `code_pattern`; otherwise docs-only.
3. **Explainer (code PRs, or when `owner` asks; optional skill).** If `/pr-explainer` is installed, run it; commit the file in `explainer_dir` and push.
4. **PR body.** Run `/mattpocock-skills:pr`. Write the body to a temp file. If the platform needs ASCII (Azure CLI drops other characters), use plain `+`/`-` sketches. If there is an explainer, add `Explainer: <link>`. End with the attribution line Claude Code gives.
5. **Open it.** Run `pr_command` with the title (`commit_format`) and the body file. Merge type: squash for docs-only, normal merge for code, unless the platform file says otherwise.
6. **Report** the PR link and the merge type. Do not complete or merge the PR; `owner` approves and completes it.
