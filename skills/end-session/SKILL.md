---
name: end-session
description: "[wf] Close a work session: refresh STATUS from git and the platform, rewrite HANDOFF as a pointer list, add one LOG line, re-slice the phase Specs list, and commit the docs on the session's last PR."
disable-model-invocation: true
tier: core
---

Read `docs/agents/workflow-settings.md` first; names in `backticks` below are its settings. Preset `lite`: do steps 1, 4 and 9 only.

1. **Facts, not memory.** `git fetch`, `git status -sb`, `git log --oneline` since the last LOG line, and open PRs (`pr_list_command`). If code changed this session, run `test_command` and report failures honestly.
2. **`status_file`** (rewrite, under ~40 lines): date; where we are (phase, spec, ticket); branches and PRs from step 1 only; test count; next action; caveats. Remove anything no longer true.
3. **`handoff_file`** (rewrite, under ~10 lines): "Read in order:" the 2-4 files the next session needs (always STATUS first), then "Skip:" what to ignore. No state, no prose; STATUS holds state.
4. **`log_file`**: one line at the top, below the header: `## YYYY-MM-DD: <what happened>. PRs #n, ADRs nnnn.`
5. **Phase Specs list** in `phase_file`: if a spec finished, mark it `done`; re-slice what is next in light of what was learned (reorder, add `fix:` lines, drop). Only the `next` spec gets detail.
6. **Only when true:** `plan_file` if a phase changed state; an ADR in `docs/adr/` only if the decision is hard to reverse, surprising without context, and a real trade-off.
7. **Reminders, one line each, only when they apply:** platform extras (see `docs/agents/platform.md`, e.g. mirror a spec to Boards); phase finished -> run `/thermo-nuclear-code-quality-review` over the phase diff, archive the phase's spec folders and do the branch sweep (step 8); something worth keeping -> offer `/vault-note`; end of day -> `/day-log` (both only if `vault_folder` is set).
8. **Branch sweep (phase end only).** `git fetch --prune`, then list every remote and local branch except `main_branch`. A branch counts as **merged** if `git branch -r --merged origin/<main_branch>` / `git branch --merged origin/<main_branch>` lists it, or its PR completed on the platform (squash merges hide it from git). Merged: delete it (`git push origin --delete <branch>`; locally `git branch -D` when it was squashed). Not merged: `git tag archive/<name> <branch>` and `git push origin archive/<name>` first, then delete. `throwaway/` branches are deleted without a tag (the abandoned PR is the record). `research/` branches (wayfinder findings, never merged) are tagged `archive/research-<name>` and deleted once their ticket has an `## Answer`. Show the list with the action for each; delete only after a yes.
9. Show the docs diff and offer to commit it as `docs: end of session` on the session's last PR branch, then `git push` so the open PR picks it up (no separate end-session PR; if there was no PR, use a small docs-only PR via `/open-pr`). Do not commit without a yes.
