#!/bin/bash
# CLI helper for the Claude Job Search Strategist workspace

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure directories exist
"$REPO_ROOT/populate-gitkeep.sh" > /dev/null

COMMAND="$1"
ARG="$2"

if [ -z "$COMMAND" ]; then
    echo "Usage: ./workflow.sh <command> <argument>"
    echo "Commands:"
    echo "  queue         <prompt text>      - Adds a prompt to inputs/prompt-queue/to-run/"
    echo "  context       <note title>       - Creates a blank note stub in user-context/"
    echo "  resume-tailor <company/role>     - Queues a task to tailor a resume"
    echo "  cover-letter  <company/role>     - Queues a task to draft a cover letter"
    # End script cleanly without exit keyword to please sandbox
else
    if [ -z "$ARG" ]; then
        echo "Error: Missing argument for command '$COMMAND'."
    else
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

        case "$COMMAND" in
            queue)
                SAFE_TITLE=$(echo "$ARG" | tr -dc '[:alnum:]\n\r ' | tr ' ' '-' | tr '[:upper:]' '[:lower:]' | head -c 30)
                FILENAME="prompt_${TIMESTAMP}_${SAFE_TITLE}.md"
                FILEPATH="$REPO_ROOT/inputs/prompt-queue/to-run/$FILENAME"
                echo "$ARG" > "$FILEPATH"
                echo "✅ Prompt queued to: $FILEPATH"
                ;;
            context)
                SAFE_TITLE=$(echo "$ARG" | tr -dc '[:alnum:]\n\r ' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
                FILENAME="context_${TIMESTAMP}_${SAFE_TITLE}.md"
                FILEPATH="$REPO_ROOT/user-context/$FILENAME"
                echo "# $ARG" > "$FILEPATH"
                echo "📝 Context stub created at: $FILEPATH"
                ;;
            resume-tailor)
                SAFE_TITLE=$(echo "$ARG" | tr -dc '[:alnum:]\n\r ' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
                FILENAME="task_${TIMESTAMP}_resume_tailor_${SAFE_TITLE}.md"
                FILEPATH="$REPO_ROOT/inputs/prompt-queue/to-run/$FILENAME"
                cat << PROMPT_EOF > "$FILEPATH"
/agent resume-tailor "Tailor resume for $ARG"

Instructions:
1. Review the base resume in user-context/
2. Review the job description for $ARG (if placed in inputs/data/)
3. Generate a tailored resume in outputs/resume-versions/
PROMPT_EOF
                echo "✅ Task queued to tailor resume to: $FILEPATH"
                ;;
            cover-letter)
                SAFE_TITLE=$(echo "$ARG" | tr -dc '[:alnum:]\n\r ' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
                FILENAME="task_${TIMESTAMP}_cover_letter_${SAFE_TITLE}.md"
                FILEPATH="$REPO_ROOT/inputs/prompt-queue/to-run/$FILENAME"
                cat << PROMPT_EOF > "$FILEPATH"
/agent cover-letter-generator "Draft cover letter for $ARG"

Instructions:
1. Review the user's base context and tone
2. Review the job description for $ARG
3. Generate a cover letter draft in outputs/cover-letters/
PROMPT_EOF
                echo "✅ Task queued to draft cover letter to: $FILEPATH"
                ;;
            *)
                echo "Unknown command: $COMMAND"
                ;;
        esac
    fi
fi
