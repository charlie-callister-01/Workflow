# The Pragmatic Programmer

> A starting summary from public sources and general knowledge of the book, written in my own words. It is not a substitute for reading the book: the examples, exercises and nuance are in the book itself.

## Question

What does *The Pragmatic Programmer* (David Thomas and Andrew Hunt, 20th anniversary edition, 2019) offer the toolbox? Its main principles, which already show up here or in Matt Pocock's skills, and which could become a skill, rule, template line or learning note.

## Sources

- Publisher page: <https://pragprog.com/titles/tpp20/the-pragmatic-programmer-20th-anniversary-edition/> (description and chapter list, read 2026-11-22)
- The authors' own tips list: <https://pragprog.com/tips/> (100 tips, titles only; read 2026-11-22)
- Matt Pocock's skills, installed plugin v1.3.1: `to-tickets`, `prototype`, `diagnosing-bugs`, `tdd`, `codebase-design`, `grilling`, `retro`, `teach`
- This repo: `skills/`, `templates/`, `presets/`

## What I learned

The book is a set of short, independent topics (about 50) grouped into nine chapters, each ending in one or more numbered tips. It is about attitude and habits more than any language or tool.

### Philosophy: own it
- **Responsibility and agency.** You own your work and your career; offer options, not excuses.
- **Broken windows.** Small unrepaired mess signals that nobody cares, and rot speeds up. Fix it, or at least board it up (log it).
- **Good-enough software.** Make quality a requirement you agree with users, not an open-ended goal.
- **Knowledge portfolio.** Invest in learning regularly and diversely, and read critically.
- **Communicate.** Know your audience; documentation is part of the work.

### Approach: keep it easy to change
- **ETC (Easier To Change).** The value behind most design rules: when in doubt, choose what keeps change cheap.
- **DRY.** About duplicated *knowledge*, not duplicated text: one authoritative place for each fact, including docs and config.
- **Orthogonality.** Unrelated things should not affect each other; fewer side effects, smaller blast radius.
- **Reversibility.** No decision is final; avoid lock-in where you can.
- **Tracer bullets.** Build a thin end-to-end path early and grow it, so you see where you land.
- **Prototypes.** Disposable code to answer one question; throw it away.
- **Estimating.** Give ranges, state your model, and refine as you learn.

### Tools and habits
- Plain text, the shell, version control for everything, fluent editing, text-manipulation scripts.
- **Debugging.** Fix the problem, not the blame; reproduce first; "select isn't broken" (suspect your own code); rubber-ducking.
- **Engineering daybook.** A running log of what you did, learned and decided.

### Paranoia and coding
- **Design by contract, assertions, crash early** ("dead programs tell no lies"). State what a function needs and promises, and fail loudly when that breaks.
- **Take small steps; don't outrun your headlights.** Get feedback before each next step.
- **Don't program by coincidence.** Know *why* the code works; don't keep a fix you can't explain.
- **Decoupling.** Tell, don't ask; avoid long chains through other objects; prefer transforming data over shared state; be wary of inheritance.
- **Refactor early and often; test to design** (tests as the first user of the code); property-based tests; naming matters; security basics.

### Projects and teams
- **Requirements are discovered, not gathered.** Work with users; keep a project glossary.
- **Agility as a habit**: find where you are, take the smallest step towards where you want to be, check, repeat.
- **Pragmatic starter kit**: version control, regression tests, full automation. "Test early, often, automatically."
- **Delight users; sign your work** (take pride and accountability).

## Idea -> where it stands

| Idea | Already in toolbox | Pocock skill | Candidate |
|---|---|---|---|
| Tracer bullets | Tickets in `.scratch/` | `to-tickets` (explicitly tracer-bullet vertical slices) | none needed |
| Prototypes | none | `prototype` (throwaway, one question) | none needed |
| Requirements discovered with the user | `full` preset uses grill-with-docs | `grilling`, `to-spec` | none needed |
| Project glossary | `GLOSSARY.md` in templates | `domain-modeling` | none needed |
| Debugging: reproduce first, fix not blame | none | `diagnosing-bugs` (feedback loop first) | none needed |
| Test early, often, automatically; test as first user | platforms add CI | `tdd` | none needed |
| Take small steps / don't outrun headlights | ticket-by-ticket `/implement` | `tdd` (one test at a time), `implement` | none needed |
| Engineering daybook | `docs/LOG.md`, `day-log`, `vault-note` | none | none needed |
| Reversibility | ADR rule "hard to reverse" | `domain-modeling` ADRs | none needed |
| Good-enough software | presets (`lite` vs `full`) | none | **template line**: quality bar per project in `workflow-settings.md` |
| ETC / orthogonality / decoupling | `thermo-nuclear-code-quality-review` | `codebase-design` (depth, locality, seams) | **rule**: "when in doubt, pick what is easier to change" in templates/CLAUDE.md |
| DRY (knowledge, not text) | partly: `skills/` is the source, `.claude/skills/` copies | none | **rule** for this repo: every fact has one home; link, don't restate (README vs SETUP vs CUSTOMISING) |
| Broken windows | refactor backlog (`docs/REFACTOR.md`) | `code-review` (standards axis) | **rule**: a mess noticed in passing gets one line in the refactor backlog, never silently left |
| Design by contract, crash early | none | `codebase-design` (interface includes invariants and error modes) | **learning note**; maybe a coding-standards line |
| Don't program by coincidence | none | `diagnosing-bugs` partly | **rule**: never accept an agent fix nobody can explain; ask for the cause |
| Knowledge portfolio | `vault-note` | `teach` | **learning note** / input to ticket 08 (learning section) |
| Estimating with ranges | none | none | **learning note** (useful for work projects, `azure` platform) |
| Sign your work / pride | commit convention, `pr-explainer` | `pr` | none needed |
| Retrospect and improve the environment | ticket 09 (evolution loop) | `retro` | links to ticket 09 |

### Observations
- Pocock's skills already carry the "doing" half of the book (tracer bullets, prototypes, debugging, tests). The gaps are mostly *attitude* rules, which fit as one-liners in a CLAUDE.md template or a coding-standards file, not as skills.
- None of the candidates justify a new skill. The strongest are the broken-windows rule (cheap, fits the existing refactor backlog) and "don't program by coincidence" (matters more with an agent writing the code).

## What I might change in the workflow

- Add two or three one-line rules to `templates/CLAUDE.md` (ETC, broken windows to the backlog, no unexplained fixes). Keep it short: the template's value is its brevity.
- Apply DRY to this repo's own docs when README, SETUP and CUSTOMISING drift.
- Feed "knowledge portfolio", "design by contract" and "estimating" into the learning section (ticket 08) as learning notes, not skills.

## My reading notes

