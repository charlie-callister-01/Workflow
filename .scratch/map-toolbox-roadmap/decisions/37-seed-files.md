# Seed files: reworking presets into profile seeds

Type: grilling
Style: rounds
Status: resolved
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

## From 15 (2026-11-26)

No `ship.*` lines are seeded (`ship.mode`, `ship.automerge.docs`, `ship.ci_watch`, `ship.ci_tries`); the defaults live in `/open-pr` and the Shipping guide.

## From 34 (2026-11-26)

`docs/agents/change-flows.md` is a plain template copy (changes go through Checks lines, `<stage>.skill[.flow]` and `<stage>.tier[.flow]`, none seeded). Shared repos get 13's six-line flow and size table in the shared-only block; personal repos get it from home's `AGENTS.md`.

## Answer

Resolved 2026-11-27 (grilling, `rounds`: two rounds). Decision 0017.

### Picks

| Source | Taken | Dismissed or parked |
|---|---|---|
| Pocock | Setup copies files once and the project owns them; a named one-off migration for older layouts (his `CONTEXT.md` to `GLOSSARY.md` step, 23's `migrations/`). | - |
| Osmani | Seeds stay small ("a good harness can't be downloaded"); must-hold rules go in hooks or checks, so `everyday` and `production` seed git hooks. | - |
| pstack / fstack | A near-empty `spike` seed; mistakes turned into rules (lint rules, checks) as part of the workflow, handed to 09. | - |
| ICM | One setup questionnaire with defaults, asked once; a leftover-placeholder scan decides when setup is done. | Copy-and-drift workspaces rejected: 23's three-way merge replaces it. |

None of the four seeds by stakes or by audience; stakes-based seed files are the toolbox's own choice. Spec Kit, BMAD and GSD Core stay parked (map Notes, Sources).

### Decisions

1. **Layout.** A new `seeds/` folder with one file per stakes value: `spike.md`, `everyday.md`, `production.md`. Each holds the literal `## Checks` block to paste and a short "also seeds" list (`.githooks/` for `everyday` and `production`, a branch-protection note for the setup guide). Literal lines let the install script copy them without an agent reading a table, and each file's history is 23's merge base. Audience stays the marked shared-only block in `templates/AGENTS.md` (07); platform stays `platforms/*.md` (toolbox files, so no migration). `presets/` is deleted in v2 and stays readable at tag `v1.0`.
2. **v1 projects naming a preset.** Migration (d) (23) retires the `preset:` line; refit asks the profile questions (10) with defaults from the old preset (`full`, `lite`, `fast-lane`: `everyday`, `personal`; `team`: `shared`) and never fills them silently. Existing Checks lines are never overwritten; the seed's lines are offered as a diff (31 point 5).
3. **Shared-only block.** Plain steps a teammate with no home and no toolbox can follow: branch naming and never commit to `main`; 34's six-line flow and size table worded so each step can be done by hand, skill names only in brackets as the owner's shortcuts; "the Checks below apply to everyone"; a pointer to the PR template's `## Verification` section. Working rules stay opt-in, off by default (07). Process only: nothing from home, no personal practice.
4. **Team and Azure.** `presets/team.md` goes and there is no team seed. Required human review and reviewers by path: a platform branch policy described in the setup guide for shared repos (with 30's branch protection), not a Checks line. Explainers as the reviewer's aid: already `/open-pr`'s for code PRs. Boards mirror scripting and work-item links: stay under "To develop" in `platforms/azure.md`. STATUS per person: 39. Risk levels: already replaced by `high_risk` (31). A shared, `production`, `azure` repo gets the shared-only block, `production`'s Checks and hooks, and the Azure platform file and PR template: neutral process files only.
5. **Code checks per stack (from 32).** None seeded. For `everyday` and `production`, setup offers one opt-in per detected stack: lint rules as errors (`.editorconfig` severities for .NET, ESLint for JS/TS); the snippets live in the guide, not `templates/`. Architecture tests and a comment guideline arrive only after a recorded failure. Turning an agent's mistake into a lint rule or check is part of the workflow (pstack, Osmani): handed to 09's ratchet.
6. **Guide.** `seeds/README.md` is the module's guide: what each stakes value seeds and why, every available Checks setting with values and how to switch it on (the off-by-default `plan.review`, `adr`, `high_risk`, `gate.pre_push`, `deploy` included), the `deploy` question, and how to tell it works (trace: `## Seeded from` plus the Checks lines each PR's `## Verification` records). The Shipping guide (15) and `change-flows.md` (34) link here instead of repeating it.
7. **`spike`** gets all four Checks lines (`verify.check_line: optional`, `verify.evidence: none`, `review: none`, `autonomy: loose`) and no hooks, so every repo has the same shape and promoting a spike is a line diff (07 point 9).
8. **Placeholder scan.** `/setup-workflow` and `/refit-workflow` end with a `## Verification` row that fails if any `<...>` or `{{...}}` placeholder is left in a seeded file; files read before setup hold none. This is the roadmap's leftover-placeholder item (40).
9. **Setup questions.** One numbered list, each with a default, asked once before anything is written: audience (`personal`), stakes (`everyday`), platform (`github`), agents (pick any number, default `claude`; the owner often uses several in one project, and per 06 it changes no project file, only which per-agent setup home applies), deploys? (`no`; if yes, the `deploy` line), and per detected stack for `everyday` and `production`, lint rules as errors (`yes`). The script takes the answers as parameters. Refit asks the same list with defaults from `## Seeded from` or the old preset.
10. **Rollout and evaluation.** Built on the beta track as `beta/seeds/` (17). Trialled on two cases: the next new project, and a refit of this Workflow repo off preset `lite` (the first v1 project, running migration (d)). Passes when both finish with no placeholders left, `/open-pr` writes the seeded Checks lines into `## Verification`, and no seeded line is edited back during the trial. Watch: every Checks line changed after seeding, with its reason, as input to 09.

Glossary: Seed file.

### Handed on

- **09**: turning a mistake into a lint rule or check; Checks lines edited after seeding as evidence that a default is wrong.
- **39**: STATUS per person for shared repos (from `presets/team.md`).
- **Roadmap items**: build `beta/seeds/` and `seeds/README.md`; delete `presets/` with migration (d); setup's questionnaire; the setup guide's branch-policy section for shared repos.
