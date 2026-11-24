# Checks in each project's code

Type: grilling
Status: resolved
Notes: merged into 37 (seed files); the habit "every correction becomes a check" into 09 in the map refit (2026-11-24); its points now live there.
Blocked by: 07

## Question

What does a primed project get to keep its codebase pristine, per stack: lint and analyzer rules as errors (`.editorconfig` severities for .NET), architecture tests (NetArchTest or ArchUnitNET; eslint-plugin-boundaries or dependency-cruiser for JS/TS) mirroring the folder map in `AGENTS.md`, a comment guideline (no linter bans comments wholesale), and the habit "every correction becomes a check". Which are templates, which are suggestions at setup, and how does a project add a rule after an agent mistake?

Related: 02, 28, 29, 07 (repo profile decides the stack); research in `notes/research/2026-11-23 Verification and enforceable architecture.md`.

## From 35 (2026-11-24)

Fits 35: these neutral checks (lint severities, architecture tests) are exactly what shared and work repos carry instead of the owner's skills.

## From 30 (2026-11-24)

Order of layers (30): platform rules and CI, then git hooks, then agent hooks; a check is added only after a recorded failure. Candidate here: a CI diff check against the plan's Scope block (`Touch` / `Never`) if scope creep keeps getting past `/ship`'s three-question check.
