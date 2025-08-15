#!/bin/bash
#
# File: core/engine/validator.sh
# Description: Validation engine for Claude Code Template system
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
# Function: validate_project_structure
# Description: Validate project structure against Claude Code standards
# Arguments:
#   $1 - Project directory to validate
#############################################################################
validate_project_structure() {
    local project_dir="$1"
    local errors=0
    local warnings=0
    
    log "INFO" "Validating project structure: $project_dir"
    
    # Check if directory exists
    if [[ ! -d "$project_dir" ]]; then
        log "ERROR" "Project directory does not exist: $project_dir"
        return 1
    fi
    
    # Validate Claude Code structure
    if ! validate_claude_structure "$project_dir"; then
        ((errors++))
    fi
    
    # Validate JSON files
    if ! validate_json_files "$project_dir"; then
        ((errors++))
    fi
    
    # Validate Markdown files
    if ! validate_markdown_files "$project_dir"; then
        ((warnings++))
    fi
    
    # Validate agent configurations
    if ! validate_agent_configurations "$project_dir"; then
        ((errors++))
    fi
    
    # Report results
    log "INFO" "Validation completed: $errors errors, $warnings warnings"
    
    if [[ $errors -gt 0 ]]; then
        return 1
    fi
    
    return 0
}

#############################################################################
# Function: validate_claude_structure
# Description: Validate Claude Code directory structure
# Arguments:
#   $1 - Project directory
#############################################################################
validate_claude_structure() {
    local project_dir="$1"
    local claude_dir="$project_dir/.claude"
    
    if [[ ! -d "$claude_dir" ]]; then
        log "ERROR" "Missing .claude directory: $claude_dir"
        return 1
    fi
    
    # Check required subdirectories
    local required_dirs=("agents" "commands")
    local missing_dirs=()
    
    for dir in "${required_dirs[@]}"; do
        if [[ ! -d "$claude_dir/$dir" ]]; then
            missing_dirs+=("$dir")
        fi
    done
    
    if [[ ${#missing_dirs[@]} -gt 0 ]]; then
        log "ERROR" "Missing required Claude directories: ${missing_dirs[*]}"
        return 1
    fi
    
    # Check optional directories  
    local optional_dirs=("memory" "workflows" "templates")
    for dir in "${optional_dirs[@]}"; do
        if [[ ! -d "$claude_dir/$dir" ]]; then
            log "DEBUG" "Optional directory not found: $dir"
        fi
    done
    
    log "DEBUG" "Claude Code structure validation passed"
    return 0
}

#############################################################################
# Function: validate_json_files
# Description: Validate JSON syntax in project
# Arguments:
#   $1 - Project directory
#############################################################################
validate_json_files() {
    local project_dir="$1"
    local errors=0
    
    log "DEBUG" "Validating JSON files in: $project_dir"
    
    # Find all JSON files
    while IFS= read -r -d '' json_file; do
        if [[ -f "$json_file" ]]; then
            log "DEBUG" "Validating JSON: $json_file"
            
            if ! jq . "$json_file" > /dev/null 2>&1; then
                log "ERROR" "Invalid JSON syntax: $json_file"
                ((errors++))
            fi
            
            # Validate settings.json specifically
            if [[ "$(basename "$json_file")" == "settings.json" ]]; then
                if ! validate_settings_json "$json_file"; then
                    ((errors++))
                fi
            fi
        fi
    done < <(find "$project_dir" -name "*.json" -type f -print0 2>/dev/null)
    
    if [[ $errors -eq 0 ]]; then
        log "DEBUG" "All JSON files valid"
    fi
    
    return $(( errors > 0 ? 1 : 0 ))
}

#############################################################################
# Function: validate_settings_json
# Description: Validate Claude Code settings.json file
# Arguments:
#   $1 - Settings file path
#############################################################################
validate_settings_json() {
    local settings_file="$1"
    local errors=0
    
    log "DEBUG" "Validating settings file: $settings_file"
    
    # Check for required fields
    local required_fields=("permissions")
    
    for field in "${required_fields[@]}"; do
        if ! jq -e ".$field" "$settings_file" > /dev/null 2>&1; then
            log "ERROR" "Missing required field '$field' in: $settings_file"
            ((errors++))
        fi
    done
    
    # Validate permissions structure
    if jq -e ".permissions" "$settings_file" > /dev/null 2>&1; then
        # Check permissions.allow is an array
        if ! jq -e ".permissions.allow | type == \"array\"" "$settings_file" > /dev/null 2>&1; then
            log "ERROR" "permissions.allow must be an array in: $settings_file"
            ((errors++))
        fi
        
        # Check permissions.deny is an array  
        if ! jq -e ".permissions.deny | type == \"array\"" "$settings_file" > /dev/null 2>&1; then
            log "ERROR" "permissions.deny must be an array in: $settings_file"
            ((errors++))
        fi
    fi
    
    return $(( errors > 0 ? 1 : 0 ))
}

#############################################################################
# Function: validate_markdown_files
# Description: Validate Markdown files for basic structure
# Arguments:
#   $1 - Project directory
#############################################################################
validate_markdown_files() {
    local project_dir="$1"
    local warnings=0
    
    log "DEBUG" "Validating Markdown files in: $project_dir"
    
    # Find all Markdown files
    while IFS= read -r -d '' md_file; do
        if [[ -f "$md_file" ]]; then
            log "DEBUG" "Validating Markdown: $md_file"
            
            # Check for basic structure
            if ! head -1 "$md_file" | grep -q "^#"; then
                log "WARN" "Markdown file should start with a header: $md_file"
                ((warnings++))
            fi
            
            # Check for empty files
            if [[ ! -s "$md_file" ]]; then
                log "WARN" "Empty Markdown file: $md_file"
                ((warnings++))
            fi
        fi
    done < <(find "$project_dir" -name "*.md" -type f -print0 2>/dev/null)
    
    log "DEBUG" "Markdown validation completed with $warnings warnings"
    return 0
}

#############################################################################
# Function: validate_agent_configurations
# Description: Validate agent configuration files
# Arguments:
#   $1 - Project directory
#############################################################################
validate_agent_configurations() {
    local project_dir="$1"
    local errors=0
    local agents_dir="$project_dir/.claude/agents"
    
    if [[ ! -d "$agents_dir" ]]; then
        log "DEBUG" "No agents directory found"
        return 0
    fi
    
    log "DEBUG" "Validating agent configurations in: $agents_dir"
    
    # Find all agent files
    while IFS= read -r -d '' agent_file; do
        if [[ -f "$agent_file" ]]; then
            log "DEBUG" "Validating agent: $agent_file"
            
            # Check for YAML frontmatter
            if ! head -1 "$agent_file" | grep -q "^---"; then
                log "ERROR" "Agent file missing YAML frontmatter: $agent_file"
                ((errors++))
                continue
            fi
            
            # Extract and validate frontmatter
            local frontmatter_end
            frontmatter_end=$(grep -n "^---$" "$agent_file" | tail -1 | cut -d: -f1)
            
            if [[ -z "$frontmatter_end" || $frontmatter_end -lt 2 ]]; then
                log "ERROR" "Invalid YAML frontmatter structure: $agent_file"
                ((errors++))
                continue
            fi
            
            # Check for required fields
            local required_fields=("name" "description")
            for field in "${required_fields[@]}"; do
                if ! sed -n "1,${frontmatter_end}p" "$agent_file" | grep -q "^$field:"; then
                    log "ERROR" "Agent missing required field '$field': $agent_file"
                    ((errors++))
                fi
            done
        fi
    done < <(find "$agents_dir" -name "*.md" -type f -print0 2>/dev/null)
    
    if [[ $errors -eq 0 ]]; then
        log "DEBUG" "All agent configurations valid"
    fi
    
    return $(( errors > 0 ? 1 : 0 ))
}

#############################################################################
# Function: validate_template_system
# Description: Validate the entire template system  
# Arguments:
#   $1 - Template directory
#############################################################################
validate_template_system() {
    local template_dir="${1:-$SCRIPT_DIR/../../templates}"
    
    log "INFO" "Validating template system: $template_dir"
    
    # Validate template structure
    if ! validate_template_structure "$template_dir"; then
        return 1
    fi
    
    # Validate individual template project
    if ! validate_project_structure "$template_dir"; then
        return 1
    fi
    
    log "INFO" "Template system validation completed successfully"
    return 0
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
            echo "Usage: $0 <command> [directory]"
            echo "Commands:"
            echo "  project <dir>    - Validate project structure"
            echo "  template [dir]   - Validate template system"
            exit "$EXIT_INVALID_INPUT"
            ;;
        "project")
            if [[ -z "${2:-}" ]]; then
                echo "Project directory required"
                exit "$EXIT_INVALID_INPUT"
            fi
            validate_project_structure "$2"
            ;;
        "template")
            validate_template_system "${2:-}"
            ;;
        *)
            echo "Unknown command: $1"
            exit "$EXIT_INVALID_INPUT"
            ;;
    esac
fi