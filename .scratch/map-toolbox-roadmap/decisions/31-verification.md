# Verification and Checks lines

Type: grilling
Style: doubt
Status: resolved
Blocked by: 13

## Question

What counts as verified for each change flow, and where the check sits? Options on a dial: a "how we'll check it" line in every work ticket and plan, evidence required by `/ship` (command and output, or a screenshot), `/goal <condition>` for longer runs, a Stop hook that runs tests (moved here from 30). Also: runtime checks with a browser (playwright-cli or Chrome DevTools MCP), a trial `docs/FEATURES.md` feature map as shared vocabulary, Mermaid state diagrams plus a transition-table test for status fields, and the four stages for a solo developer (pre-merge, deploy, release, post-release).

Related: 25, 26, 28, 29, 30 (a Stop hook), 15 (after implementation); research in `notes/research/2026-11-23 Verification and enforceable architecture.md`.

## From 05 (2026-11-23)

`/ship` starts with a three-question check; "does it work" reads the verify evidence 31 defines. Every toolbox skill that writes or ships ends in a Verification checklist. `verify-this` (team kit) is a candidate verify-stage default.

## From 35 (2026-11-24)

Prefer checks every agent obeys (tests and CI, the evidence `/ship` reads) over a Claude-only Stop hook. Shared repos carry their checks as neutral process files (35).

## From 07 (2026-11-24)

Stakes (`spike | everyday | production`) seeds a **Checks** section in the project's `AGENTS.md`: the flow picks the stages, the Checks lines set how strict verify and review are. This ticket's answer feeds what each stakes value seeds (ticket 37).

## From 30 (2026-11-24)

Order of layers (30): CI and platform rules, then git hooks, then agent hooks as optional extras that only start existing scripts. A test-running Stop hook would be Claude-only; prefer tests in CI and a `pre-push` hook if a local gate is wanted.

## Map refit (2026-11-24)

Session A. Takes in, besides the question above:
- **37 point 2:** the concrete Checks lines each stakes value seeds (evidence before ship, when review is required, when an ADR, what the agent may do unasked). 37 keeps the packaging.
- **Release and deploy** (from 15): settle them here with the four stages (pre-merge, deploy, release, post-release); 15 no longer asks.
- **High-risk paths** (from the deleted Risk levels fog): a Checks line triggered by what a change touches (auth, secrets, migrations: grill first, wait a day, second reviewer; `platforms/*.md` "Risk levels (to develop)"), and where 05's `doubt-driven-development` trial sits. Stakes (per repo) and flows (by size) don't cover this.
- **`/goal`** for longer runs stays here; where unattended runs happen (cloud, dev container, WSL2) is a later roadmap item, not a decision for this map.

32 (checks in code) moved to 37: which checks a project is seeded with is packaging.

## From the inbox (2026-11-25)

Levels of autonomy by type of project: how much the agent may do unattended is set by stakes, in the Checks lines this ticket owns ("what the agent may do unasked"): `spike` loose, `everyday` in between, `production` asks first. `/goal` runs respect the same level. 37 packages the answer into seed files.

Can a plan be verified, not only code? Candidate: a design review as the plan's check (the architecture review on plans, placed by 34), run from a fresh context.

## From 40 (2026-11-26)

ICM's Audit tables (Check | Pass condition, run before saving, revise on a failure) go into the file-writing skills' Verification checklists as their format, not a second section.

## Answer

Resolved 2026-11-26 (grilling, `doubt`: two rounds, then a fresh-context subagent tried to disprove the summary; all ten objections taken, the last in part).

### Picks

| Source | Taken | Dismissed or parked |
|---|---|---|
| Pocock | Failing test as the bug-fix check; acceptance criteria per ticket; `/code-review` from fresh contexts. | - |
| Osmani | "How we'll check it" agreed before coding; a skill ends in a hard verification exit; must-hold rules in checks; doubt review for high stakes. | - |
| pstack / fstack | Every task gets a goal and a check, **run and shown**; the three-question check before ship reads the evidence; loops need a finish condition. | `verify-this` parked until a trial slot (05's one-at-a-time rule). |
| ICM | Every stage leaves a reviewable file; audit tables as the Verification checklist format (from 40). | - |
| Built-ins | A long run with a finish condition (`/goal` on Claude Code). | Stop hook rejected: Claude-only (30, 35). |

### Decisions

1. **Check line.** Every unit of code-changing work gets one `Check:` line at define, beside its goal: in the work ticket (new feature), the spec (small feature) or the chat (small change). It names something runnable: a command, a test name, or manual or smoke steps with the expected result (`-DryRun` counts); "it works" does not. Bug fix: the failing test plus the original repro. Spike: none.
2. **Code-changing** means a change matching the project's `code_pattern` setting (in this repo: skills, tools, templates), not only files with a test command. Everything else is docs-only and skips 1 and 3.
3. **Evidence.** The command and its output tail, or a screenshot or recording path for UI, in a `## Verification` section of the PR body. For a runnable check, `/open-pr` **runs the command itself** and pastes the real output rather than trusting text the agent wrote; it is the "does it work" of the three-question check, and `/open-pr` refuses a code-changing PR without it. Shared repos, where teammates have no toolbox skills, carry a `## Verification` section in their PR template and rely on CI; a CI check of the PR body arrives only after a recorded failure.
4. **What runs checks.** CI runs `test_command` on every PR where one exists; a `pre-push` gate is an available setting. No Stop hook. A long unattended run uses the `Check:` line as its finish condition (`/goal` on Claude Code; other agents use their own equivalent or none).
5. **Checks section.** Every repo, personal or shared, carries its own `## Checks` in `AGENTS.md`, inline, or as one pointer line to `docs/agents/checks.md` once it passes about six lines. **Revises 07 point 4** (Checks were in the shared-only block). Skills read only these lines, never stakes. After seeding the section belongs to the project: refit never overwrites it, only offers toolbox default changes as a diff.
6. **Line form** `stage.knob[.flow]: value`; the most specific line wins (`review: code-review`, `review.small-change: none`). Flow-specific lines are allowed but none are seeded.
7. **Seeded settings (the starting point; the set is open).** Only what the owner's must-have principle needs is seeded on:

   | Setting | Values | spike | everyday | production |
   |---|---|---|---|---|
   | `verify.check_line` | required / optional | optional | required | required |
   | `verify.evidence` | required / optional / none | none | required | required, plus a screenshot for UI |
   | `review` | none / self / code-review | none | code-review (small change: self) | code-review |
   | `autonomy` | loose / normal / ask-first | loose | normal | ask-first |

   **Available, off by default**, documented in the toolbox and switched on per project by 09's ratchet (a recorded failure, an experiment or research): `plan.review`, `adr`, `high_risk`, `gate.pre_push`, `deploy`. 30's rule holds: a check only after a recorded failure. New settings and values arrive the same way.
8. **Autonomy.** Always: never merge, never push to `main`, never delete branches nobody asked to delete. **loose**: may commit, push its branch and open a PR unasked; **normal**: also asks before adding dependencies, deleting files outside the task, or changing CI or config; **ask-first**: also asks before each push and before starting a long run. Home's per-agent permissions are the ceiling; a project's `autonomy` line can only narrow them. Long runs follow the same level. More levels as the workflow evolves (09).
9. **High risk** (`high_risk`, off by default): paths and globs only, never topics an agent cannot match. A change touching one gets a grilling first, a fresh-context doubt review (like this session's; 05's `doubt-driven-development` trial slots in here once promoted), and advice to the owner to merge the next day. Replaces "Risk levels (to develop)" in `platforms/*.md` (a roadmap item removes it).
10. **Plan check** (`plan.review`, off by default): values name a kind of review, not a skill: `design-review` (shape and scope) or `doubt` (try to disprove; dismissed objections kept with reasons). It stays off until a skill for that kind is promoted (05, 34). Where it sits in the flow: 34. Ties to the owner's doubt-driven design principle.
11. **The four stages.** Flows end at pre-merge (verify, review, ship). Deploy (smoke test), release (flag on, re-run the check) and post-release (logs after a day, remove the flag) are the `deploy` setting, for projects that deploy. Every release flag gets a removal ticket and a date.
12. **Extras.** A runtime browser check for web projects as an optional beta-trial skill using playwright-cli (Chrome DevTools MCP mentioned for console and network, telemetry flags off); no default install. `docs/FEATURES.md` parked. A ticket that adds or changes a status field gets a Mermaid `stateDiagram-v2` and a transition-table test: one line in `docs/agents/change-flows.md`, not in Pocock's skills.
13. **Toolbox skills that write or ship** end in a `## Verification` audit table (Check | Pass condition), run before reporting done; a failure is fixed, not reported past.
14. **Observable, evolving, staged.** `/open-pr` writes the Checks lines in force into the PR's `## Verification` section, so each PR records the rules it met; git history of the Checks section is the trace of how they changed. Each change to a Checks line is its own commit with its reason; the message format and the tighten / loosen loop go to 09. Changes to the toolbox's default seeds go through the beta track (17).

### Dismissed objection

- Point 13's audit table contradicts 05 point 10 ("no audit tables"): 40 superseded that line. Kept as decided.

### Handed on

- **07**: point 4 revised (every repo carries Checks).
- **09**: the ratchet that switches settings on and off, the commit format for Checks changes, new settings and autonomy levels.
- **15**: `/open-pr` runs the check and writes `## Verification` (evidence plus the Checks lines in force); release and deploy are settled here.
- **34**: where `plan.review` and the high-risk doubt review sit; the state-diagram line in `change-flows.md`.
- **37**: package the four seeded settings, the off-by-default list and the shared repos' PR template section; `deploy` set at setup only if the project deploys.
- **Roadmap items**: remove "Risk levels (to develop)" from `platforms/*.md`; Verification audit tables in the toolbox's own skills; the browser-check beta trial.

Decision 0014.
