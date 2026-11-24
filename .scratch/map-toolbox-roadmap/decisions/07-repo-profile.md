# Repo profile

Type: grilling
Status: open
Blocked by: 06

## Question

What is a **repo profile** (set once at setup, changed by `/refit-workflow`): which axes it has (solo or team, platform, agent(s), phases and state files, others), what each axis changes (where things live and how much ceremony surrounds them, not which skills run), and where it is recorded? Today's presets `full` and `lite` are repo profiles in disguise and retire as a term; `fast-lane` becomes a change flow (13). Keep the profile from steering development decisions in prompts more than it must.

## From 35 (2026-11-24)

Constraint: personal repos rely on the home repo for general rules and skills (`AGENTS.md` project-only); public, shared and work repos stand alone with the team's process in neutral files (`AGENTS.md`, CI checks) and no toolbox skills. Decide here how the profile picks that (one template with optional blocks, or two shapes), and whether 05's Working rules count as team process (shared repos may carry them) or the owner's practice (home only). No repo carries toolbox skill copies.

## From 35, review (2026-11-24)

Review: the "agent(s)" axis now only decides instruction-file shims (06); the main axis is **personal vs shared** (who opens the repo). Also decide whether the home and knowledge repos have profiles of their own, or sit outside setup.
