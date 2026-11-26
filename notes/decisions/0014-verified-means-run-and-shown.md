# Verified means a check was run and its output shown, set per project in a Checks section

Status: **accepted** (2026-11-26), roadmap decision ticket 31 (Verification and Checks lines). Revises 07 point 4 ([0010](0010-repo-profile-is-a-seed.md)). Not built yet.

Every unit of code-changing work (a change matching `code_pattern`) gets a `Check:` line at define: a command, a test name, or manual or smoke steps with an expected result. `/open-pr` runs a runnable check itself and writes the output, plus the Checks lines in force, into a `## Verification` section of the PR body, and refuses a code-changing PR without it. How strict this is lives in each repo's own `## Checks` section (inline in `AGENTS.md` or a pointer to `docs/agents/checks.md`), as `stage.knob[.flow]: value` lines that skills read and stakes only seeds. Four settings are seeded (`verify.check_line`, `verify.evidence`, `review`, `autonomy`); `plan.review`, `adr`, `high_risk`, `gate.pre_push` and `deploy` exist but start off.

Over: (a) a Claude Stop hook that runs tests, which only one agent obeys; (b) evidence pasted by the agent and judged by the agent, which is self-grading; (c) seeding every setting by stakes (high-risk lists, pre-push gates, next-day merges, doubt reviews), which adds checks before any failure has earned them (30) and names trial skills not yet promoted (05); (d) a Checks section only in shared repos, which leaves personal repos with none.

Trade-off: a small starting set means some protection waits for a first failure or a deliberate experiment; the open settings list needs 09's ratchet to grow it, and the `.flow` override form is defined before anyone has needed it. In return every repo starts with the one thing every source agrees on (a check that is run and shown), each PR records the rules it met, and every change to the rules is a commit with a reason.

Reverse it if: `/open-pr`'s refusal is routinely bypassed or the check lines turn into boilerplate nobody runs, or a repo's Checks section drifts so far from the seeds that refit's diff stops being useful.
