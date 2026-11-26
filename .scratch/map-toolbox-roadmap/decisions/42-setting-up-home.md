# Setting up home

Type: grilling
Style: rounds
Status: open
Blocked by: 41

## Question

Until now this map left setting up the home and knowledge repos to those repos (35, Out of scope). But this repo is serving as home today, and most of how home works was decided here, so the build plan is made here too. Gather what is already decided into one plan for building **home** and the **knowledge repo**, then hand it to a normal `/to-spec` when it gets built.

Decided inputs to gather (read their answers, don't re-decide them): 35 (three repos, agent-agnostic, no plugin), 36 (session project, `## Other repos` table, sweeps, worktrees, copy script from `origin/main`), 06 (one skill copy in `.agents/skills` plus a `.claude/skills` junction, per-agent setup and permissions in home, Matt's skills from a pinned clone), 22 and 41 (`/idea` routes across project, toolbox and knowledge), 23 (home's sweep shows who is behind), 30 (enforcement never depends on where a session starts), 17 (beta skills side by side).

Decide:

1. **What home holds:** the file list (`AGENTS.md`, `## Other repos`, practices, private scripts, the copy script, the idea inbox), and what stays out.
2. **Build order:** the smallest home that works first, then what is added after; which roadmap items it needs first (the agent-neutral install and copy scripts, Phase 1).
3. **What moves out of this repo:** the toolbox ideas that are really home's (`## For home` in `notes/ideas.md`), the Inbox, the global-skills install, and when this repo stops acting as home (sessions then start in home).
4. **The knowledge repo:** created alongside home with the same steps; the layout inside is 10's answer, pointed at, not decided here; what replaces the Obsidian vault settings (`vault_folder`, `day-log`, `vault-note`).
5. **Private vs public:** what must never land in this public-safe toolbox, and the check that keeps it so.

Starting checklist: `## For home` in `notes/ideas.md`.

Created 2026-11-25 in the inbox triage grilling, at the owner's request: this repo acts as home until 42 is built. Related: 35, 36, 06, 10, 22, 23, 39 (the cross-project status page lives in home), 41.

## From 40 (2026-11-26)

The knowledge repo gets its own starting checklist, `## For knowledge` in `notes/ideas.md` (as `## For home` is home's). Point 4 changes: the learning layout is decided in the knowledge repo itself, using ICM's ideas (layers, injection, reviewable stage outputs), not in 10.

## From 41 (2026-11-26)

Home holds the `idea` script (`sh` + `ps1`, with a `check` mode), the per-agent hook triggers that start it, `inbox/<machine>.md` (one per machine) and the `pre-commit` exception for `inbox/`. On build, move this repo's `notes/ideas.md` Inbox into home's inbox. Knowledge ideas route to the knowledge repo's ideas file.
