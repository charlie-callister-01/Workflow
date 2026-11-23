# Flavio Copes on pstack

Type: research
Status: resolved
Blocked by: none

## Question

What does Flavio Copes' write-up of pstack say (what it is, how it is used day to day, what works and what doesn't) beyond what 02 found, and what is worth taking?

Source: https://flaviocopes.com/pstack/

## Answer

- **Day to day:** nearly everything runs through `/poteto-mode` with a goal plus a way to check it; learn it by doing one real task; principles are named in the prompt and the reply says which decision each changed. For the toolbox: a required "how will we know it works" line wherever a task is set up.
- **Long runs:** a finish condition, not a time limit; each loop round makes one justified change, verifies, commits or discards, and logs a TSV row (time, phase, decision, reason, evidence, result). Three autonomy levels (Autonomous run, Autopilot, Orchestrate, which needs Graphite). For the toolbox: any loop or overnight mode needs a checkable finish condition and a decision log.
- **Review and learning:** `/interrogate` sorts findings into act on / consider / noted / dismissed, keeps the dismissed with reasons, applies nothing; `/reflect` sorts skill edits into accepted / rejected / backlog and waits for approval. For the toolbox: show dismissed findings in `thermo-nuclear-code-quality-review` and `/code-review`; any reflect/correct trial needs approval.
- **Works:** reproduce before fixing, design from callers, compare models on expensive decisions, verification as a project-local skill. **Doesn't:** overkill for small changes, multi-agent frontier runs get expensive, long playbooks mean trusting the routing, advanced flows need cursor-team-kit, GitHub and Graphite.
- **Outside Cursor:** the unofficial pstack-claude port keeps playbooks, principles, `/how`, `/why` and `/interrogate` but loses per-subagent models, `/loop` and setup; "Cursor remains the best fit".
- **fstack (his small-work option):** nail -> plan -> build -> check -> push; nail only when unclear (≤5 questions, 3-line summary to approve); the plan has a "what we're NOT doing" section; check asks: does it work, does it match the plan, is it simple. For the toolbox: supports `lite`; borrow the "not doing" section and the three-question check before `/ship`. Skip pstack wholesale, model panels and Orchestrate.

Note: [notes/research/2026-11-23 Flavio Copes on pstack.md](../../../notes/research/2026-11-23%20Flavio%20Copes%20on%20pstack.md)
