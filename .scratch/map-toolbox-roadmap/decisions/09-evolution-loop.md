# Evolution loop and evidence

Type: grilling
Style: interview
Status: open
Blocked by: 17, 15

## Question

_Narrowed by the map refit (2026-11-24, last section): where they differ, the refit note wins._

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

## From 30 (2026-11-24)

The ratchet is how a rule moves from prose into a check: only after a recorded failure (30 point 1). Parked candidate: a `pre-commit` check against stray `.md` files, if they turn up in real PRs. Pruning applies to hooks and checks too.

## Map refit (2026-11-24)

Session F. Takes in **21** (read its question and notes): the markers are the loop's evidence. Also owns all of `retro` (cadence and trigger, and where it sits after `/ship`, from 15); 32's habit "every correction becomes a check"; agent hooks arriving only through the ratchet (30); and how the owner builds their own skills by picking from the primary sources (map Notes, Sources) and trials them (17). Blocked by 15 instead (where `retro` sits after `/ship` needs 15's answer). No longer blocked by 10: 35 fixed that lessons go to the knowledge repo; 10 decides only the layout inside.

Moved out: how ideas, roadmap, CHANGELOG and decisions relate (10); light refresh vs new wayfinder map (14); the README "Where I'm up to" refresh (39); automating the `upstream.md` sync (answered by 30: stays a monthly step). Compound Engineering is parked.

## From 41 (2026-11-26)

41 owns ideas up to and including routing (the idea batch); this ticket owns what happens after. Two values to tune from evidence: the batch offer threshold (5) and the backlog age that triggers keep / drop (60 days).

## From 31 (2026-11-26)

The Checks section starts with four settings on (`verify.check_line`, `verify.evidence`, `review`, `autonomy`); `plan.review`, `adr`, `high_risk`, `gate.pre_push` and `deploy` exist but are off. This ticket owns the ratchet that switches them on (a recorded failure, an experiment or research) and off (pruning), the commit-message format for a Checks change (31 suggested `chore(checks): <setting> <old> -> <new> because <reason>`), and adding new settings, values and autonomy levels. Evidence for it: each PR's `## Verification` section lists the Checks lines in force.

## Owner principle (2026-11-26)

The owner's new standing principle (map Main takeaways): every module is built in stages with a guide, settings, a trace and an **evaluation**. This ticket owns the evaluation part: what each trial watches (20's markers), its pass condition, where what was learned is written, and the keep / tune / drop call that promotes a module or sends it back.
