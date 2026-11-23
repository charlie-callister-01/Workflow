# Verification and enforceable architecture

## Question

Five related questions from the owner notes on three workflows (rows "Verification is king", "Trunk-based development", "Home repo"):

1. How should agent-written code be verified: runtime checks the agent drives in a browser, a "feature map" as shared vocabulary, and stages (pre-merge, deploy, release, post-release)? What is practical solo?
2. What is the cheapest useful version of formal-ish methods: TLA+, explicit state machines, statecharts, an agent drawing a statechart?
3. Which tools turn architecture and directory rules into checks, for .NET and JS/TS, and can comments or stray markdown files be banned by lint or hook? Which fit a starter template?
4. How does trunk-based development fit one developer with agents and the "branch, PR, owner merges" flow?
5. What is Karpathy's LLM wiki and how would it fit a home repo?

pstack's "turn corrections into deterministic checks" is in `2026-11-23 Flavio Copes on pstack.md`; hooks as the enforcement layer and the ratchet are in `2026-11-23 Agent harness engineering.md`. Not repeated here.

## Sources

Read 2026-11-23.

Verification
- [Claude Code best practices](https://code.claude.com/docs/en/best-practices): "Give Claude a check to run" and "Enforce the rules that can't have exceptions".
- [Claude Code hooks reference](https://code.claude.com/docs/en/hooks): PreToolUse, exit code 2, matchers.
- [microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp) and [microsoft/playwright-cli](https://github.com/microsoft/playwright-cli).
- [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp).
- [Martin Fowler, Deployment Pipeline](https://martinfowler.com/bliki/DeploymentPipeline.html).
- "Feature map": searched; no primary source or settled meaning found. Closest are one project's `FEATURE-MAP.md` ([code-as-plan docs](https://dwall-sys.github.io/code-as-plan/features/feature-map)) and a Chalmers thesis on feature traceability for agents ([Agent HAnS](https://odr.chalmers.se/bitstreams/c68221bc-8a8a-4c7d-a5f8-b1b02ab1ef6b/download)). Neither is authoritative.

Formal-ish methods
- [Leslie Lamport, Industrial use of TLA+](https://lamport.azurewebsites.net/tla/industrial-use.html).
- [Hillel Wayne, Learn TLA+ FAQ](https://learntla.com/intro/faq.html).
- [Stately, State machines and statecharts](https://stately.ai/docs/state-machines-and-statecharts) and [XState docs](https://stately.ai/docs/xstate).
- [Mermaid stateDiagram syntax](https://mermaid.js.org/syntax/stateDiagram.html).
- Harel, "Statecharts: a visual formalism for complex systems", *Science of Computer Programming* 8 (1987), [doi:10.1016/0167-6423(87)90035-9](https://doi.org/10.1016/0167-6423(87)90035-9). Cited for origin; not re-read.

Enforceable architecture
- [NetArchTest](https://github.com/BenMorris/NetArchTest) (MIT), [ArchUnitNET](https://github.com/TNG/ArchUnitNET) (Apache 2.0).
- [Microsoft Learn, Configure code analysis rules](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/configuration-options).
- [dependency-cruiser](https://github.com/sverweij/dependency-cruiser), [eslint-plugin-boundaries](https://github.com/javierbrea/eslint-plugin-boundaries), [ESLint no-inline-comments](https://eslint.org/docs/latest/rules/no-inline-comments).

Trunk-based development
- [trunkbaseddevelopment.com](https://trunkbaseddevelopment.com/), its pages on [short-lived feature branches](https://trunkbaseddevelopment.com/short-lived-feature-branches/) and [feature flags](https://trunkbaseddevelopment.com/feature-flags/).
- [Martin Fowler, Patterns for Managing Source Code Branches](https://martinfowler.com/articles/branching-patterns.html) (first 100k characters read).
- [Pete Hodgson, Feature Toggles](https://martinfowler.com/articles/feature-toggles.html).
- [Rouan Wilsenach, Ship / Show / Ask](https://martinfowler.com/articles/ship-show-ask.html).

LLM wiki
- [Andrej Karpathy, "LLM Wiki" gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) (created 4 April 2026). Comments under it are third party and not relied on.

## What I learned

### 1. Verification

- **A check that returns pass or fail is the whole game.** Anthropic: "Claude stops when the work looks done"; without a check "you become the test suite". A check can be a test, a build exit code, a linter, a fixture diff or "a browser screenshot next to the mockup". The single most useful line in `CLAUDE.md` is the command that runs it.
- **Strictness is a dial**: in the prompt, `/goal` (a separate model checks a condition each turn), a `Stop` hook (exit 2 sends Claude back to work; capped at eight blocks in a row), or `/code-review` in a fresh subagent. Whatever the level, ask for *evidence*: the command and its output, or the screenshot. `/verify` has Claude build, run and look at the app, catching what tests and typechecks miss.
- **Runtime verification tools.** Playwright MCP drives a page through the accessibility tree, not pixels (`browser_snapshot` "is better than screenshot"); install `claude mcp add playwright npx @playwright/mcp@latest`. But Microsoft's own README now recommends **playwright-cli plus skills for coding agents** because "CLI invocations are more token-efficient"; MCP is for long loops needing persistent browser state. `playwright-cli install --skills`; commands `open`, `snapshot`, `click <ref>`, `screenshot`. Chrome DevTools MCP adds what Playwright lacks: console messages with source-mapped stacks, network requests, performance traces. Caveats: it exposes browser content to the client, sends usage statistics by default (`--no-usage-statistics`) and may send trace URLs to Google CrUX (`--no-performance-crux`).
- **Stages.** Fowler's pipeline: early fast stages (build, unit tests) catch most problems; later stages are slower and more thorough, possibly manual; deploying to production is usually last; each stage buys confidence at the cost of time. Hodgson's release toggles add a split between *deploy* (code in production, switched off) and *release* (flag on). For one developer that gives four practical stages:
  - **Pre-merge**: build, tests, lint and architecture tests, plus an agent-driven runtime check of the changed feature with evidence in the PR.
  - **Deploy**: a smoke test against the deployed app (does it start, does the home page and login load).
  - **Release**: turn the flag on, re-run the feature's check in production or staging.
  - **Post-release**: look at logs and errors after a day; remove the flag.
- **Feature map.** No standard meaning exists. A useful own version: a short `docs/FEATURES.md` listing each user-visible feature with an ID, where it lives (route or screen) and how to check it (steps or a test name). It gives owner and agent the same names ("F12 invoice export broke"), tells the runtime check what to click, and shows which features a change touches.

### 2. Formal-ish methods, lightly

- **TLA+ checks designs, not code.** Lamport's list of industrial use is cache coherence (Intel), cloud services (AWS since 2011, Azure, Cosmos DB consistency), two-phase commit (Dropbox), Kafka replication. Wayne's FAQ: it suits concurrent and distributed systems and work spanning several services or human actors; it is poor for numerics, strings, probabilities and real-time deadlines; it "isn't 'better than' testing", and if you don't already test it "isn't the best investment". Start with PlusCal. For small business apps: almost never worth it; maybe for a sync or retry protocol across two systems.
- **Statecharts** (Harel 1987) extend flat state machines with hierarchy (child states active only inside a parent), parallel regions, and history. XState v5 is the JS/TS implementation (`createMachine`, `createActor`, `send`), with Stately Studio as a visual editor and `@statelyai/inspect` for runtime inspection. In C# the equivalent is a plain `enum` plus a transition table, or a small library.
- **Mermaid `stateDiagram-v2`** covers most of a statechart: `[*]` start and end, labelled transitions `A --> B: event`, composite (nested) states, `<<choice>>`, notes, and `--` for concurrent regions. It renders in GitHub markdown and is text, so an agent can write it and a diff can review it. Mermaid's page doesn't mention Harel and has no history or guard syntax beyond labels.
- **The cheapest useful version**: for any entity with a status field (order, invoice, job), the agent draws a Mermaid state diagram of states and allowed transitions *before* coding, the owner reviews the picture, then a table-driven test asserts every allowed transition succeeds and every other one is rejected. The diagram is the spec; the test keeps the code honest. XState only when the UI itself is state-heavy.

### 3. Enforceable architecture

- **.NET**: architecture rules as unit tests. NetArchTest (MIT) is a small fluent API: `Types.InAssembly(...).That().ResideInNamespace("App.Web").ShouldNot().HaveDependencyOn("App.Data").GetResult().IsSuccessful`. ArchUnitNET (Apache 2.0, port of Java's ArchUnit) is richer, with `.Because("...")` reasons in failures and packages for xUnit, xUnit v3, NUnit and MSTest; it looks more actively maintained (more commits and open PRs). Either drops into the test project and runs in `dotnet test`.
- **.NET analyzers**: on by default from .NET 5. `<AnalysisMode>` sets how many rules are on; `.editorconfig` sets severity per rule with `dotnet_diagnostic.<ID>.severity = error` (or per category, `dotnet_analyzer_diagnostic.category-<cat>.severity`). `error` fails the build. Bulk `.editorconfig` settings are ignored when `AnalysisMode`/`AnalysisLevel` is set, so pick one approach. This makes style and quality rules a build gate the agent can't skip.
- **JS/TS**: dependency-cruiser (`npx dependency-cruiser --init` writes rules for circular deps, missing package.json entries, orphans; custom `forbidden` rules with `from`/`to` path regexes; can output mermaid or dot graphs). eslint-plugin-boundaries classifies folders as element types and the `boundaries/dependencies` rule allows or disallows imports between them, reported as ordinary ESLint errors. dependency-cruiser is a separate CI step; boundaries shows errors in the editor too.
- **Banning comments**: no linter bans comments wholesale. ESLint's `no-inline-comments` (frozen, not deprecated) only bans comments on the same line as code. In practice this stays an `AGENTS.md` guideline or a review point (pstack has a `no-comments` skill); a hook would be too blunt.
- **Banning stray markdown files**: a good fit for a Claude Code `PreToolUse` hook on `Write` that reads `tool_input.file_path` and exits 2 with a reason when a new `.md` lands outside allowed folders (`docs/`, `notes/`, root `README.md`, etc.). Anthropic's advice: a hook is for a rule with zero exceptions; keep the enforced set small.
- **Starter template fit**: for a .NET template, one `ArchitectureTests` project with three or four NetArchTest rules (UI doesn't reference data, domain references nothing) plus an `.editorconfig` with a handful of rules at `error`. For JS/TS, eslint-plugin-boundaries if ESLint is already there, otherwise dependency-cruiser. Rules should mirror the folder map already in `AGENTS.md`, so the map is checked, not just described.

### 4. Trunk-based development, solo with agents

- **Definition**: everyone integrates into one branch and resists long-lived branches. Short-lived feature branches are allowed: "should only last a couple of days", one developer per branch, merged to trunk only when closing out, then deleted. The site now says "the unit is one developer and their coding agents", and that worktrees should be removed once their branch is merged. Review counts: integration is trunk-based only "after a prioritized code review", and "time spent waiting for review counts towards the branch's short life". Before pushing, run the full pre-integrate build locally. "Very small teams may commit direct to the trunk."
- **Fowler**: the difference between CI and feature branching is *when* you integrate, not whether a branch exists. Pre-integration review (PRs) adds latency; refinement review (after merge) suits high-trust teams.
- **Ship / Show / Ask** fits a solo owner well: *Ship* straight to main (docs, notes, trivial fixes), *Show* (PR opened and merged at once, for the record), *Ask* (PR waits for review). The author merges their own PRs; flags keep main releasable.
- **Feature flags**: release toggles are short-lived and static; a plain `if` at one point is enough. Treat flags as inventory with a carrying cost: add a removal task when you add the flag, give it an expiry date, even a "time bomb" test that fails after the date. trunkbaseddevelopment.com suggests listing flags in the README with a "review for delete" date. Old behaviour when off, new when on.
- **Atomic, revertible commits**: implied rather than stated as a rule on these pages; the mechanism is small changes behind flags so `git revert` of one commit or one merge removes one thing.
- **Fit with "branch, PR, owner merges"**: it already is trunk-based with short-lived branches, provided branches live hours to a day or two and the PR is reviewed promptly. The gaps are: no flag habit, and every change waits for the same review regardless of risk.

### 5. Karpathy's LLM wiki

- **What it is** (gist, April 2026, "intentionally abstract"): instead of retrieving from raw documents on every question, an LLM builds and maintains a persistent, interlinked markdown wiki, "a persistent, compounding artifact". Three layers: **raw sources** (immutable, LLM reads, never edits), **the wiki** (LLM writes, human reads), **a schema** file such as `CLAUDE.md` or `AGENTS.md` setting structure and workflow, refined together.
- **Operations**: *ingest* (summarise a source, update the index, revise related pages, log it; one source may touch 10 to 15 pages); *query* (read relevant pages, answer with citations, file useful answers back as pages); *lint* (periodic check for contradictions, stale claims, orphan pages, missing links).
- **Two files**: `index.md`, a catalogue by category read first on every query (works to about 100 sources and hundreds of pages; beyond that add search); `log.md`, append-only with a greppable prefix such as `## [date] ingest | Title`. Suggests Obsidian to read, git for history.
- **Fit with a home repo**: the toolbox already has most of it. `notes/research/` is the raw-source summaries, `GLOSSARY.md` and `notes/decisions/` are wiki-like pages, `AGENTS.md` is the schema, `docs/LOG.md` is the log. What's missing is an index read first, the habit of revising *existing* pages on ingest rather than only adding a dated file, and a lint pass.

## What the toolbox might change

1. **A "how we'll check it" line, with evidence, per change** (extends harness note item 4). `/ship` asks for the command and output, or a screenshot, in the PR body. Cheapest win; no new tools.
2. **An optional runtime-check skill for web projects**: prefer playwright-cli with its skills (token-cheap) over Playwright MCP; mention Chrome DevTools MCP for console and network, with its telemetry flags off. One page in `CUSTOMISING.md`, no default install.
3. **`docs/FEATURES.md` in the project template**: ID, where, how to check. `/start-session` and the runtime check read it; a PR names the feature IDs it touches. Trial on one project first since there is no prior art to copy.
4. **A state-diagram step for status fields**: when a ticket adds or changes a status, the agent draws a Mermaid `stateDiagram-v2` in the ticket or ADR before coding and writes a transition-table test. A few lines in the plan or implement skill. Skip TLA+ and XState by default.
5. **Architecture tests in the .NET starter**: an `ArchitectureTests` project (NetArchTest, three rules) and an `.editorconfig` with a few rules at `error`, mirroring the `AGENTS.md` folder map. For JS/TS note eslint-plugin-boundaries or dependency-cruiser as the option. Belongs in the setup templates; record the choice in a decision.
6. **A no-stray-markdown hook** in the optional hooks kit (harness note item 3): PreToolUse on `Write`, exit 2 for new `.md` outside an allow-list. Leave "no comments" as a guideline.
7. **Ship / Show / Ask in the presets**: notes and docs = Ship or Show (fits ticket 24, fewer PRs); `skills/`, `tools/`, `templates/` = Ask. Add a branch-age note ("merge within a day or two") and, for app projects, a flag rule: a release flag gets a removal ticket and a date.
8. **LLM wiki, lightly**: add `notes/index.md` read first by `/start-session` in the home repo, and a periodic "lint the notes" task (contradictions, stale ideas, orphans). Don't adopt Obsidian or a separate wiki; the notes folder already is one.
