# One home per fact: short CHANGELOG and LOG lines that link

Status: **accepted** (2026-11-27), roadmap decision ticket 10 (Artifact organisation and export). Not built yet; the short lines start with this repo's next session.

Each record has one job: the decision ticket holds the full answer, an ADR holds why this over that, the map indexes answers in one line, `CHANGELOG.md` says what changed and when, `docs/LOG.md` says what a session did and what is next, a trial file holds a trial's evidence, a research note holds facts from sources, and `GLOSSARY.md` holds meanings. CHANGELOG and LOG lines are one or two lines plus links, never a restatement. Links go one way (tickets point at research, never back), and research is found through a generated index, not a hand-kept one.

Over: (a) long CHANGELOG and LOG paragraphs that read on their own, which wrote ticket 09's decision out four times (about 250 words in CHANGELOG, 130 in LOG) and let the copies drift; (b) dropping CHANGELOG for planning work, which loses the one dated list of what changed.

Trade-off: reading CHANGELOG or LOG alone no longer tells the whole story; the reader follows a link. Checked by the written-work review, not a script, until drift is recorded.

Reverse it if: the owner keeps following links to answer simple "what changed" questions, or the short lines lose facts that no other file holds.
