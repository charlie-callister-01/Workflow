# What can be measured

## Question

What do Claude Code and other agents expose about context weight, tokens and plan usage, what can be collected automatically per session and per subagent, and what do other workflows (Addy Osmani's skill evals, obra/superpowers, Compound Engineering, ccusage) measure? The point: find markers a beta trial (see `../trials.md`) can be judged on, without the owner having to note numbers by hand.

## Sources

Read 2026-11-22.

- Claude Code docs: [Manage costs](https://code.claude.com/docs/en/costs) (`/usage`, plan breakdown, `/insights`, spinner count), [Commands](https://code.claude.com/docs/en/commands) (`/context`, `/cost`, `/stats`), [Monitoring (OpenTelemetry)](https://code.claude.com/docs/en/monitoring-usage), [Status line](https://code.claude.com/docs/en/statusline), [Headless / `claude -p`](https://code.claude.com/docs/en/headless), [Hooks](https://code.claude.com/docs/en/hooks) (common input fields)
- Local check: field names only (no content) of one session JSONL and one subagent `.meta.json` under `~/.claude/projects/<project>/` on this machine
- [ryoppippi/ccusage](https://github.com/ryoppippi/ccusage) README (via `gh api`)
- [addyosmani/agent-skills `evals/README.md`](https://github.com/addyosmani/agent-skills/blob/main/evals/README.md)
- [obra/superpowers `tests/claude-code/analyze-token-usage.py`](https://github.com/obra/superpowers/blob/main/tests/claude-code/analyze-token-usage.py) and `tests/claude-code/README.md`
- [EveryInc/compound-engineering-plugin](https://github.com/EveryInc/compound-engineering-plugin): `.agents/skills/ce-skill-work/references/evaluate.md`, `docs/plans/2026-09-15-review-spine-cost-eval-report.md`, `docs/solutions/skill-design/review-cost-is-in-entering-the-spine-not-the-findings.md`, `docs/solutions/skill-design/grading-live-delegation-evals-from-host-session-logs.md`

## What I learned

### Claude Code, inside a session (manual, look-only)
- **`/usage`** (aliases `/cost`, `/stats` which opens on a Stats tab): Session block with total cost (estimated at list price), API and wall duration, lines changed, and per-model input, output, cache read, cache write. A `Prompt cache (main)` line gives hit ratio, misses and warm/cold, **main conversation only**. On a subscription it also shows plan usage bars and an **attribution breakdown** of the last 24 h or 7 days by skill, subagent, plugin and MCP server, plus recommendations (e.g. "trim CLAUDE.md, 49k tokens per request"). Totals reset on `/clear`.
- **`/context [all]`**: coloured grid of what fills the context window now (system prompt, tools, memory files, skills, messages) with suggestions. The best single view of a skill's or CLAUDE.md's standing weight, but it is a screen, not data.
- **`/insights`**: HTML report over up to 200 recent sessions (friction, what you work on), saved in `~/.claude/usage-data/`. Qualitative; costs tokens to run.
- Spinner `↓ 5.5k tokens`: output of the current turn only.

### Claude Code, collectable automatically
- **Session transcripts** `~/.claude/projects/<cwd-slug>/<session>.jsonl`. Each `assistant` line has `message.usage` with `input_tokens`, `output_tokens`, `cache_read_input_tokens`, `cache_creation_input_tokens` (split `ephemeral_5m`/`ephemeral_1h`), `output_tokens_details.thinking_tokens`, `server_tool_use` (web search/fetch counts), `service_tier`, `speed`. Lines also carry `timestamp`, `sessionId`, `gitBranch`, `version`, `isSidechain`, `querySource`, `attributionSkill`, `attributionPlugin`, `effort`. Subagents get their own files: `<session>/subagents/agent-<id>.jsonl` plus `agent-<id>.meta.json` (`agentType`, `model`, `description`, `spawnDepth`, `toolUseId`). **Deleted after `cleanupPeriodDays`, 30 days by default**, so anything kept must be extracted.
- **Subagent results**: a foreground Agent tool result line has `toolUseResult` with `totalTokens`, `usage`, `toolUses`, `durationMs`; a background subagent's task notification ends with `<usage><subagent_tokens>…<tool_uses>…<duration_ms>…</usage>`. So per-subagent totals are already in the parent transcript.
- **Status line** (runs on each update, gets JSON on stdin): `cost.total_cost_usd`, `cost.total_duration_ms`, `cost.total_lines_added/removed`, `context_window.used_percentage`, `context_window_size`, `current_usage` (last call's tokens by type), `exceeds_200k_tokens`, `prompt_cache.*` (hit ratio, misses, miss causes), `rate_limits.five_hour/seven_day.used_percentage` (subscribers only), `session_id`, `transcript_path`, `model`, `effort.level`. A script could append a line per update to a log, which gives peak context % and plan-% consumed per session.
- **Hooks**: every event gets `session_id`, `transcript_path`, `cwd`, plus `agent_id`/`agent_type` inside a subagent. No usage fields, but a `SessionEnd` or `SubagentStop` hook can parse the transcript at the right moment.
- **OpenTelemetry** (`CLAUDE_CODE_ENABLE_TELEMETRY=1`, exporters `otlp`, `prometheus` or `console`): metrics `claude_code.token.usage` (by `type` input/output/cacheRead/cacheCreation), `claude_code.cost.usage`, `session.count`, `lines_of_code.count`, `commit.count`, `pull_request.count`, `active_time.total`, `code_edit_tool.decision`; events `api_request` (tokens, cost, duration per call), `tool_result`, `tool_decision`, `user_prompt`. Attributes include `session.id`, `model`, `query_source` (`main`/`subagent`), `agent.name`, `agent_id`/`parent_agent_id`, `skill.name`, `plugin.name`. The costs page says OTel "works on every setup". The richest feed, but it needs a collector running; overkill for one person unless a console exporter to a file is enough.
- **`claude -p --output-format json`**: result has `session_id`, `total_cost_usd`, per-model usage and cost, turns, duration; `stream-json` tags subagent messages with `parent_tool_use_id`. Right for scripted evals, not for ordinary sessions.
- Gaps: no per-skill context weight as data (only `/context` on screen and the `/usage` attribution share); plan % is per account, not per session (only the before/after of `rate_limits` in the status line); cache numbers exclude subagents.

### Other workflows
- **ccusage**: reads the local JSONL of Claude Code and ~20 other agent CLIs; reports `daily`, `weekly`, `monthly`, `session`, `blocks` (5-hour windows), and a `statusline`. Tokens by type and cost by model. Zero setup (`npx ccusage`), but per-session, not per-subagent or per-skill.
- **obra/superpowers**: `analyze-token-usage.py` sums `message.usage` per main session and per subagent (from `toolUseResult.usage` keyed by `agentId`), i.e. the same transcript route as above. Skill tests run `claude -p` with fixtures and grade behaviour.
- **Addy Osmani agent-skills**: three tiers. Tier 1 structural lint, Tier 2 TF-IDF trigger/collision check (CI), Tier 3 behavioural runs via `claude -p --output-format stream-json` graded against `expectations[]`, plus `claude plugin eval` with/without-plugin arms (a `Δ` per case). They measure **fire rate** ("fired 5 of 7") and **judge pass rate per arm**, not tokens. Lesson they report: pin `--model` and record the CLI version, because results drifted between versions.
- **Compound Engineering**: pre/post arms in a throwaway workspace (`skill-eval-cell`), graded from the hosts' own session logs, not the model's account. They do measure cost: orchestrator **turns**, **cache-write and cache-read tokens**, peer input tokens, against a recorded baseline (e.g. 68 turns, 12.5M cache read → 66 turns, 6.5M). Their learning: attribute cost by stage from a real run before tuning; fixed "spine" overhead (references loaded, re-read every turn) dominates. Also: "measure the outcome the skill exists to improve, not proxy volume".

## Summary table

| Source | What it gives | Automatic? | Effort to collect |
|---|---|---|---|
| `/context` | Context make-up now (tools, memory, skills, messages) | No, screen only | Low per look; manual copy |
| `/usage` (`/cost`, `/stats`) | Session cost, tokens in/out/cache by model; plan bars; 24 h/7 d share by skill, subagent, plugin, MCP | No, screen only | Low; manual copy |
| Session JSONL | Per-call tokens in/out/cache/thinking, model, skill attribution, timestamps; subagent files with type and model | Yes, always written (30-day retention) | Medium: a PowerShell parser, run at `/end-session` |
| Subagent result / task notification | Per-subagent total tokens, tool uses, duration | Yes, in parent JSONL | Low once the parser exists |
| Status line JSON | Context %, cost, cache hit ratio, 5 h/7 d plan %, lines changed | Yes, each update | Low-medium: a script that also logs a line |
| Hooks (`SessionEnd`, `SubagentStop`) | Paths and ids only, no usage | Yes | Low; trigger for the parser |
| OpenTelemetry | Tokens, cost per call, by session, model, `query_source`, agent, skill | Yes once enabled | High: env vars plus a collector (console exporter is cheaper) |
| `claude -p --output-format json` | Cost, usage by model, turns, duration for one run | Yes, scripted only | Medium: needs an eval harness |
| ccusage | Daily/session/5-h block tokens and cost | Yes, reads JSONL | Very low; no per-subagent split |
| Addy / superpowers / CE evals | Fire rate, judge pass rate per arm, turns, cache tokens vs baseline | Yes in harness | High; worth it only for skill-wording trials |

## Candidate markers for trials

1. **Main-context peak %** per session: max `context_window.used_percentage`, logged by a status line script to a per-project file. Shows whether a change keeps the main thread lighter.
2. **Main vs subagent token split** per session: sum `message.usage` in the session JSONL vs subagent files (`subagents/agent-*.jsonl`), by a PowerShell parser run from `/end-session`. Shows whether delegation actually moves weight off the main thread.
3. **Per-subagent tokens and duration by agent type and model**: from `toolUseResult.totalTokens`/`durationMs` and the task-notification `<usage>`, joined to `.meta.json` `agentType`/`model`. Feeds the model-selection tickets.
4. **Standing context weight**: tokens of system + tools + memory + skills at session start, read once from `/context` (manual) or approximated from the first assistant call's `cache_creation + cache_read` in the JSONL (automatic). Shows the cost of adding a skill or growing CLAUDE.md.
5. **Plan % per session**: `rate_limits.five_hour.used_percentage` at first and last status line update. Rough (account-wide), but the number that actually limits work.
6. **Cache hit ratio and misses**: `prompt_cache.hit_ratio`/`misses` from the status line, or `cache_read / (input + cache_read + cache_creation)` from the JSONL. Flags changes that break caching (e.g. edited tool lists).
7. **Turns and tool calls per task**: count of assistant messages and tool uses per session from the JSONL (CE's "orchestrator turns"). A proxy for rework.
8. **Skill fire rate** (only for trials of skill descriptions): N headless `claude -p` runs per prompt with the model pinned and CLI version recorded, as Addy Osmani does; manual-trigger fallback is a note in `trials.md`.

Common rule from the others: record model and CLI version beside every number, and compare against a baseline from production on the same kind of task.
