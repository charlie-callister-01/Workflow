# Flavio Copes on pstack

## Question

What does Flavio Copes' write-up of pstack add (what it is, how it is used day to day, what works and what doesn't) beyond `2026-11-22 Cursor pstack and team kit.md`, and what is worth taking?

## Sources

- [flaviocopes.com/pstack](https://flaviocopes.com/pstack/) (page says "Updated Sep 29, 2026"; read 2026-11-23). A practitioner's write-up, so a secondary source for pstack itself; the facts about pstack's contents are in the earlier note, which read the repo.
- [flaviocopes.com/fstack](https://flaviocopes.com/fstack/) and [github.com/flaviocopes/fstack](https://github.com/flaviocopes/fstack) (MIT): his own small skill set, which he recommends over pstack for small work.
- Linked, not read in full: [pstack-claude](https://github.com/michael-denyer/pstack-claude) (community Claude Code port), [official pstack guide](https://github.com/cursor/plugins/tree/main/pstack/docs/guide), [overnight agent work](https://flaviocopes.com/overnight-agent-work/), [parallel agents](https://flaviocopes.com/parallel-agents/).

## What I learned

Only what the earlier note did not already cover.

### How it is used day to day

- **One entry point, a goal and a check.** "Most of the time, `/poteto-mode` is enough." Each prompt carries a goal *and* how to verify it, e.g. "add a `--json` flag, keep text output unchanged, verify both against the sample project"; for a bug: "reproduce both webhook deliveries first, trace, fix, verify one email is sent, valid purchases unchanged". Say "new task" to switch subject; "continue" stays in the mode.
- **Learn it by using it**, not by memorising skills: install, run setup, do one real task, watch the task list, then reach for `/how`, `/why`, `/interrogate` when a specific question comes up.
- **Principles steer, they are not commands.** You name a principle in the prompt; the reply must say which decision it changed. Naming it alone does not count.

### Pieces the earlier note didn't cover

- **Long runs need a finish condition, not a duration** (e.g. "zero old callers and fixtures pass"). With `/loop until done`, each iteration checks the condition, makes one justified change, verifies the real result, then commits or discards it. Every decision is a TSV row (time, phase, decision, reason, evidence, result), local by default.
- **Three tiers of autonomy**: Autonomous run (one task to a checkable condition); Autopilot-full (a queue of independent PRs through verify and merge) vs Autopilot-stack (one reviewed PR stack, a human lands it); Orchestrate (multi-day, stacked PRs, a standing coordinator, relies on Graphite; he warns against it for things that only *sound* big).
- **`/interrogate` keeps the dismissed findings.** Multi-model review sorted into act on / consider / noted / dismissed. The dismissed list with reasons is part of the output so you can overrule it, rather than "a mysterious filtered list". It never applies changes.
- **Verification as a repo capability**: `/create-verification-skill` means "'verify it' becomes a repository capability instead of a new conversation every time".
- **`/reflect` is gated**: several reviewers propose skill edits, a synthesiser sorts them into accepted / rejected / backlog, nothing changes until you approve. `/automate-me` reads recent transcripts, asks which repeated preferences are really yours, then writes `<name>-mode/SKILL.md`.
- Small extras: `/bro` (rewrite the last reply in plain language), `/figure-it-out` (design a custom, auditable playbook when no bundled one fits), `/teach` (`/how` + `/why`). Benny is a dormant Slack-bug-to-PR automation pack, work in progress.
- **Models**: `/setup-pstack` maps roles (implementation, investigation, judgement, review) to models; the number of models in a panel sets the number of reviewers. His advice: a cheap fast model for routine work, frontier models only for the hard parts.

### What works and what doesn't (his view)

- Works: reproduce before fixing; design from caller usage; multi-model comparison for expensive decisions; `/why` is slower than reading code "but keeps the explanation tied to evidence".
- Doesn't: overkill for small changes (a date or a sentence doesn't need "several models, an architecture arena, a decision log, and a verification skill"); several agents per task on frontier models gets expensive fast; long playbooks need you to trust the routing; depends on cursor-team-kit, GitHub and Graphite for the advanced flows.
- **Outside Cursor**: pstack-claude is an unofficial port (also ships a Codex plugin). Lost: `/add-plugin`, `/setup-pstack`'s model rule, per-subagent models, `/loop`. Kept: playbooks, principles, `/how`, `/why`, `/interrogate`. He still says "Cursor remains the best fit".
- **His small-work alternative, fstack**: 13 one-job skills, `npx skills@latest add flaviocopes/fstack`. Loop: `nail` (only if unclear: up to 5 questions, 3-line summary to approve) -> `plan` (one page, with a "what we're NOT doing" section) -> `build` (small steps, asks at real choices) -> `check` (works? matches plan? simple?) -> `push`. Credits pstack, gstack, Compound Engineering, Matt Pocock's skills and others as sources.

## What the toolbox might change

1. **Goal plus check in every task prompt.** Make "how will we know it works" a required line wherever the toolbox frames work (issue template, `/start-session` "what are we doing", plan step). Cheap and the single most repeated point in the article.
2. **Finish condition and decision log for long or unattended runs.** If the toolbox adds an overnight or loop mode, require a checkable finish condition (not a time) and a one-row-per-decision log; keep-or-discard each iteration.
3. **Keep the dismissed list in reviews.** When `thermo-nuclear-code-quality-review` or `/code-review` filters findings, show what was dismissed and why, so Charlie can overrule it.
4. **Gate any learning loop on approval.** If `reflect`/`correct` is trialled (earlier note), use the accepted / rejected / backlog split and change nothing without a yes.
5. **Size the ceremony to the task.** Confirms the `lite` preset's direction: a short loop for small changes, heavier process only when earned. fstack's "what we're NOT doing" section and three-question check (works / matches plan / simple) are worth borrowing into the plan and pre-`/ship` steps.
6. **Skip**: pstack wholesale, multi-model panels and Orchestrate/Graphite flows, Benny. pstack-claude confirms the earlier packaging note: playbooks and principles port; model routing and Cursor-only commands don't.
