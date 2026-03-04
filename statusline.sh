#!/bin/bash
# Read JSON input once
input=$(cat)

# Helper functions for common extractions
get_model_name() { echo "$input" | jq -r '.model.display_name'; }
get_current_dir() { echo "$input" | jq -r '.workspace.current_dir'; }
get_project_dir() { echo "$input" | jq -r '.workspace.project_dir'; }
get_version() { echo "$input" | jq -r '.version'; }
get_cost() { echo "$input" | jq -r '.cost.total_cost_usd'; }
get_duration() { echo "$input" | jq -r '.cost.total_duration_ms'; }
get_lines_added() { echo "$input" | jq -r '.cost.total_lines_added'; }
get_lines_removed() { echo "$input" | jq -r '.cost.total_lines_removed'; }
get_total_input_tokens() { echo "$input" | jq -r '.context_window.total_input_tokens // 0'; }
get_total_output_tokens() { echo "$input" | jq -r '.context_window.total_output_tokens // 0'; }
get_used_percentage() { echo "$input" | jq -r '.context_window.used_percentage // 0'; }

# Extract values
MODEL=$(get_model_name)
CURRENT_DIR=$(get_current_dir)
PROJECT_DIR=$(get_project_dir)
COST=$(get_cost)
DURATION=$(get_duration)
TOTAL_INPUT_TOKENS=$(get_total_input_tokens)
TOTAL_OUTPUT_TOKENS=$(get_total_output_tokens)
USED_PERCENTAGE=$(get_used_percentage)
GIT_BRANCH=""

if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        GIT_BRANCH="$BRANCH"
    fi
fi

# Format directory display
if [ "$CURRENT_DIR" = "$PROJECT_DIR" ]; then
    DIR_DISPLAY="${CURRENT_DIR##*/}"
else
    PROJECT_NAME="${PROJECT_DIR##*/}"
    CURRENT_NAME="${CURRENT_DIR##*/}"
    DIR_DISPLAY="$PROJECT_NAME/$CURRENT_NAME"
fi

# Format cost (max 1 decimal place)
COST_FORMATTED=$(printf "%.1f" "$COST")

# Format duration (convert ms to seconds, no decimal places)
DURATION_SEC=$(echo "scale=0; $DURATION / 1000" | bc 2>/dev/null || echo "0")

# Format context window usage
USED_PCT_FORMATTED=$(printf "%.0f" "$USED_PERCENTAGE")

# Create sleek status line with colors
printf "📁 \033[33m%s 🌿 %s\033[0m | \033[36m⚡ %s\033[0m \033[32m💰 \$%s\033[0m \033[35m⏱️ %ss\033[0m \033[34m📊 %s%% context\033[0m\n" "$DIR_DISPLAY" "$GIT_BRANCH" "$MODEL" "$COST_FORMATTED" "$DURATION_SEC" "$USED_PCT_FORMATTED"