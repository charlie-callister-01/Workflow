# Keep session state in a note per branch, not a shared STATUS and HANDOFF

Status: **accepted** (2026-11-27), roadmap decision ticket 39 (Session bookends). Not built yet.

Each session branch gets a short **session note** (scope and decisions, status and next, files and tree, checks run, open questions; Osmani's restartable session boundaries), written by a new `/save-session` skill and by `/end-session`, folded into the LOG line and deleted when the branch's work is done. HANDOFF retires and projects keep no shared STATUS; a migration moves v1's "Next action" into a session note. Both bookends call one `session-facts` script (about 10 lines) instead of reading files to infer state. The owner's cross-repo view is a home `status` script that writes a gitignored page from each repo's LOG, PRs and session notes. `docs/LOG.md` gets `merge=union` so parallel sessions' lines both survive.

Over: (a) keeping STATUS and HANDOFF, which parallel sessions overwrite and which copy facts git already holds; (b) no state beyond the LOG, which leaves nowhere to save open questions before a `/clear`; (c) agent hooks (SessionEnd, PreCompact) to save state, which are Claude-only, have no model at SessionEnd, and come only after a recorded failure (30); (d) fstack's `LEARNED.md` written without asking, rejected because lessons must become rules or checks.

Trade-off: a note per branch is one more file to write and fold away, and state for work that spans branches lives only in the LOG and the map; the note's location waits for the Directory and design decision.

Reverse it if: during the trial the owner still re-explains context after `/clear`, `/start-session` costs more tokens than before, or session notes are left behind on `main`.
