# Seed files: reworking presets into profile seeds

Type: grilling
Style: rounds
Status: open
Blocked by: 31

## Question

07 made the repo profile a seed (audience, stakes, platform, agents) read only by setup and refit. What do the seed files in the toolbox look like, replacing `presets/`?

Points to decide:

1. **Layout:** one starter file per stakes value (`spike`, `everyday`, `production`) holding the Checks lines, the shared-only block of `templates/AGENTS.md`, and the platform files; where they live (`profiles/`?) and what happens to `presets/` and the v1 projects that name a preset.
2. **What each stakes value seeds:** the concrete Checks lines (evidence before ship, when review is required, when an ADR, what the agent may do unasked), using 31's answer on what "checked" means.
3. **The shared-only block:** its exact contents (how a change flows, Checks, optional Working rules), written so a teammate with no home and no toolbox can follow it.
4. **Team and Azure:** what was `presets/team.md` and Azure team mode (Boards mirror, work-item links, reviewers by path or risk) as seeds for a shared, `production`, `azure` repo, with only neutral process files.
5. **Inputs:** GSD Core, Spec Kit's customisation layers, BMAD's planning-path picker (research 04).

Graduated from the map's "Preset rework" fog by 07 (2026-11-24). Related: 23 (refit's seed diff), 13 (change flows).

## From 23 (2026-11-24)

Updates three-way merge each seeded file against the template at the project's seed version, so seed files stay plain templates whose history is the merge base. Retiring `presets/` and the `preset:` line is migration (d) of the v2 migration; moving or renaming seed files later needs its own migration file (`migrations/NNNN-*.md`).

## From 30 (2026-11-24)

Stakes `everyday` and `production` seed `templates/.githooks/` (`pre-commit`, `pre-push`: refuse `main` / `master`); `spike` seeds none. Setup and refit set `core.hooksPath .githooks`. Branch protection where the platform allows it belongs in the setup guide for those stakes.

## Map refit (2026-11-24)

Session B. Point 2 (the Checks lines per stakes) moved to 31; this ticket packages 31's answer. Takes in **32** (read its question and notes): which code checks per stack (lint severities, architecture tests, comment guideline) are seeded as templates and which are suggestions at setup. 32's habit "every correction becomes a check" went to 09. Also seeds the git hooks (from 30). The Spec Kit input in point 5 is parked (map Notes, Sources).

## From the inbox (2026-11-25)

31 now also sets autonomy levels by stakes (what the agent may do unattended, `/goal` runs included); the seed files package them with the Checks lines.

## From 31 (2026-11-26)

Package 31's answer: seed four settings by stakes (`verify.check_line`, `verify.evidence`, `review`, `autonomy`; table in 31 point 7) into every repo's `## Checks` (personal and shared, revising 07 point 4); document the off-by-default settings (`plan.review`, `adr`, `high_risk`, `gate.pre_push`, `deploy`) without seeding them, with `deploy` asked at setup only if the project deploys; shared repos also get a `## Verification` section in their PR template. `gate.pre_push` stays off until a recorded failure; 30's `main` guard is unchanged.
