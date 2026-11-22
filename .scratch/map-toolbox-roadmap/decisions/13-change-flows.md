# Change flows

Type: grilling
Status: open
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
