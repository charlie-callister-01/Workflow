# One branch and PR per session, Show for docs, Ask for code

Status: **accepted** (2026-11-26), roadmap decision ticket 15 (Ship and after). Not built yet.

A session's docs and notes go on one branch and one PR, LOG line included. A separate PR only for code, a second repo, or a merge the owner wants mid-session. Docs-only PRs are Show (a short body, no explainer, merged by the owner without waiting), code PRs are Ask. Three skill scripts (`pr-facts`, `ci-watch` with a try limit, `sync-main` after merge) print short summaries so shipping costs little context. Settings `ship.mode`, `ship.automerge.docs`, `ship.ci_watch`, `ship.ci_tries` are available but not seeded, and each PR shows the ones in force.

Over: (a) a PR per ticket or change plus an end-session PR, the v1 habit, which opened five PRs in one docs-only session; (b) Ship, committing docs straight to `main`, which 30's guard refuses; (c) auto-merging docs after CI by default, which takes the merge away from the owner.

Trade-off: a session's PR is bigger and merges later, so a ticket's answer isn't on `main` until the session ends unless the owner asks for a mid-session merge; the scripts are three more things to keep working on two platforms and two shells.

Reverse it if: session PRs become too big to review, or work is lost or blocked waiting for a session PR to merge.
