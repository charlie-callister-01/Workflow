# ICM paper findings: layers, observability, change

## Question

For roadmap ticket 40: what the ICM paper says about context layering and injection, observability of stages, handling change mid-pipeline, and education, to check the owner's takeaways from reading it. Builds on `2026-11-22 Interpretable Context Methodology.md` (ticket 03).

## Sources

Read 2026-11-26 by subagents; quotes checked verbatim in a second pass.

- Jake Van Clief, David McDermott, "Interpretable Context Methodology: Folder Structure as Agent Architecture", [arXiv:2603.16021v2](https://arxiv.org/html/2603.16021) (18 Mar 2026). The repo README links it under its older name, Model Workspace Protocol.
- [RinDig/Interpretable-Context-Methodology](https://github.com/RinDig/Interpretable-Context-Methodology): README and `_core/CONVENTIONS.md`.

## What I learned

**Layers and injection.** Five layers: 0 `CLAUDE.md` ("Where am I?", always loaded), 1 workspace `CONTEXT.md` (routing, "Where do I go?"), 2 stage `CONTEXT.md` (the contract for one step: inputs, process, outputs), 3 reference material (stable rules), 4 working artifacts (change every run). "Agents read down the layers. They stop as soon as they have what they need." (CONVENTIONS.md). "No agent reads everything." (§3.2). Injection is an Inputs table per stage contract listing exactly which files, and which section of each, the agent loads (columns Source | File/Location | Section/Scope | Why; "Full file" when needed).

**Observability.** "Every output is an edit surface." (§3.1). "Because every intermediate output is a plain file, the system is observable by default." (§5.3). "At each stage boundary, the human reviews the output." (§4.2). Optional Checkpoints (After Step | Agent Presents | Human Decides) and Audit tables (Check | Pass Condition, run before saving). There is no run log: "There is no logging layer to build, no dashboard to configure, no special tooling to inspect pipeline state." (README), and "ICM currently provides observability but not traceability." (§6.2); git history of committed outputs is the only record over time.

**Change.** Edit an output and the next stage picks up the edited version; "if the research output is fine but the script needs rework, the practitioner re-runs stage 2 without touching stage 1." (§6.1, compared to incremental compilation). Tracking edits across runs is future work. Limits: "Workflows that require complex branching logic based on AI decisions mid-pipeline are awkward in ICM." (§5.2); too slow for real-time or high-concurrency work; "No controlled comparison has been conducted between ICM's staged context loading and a monolithic prompting approach on the same tasks." (§4.6); one model family; self-selected practitioners.

**Education.** Only a `course-deck-production` workspace (PDFs and notes to slide decks, §4.3) and "training material development" as a listed use. Nothing on learners, curriculum or outcomes.

## What I might change

Decided in roadmap ticket 40: a planning stage-folder trial in 10 with a pass/fail test for agile change (commit each stage output to get the trace ICM lacks); layer table for `/start-session` (39) and load tables in skills and the flow table (34); audit tables into 31's Verification checklists; ICM's ideas for learning shelved in `notes/ideas.md`, `## For knowledge`.
