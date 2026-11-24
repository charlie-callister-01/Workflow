# What to adopt from the researched methods

Type: grilling
Status: resolved
Blocked by: 01, 02, 03, 04, 25, 26, 27, 28

## Question

Which ideas from the researched methods does the toolbox adopt, and as what: a preset, a core or optional skill, a practice in a template, or nothing?

## Merged in: 33, principles in AGENTS.md (2026-11-23)

Which short, standing principles go into `templates/AGENTS.md`, and how the list stays short (each line traced to a real failure, pruned when a model no longer needs it; near 60 lines, research 25). Candidates: scope discipline (touch only what's asked, surface assumptions, stop and ask on conflicting requirements, push back when warranted), prefer boring, code as a liability, Chesterton's fence, Hyrum's law, DAMP over DRY in tests, small PRs and atomic commits. If this makes 05 too big for one session, split it out again.

Also weigh research 29 (the owner's notes) alongside 01-04 and 25-28.

## Candidates from Change flows (13, 2026-11-23)

05 fills the stages 13 defined (define, plan, build, verify, review, ship) and may swap any default skill. Candidates that change what happens inside a stage: fstack's "what we're NOT doing" section (plan) and three-question check before ship (does it work, does it match the plan, is it simple); anti-rationalisation tables in the toolbox's own skills; `/goal <condition>` for long runs (build/verify); the router (34). Plus the v1.3.2 subagent wording from 11 ("fresh context, not a fork").

## Answer

Resolved 2026-11-23 (grilling, two rounds plus a look at how agent-skills keeps scope). Principles from 33 included.

1. **One adoption table** (below) for everything researched in 01-04, 11, 12, 25-29. Columns: idea, source, adopt as, stage, what lands in a project, conflicts with / resolution, owner ticket. Items another ticket owns get a pointer, not a decision. The conflicts column doubles as a comparison for future trials.
2. **How outside skills come in:** never install a pack (two routers, unused files in projects). Copy a whole skill into `skills/` as an optional skill only when it stands alone (MIT, credit line, source version); otherwise take the idea and rewrite it into our own skills or templates. **Pocock's skills and Claude Code built-ins win by default**; a borrowed skill adds only what they lack. Once the toolbox writes its own skill from a borrowed one, that becomes the default for its stage. Decision 0008.
3. **Staying current:** a register, `notes/upstream.md`: one row per outside source (Pocock plugin, agent-skills, cursor-team-kit, pstack, superpowers) with pinned version, what was taken and where it landed. A manual monthly sync diffs each pin against the latest release and raises an `/idea` per change; whether that becomes a hook or scheduled run is 30's or 09's.
4. **Borrowed skills, one live trial at a time** on the beta track (17), each used for a few weeks in this repo or one real project before the next, alongside the Pocock-heavy stack: (1) `doubt-driven-development` for high-stakes decisions; (2) security: the built-in `/security-review` in the review stage first, agent-skills' `security-and-hardening` only for what it misses; (3) `/interrogate`: single-model with a fresh context, or Claude plus Codex once 06 settles; (4) transcript diagnosis (superpowers) stays in the deep-dive fog until a bad session gives a reason. Not now: `deslop`, `verify-this` (31 may pick it as the verify default), a11y/perf, constraint-driven development.
5. **Structure of the toolbox's own skills:** every skill that writes files or ships ends in a **Verification** checklist (evidence, not "done"). Only the discipline skills (`/ship`, `/end-session`, thermo-nuclear review) get a short **Rationalisations** table. No Red flags section. The thermo-nuclear review lists dismissed findings with a reason each.
6. **Scope block** (the owner's "not doing": not opening extra context, not editing files the task doesn't need). Modelled on agent-skills: the spec's Boundaries (always / ask first / never) and Out of Scope, the plan's "Files likely touched" (over ~5 files is too big), incremental-implementation's "Noticed but not touching", and context-engineering's Relevant files plus one pattern. A plan-stage rule in `docs/agents/change-flows.md`:

   ```
   ## Scope
   - Touch: <files/folders likely edited>  (over ~5 files: split the task)
   - Read: <relevant files + one pattern to follow>  (nothing else unless needed)
   - Ask first: <schema, dependencies, public API, ...>
   - Never: <e.g. .claude/skills/, vendor, generated files>
   - Not doing: <deferred ideas>
   ```

   Small change: one line, "Touch: X. Not doing: Y." While building, a **Noticed, not touching** list leaves through `/idea` (22), never as edits. Pointers: 34 (the router may surface it), 30 (a hook may warn on edits outside Touch).
7. **Three-question check** as the first step of `/ship` for code-changing flows: does it work (reads the verify evidence; strictness is 31's), does it match the plan (diff against Touch, Never and Not doing), is it simple. Docs-only changes skip it.
8. **Working rules in `templates/AGENTS.md`** (from 33): (1) touch only what's asked; (2) surface assumptions, stop and ask when requirements conflict; (3) push back when something's wrong; (4) prefer boring, code is a liability. Chesterton's fence, Hyrum's law, DAMP over DRY (review guidance at most) and small PRs wait until a real failure earns them. The template's cap changes from ~120 to ~60 lines. The rules live in `AGENTS.md`, not a router (answers 34's point 4).
9. **The ratchet:** `/end-session` asks "what went wrong that a rule, check or hook would stop?" and sends the answer as one `/idea` line. Pocock's `retro` (installed since v1.3.0) is adopted as the ratchet's review step: it runs on the worst sessions and proposes `AGENTS.md` lines to add (each traced to its failure) or retire; the owner approves. Cadence, trigger and storage: 09; where it sits after `/ship`: 15.
10. **ICM:** a leftover-placeholder scan at the end of `/setup-workflow` and `/refit-workflow`; a line cap on `docs/agents/*.md`; one-way links as a convention in `DEVELOPING.md`. The load / don't-load table becomes part of the new fog patch **Directory map and flow**. No Audit tables (the Verification checklist covers them).
11. **Pocock sync (11):** the git remote check before a GitHub tracker, the `GLOSSARY` rename offer and the "fresh context, not a fork" wording are **v1 fixes** (`fix/` branch), not roadmap items.
12. **Not now:** skill lint and evals go to 09 (to test the removal experiment); no preset change from 05; preset rework becomes fog (**Preset rework**, merged with the Team preset fog).

### Adoption table

| Idea | Source | Adopt as | Stage | Lands in a project | Conflicts with / resolution | Owner |
|---|---|---|---|---|---|---|
| Borrow, don't install packs | 01, 26 | convention | - | nothing | a second router vs native routing: no packs | 05, decision 0008 |
| Upstream register and monthly sync | owner, 11 | convention (`notes/upstream.md`) | - | nothing | - | 05; automation 30/09 |
| `doubt-driven-development` | agent-skills (01) | optional skill, trial 1 | build | the skill, if opted in | grilling and `implement` also question decisions: it runs only on high-stakes decisions during build | 05; risk levels fog |
| Security review | Claude Code built-in; agent-skills `security-and-hardening` | built-in first, borrow the gaps, trial 2 | review | nothing (built-in) | built-in wins; borrowed parts only where it misses | 05 |
| `/interrogate` | pstack (02, 28) | optional skill, trial 3 | review | the skill, if opted in | `/code-review` and thermo-nuclear review: it adds an adversarial fresh-context pass and applies nothing | 05; multi-model 06 |
| Dismissed findings with reasons | pstack `/interrogate` (28) | section in thermo-nuclear review | review | the skill (already installed) | - | 05 |
| Transcript diagnosis | superpowers (04) | later | - | - | - | deep-dive fog |
| Verification checklist in toolbox skills | agent-skills (01, 26) | section in own skills | all | the skills (already installed) | - | 05; evidence 31 |
| Rationalisations table | agent-skills (01, 26) | section in discipline skills | ship, review | the skills (already installed) | - | 05 |
| Scope block, Noticed-not-touching | agent-skills (spec, planning, incremental, context-engineering), fstack (28), owner | plan-stage rule in `change-flows.md` | plan, build | `docs/agents/change-flows.md` | Pocock's `to-spec` can't be edited: the rule lives in our doc | 05; surfacing 34, warn hook 30 |
| Three-question check | fstack (28) | first step of `/ship` | ship | `/ship` (already installed) | - | 05; evidence 31 |
| Working rules (4 lines) | agent-skills (01, 26), 33 | `templates/AGENTS.md` section | all | 4 lines in `AGENTS.md` | router as a second home: no, `AGENTS.md` only | 05; 34 |
| AGENTS.md cap ~60 lines | 25 | template rule | - | one line changed | - | 05 |
| Lesson question at `/end-session` | 25, Compound Engineering (04) | step in `/end-session` | after ship | `/end-session` (already installed) | - | 05; storage 09/10 |
| `retro` as the ratchet's review | Pocock (11) | adopt installed skill | after ship | nothing new | overlaps pstack reflect/correct: `retro` wins | 05; cadence 09, place 15 |
| Placeholder scan after setup/refit | ICM (03) | step in setup/refit | - | nothing (global skills) | - | 05 |
| Line cap on `docs/agents/*.md` | ICM (03) | template rule | - | nothing new | - | 05 |
| One-way links | ICM (03) | convention in `DEVELOPING.md` | - | nothing | - | 05 |
| Load / don't-load table | ICM (03) | later | - | - | overlaps "Context discipline" | Directory map fog |
| Pocock setup fixes, subagent wording | 11 | v1 fixes | - | via setup | - | `fix/` branch |
| Hooks (guards, session, Stop) | 25, 26, 29 | - | - | - | - | 30, 15, 31 |
| `/goal`, loops | 28, 29 | - | build, verify | - | - | 31, loops fog |
| CI watcher, PR care | team kit (02), Compound Engineering | - | after ship | - | - | 15 |
| reflect / correct, `workflow-from-chats` | pstack (02) | - | - | - | overlaps `retro` | 09 |
| Skill lint, evals, removal test | agent-skills (01), 26 | - | - | - | - | 09 |
| Per-agent adapters | agent-skills (01), pstack (02) | - | - | - | - | 06 |
| `deslop`, `verify-this`, a11y, perf, constraint-driven | 01, 02 | not now | - | - | `verify-this` may become 31's verify default | 05 (later trial), 31 |
| Book one-liners (easier to change, broken windows, ...) | 12 | not now | - | - | wait for a real failure (ratchet) | 05 |
| Presets (GSD, Spec Kit layers, BMAD picker) | 04 | not now | - | - | - | Preset rework fog |
| pstack wholesale, multi-model panels, Orchestrate | 02, 28 | nothing | - | - | too heavy; overlaps Pocock's chain | - |
| ICM stage folders | 03 | nothing | - | - | skills hold process here, not folders | - |

Separate idea raised in this session (inbox, not part of 05): levels of autonomy set by the type of project.

## From 35 (2026-11-24)

The four Working rules follow 35's split: for personal projects they live in the home repo's `AGENTS.md`, not in each project; `templates/AGENTS.md` includes them only for public, shared or work repos (07 decides how).
