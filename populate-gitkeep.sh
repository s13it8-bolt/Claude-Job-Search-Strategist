#!/bin/bash
# Initialize skeleton directories and populate .gitkeep files
# Excludes .git directory to avoid interfering with git internals

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Initializing baseline directory structure..."
mkdir -p "$REPO_ROOT/user-context"
mkdir -p "$REPO_ROOT/inputs/prompt-queue/to-run"
mkdir -p "$REPO_ROOT/inputs/prompt-queue/run"
mkdir -p "$REPO_ROOT/inputs/data"
mkdir -p "$REPO_ROOT/data"
mkdir -p "$REPO_ROOT/outputs/analysis/company-reports"
mkdir -p "$REPO_ROOT/outputs/analysis/interview-prep"
mkdir -p "$REPO_ROOT/outputs/cover-letters"
mkdir -p "$REPO_ROOT/outputs/resume-versions"
mkdir -p "$REPO_ROOT/outputs/career-planning/cpd"
mkdir -p "$REPO_ROOT/outputs/personal-branding"

echo "Populating empty directories with .gitkeep..."
find "$REPO_ROOT" -type d -empty -not -path "$REPO_ROOT/.git*" -not -path "$REPO_ROOT/.claude*" | while read -r dir; do
    touch "$dir/.gitkeep"
    echo "Created: $dir/.gitkeep"
done

echo "Done."
