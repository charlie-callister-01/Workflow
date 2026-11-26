# Idea routing and auto-organisation

Type: grilling
Style: interview
Status: resolved
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

## Answer

Resolved 2026-11-26 (interview). Revises 22 points 3, 5 and 6; capture (22 points 1 and 2: one dated line, no questions) stands. Decision 0013, superseding 0007.

1. **Capture by script, files first.** `/idea <text>` runs an agent-neutral `idea` script (`sh` + `ps1`, in home) that appends `- YYYY-MM-DD · <project> · <text>` to home's `inbox/<machine>.md` (one append-only file per machine, so no merge conflicts), then commits and pushes only that file to home's `main`; home's `pre-commit` hook allows a direct commit for `inbox/` alone. `wf` and `k` prefixes mark the target as toolbox or knowledge; otherwise the target is the session project. It works the same on GitHub or Azure DevOps and offline (push later). **Started** by an agent hook where the agent has one (zero model tokens; Claude Code's prompt hook first, others when checked), otherwise a fresh-context subagent runs the script and returns only "noted". **Platform routes** (GitHub issue, DevOps work item) are an optional per-repo extra set in that repo's harness (e.g. `idea_route:`), never the core.
2. **Routing in a batch.** `/idea` with no text runs a fresh-context subagent (the **idea batch**) that loads only the open maps' Decisions and fog lines, ticket questions and backlog headings (ICM: load only what the contract lists). It **routes each idea to its repo without asking** and **proposes its place** (decision ticket, ticket note, fog, backlog, drop) in one table the owner approves in one go; an idea that would **create a decision ticket or change an open ticket's question always asks**. It runs when the owner calls it, when `/start-session` offers it (5 or more ideas waiting), or from an end-of-day step (39 decides which).
3. **Auto-organisation, inside the batch:** duplicates merged automatically (both origins kept, logged); related ideas grouped and attachments to open tickets proposed; backlog items untouched for 60 days proposed as keep / drop. The batch ends with one summary line: moved, merged, proposed, stale.
4. **Trust and undo:** every routed idea keeps its origin `(idea YYYY-MM-DD · <project>)`; a `## Log` section at the end of each repo's ideas file gets one line per move (`date · idea · from -> to · why`), merges and drops included; drops go to `## Dropped` with a reason, never deleted. Each batch is one commit per repo it touches (cross-repo: each repo's own PR, 36); undo is reverting that commit. The script's `check` mode, run by the batch before committing, fails if a routed line lost its origin or a log line points nowhere (a check, not prose).
5. **Surfacing:** `/start-session` gets counts from the script (no model context): one line, `Ideas: <project> N · toolbox N · knowledge N`, plus the triage offer at 5 or more.
6. **Triage skill:** stays the no-text form of `/idea`; the batch is the "inbox triaging skill" the 2026-11-25 Inbox idea asked for.
7. **Boundaries:** 09 unchanged (41 owns everything up to and including routing; the threshold 5 and the 60-day age are values 09's evidence may tune); 10 unchanged (the batch files into 10's layout).

**Until home is built (42):** this repo acts as home, but it is public, so no commit-to-main exception here: the Inbox stays in `notes/ideas.md`, committed on session branches, and triage is by hand as on 2026-11-25.

## Picks

| Source | What it does about this question | Owner's call |
|---|---|---|
| Pocock | Wayfinder fog and decision tickets as destinations; `chief-of-staff`'s dated, cited entries | **pick**: destinations, and origin lines on every routed idea |
| pstack / fstack | Decision log; dismissed findings kept with reasons | **pick**: `## Log` and `## Dropped` |
| Osmani | Must-hold rules as checks | **pick**: the script's `check` mode before each batch commit |
| ICM (from 40) | Reviewable file per stage; load only what the contract lists | **pick**: the batch's load list; the log as the reviewable output |

Owner's own: script and portable hooks first, subagent as backup, to save usage and context; files first, platform routes optional; capture into home so ideas reach every machine.
