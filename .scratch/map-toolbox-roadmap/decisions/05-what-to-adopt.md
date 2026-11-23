# What to adopt from the researched methods

Type: grilling
Status: open
Blocked by: 01, 02, 03, 04, 25, 26, 27, 28

## Question

Which ideas from the researched methods does the toolbox adopt, and as what: a preset, a core or optional skill, a practice in a template, or nothing?

## Merged in: 33, principles in AGENTS.md (2026-11-23)

Which short, standing principles go into `templates/AGENTS.md`, and how the list stays short (each line traced to a real failure, pruned when a model no longer needs it; near 60 lines, research 25). Candidates: scope discipline (touch only what's asked, surface assumptions, stop and ask on conflicting requirements, push back when warranted), prefer boring, code as a liability, Chesterton's fence, Hyrum's law, DAMP over DRY in tests, small PRs and atomic commits. If this makes 05 too big for one session, split it out again.

Also weigh research 29 (the owner's notes) alongside 01-04 and 25-28.

## Candidates from Change flows (13, 2026-11-23)

05 fills the stages 13 defined (define, plan, build, verify, review, ship) and may swap any default skill. Candidates that change what happens inside a stage: fstack's "what we're NOT doing" section (plan) and three-question check before ship (does it work, does it match the plan, is it simple); anti-rationalisation tables in the toolbox's own skills; `/goal <condition>` for long runs (build/verify); the router (34). Plus the v1.3.2 subagent wording from 11 ("fresh context, not a fork").
