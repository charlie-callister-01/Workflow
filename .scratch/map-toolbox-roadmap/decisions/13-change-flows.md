# Change flows

Type: grilling
Status: resolved
Blocked by: none

## Question

What is the catalogue of **change flows** (picked per piece of work, deciding which skills run), the size rules that suggest one, and how the agent proposes and the owner confirms? Starting draft: **start project** (setup -> wayfinder if foggy, else grill-with-docs -> PLAN, GLOSSARY, first ADRs, Phase 1); **new feature** (grill-with-docs -> to-spec -> to-tickets -> implement -> code-review -> ship); **small feature** (grilling -> to-spec -> implement -> ship, no work tickets); **small change** (in chat -> ship); **bug fix** (diagnosing-bugs -> fix with a test -> ship); **research / spike** (research or prototype -> a note, no code merged).

## Agreed so far (2026-11-22, round 1; not yet resolved)

Owner said yes to every recommendation. Next session: confirm nothing is left open, then write the `## Answer` and resolve.

1. **Catalogue:** six flows: start project, new feature, small feature, small change, bug fix, spike. Foggy work is a "wayfinder first" step before start project or new feature, not a flow. Refactor is not a flow; it takes the flow its size fits. `fast-lane` retires into small change.
2. **Size rules** (decisions and sessions first, lines as a hint): small change = no decision worth writing down, ~30 lines or 2 files; small feature = one or two decisions, one session, one PR; new feature = several decisions, sessions or PRs; wayfinder first = can't list the decisions yet; bug fix = something that should work doesn't; spike = the output is knowledge, not merged code.
3. **Who picks:** the agent proposes a flow in one line before doing anything; the owner confirms or switches. If work grows mid-flow the agent stops and proposes the bigger flow; never silently downgrades.
4. **Steps:** start project = `/setup-workflow` -> (wayfinder if foggy) -> grill-with-docs -> PLAN + first spec (what it writes depends on the repo profile, 07). New feature = (wayfinder if foggy) -> grill-with-docs -> to-spec -> to-tickets -> implement per work ticket (runs code-review) -> size check -> `/ship`. Small feature = grilling -> to-spec -> implement from the spec (runs code-review) -> `/ship`. Small change = in chat -> code-review only if code changed -> `/ship`. Bug fix = diagnosing-bugs -> failing test -> fix -> `/ship`; a large fix moves up to small or new feature. Spike = research and/or prototype on a `throwaway/` branch -> a note (where, decided in 10); only the note merges.
5. **Where written:** one project file `docs/agents/change-flows.md` (from `templates/`) the agent reads when proposing, plus a six-line table in the `CLAUDE.md` template pointing at it. No per-flow folders, no new skill.
6. **Glossary:** the six flow names added to `GLOSSARY.md` under Change flow (done).

## Answer

Resolved 2026-11-23 (grilling, round 2 on top of round 1 above; round 1 points 1-3 and 6 stand).

1. **Catalogue:** six flows: start project, new feature, small feature, small change, bug fix, spike. **Wayfinder first** is a step before start project or new feature, not a flow. Refactor takes the flow its size fits; `fast-lane` retires into small change.
2. **Size rules and who picks:** as round 1 (decisions and sessions first, lines a hint; the agent proposes in one line, the owner confirms; work that grows stops and moves up, never silently down).
3. **Stages:** every flow is a sequence of stages: define, plan, build, verify, review, ship. Skills in the table are **defaults**: 05 may swap the skill in a stage without reopening 13.

   | Flow | Define | Plan | Build | Verify | Review | Ship |
   |---|---|---|---|---|---|---|
   | Start project | `/setup-workflow` (wayfinder first if foggy), grill-with-docs | PLAN and first spec (shape by repo profile, 07) | - | - | - | yes |
   | New feature | (wayfinder first if foggy) grill-with-docs, check line per ticket | to-spec, to-tickets | implement per work ticket | per ticket | code-review, size check | yes |
   | Small feature | grilling, check line | to-spec | implement from the spec | yes | code-review | yes |
   | Small change | one line in chat (check line if code) | - | in chat | if code changed | code-review if code changed | yes |
   | Bug fix | diagnosing-bugs; failing test is the check | - | fix | test passes plus original repro | code-review | yes |
   | Spike | research question | - | research and/or prototype on `throwaway/` | - | - | only the note merges |

   A large bug fix moves up to small or new feature.
4. **Verify is a stage:** every code-changing flow has one; its "how we'll check it" line is written at define and `/ship` asks for the evidence. Evidence and strictness: 31.
5. **Where written:** a six-line table in `templates/AGENTS.md` (not `CLAUDE.md`, which is now only `@AGENTS.md`) pointing at `docs/agents/change-flows.md`, the single source any router (34) reads. No per-flow folders, no new skill.
6. **Boundary:** flows end at ship. PRs, merging, the LOG line and closing the session belong to 15.
7. **For 05:** "what we're NOT doing", fstack's three-question check before ship, anti-rationalisation tables, `/goal` for long runs and the router are adoption candidates, noted on 05.

Hooks split agreed in the same session: session hooks (SessionStart feeding `/start-session`, a SessionEnd note) go to 15; guard hooks and how hooks ship stay in 30; a Stop hook that runs tests goes to 31.
