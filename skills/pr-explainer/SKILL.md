---
name: pr-explainer
description: "[wf] Build a teacher-and-senior-engineer HTML explainer for the current branch's changes (plain-language what/why, technical why, wider system, testing guide, next steps, diagrams), save it to the explainer folder and publish it as an Artifact. Called by /open-pr for code PRs, or on request."
tier: optional
needs: Claude Code Artifact tool (claude.ai); the artifact-design and artifact-diagramming skills
---

Read `docs/agents/workflow-settings.md` first; names in `backticks` below are its settings.

Produce an explainer for the diff `<main_branch>...HEAD`. Facts come from the diff, `status_file`, `GLOSSARY.md`, any design digest, and the spec in `spec_folder`; never invent behaviour. Never include real customer or personal data.

1. Gather: `git log --oneline <main_branch>..HEAD`, `git diff --stat <main_branch>...HEAD`, then read the changed code ranges (grep first; do not read whole large files).
2. Load the `artifact-design` and `artifact-diagramming` skills before writing.
3. Write one self-contained HTML file `<explainer_dir>/<branch-slug>.html` (light and dark friendly, readable on a phone, no external scripts). Voice: a patient teacher who is also a senior engineer; plain words first, jargon defined on first use. Sections, in order:
   - **The short version**: 3 sentences, what changed and why it matters.
   - **What changed, in plain terms**: user-visible functionality first (before/after), no code vocabulary.
   - **Why it was done this way**: the technical reasons, trade-offs, alternatives rejected, links to any ADR.
   - **How it fits the wider system**: where this sits in the project's main flow and which modules are touched.
   - **How to test and use it**: exact commands (`test_command`, tool invocations, sample inputs), expected output, and what failure looks like.
   - **Next steps**: follow-ups, known caveats, the next step from `plan_file`.
   - **Diagrams** (inline SVG, accessible, both themes): at minimum (a) a flow/architecture diagram with the changed parts highlighted, and (b) a sequence or data-flow diagram of the changed behaviour. Add more only if they teach something.
4. Publish it with the Artifact tool (same file path on re-runs updates the same URL). Keep the file committed so it survives the artifact.
5. **Vault copy (only if `vault_folder` is set).** `./tools/Export-StandaloneHtml.ps1 -Source <explainer_dir>/<branch-slug>.html -Destination "<vault_folder>\Artifacts\PR Explainers\<YYYY-MM-DD> <branch-slug>.html"`. Keep the full path under ~200 characters (shorten the slug if needed). Then add one row at the top of `<vault_folder>\Artifacts\Artifacts Index.md` (date, artifact link, one-line "what it is", vault file). Overwrite the same dated file on a re-run the same day. If the vault cannot be reached, say so and do not fail the explainer.
6. Report the file path and the Artifact link; `/open-pr` puts the link in the PR body under "Explainer".
