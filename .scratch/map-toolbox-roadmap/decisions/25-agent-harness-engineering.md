# Addy Osmani: agent harness engineering

Type: research
Status: resolved
Blocked by: none

## Question

What does Addy Osmani mean by agent harness engineering (the setup around a model: instructions, tools, context, feedback loops, guardrails), which practices does he recommend, and which does this toolbox already have, lack, or do differently?

Source: https://addyosmani.com/blog/agent-harness-engineering/

## Answer

- **Definition:** agent = model + harness; the harness is everything but the model (instruction files, skills, tools and MCP descriptions, filesystem and sandbox, subagents, hooks, observability). "A decent model with a great harness beats a great model with a bad harness": the same model ranked ~33rd in Claude Code and ~5th in another harness on Terminal Bench 2.0. Failures are treated as configuration problems first.
- **Ratchet, not brainstorm:** every `AGENTS.md` line traces to a real failure, is kept short (HumanLayer: under 60 lines, hand-written, no codebase overview) and is removed when a better model makes it redundant. For the toolbox: no failure log, and `templates/AGENTS.md` allows ~120 lines; add a lessons prompt to `/end-session` ("what went wrong that a rule would stop?") and trim the template towards 60.
- **Hooks are the enforcement layer:** typecheck and tests on stop (silent on success, exit 2 on failure); block `push --force`, pushes to `main`, `rm -rf`. For the toolbox: none today, guardrails are prose; an optional hooks kit in `templates/` is the biggest gap and a good beta trial.
- **Already strong:** durable state on disk, hand-off files and context resets, progressive disclosure, subagents for context control (STATUS/HANDOFF/LOG/PLAN, `.scratch/` tickets, skills); matches Anthropic's reset-from-hand-off pattern.
- **Sprint contracts and a separate evaluator:** agree "done" and how to check it before coding, because agents grade their own work too kindly. For the toolbox: partly covered by acceptance criteria and `/code-review`; add a "how we'll check it" line per work ticket.
- **Few focused tools, CLI over MCP** (MCP descriptions are prompt text, a prompt-injection route). For the toolbox: already the habit (`gh`, `az`), not written down; add to `CUSTOMISING.md` or the platform notes.
- **Harnesses move rather than shrink:** each component encodes something the model can't yet do alone. For the toolbox: a "new model" review that retires rules no longer bearing load (09 or 19).

Note: [notes/research/2026-11-23 Agent harness engineering.md](../../../notes/research/2026-11-23%20Agent%20harness%20engineering.md)
