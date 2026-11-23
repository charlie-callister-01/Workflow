# Hooks: the toolbox's enforcement layer

Type: grilling
Status: open
Blocked by: none

## Question

Which rules move from prose into Claude Code hooks, and how do hooks reach a project? Candidates: a PreToolUse guard on commits and pushes to `main` (plus GitHub branch protection as the real guard), blocking edits to `.claude/skills/` in this repo, blocking stray `.md` writes outside an allow-list, plus (decided elsewhere) session hooks in 15 and a test-running Stop hook in 31. Decide: which hooks, PowerShell 5.1 or Git Bash, shipped in `templates/`, globally, or as an optional kit, and trialled on the beta track (17). Session hooks moved to 15 and the test-running Stop hook to 31 (2026-11-23); this ticket keeps the guard hooks and how all hooks ship.

Related: 15 (after implementation, with 24 merged in), 25, 29; research in `notes/research/2026-11-23 Loops, sandboxes and session hooks.md`.

## From 05 (2026-11-23)

Candidate: a hook that warns on edits outside the plan's Scope block (`Touch` / `Never`). Possibly: automating the `notes/upstream.md` sync.
