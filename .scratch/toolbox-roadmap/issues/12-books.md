# Books: The Pragmatic Programmer and Domain-Driven Design

Type: research
Status: resolved
Blocked by: none

## Question

What do *The Pragmatic Programmer* (Hunt and Thomas, 20th anniversary edition) and *Domain-Driven Design* (Eric Evans) offer the toolbox? For each book: its main principles, which already show up in the toolbox or in Matt Pocock's skills, and which could become a skill, rule, template line or learning note. Output one note per book that the owner can extend with their own reading notes.

## Answer

- Both notes are starting summaries from public sources (pragprog.com tips list and chapter list; Evans' free *DDD Reference*), each with an empty "My reading notes" section to extend.
- Pragmatic Programmer: Pocock's skills already carry the "doing" half (tracer bullets in `to-tickets`, `prototype`, `diagnosing-bugs`, `tdd`), and the toolbox has the daybook (`LOG.md`, `day-log`) and reversibility (ADRs). Gaps are attitude rules: ETC, broken windows to the refactor backlog, no unexplained fixes, DRY for this repo's own docs. These are one-line rules, not skills.
- Domain-Driven Design: `domain-modeling` already covers ubiquitous language, scenarios, ADRs and bounded contexts (`GLOSSARY-MAP.md`). Missing: a context map line (how contexts relate), an anticorruption rule for external APIs, and a "Core domain" line in `PLAN.md` to show where effort goes.
- Learning notes (feed ticket 08): design by contract, estimating, knowledge portfolio, DDD building blocks (entities, value objects, aggregates) with when not to use them.
- No new skill is justified by either book.

Research notes: [notes/research/2026-11-22 The Pragmatic Programmer.md](../../../notes/research/2026-11-22%20The%20Pragmatic%20Programmer.md), [notes/research/2026-11-22 Domain-Driven Design.md](../../../notes/research/2026-11-22%20Domain-Driven%20Design.md)
