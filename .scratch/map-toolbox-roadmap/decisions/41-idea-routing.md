# Idea routing and auto-organisation

Type: grilling
Style: interview
Status: open
Blocked by: none

## Question

`/idea` will be central to the owner's workflow, so routing and organisation must be strong, with as little manual triage as possible. 22 settled capture (one dated line, no questions) and a manual triage walk (`/idea` with no text proposes a destination per item, the owner confirms). Since then 35 gave ideas three homes (a project, this toolbox, the knowledge repo) and moved `/idea` into home's harness. This ticket reopens 22 points 3, 5 and 6 (where it lands, triage, clearing); capture (22 points 1 and 2) stands unless the answer needs a change to it.

Decide:

1. **Auto-routing at capture:** does `/idea` classify the target repo (project, toolbox, knowledge) and place itself (map ticket, ticket comment, fog, backlog) when it is written, or only tag it and leave placement to triage? What it may decide alone, and what always needs the owner's confirmation.
2. **Context cost:** classifying needs the maps and backlogs, but capture mustn't break the session (Inbox idea of 2026-11-24: a hook or a fresh-context subagent that returns only "noted"). Where the classifying runs: at capture, in a background subagent, or in a batch at triage or `/start-session`.
3. **Auto-organisation:** how the inbox and backlogs stay sorted without the owner: grouping duplicates and related ideas, attaching ideas to the open ticket they touch, and ageing out stale backlog items. When does it run, and what gets reported?
4. **Trust and undo:** every automatic move leaves a trail (origin line, where it went, why) and can be undone; dropped ideas are kept with a reason, never silently deleted (pstack: keep dismissed findings with reasons).
5. **Boundaries:** with 09 (what happens to an idea after routing: trial loop, retro) and 10 (where artifacts live inside the knowledge repo and the toolbox). If this answer moves either boundary, add a "From 41" note to that ticket.

Picks panel: Pocock (wayfinder fog and tickets, `chief-of-staff` from 11), pstack / fstack (decision log, dismissed findings kept), Osmani (rules in checks, not prose), ICM (from 40: folder contracts, load / don't-load).

Created 2026-11-25 at the owner's request, taken straight after 40. Related: 22 (the inbox design it revisits), 35 and 36 (three repos, sessions start in home), 09, 10.

## From the inbox (2026-11-25)

From the inbox triage grilling: `/idea` capture must not interrupt the session's context. Two routes to weigh under question 2: a routed hook script (a prompt hook catches `idea ...`, appends the line and stops the prompt before the model sees it; Claude-only, so an optional extra under decision 0009) or a fresh-context subagent that writes the line and returns only "noted" (portable, costs a little context).

An **inbox triaging skill** (idea 2026-11-25, in the Inbox): the 2026-11-25 triage grilling, done by hand, is the worked example: each idea checked against the open tickets, a destination and its effect on them recommended, the owner confirms, notes written, Inbox cleared, one PR. Decide whether triage becomes its own skill or stays the no-text form of `/idea` (22 point 5). Its shape depends on this ticket's automatic routing and on 10's final directory structure.
