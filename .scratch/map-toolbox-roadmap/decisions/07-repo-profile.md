# Repo profile

Type: grilling
Status: resolved
Blocked by: 06

## Question

What is a **repo profile** (set once at setup, changed by `/refit-workflow`): which axes it has (solo or team, platform, agent(s), phases and state files, others), what each axis changes (where things live and how much ceremony surrounds them, not which skills run), and where it is recorded? Today's presets `full` and `lite` are repo profiles in disguise and retire as a term; `fast-lane` becomes a change flow (13). Keep the profile from steering development decisions in prompts more than it must.

## From 35 (2026-11-24)

Constraint: personal repos rely on the home repo for general rules and skills (`AGENTS.md` project-only); public, shared and work repos stand alone with the team's process in neutral files (`AGENTS.md`, CI checks) and no toolbox skills. Decide here how the profile picks that (one template with optional blocks, or two shapes), and whether 05's Working rules count as team process (shared repos may carry them) or the owner's practice (home only). No repo carries toolbox skill copies.

## From 35, review (2026-11-24)

Review: the "agent(s)" axis now only decides instruction-file shims (06); the main axis is **personal vs shared** (who opens the repo). Also decide whether the home and knowledge repos have profiles of their own, or sit outside setup.

## From 06 (2026-11-24)

The agent(s) axis is now only an `agents:` line in `workflow-settings.md` recording which agents a project expects; projects carry `AGENTS.md` only, and per-agent setup lives in home. A shared repo may need an agent-specific file for a teammate with no home: decide that with the personal vs shared axis.

## Answer

Resolved 2026-11-24 (grilling, four rounds). Decision 0010.

1. **The profile is a seed, not a switch.** A repo profile is four values: **audience** (`personal | shared`, who opens the repo), **stakes** (`spike | everyday | production`, how much rides on it), **platform** (`github | azure`) and **agents** (06). Only `/setup-workflow` and `/refit-workflow` read it, to choose what goes into the project's files. It is recorded under `## Seeded from` in `workflow-settings.md` with the date and toolbox version, so refit knows the starting point and the gap between seed and today's files shows how the harness evolved.
2. **No skill reads the profile.** Day-to-day skills read only concrete settings (`pr_command`, `test_command`, ...) and the rules in `AGENTS.md`. Every behaviour sits in a line the owner can see and edit, and each repo's harness then evolves for its own domain (09). The change flow picks the stages; the project's Checks lines set how strict each stage is.
3. **Stakes seeds a Checks section** in the project's `AGENTS.md`: what a change must show before ship, when review is required, when to write an ADR, what the agent may do without asking. One starter file per stakes value lives in the toolbox; after setup the lines are edited like any other rule.
4. **Audience: one template, a shared-only block.** `templates/AGENTS.md` has one marked block that setup keeps (markers removed) for shared repos and deletes for personal ones, so no repo carries text it doesn't use. Shared repos carry in it how a change flows, the Checks section and, if the owner opts in (off by default), the Working rules (05). Personal repos get change flows and Working rules from home; their `AGENTS.md` is project-only. **Revises 13**: the change flows table is not in every project's `AGENTS.md`.
5. **Working rules are the owner's practice**, kept in home; a shared repo carries them only when the team agrees.
6. **The profile lives in the project**, in `docs/agents/workflow-settings.md`, for shared repos too: plain markdown, harmless to teammates. It can move to home later if a team objects.
7. **No depth axis, no kind axis.** Every project gets the same baseline (`AGENTS.md`, `docs/LOG.md`, `docs/agents/workflow-settings.md`); other state files (PLAN, specs, tickets, STATUS, HANDOFF) are created when a change flow first needs them. Which flows a repo uses follows from the work it does, not from a setting.
8. **Home and knowledge repos sit outside setup**: no profile; each has a hand-built harness in its own repo. They may share skills, but their workflow isn't a code repo's.
9. **Refit when the seed changes** (a spike grows up, a personal repo becomes shared): refit proposes a line-by-line diff from old seed to new; the owner approves each line; lines edited since setup are kept by default; the seed record is updated.
10. **"Preset" retires as a term.** `full` and `lite` become starting stakes sets, `fast-lane` is already the small change flow (13). The "Preset rework" fog graduates into ticket 37. Seeing drift from the seed goes to 09 and 21 as input.

Glossary: Repo profile (redefined), Audience, Stakes, Seed, Checks; Preset marked retired.

## From 31 (2026-11-26)

**Revises point 4:** every repo, personal or shared, carries its own `## Checks` section (inline in `AGENTS.md`, or one pointer line to `docs/agents/checks.md`), because Checks are project-specific. The shared-only block keeps change flows and Working rules, not Checks.
