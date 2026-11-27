# Maps close into a destination and are archived whole

Status: **accepted** (2026-11-27), roadmap decision ticket 14 (Closing work: maps and specs). Supersedes 0005. Not built yet; this map is the first to close this way.

A wayfinder map is a planning method in any repo, chosen by the flow table's signal (decisions can't be listed yet), not by preset. It lives in the repo whose files it will change, or in home when it spans repos. It closes when its frontier and fog are both empty: its last decision ticket writes the destination in the plan levels, each slice naming its route (spec, new map or small change) and status; a roadmap or plan destination is first reviewed by two fresh contexts (architecture review and a doubt pass). The closing PR carries the destination, a `git mv` of the whole map folder into the archive and the CHANGELOG line. Specs and planning folders are archived the same way when their last work ticket merges; nothing is folded into living docs at the end. Later changes to a roadmap are refreshes made in place; new fog gets a new map.

Over: (a) 0005's scope, wayfinder for `full` project starts only with `research/` branches, which this map's own run (a `lite` repo, research in notes) already outgrew; (b) deleting closed maps and relying on git history, which breaks links from ADRs and the destination; (c) folding specs into living specs at the end (OpenSpec, parked), which duplicates what the glossary, ADRs and guides already hold.

Trade-off: the archive grows and is never pruned, and closing a roadmap costs two extra review subagents.

Reverse it if: the archive is never opened in practice, or the closing reviews find nothing across two maps.
