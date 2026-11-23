# Owner notes on the three workflows

Roadmap decision ticket 29. An analysis of my own notes, not an outside source.

## Question

I took handwritten notes on Matt Pocock, Addy Osmani and pstack (plus harness engineering and the home repo pattern), then picked out main takeaways. For each takeaway: what does the toolbox already do, which research or ticket already covers it, what is new, and where should it go on the roadmap map?

## Sources

- My transcribed notebook (8 pages) and my "main takeaways" note, both kept in my vault, not in this repo.
- Earlier research: [Addy Osmani agent-skills](2026-11-22%20Addy%20Osmani%20agent-skills.md), [Cursor pstack and team kit](2026-11-22%20Cursor%20pstack%20and%20team%20kit.md), [Agent harness engineering](2026-11-23%20Agent%20harness%20engineering.md), [Addy Osmani agent-skills post](2026-11-23%20Addy%20Osmani%20agent-skills%20post.md), [Home repo pattern](2026-11-23%20Home%20repo%20pattern.md), [Flavio Copes on pstack](2026-11-23%20Flavio%20Copes%20on%20pstack.md).
- New research for the gaps: [Loops, sandboxes and session hooks](2026-11-23%20Loops,%20sandboxes%20and%20session%20hooks.md), [Verification and enforceable architecture](2026-11-23%20Verification%20and%20enforceable%20architecture.md).

## The common thread

Almost every takeaway says the same thing in a different way: **move rules out of prose and into things that enforce themselves.** Hooks instead of "remember to", lint and architecture tests instead of AGENTS.md lines, verification as a hard exit instead of "check your work", a banned-comments rule instead of trusting the agent. The toolbox today is almost all prose (skills, AGENTS.md, notes) with no hooks and no checks of its own. That is the biggest shift these notes point to.

The second thread: **less, plainer, smaller.** Scope discipline, boring design, code as a liability, atomic commits, short-lived branches, fewer markdown files, fewer comments, prune the codebase and the skills.

## Takeaways, one by one

| Takeaway | Toolbox today | Already covered by | New in my notes |
| --- | --- | --- | --- |
| **Home repo** (skills, settings, harness in one place; pointers to other repos; per-repo harness reachable from home) | Workflow repo copies skills and templates into each project | 27 (home repo pattern), 23 (updating), fog "Distribution" | Running sessions *from* the Workflow repo across projects; a Karpathy-style wiki in the home repo |
| **Ralph Wiggum loop** | Nothing; every session is driven by hand | 28 (finish condition, decision log for loops) | An autonomous loop mode, and the sandbox it needs |
| **Sandboxing** (not on my PC; good defaults, runtimes, git, tests, CLIs, headless browser) | Agents run on my PC | none | New |
| **Hooks** (start and end session as hooks; reinject state from files) | `/start-session`, `/end-session` are user-run skills | 25 (hooks are the biggest gap), 24 (leaner ship and end-session) | Which parts of the session skills become hooks |
| **Observability** | Nothing collected | 20 (what can be measured), 21 (measuring) | Nothing new; covered |
| **Meta-skill: scope discipline** (touch only what's asked, surface assumptions, stop and ask on conflicts, push back, prefer boring) | Spread across Pocock's skills; no single rule set | 01, 26 (scope discipline is the biggest single factor) | Put these five rules in `templates/AGENTS.md` (or a meta-skill), not scattered |
| **Intent, lifecycle and skill mapping** | Presets; change flows being decided | 13 (change flows), fog "Entry points vs building blocks" | A router: from what I said to which skill runs |
| **Doubt-driven development** (spec, plan, build, test, ship, simplify across all) | Pocock's to-spec, to-tickets, implement, `/ship` | 01, 05 | Nothing new; feeds 05 |
| **Anti-rationalisation table** | None of my skills have one | 01, 26 | Add to my own skills' anatomy (05) |
| **Trunk-based development** (short-lived branches, feature flags, atomic commits) | Short branches and PRs, squash or merge; no flags | 24 (fewer PRs) | Feature flags; atomic commits as a rule; fits 24 and 13 |
| **Code as a liability; boring and simple is best; nuance leads to slop** | Not stated anywhere | 12 (books: easier-to-change rule) | Principles for `templates/AGENTS.md`, with Chesterton's fence, Hyrum's law, DAMP over DRY in tests |
| **pstack: lint rules; the codebase is the best context, keep it pristine** | No lint or check setup in templates | 02, 28 | Every correction becomes a check (the "ratchet" from 25 in code form) |
| **Directory structure as context; dependency graph** | Templates set doc folders only, not code folders | none | Architecture rules as tests (enforceable architecture) |
| **Limit extra markdown; ADR clean-up and upkeep** | ADRs only when hard to reverse; no clean-up | 10 (artifact organisation), 26 (config decays) | A clean-up pass for ADRs and notes |
| **Ban most comments** (comments are excuses; non-enforceable) | Not stated | 26 (must-hold rules in checks) | A comment rule, ideally enforced by lint |
| **Verification is king** (a large share of agent time; runtime checks with dev tools; a feature map as shared vocabulary; formal checks, state machines, a statechart skill) | Tests and `/code-review` only | 25 (separate evaluator), 28 (how will we know it works) | A verification step per change; feature map; statecharts |
| **Enforceable architecture** | none | none | New |

From the notebook only (not in the takeaways): a review-agent step and agent types (feeds 06), TDD differences between Addy and Matt (feeds 05), better branch management (feeds 24), context engineering (the toolbox's core already), the test pyramid and Beyoncé rule (principles).

## What this means for the map

Already handled by existing tickets: observability (21), doubt-driven development and the anti-rationalisation table (05), intent and lifecycle mapping (13 and the entry-points fog), home repo distribution (23 and the distribution fog), fewer PRs and branches (24).

Clusters that have no ticket yet, each a candidate decision ticket:

1. **Enforcement layer (hooks)**: which guardrails become hooks (never commit to main, edit `skills/` not `.claude/skills/`, start and end of session), shipped how (template, global, beta trial).
2. **Verification**: what "verified" means per change flow (tests, runtime check with a browser, a feature map, statecharts for state-heavy work), and where it sits (before `/ship`, a skill, a hook).
3. **Enforceable codebase**: what a primed project gets for lint rules, architecture tests, a comment rule and a ban on stray markdown, per stack (feeds 07 repo profile).
4. **Principles in AGENTS.md**: scope discipline, boring design, code as a liability, Chesterton's fence; a short, ratcheted list (feeds 05; may fold into it).
5. **Autonomous loops and sandboxes**: whether the toolbox supports a Ralph loop at all, and in what sandbox. Probably fog until 1 and 2 are settled.
6. **Home repo as a workplace**: working on projects from the Workflow repo, and a wiki of what I learn (links to 08 learning and 10 artifacts).

## What the gap research changed

- **Hooks:** a SessionStart hook can feed `/start-session`'s git and PR facts (up to 10,000 characters), but proposing the next step and writing LOG/STATUS stay in skills; SessionEnd can't talk to the model (1.5 s budget). So "start and end session as hooks" becomes "hooks *back* the skills", not replace them. A PreToolUse hook can block commits to `main` and stray `.md` writes; GitHub branch protection is the guard that actually holds.
- **Loops:** `/goal <condition>` (built in) beats the ralph-loop plugin on Windows: no bash, the condition checked after each turn. A ticket's acceptance criteria can be the condition. Huntley himself only uses Ralph for greenfield work.
- **Sandboxes:** Claude Code's sandbox needs WSL2 on Windows and only covers shell commands. Unattended work goes to cloud sessions first (fresh VM with runtimes, Chrome, git, gh), then a dev container. Cloud sessions block GitHub GraphQL, so `/ship` would need a `gh api` fallback.
- **Verification:** the key is a pass/fail check plus evidence (command and output, or a screenshot), enforced on a dial from a prompt line to `/goal` to a Stop hook. Four stages for a solo developer: pre-merge, deploy, release (flag on), post-release. "Feature map" has no settled meaning: an own-design `docs/FEATURES.md` to trial.
- **Formal methods:** TLA+ is almost never worth it for small business apps. Cheapest useful version: a Mermaid `stateDiagram-v2` for any status field before coding, plus a transition-table test.
- **Enforceable architecture:** NetArchTest or ArchUnitNET for .NET (an `ArchitectureTests` project with about three rules), `.editorconfig` severities as errors; eslint-plugin-boundaries or dependency-cruiser for JS/TS. No linter bans comments wholesale: keep it a guideline.
- **Trunk-based:** trunkbaseddevelopment.com now frames the unit as "one developer and their coding agents"; Ship / Show / Ask fits a solo owner (notes Ship or Show, `skills/`/`tools/`/`templates/` Ask). Feature flags need an expiry and a removal task. Feeds 24.
- **Karpathy wiki:** raw sources, an LLM-maintained wiki, a schema file; ingest, query, lint; `index.md` plus append-only `log.md`. This repo has most of it already; a `notes/index.md` and a periodic notes lint would close the gap.

## What I might change

- Treat "rules in prose" as a smell: every new rule asks "could this be a hook, a lint rule or a test?"
- Add the scope-discipline rules to `templates/AGENTS.md` once 05 is decided.
- Open tickets for clusters 1-4; put 5 and 6 in fog.
