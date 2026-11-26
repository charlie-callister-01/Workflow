# Toolbox ideas captured from other projects go to GitHub issues

Status: **superseded** by [0013](0013-ideas-captured-into-home.md) (2026-11-26); was accepted 2026-11-23, roadmap decision ticket 22 (A fast ideas inbox). Not built yet.

`/idea wf <text>`, run in any project, opens a GitHub issue labelled `idea` on the Workflow repo instead of editing `notes/ideas.md`. Triage in the Workflow repo reads open `idea` issues alongside the `## Inbox` lines, routes each one, and closes the issue with a comment naming where it went. Project ideas (no `wf`) stay in the project's own `docs/IDEAS.md`, which travels with that project's commits.

Over: (a) appending uncommitted to the local Workflow checkout, which strands an idea on the machine it was typed on and lets two machines hold different edits; (b) committing and pushing to a fixed `inbox` branch from the middle of another task, which does git work in a second repo and can conflict when two machines push.

Trade-off: needs network and a logged-in `gh`; the toolbox inbox is split across a file and the issue list, so triage reads both. The tracker stays local markdown: issues are only an inbox, never tickets. Fallback without `gh`: option (a), or print the line if `workflow_repo` is unknown.

Reverse it if: `gh` is often unavailable where ideas come up (e.g. work machines), or the split inbox causes ideas to be missed.
