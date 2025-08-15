#!/bin/bash
#
# File: sync-templates.sh
# Description: Template synchronization and validation tool for Context Engineering projects
#              Manages template updates, validates configurations, and ensures project consistency
# Version: 2.0
# Author: Context Engineering Template
# Requirements: bash 4.0+, standard Unix tools (cp, mkdir, find, diff)
# Optional: jq (for JSON validation)
#
# Usage: ./sync-templates.sh [command] [project-dir]
#
# Commands:
#   validate              - Validate template files in this repository
#   update [project-dir]  - Update templates in existing project (default: current directory)
#   diff [project-dir]    - Check differences between templates and project (default: current directory)
#   list                  - List all available template files
#   help                  - Show detailed help message
#
# Arguments:
#   project-dir  - Path to Context Engineering project (default: current directory)
#                  Must contain .claude directory to be recognized as valid project
#
# Examples:
#   ./sync-templates.sh validate                    # Validate templates in this repository
#   ./sync-templates.sh update                      # Update templates in current directory
#   ./sync-templates.sh update /path/to/project     # Update templates in specific project
#   ./sync-templates.sh diff ./my-project           # Compare templates with project
#
# Exit Codes:
#   0 - Success
#   1 - Invalid command
#   2 - Invalid project directory
#   3 - Template errors
#   4 - File operation errors
#   5 - Permission errors
#   6 - User cancelled operation
#   7 - Backup errors

# Bash strict mode for better error handling
set -e          # Exit immediately on error
set -u          # Exit on undefined variables
set -o pipefail # Exit on pipe failures

#############################################################################
# CONFIGURATION AND CONSTANTS
#############################################################################

# Logging configuration
readonly LOG_LEVEL=${LOG_LEVEL:-"INFO"}  # DEBUG, INFO, WARN, ERROR
readonly LOG_FILE="/tmp/sync-templates-$(date +%Y%m%d-%H%M%S).log"

# Exit codes for different error conditions
readonly EXIT_SUCCESS=0
readonly EXIT_INVALID_COMMAND=1
readonly EXIT_INVALID_PROJECT=2
readonly EXIT_TEMPLATE_ERROR=3
readonly EXIT_FILE_OPERATION_ERROR=4
readonly EXIT_PERMISSION_ERROR=5
readonly EXIT_USER_CANCELLED=6
readonly EXIT_BACKUP_ERROR=7

# Color definitions for output formatting
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly RED='\033[0;31m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

#############################################################################
# UTILITY AND HELPER FUNCTIONS
#############################################################################

#############################################################################
# Function: log
# Description: Writes log messages to both log file and console with appropriate
#              formatting and filtering based on log level
# Arguments:
#   $1 - Log level (DEBUG, INFO, WARN, ERROR)
#   $* - Log message content
# Global Variables:
#   READS: LOG_LEVEL, LOG_FILE, color constants
# Returns:
#   0 - Always succeeds
# Side Effects:
#   - Appends to LOG_FILE
#   - Outputs to stdout/stderr with color formatting
# Example:
#   log "INFO" "Starting template sync"
#   log "ERROR" "Failed to process file: $filename"
#############################################################################
log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Write to log file
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
    
    # Display to user based on level
    case "$level" in
        DEBUG) [[ "$LOG_LEVEL" == "DEBUG" ]] && echo -e "${CYAN}[DEBUG]${NC} $message" ;;
        INFO) echo -e "${BLUE}[INFO]${NC} $message" ;;
        WARN) echo -e "${YELLOW}[WARN]${NC} $message" >&2 ;;
        ERROR) echo -e "${RED}[ERROR]${NC} $message" >&2 ;;
    esac
}

#############################################################################
# Function: safe_exit
# Description: Safely exits the script with proper cleanup and logging
# Arguments:
#   $1 - Exit code (optional, default: 0)
#   $2 - Exit message (optional)
# Global Variables:
#   READS: None directly
#   MODIFIES: None directly
# Returns:
#   Does not return (calls exit)
# Side Effects:
#   - Calls cleanup_on_exit
#   - Logs exit message
#   - Terminates script execution
# Example:
#   safe_exit 0 "Sync completed successfully"
#   safe_exit $EXIT_TEMPLATE_ERROR "Template validation failed"
#############################################################################
safe_exit() {
    local exit_code=${1:-0}
    local message="${2:-""}"
    
    if [[ -n "$message" ]]; then
        if [[ $exit_code -eq 0 ]]; then
            log "INFO" "$message"
        else
            log "ERROR" "$message"
        fi
    fi
    
    # Cleanup temporary files if any
    cleanup_on_exit
    
    exit $exit_code
}

#############################################################################
# Function: cleanup_on_exit
# Description: Performs cleanup operations when script exits, removing temporary
#              backup directories and incomplete operations
# Arguments:
#   None
# Global Variables:
#   READS: TEMP_BACKUP_DIR
#   MODIFIES: File system (removes temporary directories)
# Returns:
#   0 - Always succeeds (errors are ignored)
# Side Effects:
#   - Removes temporary backup directories
#   - Logs cleanup activities
# Example:
#   cleanup_on_exit  # Usually called automatically via trap
#############################################################################
cleanup_on_exit() {
    log "DEBUG" "Performing cleanup..."
    # Remove any temporary backup directories that weren't moved to final location
    if [[ -n "${TEMP_BACKUP_DIR:-}" ]] && [[ -d "$TEMP_BACKUP_DIR" ]]; then
        rm -rf "$TEMP_BACKUP_DIR" 2>/dev/null || true
    fi
}

# Trap for cleanup on exit
trap cleanup_on_exit EXIT

#############################################################################
# DIRECTORY CONFIGURATION
#############################################################################

# Determine script and template directories
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TEMPLATE_DIR="$SCRIPT_DIR/templates"

# Source the comprehensive validation library
readonly VALIDATOR_LIB="$SCRIPT_DIR/lib/template-validator.sh"
if [[ -f "$VALIDATOR_LIB" ]]; then
    source "$VALIDATOR_LIB"
    VALIDATION_LOG_FILE="$LOG_FILE"  # Use the same log file
    export VALIDATION_LOG_FILE
    log "DEBUG" "Loaded comprehensive validation library"
else
    log "WARN" "Comprehensive validation library not found: $VALIDATOR_LIB"
    log "WARN" "Falling back to basic validation functions"
fi

#############################################################################
# FILE OPERATION FUNCTIONS
#############################################################################

#############################################################################
# Function: safe_copy_recursive
# Description: Safely copies files or directories with comprehensive error
#              checking and logging
# Arguments:
#   $1 - Source path (file or directory)
#   $2 - Destination path
# Global Variables:
#   READS: EXIT_FILE_OPERATION_ERROR, EXIT_PERMISSION_ERROR, LOG_FILE
# Returns:
#   0 - Copy successful
#   Exits on error
# Side Effects:
#   - Creates parent directories as needed
#   - Logs all operations
#   - May terminate script on failure
# Safety Features:
#   - Validates source exists and is readable
#   - Creates destination parent directories
#   - Comprehensive error logging
# Example:
#   safe_copy_recursive "/path/to/source" "/path/to/dest"
#############################################################################
safe_copy_recursive() {
    local src="$1"
    local dest="$2"
    
    if [[ ! -e "$src" ]]; then
        safe_exit $EXIT_FILE_OPERATION_ERROR "Source does not exist: $src"
    fi
    
    if [[ ! -r "$src" ]]; then
        safe_exit $EXIT_PERMISSION_ERROR "No read permission for source: $src"
    fi
    
    local dest_parent="$(dirname "$dest")"
    if [[ ! -d "$dest_parent" ]]; then
        log "DEBUG" "Creating parent directory: $dest_parent"
        mkdir -p "$dest_parent" || safe_exit $EXIT_FILE_OPERATION_ERROR "Failed to create parent directory: $dest_parent"
    fi
    
    log "DEBUG" "Copying $src to $dest"
    if ! cp -r "$src" "$dest" 2>>"$LOG_FILE"; then
        safe_exit $EXIT_FILE_OPERATION_ERROR "Failed to copy $src to $dest"
    fi
}

#############################################################################
# Function: create_backup
# Description: Creates a timestamped backup of a file or directory
# Arguments:
#   $1 - Source path to backup
#   $2 - Name for the backup
#   $3 - Base directory for backup (where to create backup folder)
# Global Variables:
#   READS: EXIT_BACKUP_ERROR
# Returns:
#   Outputs backup directory path to stdout
# Side Effects:
#   - Creates backup directory with timestamp
#   - Copies source to backup location
#   - Logs backup creation
# Backup Structure:
#   - Creates .template-backup-YYYYMMDD-HHMMSS directory in base dir
#   - Preserves original structure and permissions
# Example:
#   backup_dir=$(create_backup "/path/to/source" "source-backup" "/project")
#############################################################################
create_backup() {
    local source="$1"
    local backup_name="$2"
    local backup_base_dir="$3"
    
    if [[ ! -e "$source" ]]; then
        log "DEBUG" "Source does not exist, skipping backup: $source"
        return 0
    fi
    
    local backup_dir="$backup_base_dir/.template-backup-$(date +%Y%m%d-%H%M%S)"
    if ! mkdir -p "$backup_dir" 2>>"$LOG_FILE"; then
        safe_exit $EXIT_BACKUP_ERROR "Failed to create backup directory: $backup_dir"
    fi
    
    log "INFO" "Creating backup: $backup_dir/$backup_name"
    safe_copy_recursive "$source" "$backup_dir/$backup_name"
    echo "$backup_dir"  # Return backup directory path
}

#############################################################################
# VALIDATION FUNCTIONS
#############################################################################

#############################################################################
# Function: validate_project_directory
# Description: Validates that the specified directory is a valid Context Engineering project
# Arguments:
#   $1 - Project directory path to validate
# Global Variables:
#   READS: EXIT_INVALID_PROJECT, EXIT_PERMISSION_ERROR
# Returns:
#   0 - Directory is valid Context Engineering project
#   Exits on validation failure
# Side Effects:
#   - May terminate script if directory invalid
#   - Logs validation results
# Validation Checks:
#   - Directory exists
#   - Contains .claude directory (Context Engineering marker)
#   - Has read and write permissions
# Example:
#   validate_project_directory "/path/to/project"
#############################################################################
validate_project_directory() {
    local project_dir="$1"
    
    # Check if directory exists
    if [[ ! -d "$project_dir" ]]; then
        safe_exit $EXIT_INVALID_PROJECT "Project directory does not exist: $project_dir"
    fi
    
    # Check if it's a Context Engineering project
    if [[ ! -d "$project_dir/.claude" ]]; then
        safe_exit $EXIT_INVALID_PROJECT "Not a Context Engineering project (missing .claude directory): $project_dir"
    fi
    
    # Check read/write permissions
    if [[ ! -r "$project_dir" ]]; then
        safe_exit $EXIT_PERMISSION_ERROR "No read permission for project directory: $project_dir"
    fi
    
    if [[ ! -w "$project_dir" ]]; then
        safe_exit $EXIT_PERMISSION_ERROR "No write permission for project directory: $project_dir"
    fi
    
    log "DEBUG" "Project directory validation passed: $project_dir"
}

#############################################################################
# Function: validate_command
# Description: Validates that the specified command is supported
# Arguments:
#   $1 - Command name to validate
# Global Variables:
#   READS: EXIT_INVALID_COMMAND
# Returns:
#   0 - Command is valid
#   Exits on invalid command
# Side Effects:
#   - May terminate script if command invalid
#   - Logs validation results
# Valid Commands:
#   - validate: Check template integrity
#   - update: Update project templates
#   - diff: Compare templates with project
#   - list: Show available templates
#   - help: Display help information
# Example:
#   validate_command "update"
#############################################################################
validate_command() {
    local command="$1"
    local valid_commands=("validate" "update" "diff" "list" "help")
    
    for valid_cmd in "${valid_commands[@]}"; do
        if [[ "$command" == "$valid_cmd" ]]; then
            log "DEBUG" "Command validation passed: $command"
            return 0
        fi
    done
    
    safe_exit $EXIT_INVALID_COMMAND "Invalid command: $command. Valid commands: ${valid_commands[*]}"
}

#############################################################################
# PARAMETER PROCESSING AND INITIALIZATION
#############################################################################

# Initialize log file
echo "Template Sync Log - $(date)" > "$LOG_FILE"

# Parse command line arguments with defaults
readonly COMMAND=${1:-"help"}
PROJECT_DIR=${2:-"."}  # Not readonly as it may be normalized later

#############################################################################
# USER INTERFACE FUNCTIONS
#############################################################################

#############################################################################
# Function: show_help
# Description: Displays comprehensive help information for the sync tool
# Arguments:
#   None
# Global Variables:
#   READS: LOG_FILE, CYAN, NC
# Returns:
#   0 - Always succeeds
# Side Effects:
#   - Outputs formatted help text to stdout
# Help Content:
#   - Usage examples
#   - Command descriptions
#   - Safety features overview
#   - Log file location
# Example:
#   show_help
#############################################################################
show_help() {
    echo -e "${CYAN}Context Engineering Template Synchronization Tool${NC}"
    echo ""
    echo "Usage: $0 [command] [project-dir]"
    echo ""
    echo "Commands:"
    echo "  validate              Validate template files in this repository"
    echo "  update [project-dir]  Update templates in existing project (default: current directory)"
    echo "  diff [project-dir]    Check differences between templates and project (default: current directory)"
    echo "  list                  List all available template files"
    echo "  help                  Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 validate                    # Validate templates in this repository"
    echo "  $0 update                      # Update templates in current directory"
    echo "  $0 update /path/to/project     # Update templates in specific project"
    echo "  $0 diff ./my-project           # Compare templates with project"
    echo ""
    echo "Safety Features:"
    echo "  • Automatic backups before updates"
    echo "  • Confirmation prompts for destructive operations"
    echo "  • Comprehensive error handling and logging"
    echo "  • Rollback capability for failed operations"
    echo ""
    echo "Log file: $LOG_FILE"
}

validate_templates() {
    log "INFO" "Starting comprehensive template validation..."
    
    # Check template directory first
    if [[ ! -d "$TEMPLATE_DIR" ]]; then
        safe_exit $EXIT_TEMPLATE_ERROR "Template directory not found: $TEMPLATE_DIR"
    fi
    
    if [[ ! -r "$TEMPLATE_DIR" ]]; then
        safe_exit $EXIT_PERMISSION_ERROR "No read permission for template directory: $TEMPLATE_DIR"
    fi
    
    # Use comprehensive validation if available, otherwise fall back to basic validation
    if command -v run_comprehensive_validation &> /dev/null; then
        log "INFO" "Using comprehensive validation system"
        
        # Validate both development and output contexts
        local validation_result=0
        
        # Validate development context (this repo's .claude/)
        if [[ -d "$SCRIPT_DIR/.claude" ]]; then
            log "INFO" "Validating development context (.claude/ assets)..."
            if ! validate_context_directory "$SCRIPT_DIR" "$CONTEXT_DEVELOPMENT"; then
                validation_result=1
            fi
        else
            log "WARN" "No development context found (.claude/ directory)"
        fi
        
        # Validate output templates
        log "INFO" "Validating output templates (templates/ directory)..."
        if ! validate_context_directory "$TEMPLATE_DIR" "$CONTEXT_OUTPUT"; then
            validation_result=1
        fi
        
        # Validate cross-directory synchronization
        if [[ -d "$SCRIPT_DIR/.claude" ]]; then
            log "INFO" "Validating synchronization between development and output contexts..."
            if ! validate_cross_directory_sync "$SCRIPT_DIR"; then
                validation_result=1
            fi
        fi
        
        if [[ $validation_result -eq 0 ]]; then
            log "INFO" "Comprehensive template validation completed successfully"
            return 0
        else
            log "ERROR" "Comprehensive template validation failed"
            return 1
        fi
    else
        log "WARN" "Comprehensive validation not available, using basic validation"
        return validate_templates_basic
    fi
}

# Basic validation function (fallback when comprehensive validation is not available)
validate_templates_basic() {
    log "INFO" "Running basic template validation..."
    
    local errors=0
    local warnings=0
    
    # JSON file validation
    log "INFO" "Validating JSON files..."
    if command -v jq &> /dev/null; then
        local json_files_found=false
        while IFS= read -r -d '' file; do
            json_files_found=true
            local rel_path="${file#$TEMPLATE_DIR/}"
            if ! jq empty "$file" 2>>"$LOG_FILE"; then
                log "ERROR" "JSON syntax error: $rel_path"
                ((errors++))
            else
                log "DEBUG" "JSON validation passed: $rel_path"
            fi
        done < <(find "$TEMPLATE_DIR" -name "*.json" -type f -print0 2>/dev/null)
        
        if [[ "$json_files_found" == "false" ]]; then
            log "INFO" "No JSON files found in templates"
        fi
    else
        log "WARN" "jq is not installed, skipping JSON validation"
        ((warnings++))
    fi
    
    # Check required template files
    log "INFO" "Checking required template files..."
    local required_files=(
        "CLAUDE.md"
        "INITIAL.md"
        "README.template.md"
    )
    
    for file in "${required_files[@]}"; do
        local full_path="$TEMPLATE_DIR/$file"
        if [[ -f "$full_path" ]]; then
            if [[ ! -r "$full_path" ]]; then
                log "ERROR" "No read permission for required file: $file"
                ((errors++))
            elif [[ ! -s "$full_path" ]]; then
                log "WARN" "Required file is empty: $file"
                ((warnings++))
            else
                log "DEBUG" "Required file validation passed: $file"
            fi
        else
            log "ERROR" "Required file missing: $file"
            ((errors++))
        fi
    done
    
    # Markdown file validation
    log "INFO" "Checking Markdown files..."
    local empty_md_files=()
    local binary_files=()
    
    while IFS= read -r -d '' file; do
        local rel_path="${file#$TEMPLATE_DIR/}"
        
        # Check if file is empty
        if [[ ! -s "$file" ]]; then
            empty_md_files+=("$rel_path")
        fi
        
        # Check if file is binary (shouldn't be for .md files)
        if command -v file &> /dev/null; then
            if file "$file" | grep -q "binary"; then
                binary_files+=("$rel_path")
            fi
        fi
    done < <(find "$TEMPLATE_DIR" -name "*.md" -type f -print0 2>/dev/null)
    
    if [[ ${#empty_md_files[@]} -gt 0 ]]; then
        log "WARN" "Empty Markdown files found:"
        printf '  - %s\n' "${empty_md_files[@]}" | tee -a "$LOG_FILE"
        ((warnings++))
    fi
    
    if [[ ${#binary_files[@]} -gt 0 ]]; then
        log "WARN" "Binary files with .md extension found:"
        printf '  - %s\n' "${binary_files[@]}" | tee -a "$LOG_FILE"
        ((warnings++))
    fi
    
    # Check for executable files that shouldn't be
    log "DEBUG" "Checking for unexpected executable files..."
    while IFS= read -r -d '' file; do
        local rel_path="${file#$TEMPLATE_DIR/}"
        if [[ -x "$file" ]] && [[ ! "$file" =~ \.(sh|py|rb|pl)$ ]]; then
            log "WARN" "Unexpected executable file: $rel_path"
            ((warnings++))
        fi
    done < <(find "$TEMPLATE_DIR" -type f -print0 2>/dev/null)
    
    # Summary
    log "INFO" "Basic template validation completed"
    log "INFO" "Errors: $errors, Warnings: $warnings"
    
    if [[ $errors -eq 0 ]]; then
        if [[ $warnings -gt 0 ]]; then
            log "WARN" "Template validation passed with $warnings warnings"
        else
            log "INFO" "All template validations passed successfully"
        fi
        return 0
    else
        log "ERROR" "Template validation failed with $errors errors"
        return 1
    fi
}

list_templates() {
    log "INFO" "Listing all template files..."
    
    echo -e "${BLUE}📋 Template File Inventory${NC}"
    echo ""
    
    local total_files=0
    local total_size=0
    
    # Function to display files in a category
    show_category() {
        local category="$1"
        local pattern="$2"
        local found_files=false
        
        echo -e "${CYAN}$category:${NC}"
        
        while IFS= read -r -d '' file; do
            found_files=true
            local rel_path="${file#$TEMPLATE_DIR/}"
            local file_size
            
            if command -v stat &> /dev/null; then
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    file_size=$(stat -f%z "$file" 2>/dev/null || echo "0")
                else
                    file_size=$(stat -c%s "$file" 2>/dev/null || echo "0")
                fi
                total_size=$((total_size + file_size))
            else
                file_size="?"
            fi
            
            printf "  • %-40s (%s bytes)\n" "$rel_path" "$file_size"
            ((total_files++))
        done < <(find "$TEMPLATE_DIR" $pattern -type f -print0 2>/dev/null | sort -z)
        
        if [[ "$found_files" == "false" ]]; then
            echo "  (no files found)"
        fi
        echo ""
    }
    
    # List files by category
    show_category "Claude Code Configuration" "-path '*/\.claude/*'"
    show_category "Root Template Files" "-maxdepth 1"
    show_category "All Other Files" "! -path '*/\.claude/*' ! -maxdepth 1"
    
    # Summary
    echo -e "${BLUE}Summary:${NC}"
    echo "  Total files: $total_files"
    if [[ "$total_size" != "0" ]] && [[ "$total_size" =~ ^[0-9]+$ ]]; then
        echo "  Total size: $total_size bytes ($(( total_size / 1024 )) KB)"
    fi
    echo "  Template directory: $TEMPLATE_DIR"
    echo ""
    
    log "INFO" "Listed $total_files template files"
}

diff_templates() {
    log "INFO" "Analyzing template differences for project: $PROJECT_DIR"
    
    echo -e "${BLUE}📊 Template Difference Analysis${NC}"
    echo -e "${CYAN}Project: $PROJECT_DIR${NC}"
    echo -e "${CYAN}Templates: $TEMPLATE_DIR${NC}"
    echo ""
    
    local changed_files=()
    local new_files=()
    local identical_files=()
    local missing_in_project=()
    local extra_in_project=()
    
    # Check all template files against project
    while IFS= read -r -d '' template_file; do
        local rel_path="${template_file#$TEMPLATE_DIR/}"
        local project_file="$PROJECT_DIR/$rel_path"
        
        if [[ -f "$project_file" ]]; then
            if ! diff -q "$template_file" "$project_file" 2>>"$LOG_FILE"; then
                changed_files+=("$rel_path")
                log "DEBUG" "File differs: $rel_path"
            else
                identical_files+=("$rel_path")
                log "DEBUG" "File identical: $rel_path"
            fi
        else
            new_files+=("$rel_path")
            log "DEBUG" "New file in templates: $rel_path"
        fi
    done < <(find "$TEMPLATE_DIR" -type f ! -path "*/.git/*" ! -name "*.backup-*" -print0 2>/dev/null)
    
    # Check for files in project that aren't in templates (within expected directories)
    local project_template_dirs=(".claude" "examples" "docs" "PRPs")
    for dir in "${project_template_dirs[@]}"; do
        if [[ -d "$PROJECT_DIR/$dir" ]]; then
            while IFS= read -r -d '' project_file; do
                local rel_path="${project_file#$PROJECT_DIR/}"
                local template_file="$TEMPLATE_DIR/$rel_path"
                
                if [[ ! -f "$template_file" ]]; then
                    extra_in_project+=("$rel_path")
                    log "DEBUG" "Extra file in project: $rel_path"
                fi
            done < <(find "$PROJECT_DIR/$dir" -type f ! -name "*.backup-*" -print0 2>/dev/null)
        fi
    done
    
    # Display results
    if [[ ${#changed_files[@]} -gt 0 ]]; then
        echo -e "${YELLOW}Modified files (${#changed_files[@]}):${NC}"
        printf '  - %s\n' "${changed_files[@]}"
        echo ""
    fi
    
    if [[ ${#new_files[@]} -gt 0 ]]; then
        echo -e "${GREEN}New files available (${#new_files[@]}):${NC}"
        printf '  + %s\n' "${new_files[@]}"
        echo ""
    fi
    
    if [[ ${#extra_in_project[@]} -gt 0 ]]; then
        echo -e "${BLUE}Extra files in project (${#extra_in_project[@]}):${NC}"
        printf '  ! %s\n' "${extra_in_project[@]}"
        echo ""
    fi
    
    # Summary
    echo -e "${CYAN}Summary:${NC}"
    echo "  • Identical files: ${#identical_files[@]}"
    echo "  • Modified files: ${#changed_files[@]}"
    echo "  • New files: ${#new_files[@]}"
    echo "  • Extra files: ${#extra_in_project[@]}"
    
    local total_differences=$((${#changed_files[@]} + ${#new_files[@]}))
    if [[ $total_differences -eq 0 ]]; then
        echo -e "${GREEN}✅ Templates and project are synchronized${NC}"
        log "INFO" "Project is fully synchronized with templates"
        return 0
    else
        echo -e "${YELLOW}⚠️  $total_differences differences found${NC}"
        log "INFO" "Found $total_differences differences between templates and project"
        return 1
    fi
}

update_project() {
    log "INFO" "Starting template update for project: $PROJECT_DIR"
    
    echo -e "${BLUE}🔄 Updating Project Templates${NC}"
    echo -e "${CYAN}Project: $PROJECT_DIR${NC}"
    echo ""
    
    # Create comprehensive backup
    log "INFO" "Creating backup before update..."
    local backup_dir
    backup_dir=$(create_backup "$PROJECT_DIR/.claude" ".claude" "$PROJECT_DIR")
    
    # Backup additional important files
    local important_files=("CLAUDE.md" "INITIAL.md" "README.md")
    for file in "${important_files[@]}"; do
        if [[ -f "$PROJECT_DIR/$file" ]]; then
            safe_copy_recursive "$PROJECT_DIR/$file" "$backup_dir/$file"
            log "DEBUG" "Backed up: $file"
        fi
    done
    
    echo -e "${GREEN}✓${NC} Backup created: $backup_dir"
    
    # Show what will be updated
    log "INFO" "Analyzing files to be updated..."
    local files_to_update=()
    local update_categories=()
    
    # Check Claude configuration
    if [[ -d "$TEMPLATE_DIR/.claude" ]]; then
        while IFS= read -r -d '' template_file; do
            local rel_path="${template_file#$TEMPLATE_DIR/}"
            local project_file="$PROJECT_DIR/$rel_path"
            
            if [[ ! -f "$project_file" ]] || ! diff -q "$template_file" "$project_file" 2>>"$LOG_FILE"; then
                files_to_update+=("$rel_path")
            fi
        done < <(find "$TEMPLATE_DIR/.claude" -type f -print0 2>/dev/null)
        
        if [[ ${#files_to_update[@]} -gt 0 ]]; then
            update_categories+=("Claude configuration")
        fi
    fi
    
    # Show update summary
    if [[ ${#files_to_update[@]} -eq 0 ]]; then
        log "INFO" "No template updates available"
        echo -e "${GREEN}✅ Project is already up to date${NC}"
        return 0
    fi
    
    echo -e "${YELLOW}Files to be updated (${#files_to_update[@]}):${NC}"
    printf '  - %s\n' "${files_to_update[@]:0:10}"  # Show first 10 files
    if [[ ${#files_to_update[@]} -gt 10 ]]; then
        echo "  ... and $((${#files_to_update[@]} - 10)) more files"
    fi
    echo ""
    
    # Confirmation with additional safety checks
    echo -e "${YELLOW}⚠️  Warning: This operation will overwrite template files in your project.${NC}"
    echo -e "${CYAN}A backup has been created at: $backup_dir${NC}"
    
    # Auto-proceed in CI environment
    if [[ -n "${CI:-}" || -n "${GITHUB_ACTIONS:-}" ]]; then
        log "INFO" "CI environment detected: Automatically proceeding with update"
    else
        echo -e "${BLUE}Do you want to continue with the update? (y/N)${NC}"
        read -p "" -n 1 -r
        echo
        
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log "INFO" "Update cancelled by user"
            safe_exit $EXIT_USER_CANCELLED "Update cancelled by user"
        fi
    fi
    
    # Perform selective updates with error handling
    log "INFO" "Performing template updates..."
    local update_errors=0
    local update_success=0
    
    # Update Claude configuration files
    if [[ -d "$TEMPLATE_DIR/.claude" ]]; then
        log "DEBUG" "Updating Claude configuration..."
        
        # Ensure target directory exists
        mkdir -p "$PROJECT_DIR/.claude" || {
            log "ERROR" "Failed to create .claude directory"
            ((update_errors++))
        }
        
        # Copy configuration files
        while IFS= read -r -d '' template_file; do
            local rel_path="${template_file#$TEMPLATE_DIR/}"
            local project_file="$PROJECT_DIR/$rel_path"
            local dest_dir="$(dirname "$project_file")"
            
            # Create destination directory if needed
            if [[ ! -d "$dest_dir" ]]; then
                mkdir -p "$dest_dir" || {
                    log "ERROR" "Failed to create directory: $dest_dir"
                    ((update_errors++))
                    continue
                }
            fi
            
            # Copy file
            if safe_copy_recursive "$template_file" "$project_file" 2>>"$LOG_FILE"; then
                log "DEBUG" "Updated: $rel_path"
                ((update_success++))
            else
                log "ERROR" "Failed to update: $rel_path"
                ((update_errors++))
            fi
        done < <(find "$TEMPLATE_DIR/.claude" -type f -print0 2>/dev/null)
        
        if [[ $update_errors -eq 0 ]]; then
            echo -e "${GREEN}✓${NC} Claude configuration updated"
        else
            echo -e "${YELLOW}⚠️ ${NC} Claude configuration updated with $update_errors errors"
        fi
    fi
    
    # Report results
    echo ""
    if [[ $update_errors -eq 0 ]]; then
        echo -e "${GREEN}✅ Template update completed successfully!${NC}"
        log "INFO" "Template update completed successfully ($update_success files updated)"
    else
        echo -e "${YELLOW}⚠️  Template update completed with $update_errors errors${NC}"
        log "WARN" "Template update completed with errors (success: $update_success, errors: $update_errors)"
    fi
    
    echo -e "${CYAN}Backup location: $backup_dir${NC}"
    echo -e "${CYAN}Log file: $LOG_FILE${NC}"
    
    # Offer rollback if there were errors
    if [[ $update_errors -gt 0 ]] && [[ -z "${CI:-}" ]] && [[ -z "${GITHUB_ACTIONS:-}" ]]; then
        echo ""
        echo -e "${YELLOW}Would you like to rollback the changes? (y/N)${NC}"
        read -p "" -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            perform_rollback "$backup_dir"
        fi
    fi
}

perform_rollback() {
    local backup_dir="$1"
    
    log "INFO" "Performing rollback from: $backup_dir"
    echo -e "${BLUE}🔄 Rolling back changes...${NC}"
    
    if [[ ! -d "$backup_dir" ]]; then
        safe_exit $EXIT_BACKUP_ERROR "Backup directory not found: $backup_dir"
    fi
    
    # Restore files from backup
    while IFS= read -r -d '' backup_file; do
        local rel_path="${backup_file#$backup_dir/}"
        local project_file="$PROJECT_DIR/$rel_path"
        
        if safe_copy_recursive "$backup_file" "$project_file" 2>>"$LOG_FILE"; then
            log "DEBUG" "Restored: $rel_path"
        else
            log "ERROR" "Failed to restore: $rel_path"
        fi
    done < <(find "$backup_dir" -type f -print0 2>/dev/null)
    
    echo -e "${GREEN}✓${NC} Rollback completed"
    log "INFO" "Rollback completed successfully"
}

# Main execution logic with comprehensive error handling
main() {
    log "INFO" "Starting template synchronization tool"
    log "INFO" "Command: $COMMAND, Project: ${PROJECT_DIR:-"N/A"}"
    
    # Validate template directory exists
    if [[ ! -d "$TEMPLATE_DIR" ]]; then
        safe_exit $EXIT_TEMPLATE_ERROR "Template directory not found: $TEMPLATE_DIR"
    fi
    
    # Validate command
    validate_command "$COMMAND"
    
    # Normalize and validate project directory for relevant commands
    if [[ "$COMMAND" =~ ^(update|diff)$ ]]; then
        # Convert to absolute path
        if [[ "$PROJECT_DIR" == "." ]]; then
            PROJECT_DIR="$(pwd)"
        elif [[ "$PROJECT_DIR" != /* ]]; then
            PROJECT_DIR="$(pwd)/$PROJECT_DIR"
        fi
        
        # Remove trailing slashes
        PROJECT_DIR="${PROJECT_DIR%/}"
        
        validate_project_directory "$PROJECT_DIR"
    fi
    
    case $COMMAND in
        validate)
            log "INFO" "Executing template validation"
            if validate_templates; then
                safe_exit $EXIT_SUCCESS "Template validation completed successfully"
            else
                safe_exit $EXIT_TEMPLATE_ERROR "Template validation failed"
            fi
            ;;
        list)
            log "INFO" "Executing template listing"
            list_templates
            safe_exit $EXIT_SUCCESS
            ;;
        diff)
            log "INFO" "Executing template diff analysis"
            if diff_templates; then
                safe_exit $EXIT_SUCCESS "Template comparison completed - no differences found"
            else
                safe_exit $EXIT_SUCCESS "Template comparison completed - differences found"
            fi
            ;;
        update)
            log "INFO" "Executing template update"
            update_project
            safe_exit $EXIT_SUCCESS "Template update process completed"
            ;;
        help)
            show_help
            safe_exit $EXIT_SUCCESS
            ;;
        *)
            log "ERROR" "Unknown command: $COMMAND"
            show_help
            safe_exit $EXIT_INVALID_COMMAND "Invalid command: $COMMAND"
            ;;
    esac
}

# Execute main function with error handling
if ! main "$@"; then
    safe_exit $EXIT_FILE_OPERATION_ERROR "Operation failed - check log file: $LOG_FILE"
fi