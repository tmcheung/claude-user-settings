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

# Extract values
MODEL=$(get_model_name)
CURRENT_DIR=$(get_current_dir)
PROJECT_DIR=$(get_project_dir)
COST=$(get_cost)
DURATION=$(get_duration)

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

# Create sleek status line with colors
printf "\033[36m⚡ %s\033[0m \033[33m📁 %s\033[0m \033[32m💰 \$%s\033[0m \033[35m⏱️ %ss\033[0m\n" "$MODEL" "$DIR_DISPLAY" "$COST_FORMATTED" "$DURATION_SEC" 