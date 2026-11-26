# A fast ideas inbox

Type: grilling
Status: resolved
Blocked by: none

## Question

How does the owner drop in a quick idea in a few seconds, mid-task, in any project or in this repo, and then have that idea come back up later through the wayfinder map instead of sitting in a list? Today `notes/ideas.md` is the inbox, but adding to it means opening the file and choosing a section, and nothing moves an idea into a map's decision tickets or its fog.

Points to decide:

1. **Capture:** a skill (e.g. `/idea <one line>`) or a plain instruction in `AGENTS.md`? Model-callable or user-only? Should it ask anything, or just append a dated line and return to the task without breaking flow?
2. **Where it lands:** `notes/ideas.md` (one file, an `## Inbox` section at the top) or a new `.scratch/inbox.md`? Line format: date, one line, source project, maybe a tag.
3. **From a primed project:** an idea about the toolbox that comes up in another project. Written into that project, or sent back to this repo (path from `workflow_repo`)? Projects must not carry files they don't use.
4. **Into the wayfinder map:** how wayfinder (or `/start-session`) picks up inbox items: list them when the map is opened, then the owner says for each one: new decision ticket, add to an existing ticket, fog ("Not yet specified"), backlog (`ideas.md` sections), or drop. Who writes the ticket: wayfinder, or the inbox skill on request ("idea -> ticket")?
5. **Clearing the inbox:** a processed idea is moved or struck through with where it went, so the inbox stays short.
6. **How it fits 09 (evolution loop):** 09 decides how ideas.md, the roadmap, the CHANGELOG and decisions relate; this ticket only covers the fast path in and the route into a map. Settle the boundary between them.

## Answer

Resolved 2026-11-23 (grilling).

1. **Capture:** a new global skill `/idea` (installed like `setup-workflow`, so no project carries a copy), user-only (`disable-model-invocation: true`). It asks nothing: appends one line, confirms in one line, back to the task. Its description names the `wf` option.
2. **Line:** `- YYYY-MM-DD · <project> · <idea>`, no tag; sorting happens at triage.
3. **Where it lands:**
   - Project idea (`/idea <text>`): `## Inbox` at the top of the project's `docs/IDEAS.md` (same shape as `notes/ideas.md`), created on first use, never in `templates/`.
   - In this repo: `## Inbox` at the top of `notes/ideas.md`.
   - Toolbox idea (`/idea wf <text>`): a GitHub issue labelled `idea` on the Workflow repo (`gh issue create`), date and source project in the body, so every machine sees it. Fallback without `gh`: append uncommitted to the Workflow repo's `notes/ideas.md` via `workflow_repo` (the next session there carries it onto its branch); if `workflow_repo` is unknown, print the line to paste. Decision 0007.
4. **Surfacing:** `/start-session` prints one count line (Inbox lines, plus open `idea` issues in the Workflow repo).
5. **Triage:** `/idea` with no text walks every item, proposes a destination, the owner confirms or redirects, and triage writes it: new decision ticket in a map (`Type:`, `Status: open`, `Blocked by:`, `## Question`), comment on an existing ticket, fog in a map's "Not yet specified", backlog section, or drop. Several maps: ask which. No map: backlog, drop, or "start a map" (prints a `/mattpocock-skills:wayfinder <destination>. Ideas: ...` line; the ideas move to the backlog marked `(seeds a map)`).
6. **Clearing:** routed lines leave the Inbox and keep their origin (`idea YYYY-MM-DD · <project>`) where they land; dropped lines are deleted; toolbox issues are closed with a comment naming where they went. Strike-through stays only for backlog items dropped after sorting.
7. **Boundary with 09:** this ticket owns everything up to and including routing an inbox item; 09 owns what happens to it afterwards (backlog, roadmap, CHANGELOG, decisions, the trial loop).

Lands in a project: nothing until the first `/idea`, then only `docs/IDEAS.md`. Lands in this repo: the `idea` label, an `## Inbox` section in `notes/ideas.md`, the `/idea` skill in `skills/`, one line in `start-session`. Built later through `feature/...` -> `/ship`; trial on the beta track per 17.

## Reopened in part (2026-11-25)

Points 3, 5 and 6 (where it lands, triage, clearing) are reopened by 41, idea routing and auto-organisation: the owner wants routing and organisation to be largely automatic. Capture (points 1 and 2) stands.

## Revised by 41 (2026-11-26)

Points 3, 5 and 6 replaced by 41's answer: capture goes by script to home's `inbox/<machine>.md` (committed and pushed at once), not the project's `docs/IDEAS.md` or a GitHub issue; triage is the idea batch (repo chosen automatically, place proposed, one approval); drops are kept in `## Dropped`, not deleted. Decision 0013 supersedes 0007.
