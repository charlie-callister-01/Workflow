# What can be measured

Type: research
Status: resolved
Blocked by: none

## Question

What do Claude Code and other agents expose about context weight, tokens and plan usage (`/context`, `/cost`, `/usage`, session transcripts under `~/.claude/projects/`, subagent usage in task results, OpenTelemetry), what can be collected automatically per session and per subagent, and what do other workflows (Addy Osmani's evals, superpowers, Compound Engineering) measure?

## Answer

- Inside a session, `/context` (context make-up) and `/usage` (aliases `/cost`, `/stats`: tokens in/out/cache by model, cost, plan bars, 24 h/7 d share by skill, subagent, plugin, MCP) are screens only.
- Automatic data already exists: session JSONL under `~/.claude/projects/` has per-call `usage` (input, output, cache read/write, thinking) and skill attribution; subagents get their own JSONL plus `.meta.json` (type, model); foreground Agent results carry `totalTokens`/`durationMs`, background ones a `<usage>` block. Deleted after 30 days by default, so extract at `/end-session`.
- The status line gets context %, cost, cache hit ratio and 5 h/7 d plan % as JSON on every update; logging it is the cheapest live feed. Hooks give paths only. OpenTelemetry has everything (incl. `query_source` main/subagent, `skill.name`) but needs a collector; `claude -p --output-format json` suits scripted evals.
- Others: ccusage reports tokens/cost per day, session, 5-h block (no subagent split); superpowers sums transcript usage per subagent; Addy Osmani measures skill fire rate and judge pass rate per arm; Compound Engineering compares turns and cache tokens to a baseline and grades from session logs. All pin model and CLI version.
- 8 candidate markers (peak context %, main vs subagent tokens, per-subagent tokens by type/model, standing context weight, plan % per session, cache hit ratio, turns per task, skill fire rate) are in the note.

Full note: [notes/research/2026-11-22 What can be measured.md](../../../notes/research/2026-11-22%20What%20can%20be%20measured.md)
