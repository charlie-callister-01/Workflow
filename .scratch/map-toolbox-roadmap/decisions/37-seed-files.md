# Seed files: reworking presets into profile seeds

Type: grilling
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
