#!/bin/bash
#
# File: core/lib/filesystem.sh
# Description: File system utilities for Claude Code Template system  
# Version: 2.0
#

# Source common utilities
if [[ -z "${SCRIPT_DIR:-}" ]]; then
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

source "$SCRIPT_DIR/common.sh"
source "$SCRIPT_DIR/security.sh"

#############################################################################
# Function: safe_copy_recursive
# Description: Safely copy files/directories with validation
# Arguments:
#   $1 - Source path
#   $2 - Destination path
#############################################################################
safe_copy_recursive() {
    local src="$1"
    local dest="$2"
    
    # Validate input parameters
    if [[ -z "$src" || -z "$dest" ]]; then
        log "ERROR" "Source and destination paths are required"
        return 1
    fi
    
    # Validate source exists
    if [[ ! -e "$src" ]]; then
        log "ERROR" "Source does not exist: $src"
        return 1
    fi
    
    # Validate and normalize destination path
    local normalized_dest
    if ! normalized_dest=$(validate_and_normalize_path "$dest"); then
        return 1
    fi
    
    # Create parent directory if needed
    local dest_parent
    dest_parent="$(dirname "$normalized_dest")"
    if [[ ! -d "$dest_parent" ]]; then
        log "DEBUG" "Creating parent directory: $dest_parent"
        if ! mkdir -p "$dest_parent"; then
            log "ERROR" "Failed to create parent directory: $dest_parent"
            return 1
        fi
    fi
    
    # Perform the copy operation
    log "DEBUG" "Copying $src to $normalized_dest"
    if ! cp -r "$src" "$normalized_dest" 2>/dev/null; then
        log "ERROR" "Failed to copy $src to $normalized_dest"
        return 1
    fi
    
    return 0
}

#############################################################################
# Function: safe_create_directory
# Description: Safely create directory with proper permissions
# Arguments:
#   $1 - Directory path to create
#   $2 - Permissions (optional, defaults to 755)
#############################################################################
safe_create_directory() {
    local dir_path="$1" 
    local permissions="${2:-755}"
    
    # Validate and normalize path
    local normalized_path
    if ! normalized_path=$(validate_and_normalize_path "$dir_path"); then
        return 1
    fi
    
    # Check if directory already exists
    if [[ -d "$normalized_path" ]]; then
        log "DEBUG" "Directory already exists: $normalized_path"
        return 0
    fi
    
    # Create directory
    log "DEBUG" "Creating directory: $normalized_path"
    if ! mkdir -p "$normalized_path"; then
        log "ERROR" "Failed to create directory: $normalized_path"
        return 1
    fi
    
    # Set permissions
    if ! chmod "$permissions" "$normalized_path"; then
        log "WARN" "Failed to set permissions on directory: $normalized_path"
    fi
    
    return 0
}

#############################################################################
# Function: backup_existing_file
# Description: Create backup of existing file before modification
# Arguments:
#   $1 - File path to backup
#   $2 - Backup directory (optional, defaults to same directory)
#############################################################################
backup_existing_file() {
    local file_path="$1"
    local backup_dir="${2:-$(dirname "$file_path")}"
    
    if [[ ! -f "$file_path" ]]; then
        log "DEBUG" "File does not exist, no backup needed: $file_path"
        return 0
    fi
    
    local filename
    filename="$(basename "$file_path")"
    local backup_file="$backup_dir/${filename}.backup-$(date +%Y%m%d-%H%M%S)"
    
    # Create backup directory if needed
    if ! safe_create_directory "$backup_dir"; then
        return 1
    fi
    
    # Create backup
    log "DEBUG" "Creating backup: $backup_file"
    if ! cp "$file_path" "$backup_file"; then
        log "ERROR" "Failed to create backup: $backup_file" 
        return 1
    fi
    
    log "INFO" "Backup created: $backup_file"
    return 0
}

#############################################################################
# Function: replace_placeholders
# Description: Replace placeholders in files with actual values
# Arguments:
#   $1 - File path
#   $2 - Project name
#   $3 - Project type
#   $4 - Additional replacements (optional JSON string)
#############################################################################
replace_placeholders() {
    local file_path="$1"
    local project_name="$2" 
    local project_type="${3:-general}"
    local additional_replacements="${4:-{}}"
    
    if [[ ! -f "$file_path" ]]; then
        log "ERROR" "File does not exist: $file_path"
        return 1
    fi
    
    # Create backup before modification
    if ! backup_existing_file "$file_path"; then
        return 1
    fi
    
    # Perform basic placeholder replacements
    log "DEBUG" "Replacing placeholders in: $file_path"
    
    # Use sed for safe placeholder replacement
    sed -i.tmp \
        -e "s/PROJECT_NAME_PLACEHOLDER/$project_name/g" \
        -e "s/PROJECT_NAME/$project_name/g" \
        -e "s/PROJECT_TYPE_PLACEHOLDER/$project_type/g" \
        -e "s/PROJECT_TYPE/$project_type/g" \
        "$file_path"
    
    # Remove temporary file created by sed
    rm -f "${file_path}.tmp"
    
    return 0
}

#############################################################################
# Function: find_template_files
# Description: Find all template files in directory with caching
# Arguments:
#   $1 - Template directory
#   $2 - File pattern (optional, defaults to all files)
# Returns:
#   List of files (one per line)
#############################################################################
find_template_files() {
    local template_dir="$1"
    local pattern="${2:-*}"
    
    if [[ ! -d "$template_dir" ]]; then
        log "ERROR" "Template directory does not exist: $template_dir"
        return 1
    fi
    
    # Use find with proper error handling
    find "$template_dir" -type f -name "$pattern" 2>/dev/null | sort
}

#############################################################################
# Function: validate_template_structure
# Description: Validate template directory structure
# Arguments:
#   $1 - Template directory path
#############################################################################
validate_template_structure() {
    local template_dir="$1"
    
    if [[ ! -d "$template_dir" ]]; then
        log "ERROR" "Template directory does not exist: $template_dir"
        return 1
    fi
    
    # Check for required subdirectories
    local required_dirs=("agents" "commands" "memory" "workflows")
    local missing_dirs=()
    
    for dir in "${required_dirs[@]}"; do
        if [[ ! -d "$template_dir/$dir" ]]; then
            missing_dirs+=("$dir")
        fi
    done
    
    if [[ ${#missing_dirs[@]} -gt 0 ]]; then
        log "ERROR" "Missing required template directories: ${missing_dirs[*]}"
        return 1
    fi
    
    # Check for required files
    local required_files=("settings.json")
    local missing_files=()
    
    for file in "${required_files[@]}"; do
        if [[ ! -f "$template_dir/$file" ]]; then
            missing_files+=("$file")
        fi
    done
    
    if [[ ${#missing_files[@]} -gt 0 ]]; then
        log "WARN" "Missing optional template files: ${missing_files[*]}"
    fi
    
    log "DEBUG" "Template structure validation passed: $template_dir"
    return 0
}

#############################################################################
# Function: cleanup_old_backups
# Description: Clean up old backup files to prevent disk space issues
# Arguments:
#   $1 - Directory to clean
#   $2 - Number of backups to keep (default: 5)
#############################################################################
cleanup_old_backups() {
    local backup_dir="$1"
    local keep_count="${2:-5}"
    
    if [[ ! -d "$backup_dir" ]]; then
        return 0
    fi
    
    # Find and remove old backup files
    find "$backup_dir" -name "*.backup-*" -type f -print0 | \
        xargs -0 ls -t | \
        tail -n +$((keep_count + 1)) | \
        while read -r old_backup; do
            log "DEBUG" "Removing old backup: $old_backup"
            rm -f "$old_backup"
        done
}