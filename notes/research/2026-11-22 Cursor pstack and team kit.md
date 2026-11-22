# Cursor pstack and cursor-team-kit

## Question

What do Cursor's `pstack` and `cursor-team-kit` plugins offer, how are Cursor plugins packaged compared with Claude Code skills/plugins, and what is worth taking into this toolbox?

## Sources

- Repo root and layout: [cursor/plugins README](https://github.com/cursor/plugins/blob/main/README.md), [`.cursor-plugin/marketplace.json`](https://github.com/cursor/plugins/blob/main/.cursor-plugin/marketplace.json), [`.claude-plugin/marketplace.json`](https://github.com/cursor/plugins/blob/main/.claude-plugin/marketplace.json)
- pstack: [README](https://github.com/cursor/plugins/blob/main/pstack/README.md), [`.cursor-plugin/plugin.json`](https://github.com/cursor/plugins/blob/main/pstack/.cursor-plugin/plugin.json), [`plugin.json`](https://github.com/cursor/plugins/blob/main/pstack/plugin.json), [Claude Code adapter](https://github.com/cursor/plugins/blob/main/pstack/docs/harness/claude-code.md), [harness tree README](https://github.com/cursor/plugins/blob/main/harness/pstack/README.md), skills [`poteto-mode`](https://github.com/cursor/plugins/blob/main/pstack/skills/poteto-mode/SKILL.md), [`correct`](https://github.com/cursor/plugins/blob/main/pstack/skills/correct/SKILL.md), [`reflect`](https://github.com/cursor/plugins/blob/main/pstack/skills/reflect/SKILL.md), [`principle-laziness-protocol`](https://github.com/cursor/plugins/blob/main/pstack/skills/principle-laziness-protocol/SKILL.md), [`blast-radius`](https://github.com/cursor/plugins/blob/main/pstack/skills/blast-radius/SKILL.md), [`interrogate`](https://github.com/cursor/plugins/blob/main/pstack/skills/interrogate/SKILL.md)
- cursor-team-kit: [README](https://github.com/cursor/plugins/blob/main/cursor-team-kit/README.md), [`.cursor-plugin/plugin.json`](https://github.com/cursor/plugins/blob/main/cursor-team-kit/.cursor-plugin/plugin.json), skills [`review-and-ship`](https://github.com/cursor/plugins/blob/main/cursor-team-kit/skills/review-and-ship/SKILL.md), [`deslop`](https://github.com/cursor/plugins/blob/main/cursor-team-kit/skills/deslop/SKILL.md), [`workflow-from-chats`](https://github.com/cursor/plugins/blob/main/cursor-team-kit/skills/workflow-from-chats/SKILL.md), [`verify-this`](https://github.com/cursor/plugins/blob/main/cursor-team-kit/skills/verify-this/SKILL.md), agent [`ci-watcher`](https://github.com/cursor/plugins/blob/main/cursor-team-kit/agents/ci-watcher.md), rule [`no-inline-imports.mdc`](https://github.com/cursor/plugins/blob/main/cursor-team-kit/rules/no-inline-imports.mdc); [thermos README](https://github.com/cursor/plugins/blob/main/thermos/README.md)
- Cursor docs: [Plugins](https://cursor.com/docs/plugins), [Skills](https://cursor.com/docs/skills), [Rules](https://cursor.com/docs/rules); standards: [agentskills.io](https://agentskills.io), Agent Plugins schema `https://agent-plugins.org/schemas/1.0.0/plugin.schema.json` (referenced from pstack's `plugin.json`)

All read 2026-11-22 from `main`. pstack is v0.15.46, cursor-team-kit v1.2.0. Both MIT (pstack (c) Lauren Tan, team kit (c) Cursor).

## What I learned

### cursor-team-kit (v1.2.0)

A flat kit of 18 short, independent skills plus 2 agents and 2 rules, "plug and play without requiring third-party service integrations" (README). Each skill is a small SKILL.md: Trigger, Workflow (numbered steps), Guardrails, Output. Groups:

- **CI and PRs**: `loop-on-ci`, `fix-ci`, `get-pr-comments`, `new-branch-and-pr`, `review-and-ship`, `make-pr-easy-to-review`, `pr-review-canvas` (HTML walkthrough of a diff, ships renderer/template files), `fix-merge-conflicts`. Agent `ci-watcher` (`model: fast`, `is_background: true`) wraps `gh pr checks --watch` and `gh run view --log-failed`.
- **Verification**: `verify-this` (restate a claim falsifiably, baseline vs treatment, verdict VERIFIED / NOT VERIFIED / INCONCLUSIVE), `run-smoke-tests` (Playwright), `check-compiler-errors`, `control-cli` / `control-ui` (build a harness to drive a TUI or browser).
- **Code quality**: `deslop` (strip AI slop from the branch diff: needless comments, abnormal try/catch, `any` casts, deep nesting), `thermo-nuclear-code-quality-review` (skill + subagent; our vendored copy). The same review now also lives, with a security sibling and an orchestrator, in the separate `thermos` plugin.
- **Reporting / learning**: `what-did-i-get-done`, `weekly-review` (commits over a period into a status update), `workflow-from-chats` (mine recent chat transcripts for durable preferences, rate confidence strong/medium/weak/contradicted, then choose skill vs rule vs doc vs nothing).
- **Rules** (`.mdc`, `alwaysApply: true`): `no-inline-imports`, `typescript-exhaustive-switch`.

### pstack (v0.15.46)

One person's opinionated "agent style" (Lauren Tan), far larger and more coupled than the team kit: ~45 skills, 2 agents, a 10-chapter guide, and Cursor Automations.

- **Entry point `/poteto-mode`** (`disable-model-invocation: true`): picks one of 22 playbooks (bug fix, perf, feature, refactoring, prototype, babysit a PR, shipping a stack, overnight autonomous run, session pickup, pause safely, multi-phase plan, opening a PR...), copies its steps into the todo list verbatim, then routes to other skills. Non-negotiables include "restate the goal and the smallest change", "a fork you could settle by running something: prototype it instead of asking", and "before commit: `/deslop` from cursor-team-kit" (so pstack depends on team kit).
- **24 principle skills** (`principle-*`, each a few bullets, user-invocable only), grouped core / architecture / verification / delegation / meta: laziness protocol, subtract before you add, fix root causes, prove it works, test behaviour not implementation, guard the context window, never block on the human, encode lessons in structure... `poteto-mode` holds an inline index and reads a leaf only when it applies it, and must cite the principles that shaped each decision.
- **Situational skills**: `how` / `why` (why answers from commits and PR discussion, not code), `recall` (rebuild context from chat history), `ketchup` (catch-up of what changed and what waits on you), `blast-radius`, `architect`, `arena` / `swarm` (N parallel attempts or slices), `interrogate` (multi-model adversarial review; a finding survives only if a run proves it), `tdd`, `unslop`, `technical-writing`, `no-comments`, `benchmark-checklist`, `show-me-your-work` (decision log as a committed TSV), `create-verification-skill` / `maintain-verification-skill` (generate a project-local "verify the app" skill), formal-verification and TLA+ `statechart` skills.
- **Self-improvement loop**: `reflect` (mine the transcript, route each durable learning to an edit of an existing skill; drop one-offs, SHAs, counts), `correct` (find repeated agent mistakes and fix each at the highest level: architecture, then types/lint whose error names the fix, then tests, docs last; keep a rule-to-enforcer table), `automate-me` (draft your own `-mode` skill from how you work).
- **Model routing**: `/setup-pstack` writes per-role model choices to a rule (`~/.cursor/rules/pstack-models.mdc`); several skills deliberately use multiple model families.

### Packaging

- **Cursor plugin**: a folder with `.cursor-plugin/plugin.json` (only `name` required; `skills`, `agents`, `rules` paths optional, default directories otherwise) holding `skills/*/SKILL.md`, `agents/*.md`, `rules/*.mdc`, `commands/`, `hooks`, `mcp.json`. A repo is a marketplace via `.cursor-plugin/marketplace.json`. Installed from the marketplace or `/add-plugin <name>`, at project or user scope; teams can mark plugins Default On or Required; local dev in `~/.cursor/plugins/local` (Cursor Plugins docs).
- **Agent Plugins standard**: Cursor also loads plugins that follow the open Agent Plugins spec (root `plugin.json` with the `$schema`). The docs say only skills and MCP servers are portable in that format; rules, agents, commands and hooks are Cursor-plugin-only.
- **Skills** follow the Agent Skills standard (agentskills.io): `name` (must match folder), `description`, optional `disable-model-invocation`, `paths`, `icon`, `color`, `metadata`. Any skill can back a Cursor "custom mode" (Alt+Enter keeps it in context every turn).
- **Claude Code plugin**: `.claude-plugin/plugin.json` + `skills/`, `agents/`, `commands/`, `hooks`, `.mcp.json`, marketplace in `.claude-plugin/marketplace.json`, installed with `/plugin marketplace add` + `/plugin install name@marketplace`; commands and agents get a `plugin:` prefix.

### Cross-agent support / packaging

- **Same SKILL.md works in both, mostly.** Cursor loads skills from `.agents/skills/`, `.cursor/skills/` *and*, "for compatibility", `.claude/skills/`, `~/.claude/skills/` and the Codex dirs (Skills docs). So this toolbox's installed skills already show up in Cursor with no change. Shared frontmatter: `name`, `description`, `disable-model-invocation`. Our extra `tier:` key is harmless (unknown keys are ignored / `metadata` is the standard place for it).
- **What does not port is the body**: tool names (`Task` vs `Agent`, `AskQuestion` vs `AskUserQuestion`), subagent fields, model slugs, paths (`.cursor/rules/*.mdc` vs `CLAUDE.md`), transcript locations, and Cursor-only features (Automations, Bugbot, cloud agents). pstack solves this with a one-page **adapter** (`docs/harness/claude-code.md`): skills keep Cursor names and the agent reads a mapping table once per session. A Node script generates a separate Claude Code tree (`harness/pstack/claude-code/`, own `.claude-plugin/plugin.json`), and CI fails if it is stale. The root `.claude-plugin/marketplace.json` lists only pstack and origin-apps, so cursor-team-kit is Cursor-only as a plugin (its skills are still plain SKILL.md you can copy).
- **Instructions files**: Cursor reads `AGENTS.md` (root and nested) and `.cursor/rules/*.mdc`; the rules page does not mention `CLAUDE.md`. Claude Code reads `CLAUDE.md`, never `.mdc`. A shared `AGENTS.md` with `CLAUDE.md` pointing at it (or vice versa) is the cheap bridge.
- **Implication for the multi-agent ticket**: writing skills in Claude Code terms and installing into `.claude/skills/` already gets Cursor for free; a Cursor *plugin* would need a second manifest and probably an adapter page like pstack's. Keep agent-specific tool names out of skill bodies where possible ("spawn a subagent" rather than `Agent`), or add one adapter doc.

## What I might change in the workflow

1. **Take now (small, self-contained, MIT):**
   - `deslop` as an optional pre-`/ship` step (or a line in `/ship`): branch-diff clean-up of AI slop. Tiny and stack-neutral.
   - `verify-this` pattern (falsifiable claim, baseline vs treatment, three-way verdict) as an optional skill or as wording inside the implement/review step.
   - `ci-watcher` / `loop-on-ci` ideas for the `github` platform (`gh pr checks --watch --fail-fast`, `gh run view --log-failed`); an Azure equivalent later.
   - Keep the README attribution for the vendored thermo-nuclear skill; licence is MIT (c) Cursor, so a public repo just needs the notice kept. Upstream moved its full version into the `thermos` plugin (with a security review sibling); worth a look when the thermo skill is next touched.
2. **Try as an experiment:**
   - `reflect` + `correct`: a learning loop that turns corrections into skill edits or, better, lints/tests. Fits `/end-session` (offer "reflect?" at the end) and the "Measure it" direction in `ideas.md`.
   - `workflow-from-chats` with Claude Code transcripts (`~/.claude/projects/<slug>/*.jsonl`) to find my own durable preferences; feeds the "find the best workflow for me" goal.
   - A short principles index (5-8 of pstack's, e.g. laziness protocol, subtract before you add, fix root causes, prove it works, guard the context window) referenced from `CLAUDE.md` templates rather than 24 separate skills.
3. **Skip:** `poteto-mode` and its 22 playbooks wholesale (too personal and heavy; overlaps Matt Pocock's wayfinder/implement chain), multi-model arena/interrogate (needs several model families), Cursor Automations, `ketchup-video`, `make-bot-ui`, formal verification.
4. **Packaging:** if the toolbox becomes a plugin (`ideas.md` "Package as a plugin"), copy pstack's shape: one source tree, a generator for each harness's manifest, a CI check that generated trees are current, and an adapter page instead of forking skill text.
