#!/bin/bash
#
# File: core/engine/generator.sh
# Description: Project generation engine for Claude Code Template system
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
# Function: generate_project
# Description: Main project generation function
# Arguments:
#   $1 - Project name
#   $2 - Project type (optional, defaults to "general")
#   $3 - Target directory (optional, defaults to current directory)
#############################################################################
generate_project() {
    local project_name="$1"
    local project_type="${2:-general}"
    local target_dir="${3:-.}"
    
    log "INFO" "Starting project generation: $project_name ($project_type)"
    
    # Validate inputs
    if ! validate_project_name "$project_name"; then
        return 1
    fi
    
    if ! validate_project_type "$project_type"; then
        return 1
    fi
    
    # Normalize target directory
    local normalized_target
    if ! normalized_target=$(validate_and_normalize_path "$target_dir"); then
        return 1
    fi
    
    local full_project_path="$normalized_target/$project_name"
    
    # Check if project already exists
    if [[ -e "$full_project_path" ]]; then
        log "ERROR" "Project directory already exists: $full_project_path"
        return 1
    fi
    
    # Create project directory
    log "INFO" "Creating project directory: $full_project_path"
    if ! safe_create_directory "$full_project_path"; then
        return 1
    fi
    
    # Copy template structure
    if ! copy_template_structure "$full_project_path" "$project_type"; then
        log "ERROR" "Failed to copy template structure"
        return 1
    fi
    
    # Process templates with placeholders
    if ! process_template_placeholders "$full_project_path" "$project_name" "$project_type"; then
        log "ERROR" "Failed to process template placeholders"
        return 1
    fi
    
    # Create project-specific directories
    if ! create_project_directories "$full_project_path" "$project_type"; then
        log "ERROR" "Failed to create project directories"
        return 1
    fi
    
    # Initialize git repository if git is available
    if command -v git &> /dev/null; then
        initialize_git_repository "$full_project_path"
    fi
    
    log "INFO" "Project generation completed successfully: $full_project_path"
    return 0
}

#############################################################################
# Function: validate_project_type
# Description: Validate that project type is supported
# Arguments:
#   $1 - Project type to validate
#############################################################################
validate_project_type() {
    local project_type="$1"
    
    # Get supported types from config
    local supported_types
    supported_types=$(get_config_value ".projectTypes | keys[]" | tr '\n' ' ')
    
    if [[ ! "$supported_types" =~ $project_type ]]; then
        log "ERROR" "Unsupported project type: $project_type"
        log "INFO" "Supported types: $supported_types"
        return 1
    fi
    
    return 0
}

#############################################################################
# Function: copy_template_structure  
# Description: Copy template files to project directory
# Arguments:
#   $1 - Project directory
#   $2 - Project type
#############################################################################
copy_template_structure() {
    local project_dir="$1"
    local project_type="$2"
    
    local template_dir="$SCRIPT_DIR/../../templates"
    
    if [[ ! -d "$template_dir" ]]; then
        log "ERROR" "Template directory not found: $template_dir"
        return 1
    fi
    
    log "INFO" "Copying template structure from: $template_dir"
    
    # Copy Claude Code configuration
    if [[ -d "$template_dir/.claude" ]]; then
        log "DEBUG" "Copying Claude Code configuration"
        if ! safe_copy_recursive "$template_dir/.claude" "$project_dir/.claude"; then
            return 1
        fi
    fi
    
    # Copy base template files
    local base_files=("CLAUDE.md" "INITIAL.md" "README.template.md")
    for file in "${base_files[@]}"; do
        if [[ -f "$template_dir/$file" ]]; then
            log "DEBUG" "Copying base file: $file"
            if ! safe_copy_recursive "$template_dir/$file" "$project_dir/$file"; then
                return 1
            fi
        fi
    done
    
    # Rename README.template.md to README.md
    if [[ -f "$project_dir/README.template.md" ]]; then
        mv "$project_dir/README.template.md" "$project_dir/README.md"
    fi
    
    return 0
}

#############################################################################
# Function: process_template_placeholders
# Description: Process all template files and replace placeholders
# Arguments:
#   $1 - Project directory
#   $2 - Project name
#   $3 - Project type
#############################################################################
process_template_placeholders() {
    local project_dir="$1" 
    local project_name="$2"
    local project_type="$3"
    
    log "INFO" "Processing template placeholders"
    
    # Find all template files that need processing
    local template_files
    template_files=$(find "$project_dir" -type f \( -name "*.md" -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" \) 2>/dev/null)
    
    while IFS= read -r file; do
        if [[ -n "$file" ]]; then
            log "DEBUG" "Processing placeholders in: $file"
            if ! replace_placeholders "$file" "$project_name" "$project_type"; then
                log "WARN" "Failed to process placeholders in: $file"
            fi
        fi
    done <<< "$template_files"
    
    return 0
}

#############################################################################
# Function: create_project_directories
# Description: Create project-specific directories based on type
# Arguments:
#   $1 - Project directory
#   $2 - Project type
#############################################################################
create_project_directories() {
    local project_dir="$1"
    local project_type="$2"
    
    # Get directories for project type from config
    local directories
    directories=$(get_config_value ".projectTypes.${project_type}.directories[]")
    
    if [[ "$directories" == "null" ]]; then
        log "DEBUG" "No specific directories defined for project type: $project_type"
        return 0
    fi
    
    log "INFO" "Creating project-specific directories"
    
    while IFS= read -r dir; do
        if [[ -n "$dir" && "$dir" != "null" ]]; then
            local full_dir_path="$project_dir/$dir"
            log "DEBUG" "Creating directory: $dir"
            if ! safe_create_directory "$full_dir_path"; then
                log "WARN" "Failed to create directory: $dir"
            fi
        fi
    done <<< "$directories"
    
    return 0
}

#############################################################################
# Function: initialize_git_repository
# Description: Initialize git repository in project directory
# Arguments:
#   $1 - Project directory
#############################################################################
initialize_git_repository() {
    local project_dir="$1"
    
    log "INFO" "Initializing git repository"
    
    # Change to project directory
    if ! cd "$project_dir"; then
        log "WARN" "Failed to change to project directory for git initialization"
        return 1
    fi
    
    # Initialize git repository
    if ! git init . &> /dev/null; then
        log "WARN" "Failed to initialize git repository"
        return 1
    fi
    
    # Create .gitignore if it doesn't exist
    if [[ ! -f ".gitignore" ]]; then
        cat > .gitignore << 'EOF'
# Dependencies
node_modules/
*.log

# Environment variables  
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Build outputs
dist/
build/
.next/
.nuxt/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Temporary files
*.tmp
*.temp
EOF
    fi
    
    # Add initial commit
    git add . &> /dev/null
    git commit -m "Initial commit from Claude Code Template" &> /dev/null
    
    log "DEBUG" "Git repository initialized successfully"
    return 0
}

#############################################################################
# Main execution when script is run directly
#############################################################################
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Script is being executed directly
    if ! validate_dependencies; then
        safe_exit "$EXIT_INVALID_INPUT" "Missing required dependencies"
    fi
    
    if [[ $# -lt 1 ]]; then
        echo "Usage: $0 <project-name> [project-type] [target-directory]"
        echo "Project types: general, api, frontend, fullstack"
        exit "$EXIT_INVALID_INPUT"
    fi
    
    generate_project "$@"
fi