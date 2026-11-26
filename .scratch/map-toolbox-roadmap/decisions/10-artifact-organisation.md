# Artifact organisation and export

Type: grilling
Style: interview
Status: open
Blocked by: 35, 40

## Question

How are the artifacts a project produces (research, changes, lessons learned, decisions) organised in the repo so they are readable and searchable; how is research captured, summarised (summary or index) and passed on to ideas, decisions and the vault; and which are exported to outside places such as the Obsidian vault, and how?

## Merged in: 08, learning section (2026-11-23)

Where coding practices, learning notes and book notes (see 12) live, what shape they take, and how something learned becomes a skill, rule or template change. Read with 35's answer on whether this repo becomes an LLM-kept wiki (`notes/index.md`, ingest / query / lint, research 29) and its relation to the Obsidian vault.

## From 35 (2026-11-24)

The Obsidian vault is replaced by a private **knowledge repo** (learning is a folder in it); it is the LLM-kept wiki. This repo's `notes/` stays the toolbox's own record. Organise and export both here; ideas reach the knowledge repo from the home repo.

## From 35, review (2026-11-24)

Review: now three places, not one repo plus a vault: each project's artifacts, the toolbox's `notes/`, and the knowledge repo. The directory map fog spans all three.

## Map refit (2026-11-24)

Session G, opened with what 40 took from the owner's ICM research. Takes in from 09: how `ideas.md` / the inbox, the roadmap, `CHANGELOG.md` and the decision records relate. The directory map page is no longer a fog patch: once this resolves, writing it is a roadmap item.

## From 40 (2026-11-26)

New point for this session: **design the planning stage-folder layout** (grill, spec, tickets for one effort, each stage with a `CONTEXT.md` contract: load / don't load, outputs, checkpoint; a human review at each boundary; code untouched) and run it as a beta trial (17) on one real feature, with 40's pass/fail test (edit the earliest affected stage, re-run only downstream, each stage output committed; fail if contracts go stale, the load table is ignored, or the ceremony outweighs a small change). Conventions to adopt: one-way links, one canonical home per fact (grep test), docs over outputs. Learning (from 08) moves out: the knowledge repo decides its own layout from `## For knowledge` in `notes/ideas.md`; this ticket keeps only what the toolbox and projects export to it.

## Owner principle (2026-11-26)

The owner's new standing principle (map Main takeaways): every module ships with a **guide** (what, why, how to use, how to configure, how to tell it is working). Decide where guides live in the toolbox and how they are indexed (possibly the planned directory map page), and whether they also serve as the learning material 08 merged in here.
