# Trials run per module, and the evolution loop runs as a weekly review

Status: **accepted** (2026-11-27), roadmap decision ticket 09 (Evolution loop and evidence). Revises [0011](0011-beta-skills-side-by-side.md) (the unit of trial and the success check). Not built yet.

A trial is **one module switched on in one project**, with a pass condition written before it starts (1 to 3 markers with baseline and target, a "drop if" line, a review-by date; usage always measured; an optional owner opinion that is never a marker) and its own file, `notes/trials/<slug>.md`; `notes/trials.md` becomes an index. `<skill>-beta` copies and the template beta track stay as the ways a change is carried. Evidence comes from one markers row per session that `session-facts --end` appends to home. Once a week a home script ranks the sessions and `retro` reads the worst 1 in 5 transcripts in fresh subagents; every proposal is gated accepted / rejected / backlog in a weekly review file, and accepted ones leave as ideas. Removal is a trial in reverse, on set triggers (a new model, an `AGENTS.md` over about 60 lines, 90 days without a catch). Monthly, seed drift and migration retirement are checked in the same sitting.

Over: (a) keeping trials per `<skill>-beta` copy or template track (0011), which ties the evaluation to a file copy rather than the thing being judged; (b) `retro` offered at the end of every flagged session, which adds weight to the session end that 0018 keeps cheap; (c) pstack's `reflect` / `correct`, which duplicate `retro`; (d) a quarterly audit for pruning, which argues for each item instead of testing its absence; (e) markers on the project's LOG line, which grow the line and put usage in public repos.

Trade-off: a weekly ritual the owner has to keep, run per machine because transcripts live there; cloud sessions and other agents get only their lesson line and LOG; markers and reviews live in private home, so the public toolbox holds only trial files named generically.

Reverse it if: weekly reviews are skipped two weeks running, `retro` proposals are rarely accepted, or no rule in four reviews traces to a real failure.
