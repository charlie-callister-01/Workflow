# An agent workspace replaces .scratch

Status: **accepted** (2026-11-27), roadmap decision ticket 43 (Directory and design). Not built yet; the toolbox moves first, in the roadmap map's closing PR.

Every repo keeps its planning and context work in one committed folder, `workspace/`, never code: a routing `CONTEXT.md`, the roadmap, maps, specs with their planning folders, research, session notes and the archive, its folders following the context layers (ICM). Routing files sit at the root and in each map or spec; stage contracts only in a spec's planning folders. `docs/agents/`, `docs/adr/`, `docs/LOG.md` and the root files stay where Pocock's skills expect them, and his skills reach the workspace through the tracker doc. One layout and naming scheme in every repo, the toolbox included.

Over: (a) Pocock's `.scratch/` working root, a hidden, throwaway-sounding folder that tools skip and that splits planning from research and roadmap; (b) spreading planning across `docs/` and `notes/`, which hides what is current and breaks the one-folder view of inputs and outputs.

Trade-off: drifts from Pocock's default path, so his skills rely on the tracker doc and may need checking after each upstream update; routing files are one more thing to keep current.

Reverse it if: Pocock's skills keep writing to `.scratch/` despite the tracker doc, or routing files go stale in the workspace trial.
