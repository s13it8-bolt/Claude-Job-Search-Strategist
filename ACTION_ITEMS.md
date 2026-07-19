# Review & Recommendations

## Overall Workflow Review
The overarching workflow defined in `CLAUDE.md` provides an excellent, structured approach for managing a job search using Claude as a local sub-agent manager. Separating context, raw data inputs, and different stages of outputs (analysis, resumes, cover letters) enables highly specialized agent work and robust iteration.

However, relying purely on Claude Code or client UI features to type long paths for prompt queues or context stubs can be brittle. Providing actual CLI wrappers to standardise these actions (as proposed below) will make the human-in-the-loop steps far faster and less error-prone.

## Structural Discrepancies (Filesystem vs Documentation)
1.  **Missing `inputs/data/`:** `CLAUDE.md` references `inputs/data/` as a drop-zone for raw job descriptions, PDFs, and CSVs. However, this directory does not currently exist.
2.  **Missing Agent Playbook Sync:** `.claude/agents/` contains `interview-prep-researcher.md`, but it is missing from the human-readable `agents/` directory, which breaks the documented paradigm of keeping them paired.
3.  **Missing Output Dirs:** While most output directories exist, if `populate-gitkeep.sh` was run previously, they were added. However, `populate-gitkeep.sh` only touches existing directories. We should ensure the script can *create* the baseline documented structure before placing `.gitkeep`s.

## Open Issues & Action Items
-   [x] Create the missing `inputs/data/` directory.
-   [x] Sync `interview-prep-researcher.md` from `.claude/agents/` to `agents/`.
-   [x] Make `populate-gitkeep.sh` smarter: have it create the skeleton directory structure defined in `CLAUDE.md` first, ensuring consistency for new clones.
-   [x] Add automation tools to improve the developer experience and align with the "Slash command conventions" defined in `CLAUDE.md`.

## Automation Improvements

To better align with the slash commands referenced in `CLAUDE.md` (`/queue`, `/context`, etc.), we will implement a `workflow.sh` wrapper script that provides these as local CLI commands.

This script will allow a user to run:
- `./workflow.sh queue "Refine cover letter for Acme Corp"` -> Automatically creates a timestamped prompt file in `inputs/prompt-queue/to-run/`.
- `./workflow.sh context "Phone screening with Alice"` -> Creates a markdown stub in `user-context/` ready for notes.
- `./workflow.sh resume-tailor "Stark Industries - SWE"` -> Drops a prompt skeleton to tailor the resume.
- `./workflow.sh cover-letter "Stark Industries - SWE"` -> Drops a prompt skeleton to tailor the cover letter.

This provides the concrete "better automation" requested and acts as a bridge for environments without built-in slash commands.
