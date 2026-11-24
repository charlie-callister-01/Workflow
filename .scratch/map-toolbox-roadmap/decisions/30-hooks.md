# Hooks: the toolbox's enforcement layer

Type: grilling
Status: open
Blocked by: none

## Question

Which rules move from prose into Claude Code hooks, and how do hooks reach a project? Candidates: a PreToolUse guard on commits and pushes to `main` (plus GitHub branch protection as the real guard), blocking edits to `.claude/skills/` in this repo, blocking stray `.md` writes outside an allow-list, plus (decided elsewhere) session hooks in 15 and a test-running Stop hook in 31. Decide: which hooks, PowerShell 5.1 or Git Bash, shipped in `templates/`, globally, or as an optional kit, and trialled on the beta track (17). Session hooks moved to 15 and the test-running Stop hook to 31 (2026-11-23); this ticket keeps the guard hooks and how all hooks ship.

Related: 15 (after implementation, with 24 merged in), 25, 29; research in `notes/research/2026-11-23 Loops, sandboxes and session hooks.md`.

## From 05 (2026-11-23)

Candidate: a hook that warns on edits outside the plan's Scope block (`Touch` / `Never`). Possibly: automating the `notes/upstream.md` sync.

## From 35 (2026-11-24)

Sessions start in the home repo, and a project's hooks don't run there (only when the session starts in, or `/cd`s into, the project). Decide whether must-hold hooks live in each project, in home (working for every project), or both. Prefer checks every agent obeys (git hooks, CI) over Claude-only ones.

## From 35 (2026-11-24)

Reframed: the title says "Claude Code hooks", but the owner wants the workflow agent-agnostic. Rank enforcement as git hooks and CI or branch protection first (every agent and teammate obeys them), agent hooks second (per agent, home or project). Shared repos get only neutral checks.
