---
name: start-session
description: "[wf] Start a work session: check the branch is current, read STATUS and the files HANDOFF lists, list open PRs, and propose the next step in under 10 lines."
disable-model-invocation: true
tier: core
---

Read `docs/agents/workflow-settings.md` first; names in `backticks` below are its settings.

1. `git fetch --quiet origin`, then `git status -sb` and `git log --oneline -3`. Note if the branch is behind `origin/<main_branch>`, and list any remote branch whose last commit is newer than this branch's tip: compare `git for-each-ref --sort=-committerdate refs/remotes --count=5 --format="%(committerdate:iso-strict) %(refname:short)"` against `git log -1 --format=%cI`.
2. Read `status_file` in full, then only the files listed in `handoff_file`, in order. Do not read anything else yet. (Preset `lite`: no state files; read the README and the last 5 commits instead.)
3. **Active wayfinder map?** If a `.scratch/map-*/map.md` exists outside `.scratch/archive/` and has open decision tickets, list its frontier (open, unblocked, unclaimed `decisions/NN-*.md`, first number first) and propose `/mattpocock-skills:wayfinder .scratch/map-<effort>/map.md` as the next step.
4. Open PRs: run `pr_list_command`. If the CLI is missing or not signed in, say so and skip.
5. Report in under 10 lines: branch and whether it is current, open PRs, where we are, the proposed next step (from STATUS "Next action", or the map frontier). If STATUS disagrees with git or the platform, say which and trust git/the platform.
6. Wait for `owner` to confirm the step before starting work.
