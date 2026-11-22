# Model choice per agent

## Question

How is the model chosen in Claude Code (`/model`, settings, a subagent's `model:`, the Agent tool's model option, skill frontmatter, plan-with-one/build-with-another modes), and in Cursor, Codex CLI and Gemini CLI? What does each tier cost? How can a plan made by one vendor's model be handed to another vendor's agent?

## Sources

All read 2026-11-22. Most pages carry no date; dates given where shown.

- Claude Code: [Model configuration](https://code.claude.com/docs/en/model-config), [Subagents](https://code.claude.com/docs/en/sub-agents), [Skills](https://code.claude.com/docs/en/skills), [Costs](https://code.claude.com/docs/en/costs), [Memory (AGENTS.md)](https://code.claude.com/docs/en/memory)
- Anthropic pricing: [API pricing](https://platform.claude.com/docs/en/about-claude/pricing), [claude.com/pricing](https://claude.com/pricing), [Models, usage and limits in Claude Code](https://support.claude.com/en/articles/14552983-models-usage-and-limits-in-claude-code) ("updated over 3 weeks ago")
- Cursor: [Subagents](https://cursor.com/docs/agent/subagents), [Modes](https://cursor.com/docs/agent/modes), [Models and pricing](https://cursor.com/docs/models-and-pricing), [Rules](https://cursor.com/docs/rules)
- Codex (developers.openai.com now redirects to learn.chatgpt.com): [Config reference](https://learn.chatgpt.com/docs/config-file/config-reference), [Subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents), [CLI](https://learn.chatgpt.com/docs/cli), [Pricing](https://learn.chatgpt.com/docs/pricing)
- Gemini CLI: [Subagents](https://geminicli.com/docs/core/subagents/) (updated 2026-06-08), [Plan mode](https://geminicli.com/docs/cli/plan-mode/) (updated 2026-06-18), [Configuration](https://geminicli.com/docs/reference/configuration/)
- [agents.md](https://agents.md/)

## What I learned

### Comparison

| Agent | Main model | Per-subagent / per-task model | Plan-then-execute | Notes |
|---|---|---|---|---|
| Claude Code | `/model` (Enter saves to user settings, `s` = session only) > `--model` > `ANTHROPIC_MODEL` > settings `"model"` > `ANTHROPIC_DEFAULT_MODEL` | Agent file `model:` (`sonnet`/`opus`/`haiku`/`fable`/full ID/`inherit`); Agent tool `model` param (alias only); `CLAUDE_CODE_SUBAGENT_MODEL`; skill `model:` (this turn, or the fork with `context: fork`); `effort:` on agents and skills | `opusplan`: Opus in plan mode, Sonnet to execute | Order for subagents: spawn param > agent file > env var > parent. `..._FORCE=1` pins all subagents |
| Cursor | Model picker (incl. Auto) for the parent agent | Subagent `model:` = `inherit` (default) or a model ID; parent can name a model at spawn; built-in Explore uses "a faster model" | Plan mode exists (plans saved to home dir, "Save to workspace", "build"); docs do not say plan and build can use different models | Cursor may override the model (admin block, plan, legacy plans force Composer) |
| Codex CLI | `/model` (model + effort); `model` in `~/.codex/config.toml` or `.codex/config.toml`; profiles via `--profile` | `.codex/agents/*.toml` with `model`, `model_reasoning_effort`; `agents.default_subagent_model`; `review_model` for `/review` | No plan-mode model; only `plan_mode_reasoning_effort` | Agent file wins over spawn value (opposite of Claude Code). Open issues report Windows ignoring agent TOML model (openai/codex#19399, unconfirmed) |
| Gemini CLI | `model.name` in `settings.json`, `GEMINI_MODEL`; CLI args > env > settings | Subagent `model:` (default `inherit`); `agents.overrides.<name>.modelConfig.model` in settings | With an `auto` model, plan mode routes to Pro, implementation to Flash (`general.plan.modelRouting`, default true) | Replaced by Antigravity CLI for free/Google One users on 2026-06-18; "not optimized for Gemini 4" |

Not confirmed: Gemini `--model`/`/model` behaviour (pages cut off); Cursor per-mode model choice; a Codex plan-mode model key.

### Claude Code detail

- **Skill `model:`** applies for the rest of the current turn only and is not saved; with `context: fork` (+ `agent:` to pick the subagent type) it sets the forked subagent's model. `model`, `effort`, `context`, `agent` are Claude Code extensions: the Skills API / claude.ai reject them.
- **Built-ins:** Explore and Plan inherit the parent (Explore runs on Opus when the parent is Fable on a subscription); claude-code-guide and web-fetch use Haiku. Override Explore by defining a project agent named `Explore` with `model: haiku`. `CLAUDE_CODE_SUBAGENT_MODEL` does not change Explore/Plan.
- **Effort:** `low`..`max`; current models default to `medium`. `CLAUDE_CODE_EFFORT_LEVEL` beats everything, then session choice, `--effort`, settings `effortLevel`.
- **Aliases float:** `opus` = Opus 5.5, `sonnet` = Sonnet 5.5, `haiku` = Haiku 5.5 on the Anthropic API; pin with full IDs or `ANTHROPIC_DEFAULT_*_MODEL`.
- **Allowlists:** managed `availableModels` restricts subagent and skill models too.

### Cost

- **Anthropic API (per MTok in/out):** Fable 5.2 $8/$40; Opus 5.5 $4/$20; Sonnet 5.5 $2/$10; Haiku 5.5 $0.10/$0.50 (prompts under 100k tokens; $0.50/$2.50 above). Cache hits on Opus/Sonnet 5.5 are 0.05x input.
- **Claude plans:** Pro $20/mo, Max 5x $100, Ultra $200 (all include Claude Code). Limits are a 5-hour and a weekly window shared with claude.ai, plus a separate weekly Fable limit on Max. Support: "Opus costs several times more per turn than Sonnet, and Sonnet more than Haiku"; Sonnet for "the large majority of coding work". Subagents draw on the same limits; `/usage` attributes usage to skills and subagents.
- **Cursor:** Plus $8 to Ultra $200; weekly pool for Cursor models (Composer 2.5 $0.50/$2.50); Claude/GPT/Gemini billed at API list price from prepaid credit (Premium and above only).
- **Codex (ChatGPT plans):** Plus $20, Pro $100-500; models drain limits at very different rates (Plus, per 5 h: GPT-6 Luna 350-3,000 messages vs GPT-6.2 Astra 6-50). Fast mode 2-2.5x.
- **Gemini CLI:** pricing not researched; free tier moved to Antigravity CLI.

### Handing a plan across vendors

- **Shared instruction file:** AGENTS.md is read by Codex, Cursor (root and nested), Gemini CLI (via `context.fileName`, unconfirmed for AGENTS.md specifically) and, since v2.1.277, Claude Code when there is no CLAUDE.md (or set Project instructions to `claude-md-and-agents-md`, or `@AGENTS.md` import from CLAUDE.md).
- **Plan files:** every tool can write its plan to Markdown (Cursor "Save to workspace"; Gemini `general.plan.directory` inside the project). A plan in a repo file (spec + tickets in `.scratch/`) is the vendor-neutral hand-off; the receiving agent just reads it.
- **What does not port:** skill/agent frontmatter `model:` values are vendor-specific (`sonnet` vs `gpt-6.2-sol` vs `gemini-3-pro-preview`); Codex agents are TOML, others Markdown.

## For this toolbox

1. **`model:` in agent files.** When the toolbox ships `.claude/agents/*.md` (e.g. a reviewer or explorer), set `model:` explicitly: `haiku` for search/fetch, `sonnet` for implement/review, `inherit` where it should follow the session. Cheapest and fully supported.
2. **`model:` / `effort:` in skill frontmatter** for skills that should run cheaper or harder (e.g. `/end-session` on `haiku`, a grilling or spec skill on `opus`). Plain `model:` only lasts the turn; for a whole skill on another model use `context: fork` + `model:`. Breaks claude.ai upload, so only on Claude Code-only skills.
3. **A setting in `docs/agents/workflow-settings.md`**, e.g. `models: plan=opus, build=sonnet, explore=haiku`, which skills read and pass as the Agent tool's `model` param. One knob per repo, but relies on the skill text being followed (a convention, not enforced), and the param takes aliases only.
4. **`opusplan`** as the recommended session model in SETUP/CUSTOMISING for the grill -> spec -> implement pipeline; no toolbox change needed.
5. **Cross-vendor:** keep specs and tickets as plain files (already the case) and add an `AGENTS.md` that points at them (or a CLAUDE.md `@AGENTS.md` import) so a Codex/Cursor/Gemini agent can implement a Claude-made plan. Decide whether templates ship AGENTS.md alongside CLAUDE.md.
6. Watch `/usage` attribution before and after, to measure (links to the measuring ticket).
