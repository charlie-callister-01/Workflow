# Borrow ideas from outside skill sets; never install a pack

Status: **accepted** (2026-11-23), roadmap decision ticket 05 (What to adopt). Not built yet.

The toolbox takes ideas from outside skill sets (Addy Osmani's agent-skills, cursor-team-kit, pstack, superpowers) and rewrites them into its own skills and templates. A whole outside skill is copied into `skills/` as an optional skill only when it stands alone, with a credit line and the source version. Matt Pocock's skills and Claude Code's built-ins stay the default in every stage; a borrowed skill adds only what they lack. Borrowed skills are trialled one at a time on the beta track. Every source is pinned in `notes/upstream.md`, and a monthly sync checks each pin against its latest release.

Over: (a) installing whole packs, which brings a second router that clashes with native skill routing and puts files in projects that they never use; (b) using only Pocock's skills, which misses what others do better at review and ship.

Trade-off: copies and rewrites drift from upstream, so the register and sync are a standing chore, and keeping current is manual.

Reverse it if: the sync is skipped so often that borrowed parts go stale, or a pack ships per-skill installs that put nothing unused in a project.
