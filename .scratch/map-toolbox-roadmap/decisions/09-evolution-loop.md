# The evolution loop

Type: grilling
Status: open
Blocked by: 17, 10

## Question

How does the toolbox keep evolving: the research -> trial -> adopt -> retire loop, how ideas.md, roadmap, CHANGELOG and decisions relate, and when a cycle is a light refresh versus a new wayfinder map? Also: should `/end-session` in this repo refresh the README's "Where I'm up to" section (today nothing keeps it current)?

Boundary: capture and routing of ideas into a map or the backlog are decided in 22 (A fast ideas inbox); this ticket starts after routing.

## From 05 (2026-11-23)

The ratchet: `/end-session`'s lesson line goes to the inbox; Pocock's `retro` reviews the worst sessions and proposes `AGENTS.md` lines to add or retire, and the owner approves. 09 decides cadence, trigger and where lessons are stored. Also here: skill lint, evals and the removal test; pstack's reflect/correct and `workflow-from-chats` only if `retro` falls short; possibly automating the `notes/upstream.md` monthly sync.

## From 35 (2026-11-24)

Ideas now enter through home (`/idea` with project, toolbox and knowledge routes) and lessons learned go to the knowledge repo (10), so the loop spans three repos. Trials run through home's copy script, which affects every project at once (17), not one trial project.

## From 07 (2026-11-24)

Each repo's harness evolves for its own domain after setup: the profile is only a seed, recorded with date and toolbox version under `## Seeded from`. Input here: make that drift observable (seed vs today's `AGENTS.md` Checks and settings) and decide when a project's evolved lines feed back into the toolbox's seed files.

## From 17 (2026-11-24)

Correction to the "From 35" note: skill trials don't switch every project. Beta skills install side by side as `<skill>-beta` and are used only when typed; template trials put one project on the beta track. Trial notes arrive as `trial:<slug>` lines in project LOGs and are swept at each trial's Review-by date (default 1 week), so the loop's evidence lives in project LOGs.

## From 23 (2026-11-24)

Promotion and retirement now have a project side: a change that moves, renames or deletes a project file or retires a setting ships a migration (`migrations/NNNN-*.md`, check and rollback) in the same PR, and projects learn they are behind from a `/start-session` line and home's sweep. The loop should cover writing and retiring migrations.
