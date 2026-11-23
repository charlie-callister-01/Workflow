# Verification: what "checked" means for a change

Type: grilling
Status: open
Blocked by: 13

## Question

What counts as verified for each change flow, and where the check sits? Options on a dial: a "how we'll check it" line in every work ticket and plan, evidence required by `/ship` (command and output, or a screenshot), `/goal <condition>` for longer runs, a Stop hook that runs tests (moved here from 30). Also: runtime checks with a browser (playwright-cli or Chrome DevTools MCP), a trial `docs/FEATURES.md` feature map as shared vocabulary, Mermaid state diagrams plus a transition-table test for status fields, and the four stages for a solo developer (pre-merge, deploy, release, post-release).

Related: 25, 26, 28, 29, 30 (a Stop hook), 15 (after implementation); research in `notes/research/2026-11-23 Verification and enforceable architecture.md`.

## From 05 (2026-11-23)

`/ship` starts with a three-question check; "does it work" reads the verify evidence 31 defines. Every toolbox skill that writes or ships ends in a Verification checklist. `verify-this` (team kit) is a candidate verify-stage default.
