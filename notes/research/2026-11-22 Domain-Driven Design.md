# Domain-Driven Design

> A starting summary from public sources (mainly Evans' own *DDD Reference*) and general knowledge of the book, written in my own words. It is not a substitute for reading the book: the case studies and the reasoning behind each pattern are in the book itself.

## Question

What does *Domain-Driven Design: Tackling Complexity in the Heart of Software* (Eric Evans, 2003) offer the toolbox? Its main principles, which already show up here or in Matt Pocock's skills, and which could become a skill, rule, template line or learning note.

## Sources

- Eric Evans, *DDD Reference* (free PDF, version 2015-03, CC BY 4.0): <https://www.domainlanguage.com/ddd/reference/>. Summarises every definition and pattern in the book, plus three later patterns (read 2026-11-22).
- Evans' company site: <https://www.domainlanguage.com/>
- Matt Pocock's skills, installed plugin v1.3.1: `domain-modeling` (and its GLOSSARY/ADR formats), `grill-with-docs`, `codebase-design`, `tdd`, `wait-what`, `improve-codebase-architecture`
- This repo: `templates/docs/agents/domain.md`, `templates/docs/adr/`, `presets/full.md`

## What I learned

The book's claim: in complex software, the hard part is the domain, so the design should be built around a shared model of it, kept in step with the code. It has four parts.

### 1. Putting the model to work
- **Ubiquitous language.** One vocabulary shared by experts, developers and code. If a term changes in talk, it changes in code, and the reverse.
- **Knowledge crunching.** Developers and domain experts refine the model together through concrete scenarios.
- **Model-driven design.** The code *is* the model; no separate analysis model that drifts. People who model should also code (hands-on modellers).

### 2. Building blocks (tactical design)
- **Layered architecture**: isolate domain logic from UI, infrastructure and application plumbing.
- **Entities** (identity over time) vs **value objects** (defined only by their attributes; immutable, freely replaced).
- **Domain services** for operations that belong to no single object.
- **Aggregates**: a cluster of objects with one root that guards its consistency rules; outside code holds only the root.
- **Factories** (create complex things whole and valid) and **repositories** (the illusion of an in-memory collection of aggregates).
- **Modules** named in the ubiquitous language, high cohesion inside, low coupling between.
- Later additions in the Reference: **domain events** (something that happened that experts care about).

### 3. Refactoring toward deeper insight (supple design)
- Models improve in steps, sometimes in sudden **breakthroughs**; make implicit concepts explicit (constraints, processes, specifications).
- **Supple design**: intention-revealing interfaces, side-effect-free functions, assertions, conceptual contours (split where the domain splits), standalone classes, closure of operations, declarative style.

### 4. Strategic design
- **Bounded context.** A model and its language are valid only inside an explicit boundary. The same word may mean different things in two contexts; that is fine if the boundary is clear.
- **Context map.** Name each context and the relationship between them: shared kernel, customer/supplier, conformist, **anticorruption layer** (translate a foreign model at the edge), open host service, published language, separate ways; later also partnership and "big ball of mud" (mark a messy area and keep its model out).
- **Distillation.** Find the **core domain** (what makes the system worth building) and spend the best effort there; generic subdomains can be bought, borrowed or kept simple. A short **domain vision statement** says what the core is.
- **Large-scale structure**: evolving order, system metaphor, responsibility layers, knowledge level, pluggable frameworks. Use only when it helps.

## Idea -> where it stands

| Idea | Already in toolbox | Pocock skill | Candidate |
|---|---|---|---|
| Ubiquitous language | `GLOSSARY.md`; `templates/docs/agents/domain.md` ("use the glossary's vocabulary") | `domain-modeling`; `tdd` and `diagnosing-bugs` read the glossary; `wait-what` re-pitches in it | none needed |
| Knowledge crunching with scenarios | `full` preset: grill-with-docs | `grilling`, `domain-modeling` ("discuss concrete scenarios", "sharpen fuzzy language") | none needed |
| Model-driven design (code agrees with model) | none | `domain-modeling` ("cross-reference with code") | none needed |
| Bounded contexts | `GLOSSARY-MAP.md`, one glossary per context, in `domain.md` | `domain-modeling` multi-context layout; `codebase-design` avoids "boundary" because DDD owns it | none needed |
| Context map (relationships between contexts) | none: the map lists contexts but not how they relate | none | **template line**: one line per context pair in `GLOSSARY-MAP.md` (e.g. "billing conforms to payments API") |
| Anticorruption layer | none | `codebase-design` (seams and adapters) partly | **rule**: external APIs are translated at one seam; their terms don't leak into the glossary |
| Core domain / distillation | presets choose rigour per project, not per area | `improve-codebase-architecture` (focus on hot spots) | **template line** in `PLAN.md`: "Core domain: ...; generic parts: ..." so effort and full grilling go to the core |
| Domain vision statement | `PLAN.md` goal paragraph | none | fold into the same `PLAN.md` line |
| Recording model decisions | ADRs | `domain-modeling` ADR format | none needed |
| Supple design / intention-revealing interfaces | none | `codebase-design` (deep modules, interface includes invariants) | none needed; note the overlap in a learning note |
| Entities, value objects, aggregates, repositories, domain events | none | none | **learning note** (stack-neutral cheat sheet, with when *not* to use them) |
| Layered architecture, isolate the domain | none | `codebase-design` seams | **learning note** |
| Refactoring toward deeper insight | `thermo-nuclear-code-quality-review`, refactor backlog | `improve-codebase-architecture` | **rule**: when a glossary term changes, rename it in code in the same PR |
| Large-scale structure | none | none | skip for now (too big for personal projects) |

### Observations
- Pocock's `domain-modeling` already *is* the strategic heart of DDD in miniature: ubiquitous language, scenarios, ADRs, and bounded contexts via `GLOSSARY-MAP.md`. The toolbox adopts it through `domain.md`.
- What is missing is the *relationships between contexts* (context map, anticorruption layer) and *where to spend effort* (core domain). Both are one-line additions, not skills.
- The tactical building blocks are the part most often over-applied. They fit a learning note with warnings, not a rule.
- This toolbox has a domain of its own (skill, preset, platform, template, tier). A `GLOSSARY.md` for this repo could be worth a trial.

## What I might change in the workflow

- Add a "Core domain" line to `templates/docs/PLAN.md` and a relationship line per context to the `GLOSSARY-MAP.md` guidance in `domain.md`.
- Add an anticorruption rule for external APIs to the CLAUDE.md template or coding standards.
- Write a DDD building-blocks learning note under the learning section (ticket 08).
- Consider a `GLOSSARY.md` for this repo's own terms.

## My reading notes

