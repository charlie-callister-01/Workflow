# A fast ideas inbox

Type: grilling
Status: open
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
