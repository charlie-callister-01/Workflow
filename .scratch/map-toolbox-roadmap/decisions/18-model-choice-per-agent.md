# How model choice works per agent

Type: research
Status: resolved
Blocked by: none

## Question

How is the model chosen in Claude Code (`/model`, settings, a subagent's `model:` frontmatter, the Agent tool's model option, any built-in plan-with-one/build-with-another mode), and in Cursor, Codex and Gemini CLI? What does each model tier cost in plan usage? How can a plan made by one vendor's model be handed to another vendor's agent to implement (files, AGENTS.md, specs)?

## Answer

- **Claude Code:** main model via `/model`, `--model`, `ANTHROPIC_MODEL` or settings `"model"`. Per subagent: `model:` in `.claude/agents/*.md` (`haiku`/`sonnet`/`opus`/`fable`/ID/`inherit`), the Agent tool's `model` param (wins over the file), or `CLAUDE_CODE_SUBAGENT_MODEL`. Skills accept `model:` and `effort:` (current turn only, or the forked subagent with `context: fork`). `opusplan` = Opus in plan mode, Sonnet to execute.
- **Others:** Cursor subagents take `model:` (`inherit` default), main model via the picker/Auto. Codex: `model` in config.toml, `.codex/agents/*.toml` per agent (file wins over spawn), only a plan-mode *effort* key. Gemini CLI: `model.name`/`GEMINI_MODEL`, subagent `model:`, and auto routing uses Pro to plan, Flash to implement.
- **Cost:** API Opus 5.5 $4/$20, Sonnet 5.5 $2/$10, Haiku 5.5 $0.10/$0.50 per MTok; on plans, Opus costs "several times more per turn" than Sonnet, and subagents share the same limits.
- **Cross-vendor:** a plan in repo files (spec + tickets) plus AGENTS.md is the hand-off; Codex, Cursor and Gemini read AGENTS.md, Claude Code reads it when there is no CLAUDE.md or via an `@AGENTS.md` import. `model:` values do not port between vendors.
- **For the toolbox:** explicit `model:` in shipped agent files, `model:`/`context: fork` on Claude-only skills, optionally a `models:` line in `workflow-settings.md`, and recommend `opusplan`.

Note: [notes/research/2026-11-22 Model choice per agent.md](../../../notes/research/2026-11-22%20Model%20choice%20per%20agent.md)
