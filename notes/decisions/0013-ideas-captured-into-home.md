# Ideas are captured into home by script and routed in a batch

Status: **accepted** (2026-11-26), roadmap decision ticket 41 (Idea routing and auto-organisation). Supersedes [0007](0007-github-issues-as-toolbox-inbox.md). Not built yet.

`/idea <text>` runs an agent-neutral `idea` script that appends one line to home's `inbox/<machine>.md` and commits and pushes only that file to home's `main` (home's `pre-commit` hook allows `inbox/` alone). An agent hook starts the script where the agent has one; otherwise a fresh-context subagent does. `/idea` with no text runs the idea batch: it routes each idea to its repo without asking, proposes its place for one approval, and always asks before creating a decision ticket or changing a ticket's question. Platform routes (GitHub issues, DevOps work items) are an optional per-repo extra.

Over: (a) 0007's GitHub issue for toolbox ideas, which ties the inbox to one platform and to a logged-in `gh`; (b) appending to each repo's own file and committing at the batch, which strands ideas on one machine until then; (c) the script committing to an `inbox` branch in each repo, which does git work in other repos mid-task and conflicts when two machines push.

Trade-off: a narrow commit-to-`main` exception in home; ideas wait in home until a batch routes them, so a project's own files don't show them until then; until home is built (42), this public repo keeps the manual Inbox in `notes/ideas.md`. One append-only file per machine avoids conflicts; everything is plain files, so it works on GitHub or Azure DevOps and offline.

Reverse it if: ideas sit unrouted in home long enough to be missed in their projects, or the `inbox/` exception lets other commits slip onto home's `main`.
