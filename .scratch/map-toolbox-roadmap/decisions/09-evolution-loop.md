# Evolution loop and evidence

Type: grilling
Style: interview
Status: resolved
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

## From 15 (2026-11-26)

Shipping rolls out in three stages (15 point 11), each watched for about a week on PRs per session, tokens per ship and anything lost; this ticket owns how those evaluations run and decide. **Owner's open question (2026-11-26):** should trials be per module (a module switched on for a project, evaluated, promoted) rather than per `<skill>-beta` copy (17)? Decide here, revising 17 if so.

## From 34 (2026-11-26)

Routing stage 1 (34 point 13) is evaluated on how often the owner corrects the agent's first proposed flow, skill or method, plus tokens; decide how corrections are counted (39 owns any LOG-line marker). Recurring "no skill fits" gaps arrive as `/idea` lines for the ratchet to turn into a skill or a table row.

## From 37 (2026-11-27)

Turning an agent's mistake into a lint rule or check is part of the workflow (pstack, Osmani); 37 only offers lint rules as errors at setup, the rest arrives through this ratchet. The seed trial watches every Checks line changed after seeding, with its reason: a seeded line edited back is evidence that the toolbox default is wrong.

## From 39 (2026-11-27)

LOG lines carry an optional `Flow: <flow>` tail with `(corrected from <flow>)` when the owner changed the first proposed flow. `/end-session`'s lesson answers arrive as `/idea` lines tagged `lesson`; `retro`'s cadence on the worst sessions is decided here. The session-bookends trial counts tokens per start and end, re-explanations after `/clear`, and missed-save flags.

## From the idea inbox (2026-11-27)

A first recorded failure for the ratchet: a private project ran out of GitHub Actions minutes because every push, docs and notes included, ran the full CI and build. 31 says CI runs `test_command` on every PR, and 15 cut docs-only PRs to one per session but leaves CI as it is. Decide whether a CI that skips docs-only changes (keyed on `code_pattern`; `paths` filter, or a "changes" job when the build is a required check; `concurrency` cancel-in-progress; Linux runners) is offered at setup like 37's code checks or seeded for private repos, and whether usage (Actions minutes, as well as tokens) is a marker the evolution loop watches. Building the template is a roadmap item.

## Answer

Resolved 2026-11-27 (grilling, `interview`: fourteen questions, one at a time). Decision 0019.

### Picks

| Source | Taken | Dismissed or parked |
|---|---|---|
| Pocock | `retro` as the ratchet's review step, reading the session's own transcript; `chief-of-staff`'s cadence, about 1 session in 5, worst first. | - |
| Osmani | The removal test (switch it off, run real work, keep it only if its absence shows); "configuration has a half-life"; Tier 1 skill lint; every `AGENTS.md` line traced to a failure. | Tier 2 (description collisions) and Tier 3 (behavioural evals): parked until the toolbox has enough skills for collisions to matter. |
| pstack / fstack | The gate: proposals sorted accepted / rejected / backlog, kept with reasons, nothing changed without a yes. | `reflect` / `correct`: rejected, they duplicate `retro` (05). `workflow-from-chats` / `automate-me`: parked. |
| ICM | A trial's pass condition written before it starts; its result written to a plain file. | - |

### Decisions

1. **Trials are per module** (the owner's question from 15; revises 17). A trial is one module switched on, through its setting, in one project, evaluated, then kept, tuned or dropped. A `<skill>-beta` copy and the template beta track are how a module's change is carried, not the unit of trial.
2. **Pass condition, written before the trial starts.** 1 to 3 markers, each with a baseline (the same project before, or production) and a target; a **drop if** line naming the harm that ends it; a review-by date (default 1 week). **Usage is always measured** whatever markers are chosen: tokens per session, and Actions minutes where the project has CI. The owner may add an **opinion** line beside the numbers; it is never a marker (21's "no self-rating" stands for markers). The owner makes the keep / tune / drop call.
3. **Markers.** `session-facts --end` (39) appends one row per session to home's `markers/<machine>.csv` (append-only per machine, like the idea inbox; private because home is): date, session id, project, flow, modules on, tokens (main and subagents), peak context %, turns, skills used. Actions minutes come from `gh api` billing at review time. Other agents get an `n/a` row (date and project) so the gap shows. A status-line plan % column is added only if a trial needs it.
4. **Evaluation file.** Each trial gets `notes/trials/<slug>.md`: module, project, markers with baseline, target and drop if, review by; at the end the results (from the scripts), the owner's optional opinion, the verdict and **what was learned**. `notes/trials.md` becomes an index, one line per trial (module, review by, verdict, link). On keep, what was learned updates the module guide's "how to tell it's working"; on drop the file stays as the record of why. Private projects are named generically.
5. **`retro` in a weekly review.** Once a week, from home, a script ranks the week's sessions from the markers file (tokens against the project's usual level, corrected flows in LOG lines, missed-save flags, `lesson` ideas) and `retro` runs on the worst 1 in 5 (at least one), each in a fresh subagent reading that session's transcript by its session id (kept 30 days; weekly is well inside). Transcripts are per machine, so the review runs per machine; cloud sessions and other agents rely on their `lesson` line and LOG. Escape hatch: answering `/end-session`'s lesson question with `retro now` runs `retro` at once on the live session. A skipped week is covered by the next.
6. **The gate.** Each sitting writes `reviews/YYYY-Www.md` in home: every proposal with its source session, the owner's call (accepted / rejected / backlog) and a one-line reason. Accepted proposals go out as `/idea` lines to their repo and are built through its normal flow; rejected ones keep their reason so a repeat is recognised; backlog items reappear each week and drop after 60 days. A rule, check or setting goes **on** only through an accepted proposal (a recorded failure), a trial kept (an experiment) or a research pick, each committed in 31's format: `chore(checks): <setting> <old> -> <new> because <reason>`.
7. **Removal is a trial in reverse.** A module, Checks setting, `AGENTS.md` line, hook or skill is switched off in one project for the review period, kept only if the failure it was added for comes back. Triggers, checked at the weekly review: a new model comes into use (research 25), an `AGENTS.md` past about 60 lines, or 90 days with no recorded catch in an item's trace. At most one removal trial at a time.
8. **Seed drift, monthly.** At the first weekly review of the month a home script compares each project's `## Checks` with the seed recorded under `## Seeded from`, listing each changed line with the reason from its commit. Two or more projects of the same stakes changing the same setting the same way becomes a proposal to change the seed, gated like any other.
9. **Migrations retire** to `migrations/archive/` once every project in home's `## Other repos` is past them (version under `## Seeded from`), checked in the monthly sitting; refit can still read the archive for a long-dormant project.
10. **CI that skips docs-only changes** (the first recorded failure: a private project ran out of Actions minutes). Setup and refit read the project's existing CI; where a build or test job runs on docs-only changes, they propose the edit (a `paths` filter, or a "changes" job when the build is a required check, plus `concurrency` cancel-in-progress), default yes for private repos and no for public ones, recorded as `ci.skip_docs: on`. The toolbox still writes no CI of its own (37); shared repos get it through setup's shared-repo questions (37). It is the worked example in the evolution guide.
11. **Running it.** A home `weekly-review` script (POSIX `sh` plus `ps1`, like 15's) prints a short agenda (~15 lines, counts and names): ranked sessions, trials past review by, the idea batch, the backlog; monthly items only in the first week; removal triggers only when they fire. A `/weekly-review` skill walks it one item at a time, runs the `retro` subagents and writes the review file. `session-facts` at `/start-session` adds one line, "weekly review due", once 7 days pass since the last review file.
12. **Skill lint (Tier 1).** `tools/lint-skills` (sh and ps1): frontmatter present, `name` matches the folder, description about two lines (34), no clash with a built-in command, beta copies named `<skill>-beta`. Runs in this repo's CI only when `skills/` or `beta/skills/` change (point 10's rule applied to the toolbox; free on a public repo), and home's copy script refuses a skill that fails it.
13. **Building the owner's own skills.** A pick (picks panel, research or idea) becomes a module with its guide; a new or changed skill is carried as `<skill>-beta` and trialled per points 1 to 4; keep promotes it. Skills stay focused on the workflow and usage weighs in the keep call. A skill may combine skills from several repos; its guide names every source with its version, so the monthly `notes/upstream.md` sync (30) finds every skill an upstream change touches. Wording-only fixes skip the trial if lint passes; anything that changes behaviour is trialled.
14. **Rollout, three stages.** Stage 1, evidence: the markers row (needs 39 stage 1), the trial file and slim board; lint and `ci.skip_docs` are independent and can go first. Stage 2, the weekly review: script, skill, `retro` on transcripts, `retro now`, the review file and gate. Stage 3, monthly and triggers: drift check, migration retirement, removal trials. **Settings** in home (the review spans projects): `review.cadence` (weekly), `retro.share` (1 in 5), `backlog.max_age` (60 days), `ideas.batch_offer` (5, from 41), `removal.agents_lines` (60), `removal.idle_days` (90). **Trace**: the markers file, trial files, review files. **Evaluation of the loop itself** after about 4 weekly reviews: minutes and tokens per review, share of `retro` proposals accepted, at least one rule traced to a real failure, reviews actually held. Drop if reviews are skipped two weeks running.

Glossary: Trial (revised), Pass condition, Marker, Weekly review, Removal trial.

### Handed on

- **17**: revised by point 1 (trials per module); note added there.
- **10**: new artifacts: `notes/trials/<slug>.md`, home's `markers/` and `reviews/`; how trial files relate to ideas, CHANGELOG and decisions.
- **Directory and design**: where `markers/`, `reviews/` and `notes/trials/` sit.
- **37 and setup**: the `ci.skip_docs` check in setup and refit, with the shared-repo questions.
- **Roadmap items**: the three stages above.
