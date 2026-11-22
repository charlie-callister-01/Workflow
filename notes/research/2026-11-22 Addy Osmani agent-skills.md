# Addy Osmani's agent-skills

## Question

What does Addy Osmani's agent-skills collection offer (skills, structure, conventions, cross-agent support), how does it overlap with this toolbox and Matt Pocock's skills, and what is worth taking?

## Sources

- Repo: <https://github.com/addyosmani/agent-skills> (MIT, plugin v0.6.17, last commit 2026-11-18; read via `gh api` on 2026-11-22)
  - [README.md](https://github.com/addyosmani/agent-skills/blob/main/README.md): commands, the 26 skills, personas, project structure, install per host
  - [docs/skill-anatomy.md](https://github.com/addyosmani/agent-skills/blob/main/docs/skill-anatomy.md): SKILL.md format and section pattern
  - [docs/comparison.md](https://github.com/addyosmani/agent-skills/blob/main/docs/comparison.md): their own comparison with Superpowers and Matt Pocock's skills
  - [evals/README.md](https://github.com/addyosmani/agent-skills/blob/main/evals/README.md): the three-tier eval framework
  - [skills/using-agent-skills/SKILL.md](https://github.com/addyosmani/agent-skills/blob/main/skills/using-agent-skills/SKILL.md): router flowchart and "core operating behaviors"
  - [skills/constraint-driven-development/SKILL.md](https://github.com/addyosmani/agent-skills/blob/main/skills/constraint-driven-development/SKILL.md), [skills/doubt-driven-development/SKILL.md](https://github.com/addyosmani/agent-skills/blob/main/skills/doubt-driven-development/SKILL.md)
  - [hooks/session-start.sh](https://github.com/addyosmani/agent-skills/blob/main/hooks/session-start.sh), [docs/getting-started.md](https://github.com/addyosmani/agent-skills/blob/main/docs/getting-started.md), [AGENTS.md](https://github.com/addyosmani/agent-skills/blob/main/AGENTS.md)
- Addy Osmani, ["Agent Skills"](https://addyosmani.com/blog/agent-skills/) (blog, 2026-05-03): the design rationale
- Matt Pocock's skills: <https://github.com/mattpocock/skills> (installed here as the `mattpocock-skills` plugin)

## What I learned

### What it is
A broad lifecycle pack of 26 skills: 25 lifecycle skills plus a meta-skill router, grouped into **Define, Plan, Build, Verify, Review, Ship**. It encodes Google engineering practice (Hyrum's Law, test pyramid, ~100-line changes, Chesterton's Fence, trunk-based development, feature flags). README and comparison doc.

- **Define**: `interview-me` (one question at a time until ~95% confidence; a close cousin of Pocock's `grilling`), `idea-refine`, `spec-driven-development` (a PRD before code), `constraint-driven-development` (interviews for a quality bar, writes `CONSTRAINTS.md`, watches diffs for weakened checks such as new `eslint-disable`, skipped tests or lowered thresholds).
- **Plan**: `planning-and-task-breakdown`.
- **Build**: `incremental-implementation`, `test-driven-development`, `context-engineering`, `source-driven-development` (cite official docs for every framework decision), `doubt-driven-development` (a fresh-context reviewer, biased to disprove, for each non-trivial decision while work is in flight), `frontend-ui-engineering`, `api-and-interface-design`.
- **Verify**: `browser-testing-with-devtools`, `debugging-and-error-recovery`.
- **Review**: `code-review-and-quality` (five axes, severity labels), `code-simplification`, `security-and-hardening`, `performance-optimization`, `accessibility-engineering`.
- **Ship**: `git-workflow-and-versioning`, `ci-cd-and-automation`, `deprecation-and-migration`, `documentation-and-adrs`, `observability-and-instrumentation`, `shipping-and-launch`.
- **Also included**: 10 slash commands mapped to phases (`/spec /plan /build /test /review /ship /constraints /code-simplify /webperf /a11y`; `/build auto` runs a whole approved plan in one pass), 5 reviewer **personas** in `agents/` (code-reviewer, test-engineer, security-auditor, web-performance-auditor, accessibility-auditor; `/ship` runs them in parallel and merges them into a go/no-go), and 7 shared **reference checklists** in `references/` (definition-of-done, testing, security, performance, accessibility, observability, orchestration patterns).

### Conventions
- **Skill anatomy** (docs/skill-anatomy.md): frontmatter limited to the agentskills.io spec keys (`name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`). Vendor keys such as `model` go under `metadata` or in a per-agent adapter, and a validator rejects anything else. The description says what the skill does plus "Use when..." and must *not* summarise the process, or the agent follows the summary instead of the skill.
- **Sections**: Overview, When to Use (including when NOT to), Process, **Common Rationalizations** (a table of excuses with rebuttals, "pre-written rebuttals to lies the agent hasn't yet told"), **Red Flags**, **Verification** (an evidence checklist; "passing tests are evidence, not proof").
- **Progressive disclosure**: supporting files only above about 100 lines. Shared checklists sit at the repo root, which breaks single-skill `npx skills add` installs (they track this as issue #361).
- **Five non-negotiables** in the router, which the blog suggests putting in any AGENTS.md: surface assumptions, stop and ask on conflicts, push back, prefer the boring solution, touch only what you're asked to.
- **Evals** (their claimed differentiator): Tier 1 is structural lint in CI. Tier 2 is a lexical (TF-IDF) check that each description ranks top for its own trigger prompts and that no two descriptions collide (in CI, rank-1 floor 95%). Tier 3 runs behaviour through headless `claude -p` in a throwaway git repo and grades the trace against `expectations[]` (Anthropic skill-creator `evals.json` schema), including "pressure" cases (time pressure, sunk cost, authority).
- **Governance**: community PRs, a skill-gap issue template, versioned plugin manifests.

### Cross-agent support
- **Portable core**: `skills/*/SKILL.md` follows the agentskills.io spec, so any host that reads SKILL.md can use it. The README says "Skills are plain Markdown" and work wherever instruction files are accepted.
- **Adapters checked in, one per host convention**: Claude Code (`.claude-plugin/` marketplace, `.claude/commands/*.md`, `hooks/`), Gemini CLI (`.gemini/commands/*.toml`), Antigravity (`commands/*.toml` + root `plugin.json`), Codex (`.codex-plugin/`, `.agents/plugins/`, reading `skills/` directly, invoked as `@skill`), Copilot CLI (root `plugin.json`), OpenCode (`.opencode/skills` link + `AGENTS.md` rules, because it has no slash commands).
- **Docs only, no adapter**: Cursor (copy to `.cursor/skills/`, short policies in `.cursor/rules/*.mdc`, never whole skills in rules), Windsurf (rules), Copilot IDE (`.github/copilot-instructions.md`, `agents/` as personas), Kiro (`.kiro/skills/`), Command Code.
- **One-command install** into 70+ agents via Vercel's `npx skills add addyosmani/agent-skills`.
- **Router rule**: the `using-agent-skills` meta-skill is injected by a SessionStart hook *only* on hosts without native skill routing. On Claude Code and Codex they deliberately don't wire it, to avoid "two routers" (hooks/session-start.sh, getting-started.md).
- **Takeaway for multi-agent support** (ticket 06): keep one portable `skills/` core in spec-only frontmatter, add thin per-host adapters only where a host needs a manifest or command wrapper, and push host-specific controls into `metadata`.

### Overlap

| Area | agent-skills | Matt Pocock | This toolbox |
|---|---|---|---|
| Requirements | `interview-me`, `idea-refine` | `grilling`, `grill-with-docs` (reference implementation) | uses Pocock's |
| Spec / plan | `spec-driven-development`, `planning-and-task-breakdown` | `to-spec`, `to-tickets`, `wayfinder` | uses Pocock's + `.scratch/` tickets |
| Build | `incremental-implementation`, `/build auto` | `implement`, `implement-spec`, `tdd` | uses Pocock's |
| Debug | `debugging-and-error-recovery` | `diagnosing-bugs` | uses Pocock's |
| Review | `code-review-and-quality`, personas, `code-simplification` | `code-review` (standards + spec) | `thermo-nuclear-code-quality-review`, `pr-explainer` |
| Ship | `/ship` persona fan-out, `shipping-and-launch` | `pr` | `ship` (PR via platform) |
| Docs / ADRs | `documentation-and-adrs` | `domain-modeling` (glossary + ADRs) | `notes/decisions/` |
| Session continuity | none ("no one has solved cross-session memory", comparison.md) | `wayfinder` | `start-session`, `end-session`, STATUS/HANDOFF/LOG, `day-log` |
| Setup / presets / platforms | none | `setup-matt-pocock-skills` | `setup-workflow`, `refit-workflow`, presets, platforms |
| Production concerns (security, perf, a11y, CI/CD, observability, deprecation, launch) | yes, deep | thin | none |
| Skill evals | three tiers in CI | none | none |

In short: Pocock is strongest at Define and Build; agent-skills is broadest at Verify, Review and Ship; this toolbox's own value is the *outer loop* (sessions, presets, platforms, setup). That outer loop is exactly the gap agent-skills admits to. Their comparison doc also warns against running two frameworks as the active router at once: pick one primary and borrow skills individually. That fits this toolbox, which already uses Pocock as its primary.

## What I might change in the workflow

1. **Don't install the pack as a whole.** It would compete with Pocock's skills for `/ship`, `/review`, TDD and grilling. Borrow individual skills instead.
2. **Take as optional skills**, installed per skill with `npx skills add ... --skill X`:
   - `security-and-hardening`, `accessibility-engineering`, `performance-optimization` for production or web projects (perhaps the `full` preset only)
   - `doubt-driven-development` for high-stakes changes (fits the "risk levels" idea in `ideas.md`)
   - `constraint-driven-development`: a `CONSTRAINTS.md` quality bar plus diff watching for weakened checks. This is the most novel one and suits `full` and `azure` work projects.
3. **Adopt conventions in our own skills**:
   - Add **Common Rationalizations** and **Red Flags** tables to the discipline skills (`ship`, `end-session`, `thermo-nuclear-code-quality-review`).
   - Add a **Verification** exit checklist to each skill.
   - Keep frontmatter to agentskills.io keys so the skills stay portable.
4. **The five non-negotiables**: consider adding them to the CLAUDE.md template (`templates/`). Short, and close to what `lite` already implies.
5. **Definition of Done**: a `references/definition-of-done.md`-style standing bar fits `presets/full.md`.
6. **Skill evals, light version**: start with Tier 1, a PowerShell lint for frontmatter and description length. Defer Tier 2 and 3 until the toolbox has enough skills for routing collisions to matter. Feeds the "Measure it" idea.
7. **Multi-agent (ticket 06)**: copy their layout pattern (portable core + thin adapters + hook-injected router only where routing is missing) rather than inventing one.

Candidates for `../ideas.md`: items 2, 3, 5, 6 (the parent decides in ticket 05).
