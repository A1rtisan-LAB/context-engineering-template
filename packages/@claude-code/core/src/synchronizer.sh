#!/bin/bash
#
# File: core/engine/synchronizer.sh
# Description: Template synchronization engine for Claude Code Template system
# Version: 2.0
#

# Source required libraries
if [[ -z "${SCRIPT_DIR:-}" ]]; then
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/security.sh"
source "$SCRIPT_DIR/../lib/filesystem.sh"

#############################################################################
# Function: sync_templates
# Description: Synchronize templates between development and distribution
# Arguments:
#   $1 - Source directory (development)
#   $2 - Target directory (templates)
#   $3 - Operation (sync|diff|status)
#############################################################################
sync_templates() {
    local source_dir="$1"
    local target_dir="$2"
    local operation="${3:-sync}"
    
    log "INFO" "Template synchronization: $operation"
    log "DEBUG" "Source: $source_dir"
    log "DEBUG" "Target: $target_dir"
    
    # Validate directories
    if [[ ! -d "$source_dir" ]]; then
        log "ERROR" "Source directory does not exist: $source_dir"
        return 1
    fi
    
    # Create target directory if it doesn't exist
    if [[ ! -d "$target_dir" ]]; then
        log "INFO" "Creating target directory: $target_dir"
        if ! safe_create_directory "$target_dir"; then
            return 1
        fi
    fi
    
    case "$operation" in
        "sync")
            perform_sync "$source_dir" "$target_dir"
            ;;
        "diff")
            show_differences "$source_dir" "$target_dir"
            ;;
        "status")
            show_sync_status "$source_dir" "$target_dir"
            ;;
        *)
            log "ERROR" "Unknown operation: $operation"
            return 1
            ;;
    esac
}

#############################################################################
# Function: perform_sync
# Description: Perform actual synchronization
# Arguments:
#   $1 - Source directory
#   $2 - Target directory
#############################################################################
perform_sync() {
    local source_dir="$1"
    local target_dir="$2"
    local files_synced=0
    local errors=0
    
    log "INFO" "Starting template synchronization"
    
    # Create backup of target directory
    local backup_dir="${target_dir}.backup-$(date +%Y%m%d-%H%M%S)"
    if [[ -d "$target_dir" ]]; then
        log "INFO" "Creating backup: $backup_dir"
        if ! cp -r "$target_dir" "$backup_dir"; then
            log "WARN" "Failed to create backup, proceeding without backup"
        fi
    fi
    
    # Sync .claude directory if it exists
    if [[ -d "$source_dir/.claude" ]]; then
        log "DEBUG" "Synchronizing .claude directory"
        if sync_claude_directory "$source_dir/.claude" "$target_dir/.claude"; then
            ((files_synced++))
        else
            ((errors++))
        fi
    fi
    
    # Sync template files
    local template_files=("CLAUDE.md" "INITIAL.md" "README.template.md")
    for file in "${template_files[@]}"; do
        if [[ -f "$source_dir/$file" ]]; then
            log "DEBUG" "Synchronizing: $file"
            if safe_copy_recursive "$source_dir/$file" "$target_dir/$file"; then
                ((files_synced++))
            else
                ((errors++))
            fi
        fi
    done
    
    # Report results
    if [[ $errors -eq 0 ]]; then
        log "INFO" "Synchronization completed successfully: $files_synced files synced"
        
        # Cleanup old backup if sync was successful
        if [[ -d "$backup_dir" ]]; then
            log "DEBUG" "Removing backup directory: $backup_dir"
            rm -rf "$backup_dir"
        fi
    else
        log "ERROR" "Synchronization completed with $errors errors"
        
        # Keep backup for troubleshooting
        if [[ -d "$backup_dir" ]]; then
            log "INFO" "Backup preserved for troubleshooting: $backup_dir"
        fi
        
        return 1
    fi
    
    return 0
}

#############################################################################
# Function: sync_claude_directory
# Description: Synchronize .claude directory contents
# Arguments:
#   $1 - Source .claude directory
#   $2 - Target .claude directory
#############################################################################
sync_claude_directory() {
    local source_claude="$1"
    local target_claude="$2"
    
    # Create target .claude directory
    if ! safe_create_directory "$target_claude"; then
        return 1
    fi
    
    # Sync subdirectories
    local subdirs=("agents" "commands" "memory" "workflows" "templates")
    
    for subdir in "${subdirs[@]}"; do
        if [[ -d "$source_claude/$subdir" ]]; then
            log "DEBUG" "Synchronizing .claude/$subdir"
            if ! safe_copy_recursive "$source_claude/$subdir" "$target_claude/$subdir"; then
                log "ERROR" "Failed to sync .claude/$subdir"
                return 1
            fi
        fi
    done
    
    # Sync settings file
    if [[ -f "$source_claude/settings.json" ]]; then
        log "DEBUG" "Synchronizing settings.json"
        if ! safe_copy_recursive "$source_claude/settings.json" "$target_claude/settings.json"; then
            return 1
        fi
    fi
    
    return 0
}

#############################################################################
# Function: show_differences
# Description: Show differences between source and target
# Arguments:
#   $1 - Source directory
#   $2 - Target directory
#############################################################################
show_differences() {
    local source_dir="$1"
    local target_dir="$2"
    local differences=0
    
    log "INFO" "Checking for differences between directories"
    
    # Check .claude directory differences
    if [[ -d "$source_dir/.claude" && -d "$target_dir/.claude" ]]; then
        local claude_diff
        claude_diff=$(diff -r "$source_dir/.claude" "$target_dir/.claude" 2>/dev/null | wc -l)
        if [[ $claude_diff -gt 0 ]]; then
            log "INFO" "Found $claude_diff differences in .claude directory"
            ((differences++))
            
            # Show detailed differences
            diff -r "$source_dir/.claude" "$target_dir/.claude" | head -20
        fi
    elif [[ -d "$source_dir/.claude" && ! -d "$target_dir/.claude" ]]; then
        log "INFO" "Source has .claude directory, target does not"
        ((differences++))
    elif [[ ! -d "$source_dir/.claude" && -d "$target_dir/.claude" ]]; then
        log "INFO" "Target has .claude directory, source does not"
        ((differences++))
    fi
    
    # Check template files
    local template_files=("CLAUDE.md" "INITIAL.md" "README.template.md")
    for file in "${template_files[@]}"; do
        if [[ -f "$source_dir/$file" && -f "$target_dir/$file" ]]; then
            if ! diff "$source_dir/$file" "$target_dir/$file" >/dev/null 2>&1; then
                log "INFO" "Differences found in: $file"
                ((differences++))
            fi
        elif [[ -f "$source_dir/$file" && ! -f "$target_dir/$file" ]]; then
            log "INFO" "File exists in source but not target: $file"
            ((differences++))
        elif [[ ! -f "$source_dir/$file" && -f "$target_dir/$file" ]]; then
            log "INFO" "File exists in target but not source: $file"
            ((differences++))
        fi
    done
    
    if [[ $differences -eq 0 ]]; then
        log "INFO" "No differences found between directories"
    else
        log "INFO" "Total differences found: $differences"
    fi
    
    return 0
}

#############################################################################
# Function: show_sync_status
# Description: Show synchronization status
# Arguments:
#   $1 - Source directory
#   $2 - Target directory
#############################################################################
show_sync_status() {
    local source_dir="$1"
    local target_dir="$2"
    
    log "INFO" "Synchronization status report"
    
    # Check directory existence
    echo "Directory Status:"
    if [[ -d "$source_dir" ]]; then
        echo "  ✅ Source directory exists: $source_dir"
    else
        echo "  ❌ Source directory missing: $source_dir"
    fi
    
    if [[ -d "$target_dir" ]]; then
        echo "  ✅ Target directory exists: $target_dir"
    else
        echo "  ❌ Target directory missing: $target_dir"
    fi
    
    # Check .claude directory
    echo ""
    echo "Claude Code Configuration:"
    if [[ -d "$source_dir/.claude" ]]; then
        local agent_count
        agent_count=$(find "$source_dir/.claude/agents" -name "*.md" 2>/dev/null | wc -l)
        echo "  📁 Source agents: $agent_count"
    fi
    
    if [[ -d "$target_dir/.claude" ]]; then
        local target_agent_count
        target_agent_count=$(find "$target_dir/.claude/agents" -name "*.md" 2>/dev/null | wc -l)
        echo "  📁 Target agents: $target_agent_count"
        
        # Check if counts match
        if [[ -d "$source_dir/.claude" ]]; then
            if [[ $agent_count -eq $target_agent_count ]]; then
                echo "  ✅ Agent counts match"
            else
                echo "  ⚠️  Agent counts differ (source: $agent_count, target: $target_agent_count)"
            fi
        fi
    fi
    
    # Check last modification times
    echo ""
    echo "Last Modified:"
    if [[ -d "$source_dir" ]]; then
        echo "  Source: $(stat -f "%Sm" "$source_dir" 2>/dev/null || stat -c "%y" "$source_dir" 2>/dev/null || echo "unknown")"
    fi
    if [[ -d "$target_dir" ]]; then
        echo "  Target: $(stat -f "%Sm" "$target_dir" 2>/dev/null || stat -c "%y" "$target_dir" 2>/dev/null || echo "unknown")"
    fi
}

#############################################################################
# Main execution when script is run directly
#############################################################################
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if ! validate_dependencies; then
        safe_exit "$EXIT_INVALID_INPUT" "Missing required dependencies"
    fi
    
    case "${1:-}" in
        "")
            echo "Usage: $0 <command> <source> <target>"
            echo "Commands:"
            echo "  sync <source> <target>    - Synchronize templates"
            echo "  diff <source> <target>    - Show differences"
            echo "  status <source> <target>  - Show sync status"
            exit "$EXIT_INVALID_INPUT"
            ;;
        "sync"|"diff"|"status")
            if [[ $# -lt 3 ]]; then
                echo "Source and target directories required"
                exit "$EXIT_INVALID_INPUT"
            fi
            sync_templates "$2" "$3" "$1"
            ;;
        *)
            echo "Unknown command: $1"
            exit "$EXIT_INVALID_INPUT"
            ;;
    esac
fi