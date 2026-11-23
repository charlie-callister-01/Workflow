# Agent harness engineering

## Question

What does Addy Osmani mean by "agent harness engineering" (the setup around a model: instructions, tools, context, feedback loops, guardrails), which practices does he recommend, and which does this toolbox already have, lack, or do differently?

## Sources

- Addy Osmani, ["Agent Harness Engineering"](https://addyosmani.com/blog/agent-harness-engineering/) (blog, 2026-04-19): the main source, read in full on 2026-11-23.
- HumanLayer, ["Skill issue: harness engineering for coding agents"](https://www.humanlayer.dev/blog/skill-issue-harness-engineering-for-coding-agents): the source of the "it's a configuration problem" framing, the under-60-line instruction file and the silent-on-success hook. Read in full.
- Prithvi Rajasekaran (Anthropic), ["Harness design for long-running application development"](https://www.anthropic.com/engineering/harness-design-long-running-apps) (2026-03-24): the source of planner/generator/evaluator, sprint contracts, context resets and "every component encodes an assumption". Read in full.
- Cited by Osmani but not read here: Viv Trivedy's ["Anatomy of an Agent Harness"](https://x.com/Vtrivedy10/status/2031408954517971368) and [Harness-as-a-Service](https://www.vtrivedy.com/posts/claude-code-sdk-haas-harness-as-a-service), Birgitta Böckeler on [martinfowler.com](https://martinfowler.com/articles/exploring-gen-ai/harness-engineering.html), Simon Willison, ["Designing agentic loops"](https://simonwillison.net/2025/Sep/30/designing-agentic-loops/).

## What I learned

### The idea
- **Agent = model + harness.** The harness is everything that isn't the model: system prompt, `AGENTS.md`/`CLAUDE.md`, skills, subagent prompts, tools and MCP servers (with their descriptions), filesystem and sandbox, orchestration (subagents, hand-offs, model routing), hooks, and observability (logs, traces, cost). "If you're not the model, you're the harness." (Osmani, after Trivedy.)
- **"A decent model with a great harness beats a great model with a bad harness."** Evidence given: on Terminal Bench 2.0 the same model ranked about 33rd inside Claude Code and about 5th in another harness (HumanLayer).
- **Failures are a "skill issue" first.** Before blaming the model, fix the harness: a convention in `AGENTS.md`, a hook that blocks a command, a planner/executor split, typecheck feedback in the loop (Osmani, HumanLayer).

### The practices
1. **The ratchet.** Every real mistake becomes a rule; add constraints only after a failure and remove them when a better model makes them redundant. Every line in `AGENTS.md` should trace to a past failure: "ratchet, not brainstorm"; "pilot's checklist, not style guide". So a good harness can't be downloaded; it is shaped by your own failures (Osmani). HumanLayer: start simple, add config only after a failure, remove what doesn't help; they discarded more hooks than they kept.
2. **Work backwards from behaviour.** Name the behaviour you want, then the component that delivers it; a component that can't be tied to a behaviour probably shouldn't be there (Osmani).
3. **Filesystem and git as durable state**; **bash as the general tool** rather than a bespoke tool per action (Osmani, Willison).
4. **Sandboxes and default tooling**: isolated environments, allow-listed commands, network isolation; give the agent runtimes, git, test CLIs and a headless browser so it can check its own work (Osmani).
5. **Memory**: load `AGENTS.md` at every start; bridge the training cutoff with web search or docs tools such as Context7 (Osmani).
6. **Fight context rot**: compaction; offload big tool output to a file and keep head and tail; skills with progressive disclosure; full context resets from a compact hand-off file when compaction isn't enough (Osmani, Anthropic).
7. **Long tasks**: a plan file on disk checked step by step; the "Ralph loop" (a hook catches the exit and re-feeds the prompt into a fresh context, state read from disk); split generator from evaluator because agents grade their own work too kindly; **sprint contracts**, where builder and checker agree what "done" means before coding. Osmani says writing the done-condition first caught more scope drift than any prompt change. Anthropic adds that they later dropped sprints and resets as models improved.
8. **Hooks are the enforcement layer**: typecheck, lint and tests after edits; block `rm -rf`, `git push --force`, `DROP TABLE`; require approval before pushes to `main`; format on write. "Success is silent, failures are verbose." HumanLayer's stop hook exits with code 2 so the agent keeps going until errors are fixed, and keeps test output small (a full suite once dumped about 4,000 lines of passes into context).
9. **Short instruction file, few tools**: HumanLayer keeps theirs under 60 lines, hand-written (agent-generated files did worse and cost 20%+ more in an ETH Zurich study); no directory listings or codebase overviews. Ten focused tools beat fifty overlapping ones; prefer a well-known CLI (`gh`, `docker`) to an MCP server; tool descriptions are prompt text, so an untrusted MCP server can inject instructions (Osmani, HumanLayer).
10. **Subagents for context control, not personas**: isolated context, condensed result, cite `file:line` or URLs, cheaper model for the child (HumanLayer).
11. **Harnesses move rather than shrink**: "every component in a harness encodes an assumption about what the model can't do on its own" (Anthropic). Re-check the harness on each new model and remove pieces one at a time to see which bear load.

### Against this toolbox

| Practice | Toolbox today |
|---|---|
| Instruction file loaded every session | **Have.** `AGENTS.md` with `CLAUDE.md` = `@AGENTS.md` (decision 0006); `/start-session` reads it plus STATUS/HANDOFF. |
| Short instruction file | **Have, looser.** This repo's `AGENTS.md` is 29 lines; `templates/AGENTS.md` caps at ~120 lines, double HumanLayer's 60. The template's "Solution map" is the kind of overview HumanLayer says doesn't help. |
| Ratchet: each rule traces to a failure | **Lack.** Rules come from research and presets, not a failure log. Nothing records "this went wrong, so this rule exists". Closest: `notes/decisions/`, ticket 09 (evolution loop). |
| Filesystem state, plans on disk, hand-off files | **Have, strongly.** `docs/STATUS.md`, `HANDOFF.md`, `LOG.md`, `PLAN.md`, `.scratch/` specs and tickets. This is the toolbox's core and matches the "context reset from a hand-off file" pattern. |
| Progressive disclosure | **Have.** Skills; `AGENTS.md` points to `docs/` rather than inlining; "only `docs/phases/P-NN.md`". |
| Subagents for context control | **Have.** Template's "Context discipline" section; `/code-review` runs parallel subagents; research delegated to agents. |
| Done-condition before coding (sprint contract) | **Partly.** `/to-spec` and `/to-tickets` write acceptance criteria; `/code-review` checks against spec. No explicit "agree how it will be verified" step per ticket. |
| Separate evaluator | **Partly.** `/code-review` and `/thermo-nuclear-code-quality-review` run in fresh context; no evaluator that runs the app. |
| Hooks (verify on stop, block destructive commands) | **Lack.** No hooks or `settings.json` in `templates/`, `presets/` or `tools/`. Guardrails are prose ("never commit to `main`", "open PRs only with `/ship`"), which the model can ignore. |
| Sandboxes, allow-lists | **Lack.** Left to Claude Code's defaults and permission prompts. |
| Few tools, CLI over MCP | **Have, by habit.** Platforms use `gh` and `az` CLIs. Not written down as a rule. |
| Observability (cost, traces) | **Lack.** Covered as research in "What can be measured" (ticket 20/21). |
| Re-check the harness on new models | **Lack.** No step to retire rules when a model improves. |

## What I might change in the workflow

1. **A failure log that feeds the ratchet.** When an agent gets something wrong, one line in `docs/LESSONS.md` (or a `fix:` line in LOG) noting what went wrong and the rule or hook it produced. `/end-session` could ask "anything go wrong that a rule would have stopped?". Fits ticket 09 (evolution loop) and ticket 22 (ideas inbox).
2. **Trim the `AGENTS.md` template.** Aim for ~60 lines, not 120; drop or shrink the "Solution map"; make the rule "every line earns its place, add after a failure".
3. **Ship a small hooks kit as an option** (`templates/.claude/settings.json` or a preset knob): block `git push --force`, push to `main`, `rm -rf`; on Stop, run the project's `test_command` quietly and exit 2 only on failure. Turns the prose guardrails into enforced ones. Start with one or two hooks; trial on the beta track.
4. **A verification line per ticket.** `/to-tickets` already writes acceptance criteria; add "how will we check it" (command or manual step) before `/implement` starts. Cheap sprint contract.
5. **Write down "prefer a CLI over an MCP server"** in `CUSTOMISING.md` or the platform notes, with the prompt-injection reason.
6. **A "new model" review.** When the default model changes, walk the presets and `AGENTS.md` template and ask which rules still bear load. Could live in ticket 09 or 19 (model selection).

Candidates for `../ideas.md`: 1, 3, 4 (the parent decides in ticket 05).
