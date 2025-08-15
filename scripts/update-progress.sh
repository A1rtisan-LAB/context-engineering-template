#!/bin/bash

# Project Improvement Progress Updater
# Updates the IMPROVEMENT_PLAN.md files with task completion status

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Files to update
PLAN_EN="docs/IMPROVEMENT_PLAN.md"
PLAN_KO="docs/IMPROVEMENT_PLAN.ko.md"

# Function to display usage
usage() {
    echo "Usage: $0 <action> <task-id> [notes]"
    echo ""
    echo "Actions:"
    echo "  start <task-id>    - Mark task as started"
    echo "  complete <task-id> - Mark task as completed"
    echo "  block <task-id>    - Mark task as blocked"
    echo "  status             - Show current progress"
    echo ""
    echo "Example:"
    echo "  $0 start 'Generate package-lock.json'"
    echo "  $0 complete 'Generate package-lock.json' 'Added with npm install --package-lock-only'"
    exit 1
}

# Function to update task status in markdown
update_task() {
    local file=$1
    local task=$2
    local action=$3
    local notes=$4
    local date=$(date +%Y-%m-%d)
    
    case $action in
        start)
            # Update task to show it's started
            sed -i.bak "/$task/,/^$/s/Status: Pending/Status: 🔄 In Progress/" "$file"
            sed -i.bak "/$task/,/^$/s/Started: $/Started: $date/" "$file"
            echo -e "${GREEN}✓ Task '$task' marked as started${NC}"
            ;;
        complete)
            # Mark task as completed with checkbox
            sed -i.bak "s/- \[ \] \*\*$task/- \[x\] \*\*$task/" "$file"
            sed -i.bak "/$task/,/^$/s/Status: .*/Status: ✅ Completed/" "$file"
            sed -i.bak "/$task/,/^$/s/Completed: $/Completed: $date/" "$file"
            if [ -n "$notes" ]; then
                sed -i.bak "/$task/,/^$/s/Notes: .*/Notes: $notes/" "$file"
            fi
            echo -e "${GREEN}✓ Task '$task' marked as completed${NC}"
            ;;
        block)
            # Mark task as blocked
            sed -i.bak "/$task/,/^$/s/Status: .*/Status: 🚫 Blocked/" "$file"
            if [ -n "$notes" ]; then
                sed -i.bak "/$task/,/^$/s/Notes: .*/Notes: BLOCKED: $notes/" "$file"
            fi
            echo -e "${RED}⚠ Task '$task' marked as blocked${NC}"
            ;;
    esac
    
    # Clean up backup files
    rm -f "$file.bak"
}

# Function to calculate and update progress
update_progress() {
    local file=$1
    
    # Count total tasks and completed tasks
    total=$(grep -c "^- \[.\] " "$file" || echo 0)
    completed=$(grep -c "^- \[x\] " "$file" || echo 0)
    
    if [ $total -gt 0 ]; then
        percentage=$((completed * 100 / total))
        
        # Update the progress line
        sed -i.bak "s/## 📊 .* Progress: .*% (.*\/.*)/## 📊 Overall Progress: ${percentage}% (${completed}\/${total}/" "$file"
        
        # Update phase progress
        for phase in 1 2 3 4; do
            phase_total=$(grep -A 100 "Phase $phase:" "$file" | grep -c "^- \[.\] " || echo 0)
            phase_completed=$(grep -A 100 "Phase $phase:" "$file" | grep -c "^- \[x\] " || echo 0)
            if [ $phase_total -gt 0 ]; then
                phase_percentage=$((phase_completed * 100 / phase_total))
                sed -i.bak "s/Phase $phase:.* - .*% Complete/Phase $phase:.* - ${phase_percentage}% Complete/" "$file"
            fi
        done
        
        echo -e "${GREEN}Progress updated: ${percentage}% (${completed}/${total} tasks)${NC}"
    fi
    
    # Clean up backup files
    rm -f "$file.bak"
}

# Function to show current status
show_status() {
    echo -e "${YELLOW}=== Project Improvement Status ===${NC}"
    echo ""
    
    if [ -f "$PLAN_EN" ]; then
        total=$(grep -c "^- \[.\] " "$PLAN_EN" || echo 0)
        completed=$(grep -c "^- \[x\] " "$PLAN_EN" || echo 0)
        pending=$((total - completed))
        
        if [ $total -gt 0 ]; then
            percentage=$((completed * 100 / total))
            echo -e "Overall Progress: ${GREEN}${percentage}%${NC} (${completed}/${total} tasks)"
            echo -e "  ✅ Completed: ${completed}"
            echo -e "  ⏳ Pending: ${pending}"
            echo ""
            
            # Show phase breakdown
            for phase in 1 2 3 4; do
                phase_total=$(grep -A 100 "Phase $phase:" "$PLAN_EN" | grep -c "^- \[.\] " || echo 0)
                phase_completed=$(grep -A 100 "Phase $phase:" "$PLAN_EN" | grep -c "^- \[x\] " || echo 0)
                if [ $phase_total -gt 0 ]; then
                    phase_percentage=$((phase_completed * 100 / phase_total))
                    echo -e "  Phase $phase: ${phase_percentage}% (${phase_completed}/${phase_total})"
                fi
            done
        fi
    else
        echo -e "${RED}Error: $PLAN_EN not found${NC}"
    fi
}

# Main script logic
if [ $# -lt 1 ]; then
    usage
fi

ACTION=$1

case $ACTION in
    start|complete|block)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Task ID required${NC}"
            usage
        fi
        TASK=$2
        NOTES=${3:-}
        
        # Update both English and Korean versions
        if [ -f "$PLAN_EN" ]; then
            update_task "$PLAN_EN" "$TASK" "$ACTION" "$NOTES"
            update_progress "$PLAN_EN"
        fi
        
        if [ -f "$PLAN_KO" ]; then
            update_task "$PLAN_KO" "$TASK" "$ACTION" "$NOTES"
            update_progress "$PLAN_KO"
        fi
        
        # Add to change log
        echo "| $(date +%Y-%m-%d) | $TASK | $USER | $ACTION - $NOTES |" >> docs/IMPROVEMENT_LOG.md
        ;;
    status)
        show_status
        ;;
    *)
        echo -e "${RED}Error: Unknown action '$ACTION'${NC}"
        usage
        ;;
esac

echo -e "${GREEN}✓ Update complete!${NC}"