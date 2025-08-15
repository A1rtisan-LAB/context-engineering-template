#!/bin/bash
#
# File: setup-claude-code.sh
# Description: Context Engineering project structure initialization script for Claude Code
#              Creates a new project with Claude Code configuration, templates, and best practices
# Version: 2.0
# Author: Context Engineering Template
# Requirements: bash 4.0+, git, standard Unix tools (cp, mkdir, find, sed)
# Optional: jq (for JSON validation)
#
# Usage: ./setup-claude-code.sh [project-name] [project-type] [project-path]
#
# Arguments:
#   project-name  - Name of the project to create (default: my-project)
#                   Must be 1-50 characters, alphanumeric with hyphens/underscores
#   project-type  - Type of project template (default: general)
#                   Options: general, api, frontend, fullstack
#   project-path  - Where to create the project (default: current directory)
#                   Can be absolute or relative path
#
# Examples:
#   ./setup-claude-code.sh                          # Creates 'my-project' in current directory
#   ./setup-claude-code.sh my-api api               # Creates 'my-api' API project in current directory
#   ./setup-claude-code.sh frontend-app frontend /tmp  # Creates 'frontend-app' in /tmp
#
# Exit Codes:
#   0 - Success
#   1 - Invalid input parameters
#   2 - Missing dependencies
#   3 - Template errors
#   4 - File operation errors
#   5 - Permission errors
#   6 - User cancelled operation

# Bash strict mode for better error handling
set -e          # Exit immediately on error
set -u          # Exit on undefined variables  
set -o pipefail # Exit on pipe failures

#############################################################################
# CONFIGURATION AND CONSTANTS
#############################################################################

# Color definitions for output formatting
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly RED='\033[0;31m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

# Logging configuration
readonly LOG_LEVEL=${LOG_LEVEL:-"INFO"}  # DEBUG, INFO, WARN, ERROR
readonly LOG_FILE="/tmp/setup-claude-code-$(date +%Y%m%d-%H%M%S).log"

# Exit codes for different error conditions
readonly EXIT_SUCCESS=0
readonly EXIT_INVALID_INPUT=1
readonly EXIT_MISSING_DEPENDENCY=2
readonly EXIT_TEMPLATE_ERROR=3
readonly EXIT_FILE_OPERATION_ERROR=4
readonly EXIT_PERMISSION_ERROR=5
readonly EXIT_USER_CANCELLED=6

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
#   log "INFO" "Starting process"
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
#   safe_exit 0 "Operation completed successfully"
#   safe_exit $EXIT_FILE_OPERATION_ERROR "Failed to create directory"
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
#              files and incomplete operations
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
    # Remove any temporary files or incomplete operations
    if [[ -n "${TEMP_BACKUP_DIR:-}" ]] && [[ -d "$TEMP_BACKUP_DIR" ]]; then
        rm -rf "$TEMP_BACKUP_DIR" 2>/dev/null || true
    fi
}

# Trap for cleanup on exit
trap cleanup_on_exit EXIT

#############################################################################
# INPUT VALIDATION FUNCTIONS
#############################################################################

#############################################################################
# Function: validate_project_name
# Description: Validates project name according to naming rules and constraints
# Arguments:
#   $1 - Project name to validate
# Global Variables:
#   READS: EXIT_INVALID_INPUT
# Returns:
#   0 - Validation passed
#   Exits on validation failure
# Side Effects:
#   - Logs validation results
#   - May terminate script if validation fails
# Validation Rules:
#   - Length: 1-50 characters
#   - Characters: alphanumeric, hyphens, underscores only
#   - Must start with alphanumeric character
# Example:
#   validate_project_name "my-project-123"  # Valid
#   validate_project_name "-invalid"        # Invalid (starts with hyphen)
#############################################################################
validate_project_name() {
    local name="$1"
    
    # Check length (1-50 characters)
    if [[ ${#name} -lt 1 || ${#name} -gt 50 ]]; then
        safe_exit $EXIT_INVALID_INPUT "Project name must be between 1 and 50 characters"
    fi
    
    # Check for valid characters (alphanumeric, hyphens, underscores)
    if [[ ! $name =~ ^[a-zA-Z0-9_-]+$ ]]; then
        safe_exit $EXIT_INVALID_INPUT "Project name can only contain letters, numbers, hyphens, and underscores"
    fi
    
    # Check if it starts with alphanumeric
    if [[ ! $name =~ ^[a-zA-Z0-9] ]]; then
        safe_exit $EXIT_INVALID_INPUT "Project name must start with a letter or number"
    fi
    
    log "DEBUG" "Project name validation passed: $name"
}

#############################################################################
# Function: validate_project_type
# Description: Validates that the project type is one of the supported types
# Arguments:
#   $1 - Project type to validate
# Global Variables:
#   READS: EXIT_INVALID_INPUT
# Returns:
#   0 - Validation passed
#   Exits on validation failure
# Side Effects:
#   - Logs validation results
#   - May terminate script if validation fails
# Valid Types:
#   - general: Basic project template
#   - api: API/backend project with routes, controllers, models
#   - frontend: Frontend project with components, pages, styles
#   - fullstack: Combined API and frontend structure
# Example:
#   validate_project_type "api"      # Valid
#   validate_project_type "invalid"  # Invalid
#############################################################################
validate_project_type() {
    local type="$1"
    local valid_types=("general" "api" "frontend" "fullstack")
    
    for valid_type in "${valid_types[@]}"; do
        if [[ "$type" == "$valid_type" ]]; then
            log "DEBUG" "Project type validation passed: $type"
            return 0
        fi
    done
    
    safe_exit $EXIT_INVALID_INPUT "Invalid project type: $type. Valid types: ${valid_types[*]}"
}

#############################################################################
# Function: validate_and_normalize_path
# Description: Validates and normalizes the project path, ensuring parent
#              directory exists and is writable
# Arguments:
#   $1 - Input path (relative or absolute)
# Global Variables:
#   READS: EXIT_FILE_OPERATION_ERROR, EXIT_PERMISSION_ERROR
# Returns:
#   Outputs normalized absolute path to stdout
# Side Effects:
#   - May terminate script if validation fails
#   - Logs validation results
# Path Handling:
#   - "." becomes current working directory
#   - Relative paths converted to absolute
#   - Trailing slashes removed
#   - Parent directory existence and permissions checked
# Example:
#   normalized_path=$(validate_and_normalize_path "./my-project")
#   normalized_path=$(validate_and_normalize_path "/tmp/projects")
#############################################################################
validate_and_normalize_path() {
    local input_path="$1"
    local normalized_path
    
    # Handle current directory
    if [[ "$input_path" == "." ]]; then
        normalized_path="$(pwd)"
    elif [[ "$input_path" == /* ]]; then
        # Absolute path
        normalized_path="$input_path"
    else
        # Relative path
        normalized_path="$(pwd)/$input_path"
    fi
    
    # Remove trailing slashes
    normalized_path="${normalized_path%/}"
    
    # Check if parent directory exists and is writable
    local parent_dir="$(dirname "$normalized_path")"
    if [[ ! -d "$parent_dir" ]]; then
        safe_exit $EXIT_FILE_OPERATION_ERROR "Parent directory does not exist: $parent_dir"
    fi
    
    if [[ ! -w "$parent_dir" ]]; then
        safe_exit $EXIT_PERMISSION_ERROR "No write permission to parent directory: $parent_dir"
    fi
    
    log "DEBUG" "Path validation passed: $normalized_path"
    echo "$normalized_path"
}

#############################################################################
# PARAMETER PROCESSING AND CONFIGURATION
#############################################################################

# Parse command line arguments with defaults
readonly PROJECT_NAME=${1:-"my-project"}
readonly PROJECT_TYPE=${2:-"general"}
readonly PROJECT_PATH=${3:-"."}

# Determine script and template directories
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TEMPLATE_DIR="$SCRIPT_DIR/templates"

# Validate all input parameters
validate_project_name "$PROJECT_NAME"
validate_project_type "$PROJECT_TYPE"
readonly NORMALIZED_PATH=$(validate_and_normalize_path "$PROJECT_PATH")

# Calculate the full project path where files will be created
readonly FULL_PROJECT_PATH="$NORMALIZED_PATH/$PROJECT_NAME"


# Logo output
echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════╗"
echo "  ║            C O N T E X T              ║"
echo "  ║       Engineering Template            ║"
echo "  ╚═══════════════════════════════════════╝"
echo "                                        "
echo "     Engineering Template Setup         "
echo -e "${NC}"

echo -e "${BLUE}🚀 Creating Context Engineering project for Claude Code${NC}"
echo -e "   Project name: ${GREEN}$PROJECT_NAME${NC}"
echo -e "   Project type: ${GREEN}$PROJECT_TYPE${NC}"
echo -e "   Creation path: ${GREEN}$FULL_PROJECT_PATH${NC}"
echo ""

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
# Function: safe_remove_recursive
# Description: Safely removes files or directories with multiple safety checks
#              to prevent accidental deletion of system directories
# Arguments:
#   $1 - Path to remove
#   $2 - Confirmation token (must be "CONFIRMED")
# Global Variables:
#   READS: EXIT_INVALID_INPUT, EXIT_FILE_OPERATION_ERROR, LOG_FILE
# Returns:
#   0 - Removal successful or file doesn't exist
#   Exits on error
# Side Effects:
#   - Removes specified files/directories
#   - Logs all operations
#   - May terminate script on failure
# Safety Features:
#   - Requires confirmation token
#   - Blacklists system directories
#   - Comprehensive error logging
# Example:
#   safe_remove_recursive "/path/to/remove" "CONFIRMED"
#############################################################################
safe_remove_recursive() {
    local target="$1"
    local confirm_token="$2"  # Safety token to prevent accidents
    
    if [[ -z "$confirm_token" ]] || [[ "$confirm_token" != "CONFIRMED" ]]; then
        safe_exit $EXIT_INVALID_INPUT "Safe remove requires confirmation token"
    fi
    
    if [[ ! -e "$target" ]]; then
        log "DEBUG" "Target does not exist, skipping removal: $target"
        return 0
    fi
    
    # Extra safety checks
    case "$target" in
        "/" | "/usr" | "/usr/local" | "/etc" | "/var" | "/home" | "$HOME")
            safe_exit $EXIT_INVALID_INPUT "Refusing to remove system directory: $target"
            ;;
    esac
    
    log "DEBUG" "Safely removing: $target"
    if ! rm -rf "$target" 2>>"$LOG_FILE"; then
        safe_exit $EXIT_FILE_OPERATION_ERROR "Failed to remove $target"
    fi
}

#############################################################################
# Function: create_backup
# Description: Creates a timestamped backup of a file or directory
# Arguments:
#   $1 - Source path to backup
#   $2 - Name for the backup
# Global Variables:
#   READS: EXIT_FILE_OPERATION_ERROR
# Returns:
#   Outputs backup directory path to stdout
# Side Effects:
#   - Creates backup directory with timestamp
#   - Copies source to backup location
#   - Logs backup creation
# Backup Structure:
#   - Creates .backup-YYYYMMDD-HHMMSS directory
#   - Preserves original structure and permissions
# Example:
#   backup_dir=$(create_backup "/path/to/source" "source-backup")
#############################################################################
create_backup() {
    local source="$1"
    local backup_name="$2"
    
    if [[ ! -e "$source" ]]; then
        log "DEBUG" "Source does not exist, skipping backup: $source"
        return 0
    fi
    
    local backup_dir="$(dirname "$source")/.backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir" || safe_exit $EXIT_FILE_OPERATION_ERROR "Failed to create backup directory: $backup_dir"
    
    log "INFO" "Creating backup: $backup_dir/$backup_name"
    safe_copy_recursive "$source" "$backup_dir/$backup_name"
    echo "$backup_dir"  # Return backup directory path
}

#############################################################################
# DEPENDENCY AND VALIDATION FUNCTIONS
#############################################################################

#############################################################################
# Function: check_dependencies
# Description: Validates that all required system dependencies are available
#              and warns about missing optional dependencies
# Arguments:
#   None
# Global Variables:
#   READS: EXIT_MISSING_DEPENDENCY, BASH_VERSION
# Returns:
#   0 - All required dependencies available
#   Exits if required dependencies missing
# Side Effects:
#   - Logs dependency check results
#   - May terminate script if required deps missing
# Dependencies Checked:
#   Required: git, mkdir, cp, rm, find, sed
#   Optional: jq (for JSON validation)
#   Bash: version 4.0+ recommended
# Example:
#   check_dependencies
#############################################################################
check_dependencies() {
    log "INFO" "Checking dependencies..."
    local missing_deps=()
    local optional_missing=()
    
    # Required dependencies
    local required_deps=("git" "mkdir" "cp" "rm" "find" "sed")
    for dep in "${required_deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    # Optional dependencies
    if ! command -v jq &> /dev/null; then
        optional_missing+=("jq")
        log "WARN" "jq is not installed. JSON validation will be skipped."
    fi
    
    # Check for bash version (need 4.0+ for associative arrays)
    if [[ ${BASH_VERSION%%.*} -lt 4 ]]; then
        log "WARN" "Bash version ${BASH_VERSION} detected. Some features may not work optimally."
    fi
    
    if [[ ${#missing_deps[@]} -ne 0 ]]; then
        log "ERROR" "Missing required dependencies: ${missing_deps[*]}"
        log "ERROR" "Please install the missing dependencies and try again."
        safe_exit $EXIT_MISSING_DEPENDENCY
    fi
    
    log "INFO" "Dependency check completed successfully"
}

#############################################################################
# Function: validate_template_directory_access
# Description: Validates that template directory exists and is accessible
# Arguments:
#   None
# Global Variables:
#   READS: TEMPLATE_DIR, EXIT_TEMPLATE_ERROR, EXIT_PERMISSION_ERROR
# Returns:
#   0 - Directory is accessible
#   Exits on error
# Side Effects:
#   - May terminate script if directory inaccessible
# Example:
#   validate_template_directory_access
#############################################################################
validate_template_directory_access() {
    if [[ ! -d "$TEMPLATE_DIR" ]]; then
        safe_exit $EXIT_TEMPLATE_ERROR "Template directory not found: $TEMPLATE_DIR"
    fi
    
    if [[ ! -r "$TEMPLATE_DIR" ]]; then
        safe_exit $EXIT_PERMISSION_ERROR "No read permission for template directory: $TEMPLATE_DIR"
    fi
    
    log "DEBUG" "Template directory access validation passed: $TEMPLATE_DIR"
}

#############################################################################
# Function: validate_required_template_files
# Description: Validates that all required template files exist and are readable
# Arguments:
#   None
# Global Variables:
#   READS: TEMPLATE_DIR, EXIT_PERMISSION_ERROR
# Returns:
#   Returns count of missing required files
# Side Effects:
#   - Logs validation results for each file
# Required Files:
#   - CLAUDE.md: Main AI assistant configuration
#   - INITIAL.md: Project starting instructions
#   - README.template.md: Project README template
# Example:
#   missing_count=$(validate_required_template_files)
#############################################################################
validate_required_template_files() {
    local required_files=(
        "CLAUDE.md"
        "INITIAL.md"
        "README.template.md"
    )
    
    local missing_required=()
    
    # Validate required files
    for file in "${required_files[@]}"; do
        local full_path="$TEMPLATE_DIR/$file"
        if [[ ! -f "$full_path" ]]; then
            missing_required+=("$file")
        elif [[ ! -r "$full_path" ]]; then
            safe_exit $EXIT_PERMISSION_ERROR "No read permission for required file: $full_path"
        elif [[ ! -s "$full_path" ]]; then
            log "WARN" "Required file is empty: $file"
        else
            log "DEBUG" "Required file validation passed: $file"
        fi
    done
    
    # Report missing required files
    if [[ ${#missing_required[@]} -ne 0 ]]; then
        log "ERROR" "Missing required template files:"
        printf '  - %s\n' "${missing_required[@]}" | tee -a "$LOG_FILE"
        safe_exit $EXIT_TEMPLATE_ERROR
    fi
    
    return 0
}

#############################################################################
# Function: validate_optional_template_files
# Description: Validates optional template files and reports missing ones
# Arguments:
#   None
# Global Variables:
#   READS: TEMPLATE_DIR
# Returns:
#   Returns count of missing optional files
# Side Effects:
#   - Logs warnings for missing optional files
# Optional Files:
#   - .claude/settings.json: Claude Code settings
#   - .claude/commands/orchestrate.md: Main orchestration command
# Example:
#   missing_optional=$(validate_optional_template_files)
#############################################################################
validate_optional_template_files() {
    local optional_files=(
        ".claude/settings.json"
        ".claude/commands/orchestrate.md"
    )
    
    local missing_optional=()
    
    # Validate optional files
    for file in "${optional_files[@]}"; do
        local full_path="$TEMPLATE_DIR/$file"
        if [[ ! -f "$full_path" ]]; then
            missing_optional+=("$file")
        elif [[ ! -r "$full_path" ]]; then
            log "WARN" "No read permission for optional file: $full_path"
        else
            log "DEBUG" "Optional file validation passed: $file"
        fi
    done
    
    # Report missing optional files
    if [[ ${#missing_optional[@]} -ne 0 ]]; then
        log "WARN" "Missing optional template files:"
        printf '  - %s\n' "${missing_optional[@]}" | tee -a "$LOG_FILE"
    fi
    
    echo "${#missing_optional[@]}"
}

#############################################################################
# Function: validate_json_template_files
# Description: Validates JSON syntax in all template JSON files using jq
# Arguments:
#   None
# Global Variables:
#   READS: TEMPLATE_DIR, EXIT_TEMPLATE_ERROR, LOG_FILE
# Returns:
#   0 - All JSON files valid or jq not available
#   Exits if JSON syntax errors found
# Side Effects:
#   - May terminate script if JSON syntax errors found
#   - Logs validation results
# Dependencies:
#   - jq (optional, validation skipped if not available)
# Example:
#   validate_json_template_files
#############################################################################
validate_json_template_files() {
    # JSON syntax validation (if jq is available)
    if command -v jq &> /dev/null; then
        while IFS= read -r -d '' json_file; do
            if ! jq empty "$json_file" 2>>"$LOG_FILE"; then
                safe_exit $EXIT_TEMPLATE_ERROR "JSON syntax error in: ${json_file#$TEMPLATE_DIR/}"
            fi
            log "DEBUG" "JSON validation passed: ${json_file#$TEMPLATE_DIR/}"
        done < <(find "$TEMPLATE_DIR" -name "*.json" -type f -print0 2>/dev/null)
    else
        log "WARN" "jq is not installed, skipping JSON validation"
    fi
}

#############################################################################
# Function: validate_template_file_encoding
# Description: Validates template files for proper encoding and detects binary files
# Arguments:
#   None
# Global Variables:
#   READS: TEMPLATE_DIR
# Returns:
#   0 - Always succeeds
# Side Effects:
#   - Logs warnings for binary files in templates
# Example:
#   validate_template_file_encoding
#############################################################################
validate_template_file_encoding() {
    # Validate template file encoding (check for binary files)
    while IFS= read -r -d '' template_file; do
        if file "$template_file" | grep -q "binary"; then
            log "WARN" "Binary file detected in templates: ${template_file#$TEMPLATE_DIR/}"
        fi
    done < <(find "$TEMPLATE_DIR" -type f -print0 2>/dev/null)
}

#############################################################################
# Function: validate_templates
# Description: Main template validation function that coordinates all validation checks
# Arguments:
#   None
# Global Variables:
#   READS: Various validation functions
# Returns:
#   0 - All validations passed
#   Exits on critical validation failures
# Side Effects:
#   - Calls all validation helper functions
#   - Logs comprehensive validation summary
# Example:
#   validate_templates
#############################################################################
validate_templates() {
    log "INFO" "Validating templates..."
    
    # Step 1: Check basic template directory access
    validate_template_directory_access
    
    # Step 2: Validate required template files
    validate_required_template_files
    
    # Step 3: Validate optional template files (warnings only)
    local missing_optional_count
    missing_optional_count=$(validate_optional_template_files)
    
    # Step 4: Validate JSON file syntax
    validate_json_template_files
    
    # Step 5: Validate file encoding and detect binary files
    validate_template_file_encoding
    
    log "INFO" "Template validation completed successfully"
    if [[ $missing_optional_count -gt 0 ]]; then
        log "INFO" "Note: $missing_optional_count optional template files are missing (warnings logged above)"
    fi
}

#############################################################################
# PROJECT STRUCTURE CREATION FUNCTIONS
#############################################################################

#############################################################################
# Function: handle_existing_project_directory
# Description: Handles the case where project directory already exists,
#              including backup creation and user confirmation
# Arguments:
#   None
# Global Variables:
#   READS: FULL_PROJECT_PATH, CI, GITHUB_ACTIONS
#   MODIFIES: TEMP_BACKUP_DIR
# Returns:
#   0 - User confirmed or directory empty
#   Exits if user cancels
# Side Effects:
#   - Creates backup of existing directory
#   - Prompts user for confirmation (unless in CI)
#   - May terminate script if user cancels
# Example:
#   handle_existing_project_directory
#############################################################################
handle_existing_project_directory() {
    # Check if project directory already exists
    if [[ ! -d "$FULL_PROJECT_PATH" ]]; then
        return 0  # Directory doesn't exist, nothing to handle
    fi
    
    log "WARN" "Directory already exists: $FULL_PROJECT_PATH"
    
    # Create backup of existing directory if it's not empty
    if [[ -n "$(ls -A "$FULL_PROJECT_PATH" 2>/dev/null)" ]]; then
        TEMP_BACKUP_DIR=$(create_backup "$FULL_PROJECT_PATH" "$(basename "$FULL_PROJECT_PATH")")
        log "INFO" "Existing directory backed up to: $TEMP_BACKUP_DIR"
    fi
    
    # Auto-proceed in CI environment, otherwise ask for confirmation
    if [[ -n "${CI:-}" || -n "${GITHUB_ACTIONS:-}" ]]; then
        log "INFO" "CI environment detected: Automatically proceeding with directory creation"
    else
        echo -e "${YELLOW}⚠️  Warning: Directory '$FULL_PROJECT_PATH' already exists.${NC}"
        if [[ -n "${TEMP_BACKUP_DIR:-}" ]]; then
            echo -e "${CYAN}A backup has been created at: $TEMP_BACKUP_DIR${NC}"
        fi
        read -p "Do you want to continue? Existing files may be overwritten. (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log "INFO" "Operation cancelled by user"
            safe_exit $EXIT_USER_CANCELLED "Operation cancelled by user"
        fi
    fi
}

#############################################################################
# Function: create_base_project_directory
# Description: Creates the base project directory and its parent if needed
# Arguments:
#   None
# Global Variables:
#   READS: FULL_PROJECT_PATH, EXIT_FILE_OPERATION_ERROR, LOG_FILE
# Returns:
#   0 - Directory created successfully
#   Exits on error
# Side Effects:
#   - Creates parent directories as needed
#   - Creates main project directory
#   - May terminate script on failure
# Example:
#   create_base_project_directory
#############################################################################
create_base_project_directory() {
    # Create parent directory with proper error checking
    local parent_dir="$(dirname "$FULL_PROJECT_PATH")"
    if [[ ! -d "$parent_dir" ]]; then
        log "DEBUG" "Creating parent directory: $parent_dir"
        if ! mkdir -p "$parent_dir" 2>>"$LOG_FILE"; then
            safe_exit $EXIT_FILE_OPERATION_ERROR "Failed to create parent directory: $parent_dir"
        fi
    fi
    
    # Create project directory
    if ! mkdir -p "$FULL_PROJECT_PATH" 2>>"$LOG_FILE"; then
        safe_exit $EXIT_FILE_OPERATION_ERROR "Failed to create project directory: $FULL_PROJECT_PATH"
    fi
    
    log "DEBUG" "Base project directory created: $FULL_PROJECT_PATH"
}

#############################################################################
# Function: copy_template_files
# Description: Copies regular template files to the project directory
# Arguments:
#   None
# Global Variables:
#   READS: TEMPLATE_DIR, FULL_PROJECT_PATH, EXIT_FILE_OPERATION_ERROR
# Returns:
#   0 - Files copied successfully
#   Exits on error
# Side Effects:
#   - Copies all template files (excluding .git)
#   - Creates destination directories as needed
#   - Logs copy operations
# Example:
#   copy_template_files
#############################################################################
copy_template_files() {
    log "DEBUG" "Copying template files..."
    
    # Copy regular files
    while IFS= read -r -d '' template_file; do
        local rel_path="${template_file#$TEMPLATE_DIR/}"
        local dest_file="$FULL_PROJECT_PATH/$rel_path"
        
        # Create destination directory if needed
        local dest_dir="$(dirname "$dest_file")"
        if [[ ! -d "$dest_dir" ]]; then
            mkdir -p "$dest_dir" || safe_exit $EXIT_FILE_OPERATION_ERROR "Failed to create directory: $dest_dir"
        fi
        
        safe_copy_recursive "$template_file" "$dest_file"
    done < <(find "$TEMPLATE_DIR" -type f ! -path "*/.git/*" -print0 2>/dev/null)
}

#############################################################################
# Function: copy_hidden_directories
# Description: Copies hidden directories (like .claude) from templates
# Arguments:
#   None
# Global Variables:
#   READS: TEMPLATE_DIR, FULL_PROJECT_PATH
# Returns:
#   0 - Directories copied successfully
# Side Effects:
#   - Copies hidden directories from templates
#   - Excludes .git directories
# Example:
#   copy_hidden_directories
#############################################################################
copy_hidden_directories() {
    log "DEBUG" "Copying hidden directories..."
    
    # Copy hidden directories (like .claude)
    while IFS= read -r -d '' hidden_dir; do
        local dir_name="$(basename "$hidden_dir")"
        safe_copy_recursive "$hidden_dir" "$FULL_PROJECT_PATH/$dir_name"
    done < <(find "$TEMPLATE_DIR" -maxdepth 1 -type d -name ".*" ! -name "." ! -name ".." ! -name ".git" -print0 2>/dev/null)
    
    # Remove any .git directory that might have been copied
    if [[ -d "$FULL_PROJECT_PATH/.git" ]]; then
        safe_remove_recursive "$FULL_PROJECT_PATH/.git" "CONFIRMED"
        log "DEBUG" "Removed .git directory from project"
    fi
}

#############################################################################
# Function: create_standard_directories
# Description: Creates standard project directories (src, tests, etc.)
# Arguments:
#   None
# Global Variables:
#   READS: LOG_FILE
# Returns:
#   0 - Always succeeds (logs warnings for failures)
# Side Effects:
#   - Creates standard project directory structure
#   - Logs creation results
# Standard Directories:
#   - src: Source code
#   - tests: Test files
#   - PRPs: Product Requirements Prompts
#   - examples: Code examples and patterns
# Example:
#   create_standard_directories
#############################################################################
create_standard_directories() {
    log "DEBUG" "Creating standard project directories..."
    
    local standard_dirs=(
        "src"
        "tests"
        "PRPs/ai_docs"
        "PRPs/completed"
        "examples/architecture"
        "examples/api"
        "examples/database"
        "examples/tests"
    )
    
    for dir in "${standard_dirs[@]}"; do
        if ! mkdir -p "$dir" 2>>"$LOG_FILE"; then
            log "WARN" "Failed to create directory: $dir"
        else
            log "DEBUG" "Created directory: $dir"
        fi
    done
}

#############################################################################
# Function: create_gitkeep_files
# Description: Creates .gitkeep files in empty directories to preserve them in git
# Arguments:
#   None
# Global Variables:
#   READS: LOG_FILE
# Returns:
#   0 - Always succeeds (logs warnings for failures)
# Side Effects:
#   - Creates .gitkeep files in specified directories
#   - Logs creation results
# Example:
#   create_gitkeep_files
#############################################################################
create_gitkeep_files() {
    log "DEBUG" "Creating .gitkeep files..."
    
    local gitkeep_dirs=(
        "src"
        "tests"
        "PRPs/ai_docs"
        "PRPs/completed"
        "examples/architecture"
        "examples/api"
        "examples/database"
        "examples/tests"
    )
    
    for dir in "${gitkeep_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            touch "$dir/.gitkeep" 2>>"$LOG_FILE" || log "WARN" "Failed to create .gitkeep in: $dir"
        fi
    done
}

#############################################################################
# Function: create_project_structure
# Description: Main function that coordinates the creation of complete project structure
# Arguments:
#   None
# Global Variables:
#   READS: FULL_PROJECT_PATH, EXIT_FILE_OPERATION_ERROR
# Returns:
#   0 - Project structure created successfully
#   Exits on error
# Side Effects:
#   - Creates complete project directory structure
#   - Copies all template files and directories
#   - Changes working directory to project
# Example:
#   create_project_structure
#############################################################################
create_project_structure() {
    log "INFO" "Creating project structure at: $FULL_PROJECT_PATH"
    
    # Step 1: Handle existing directory (backup and confirmation)
    handle_existing_project_directory
    
    # Step 2: Create the base project directory
    create_base_project_directory
    
    # Step 3: Copy template files to project
    copy_template_files
    
    # Step 4: Copy hidden directories (like .claude)
    copy_hidden_directories
    
    # Step 5: Change to project directory safely
    if ! cd "$FULL_PROJECT_PATH" 2>>"$LOG_FILE"; then
        safe_exit $EXIT_FILE_OPERATION_ERROR "Failed to change to project directory: $FULL_PROJECT_PATH"
    fi
    
    # Step 6: Create standard project directories
    create_standard_directories
    
    # Step 7: Add .gitkeep files to maintain empty directories in git
    create_gitkeep_files
    
    log "INFO" "Project structure creation completed successfully"
}

#############################################################################
# PROJECT CUSTOMIZATION FUNCTIONS
#############################################################################

#############################################################################
# Function: customize_project_files
# Description: Replaces PROJECT_NAME placeholder in specified template files
# Arguments:
#   None
# Global Variables:
#   READS: PROJECT_NAME, LOG_FILE, OSTYPE
# Returns:
#   0 - Customization completed (with or without warnings)
# Side Effects:
#   - Modifies template files in place
#   - Creates temporary backups during modification
#   - Logs customization results
# Platform Handling:
#   - Uses appropriate sed syntax for macOS vs Linux
# Example:
#   customize_project_files
#############################################################################
customize_project_files() {
    # Files that need project name replacement
    local files_to_customize=(
        "CLAUDE.md"
        "docs/PLANNING.md"
    )
    
    # Safely replace project name in files
    for file in "${files_to_customize[@]}"; do
        if [[ -f "$file" ]]; then
            log "DEBUG" "Customizing file: $file"
            
            # Create backup before modification
            local backup_file="${file}.backup-$(date +%Y%m%d-%H%M%S)"
            safe_copy_recursive "$file" "$backup_file"
            
            # Perform safe replacement with platform-specific sed syntax
            local sed_success=false
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS requires empty string after -i
                if sed -i '' "s/PROJECT_NAME/$PROJECT_NAME/g" "$file" 2>>"$LOG_FILE"; then
                    sed_success=true
                fi
            else
                # Linux and other Unix systems
                if sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" "$file" 2>>"$LOG_FILE"; then
                    sed_success=true
                fi
            fi
            
            # Handle success or failure
            if [[ "$sed_success" == "true" ]]; then
                # Remove backup on success
                safe_remove_recursive "$backup_file" "CONFIRMED"
                log "DEBUG" "Successfully customized: $file"
            else
                # Restore from backup on failure
                log "WARN" "Failed to customize file: $file"
                safe_copy_recursive "$backup_file" "$file"
                safe_remove_recursive "$backup_file" "CONFIRMED"
            fi
        else
            log "DEBUG" "File not found for customization: $file"
        fi
    done
}

#############################################################################
# Function: process_readme_template
# Description: Processes README.template.md and creates final README.md
# Arguments:
#   None
# Global Variables:
#   READS: PROJECT_NAME, LOG_FILE
# Returns:
#   0 - Always succeeds (logs warnings on failure)
# Side Effects:
#   - Creates README.md from template
#   - Removes README.template.md on success
#   - Logs processing results
# Example:
#   process_readme_template
#############################################################################
process_readme_template() {
    # Process README template
    if [[ -f "README.template.md" ]]; then
        log "DEBUG" "Processing README template"
        
        if sed "s/PROJECT_NAME/$PROJECT_NAME/g" "README.template.md" > "README.md" 2>>"$LOG_FILE"; then
            safe_remove_recursive "README.template.md" "CONFIRMED"
            log "DEBUG" "README.md created successfully"
        else
            log "WARN" "Failed to process README template"
        fi
    else
        log "DEBUG" "README template not found, skipping"
    fi
}

#############################################################################
# Function: apply_project_type_customization
# Description: Applies project type-specific customizations
# Arguments:
#   None
# Global Variables:
#   READS: PROJECT_TYPE
# Returns:
#   0 - Always succeeds
# Side Effects:
#   - Calls appropriate project type function
#   - Logs customization type applied
# Project Types:
#   - api: Adds API-specific directories (routes, controllers, models)
#   - frontend: Adds frontend directories (components, pages, styles)
#   - fullstack: Combines API and frontend plus database structure
#   - general: No additional directories
# Example:
#   apply_project_type_customization
#############################################################################
apply_project_type_customization() {
    # Apply project type-specific customizations
    case $PROJECT_TYPE in
        api)
            log "INFO" "Applying API project settings"
            apply_api_settings
            ;;
        frontend)
            log "INFO" "Applying Frontend project settings"
            apply_frontend_settings
            ;;
        fullstack)
            log "INFO" "Applying Fullstack project settings"
            apply_fullstack_settings
            ;;
        general)
            log "INFO" "Using general project settings"
            ;;
        *)
            log "WARN" "Unknown project type: $PROJECT_TYPE, using general settings"
            ;;
    esac
}

#############################################################################
# Function: customize_project
# Description: Main function that coordinates all project customization
# Arguments:
#   None
# Global Variables:
#   READS: PROJECT_NAME, PROJECT_TYPE
# Returns:
#   0 - Customization completed successfully
# Side Effects:
#   - Customizes template files with project name
#   - Processes README template
#   - Applies project type-specific settings
# Example:
#   customize_project
#############################################################################
customize_project() {
    log "INFO" "Customizing project for: $PROJECT_NAME (type: $PROJECT_TYPE)"
    
    # Step 1: Replace PROJECT_NAME placeholder in template files
    customize_project_files
    
    # Step 2: Process README template
    process_readme_template
    
    # Step 3: Apply project type-specific customizations
    apply_project_type_customization
    
    log "INFO" "Project customization completed successfully"
}

#############################################################################
# PROJECT TYPE-SPECIFIC CONFIGURATION FUNCTIONS
#############################################################################

#############################################################################
# Function: apply_api_settings
# Description: Creates API-specific directory structure for backend projects
# Arguments:
#   None
# Global Variables:
#   READS: LOG_FILE
# Returns:
#   0 - Always succeeds (logs warnings on failure)
# Side Effects:
#   - Creates API-specific directories
#   - Creates .gitkeep files in new directories
# Directories Created:
#   - src/routes: API route definitions
#   - src/middleware: Express/framework middleware
#   - src/models: Data models and schemas
#   - src/controllers: Request handlers and business logic
# Example:
#   apply_api_settings
#############################################################################
apply_api_settings() {
    log "DEBUG" "Configuring API-specific settings"
    # Add API-specific directories
    mkdir -p "src/routes" "src/middleware" "src/models" "src/controllers" 2>>"$LOG_FILE" || true
    touch "src/routes/.gitkeep" "src/middleware/.gitkeep" "src/models/.gitkeep" "src/controllers/.gitkeep" 2>>"$LOG_FILE" || true
}

#############################################################################
# Function: apply_frontend_settings
# Description: Creates frontend-specific directory structure for UI projects
# Arguments:
#   None
# Global Variables:
#   READS: LOG_FILE
# Returns:
#   0 - Always succeeds (logs warnings on failure)
# Side Effects:
#   - Creates frontend-specific directories
#   - Creates .gitkeep files in new directories
# Directories Created:
#   - src/components: Reusable UI components
#   - src/pages: Page-level components
#   - src/styles: CSS/styling files
#   - src/hooks: Custom React/Vue hooks
#   - src/utils: Utility functions
# Example:
#   apply_frontend_settings
#############################################################################
apply_frontend_settings() {
    log "DEBUG" "Configuring Frontend-specific settings"
    # Add frontend-specific directories
    mkdir -p "src/components" "src/pages" "src/styles" "src/hooks" "src/utils" 2>>"$LOG_FILE" || true
    touch "src/components/.gitkeep" "src/pages/.gitkeep" "src/styles/.gitkeep" "src/hooks/.gitkeep" "src/utils/.gitkeep" 2>>"$LOG_FILE" || true
}

#############################################################################
# Function: apply_fullstack_settings
# Description: Creates comprehensive directory structure for full-stack projects
# Arguments:
#   None
# Global Variables:
#   READS: LOG_FILE
# Returns:
#   0 - Always succeeds (logs warnings on failure)
# Side Effects:
#   - Creates both API and frontend directories
#   - Creates database-related directories
#   - Creates .gitkeep files in all new directories
# Directories Created:
#   - All API directories (via apply_api_settings)
#   - All frontend directories (via apply_frontend_settings)
#   - database/migrations: Database schema changes
#   - database/seeds: Sample data for development
#   - config: Application configuration files
# Example:
#   apply_fullstack_settings
#############################################################################
apply_fullstack_settings() {
    log "DEBUG" "Configuring Fullstack-specific settings"
    # Combine API and frontend settings
    apply_api_settings
    apply_frontend_settings
    # Add additional fullstack directories
    mkdir -p "database/migrations" "database/seeds" "config" 2>>"$LOG_FILE" || true
    touch "database/migrations/.gitkeep" "database/seeds/.gitkeep" "config/.gitkeep" 2>>"$LOG_FILE" || true
}

#############################################################################
# GIT REPOSITORY INITIALIZATION FUNCTIONS
#############################################################################

#############################################################################
# Function: configure_git_user_for_ci
# Description: Configures git user settings for CI environments
# Arguments:
#   None
# Global Variables:
#   READS: CI, GITHUB_ACTIONS, LOG_FILE
# Returns:
#   0 - Always succeeds (logs warnings on failure)
# Side Effects:
#   - Sets git user.name and user.email for CI if not already set
#   - Logs configuration results
# CI Configuration:
#   - Name: "GitHub Actions"
#   - Email: "github-actions@github.com"
# Example:
#   configure_git_user_for_ci
#############################################################################
configure_git_user_for_ci() {
    # Check if git user is configured globally
    local git_user_name git_user_email
    git_user_name=$(git config --global user.name 2>/dev/null || echo "")
    git_user_email=$(git config --global user.email 2>/dev/null || echo "")
    
    # Configure git for CI environments if needed
    if [[ -n "${CI:-}" || -n "${GITHUB_ACTIONS:-}" ]]; then
        if [[ -z "$git_user_name" ]]; then
            git config user.name "GitHub Actions" 2>>"$LOG_FILE" || log "WARN" "Failed to set git user name"
            log "DEBUG" "Set git user name for CI environment"
        fi
        if [[ -z "$git_user_email" ]]; then
            git config user.email "github-actions@github.com" 2>>"$LOG_FILE" || log "WARN" "Failed to set git user email"
            log "DEBUG" "Set git user email for CI environment"
        fi
    elif [[ -z "$git_user_name" || -z "$git_user_email" ]]; then
        log "WARN" "Git user name and email are not configured. You may need to set them later."
        log "WARN" "Use: git config --global user.name 'Your Name'"
        log "WARN" "Use: git config --global user.email 'your.email@example.com'"
    fi
}

#############################################################################
# Function: create_initial_git_commit
# Description: Creates initial git repository and commit
# Arguments:
#   None
# Global Variables:
#   READS: PROJECT_NAME, PROJECT_TYPE, LOG_FILE
# Returns:
#   0 - Git repository created successfully
#   1 - Git operations failed
# Side Effects:
#   - Initializes git repository
#   - Adds all files to staging
#   - Creates initial commit with project metadata
# Commit Message Format:
#   Initial commit: Context Engineering template applied
#   
#   Project: [PROJECT_NAME]
#   Type: [PROJECT_TYPE]
#   Created: [timestamp]
# Example:
#   create_initial_git_commit
#############################################################################
create_initial_git_commit() {
    # Initialize repository
    if ! git init 2>>"$LOG_FILE"; then
        log "WARN" "Failed to initialize git repository"
        return 1
    fi
    
    # Add all files
    if ! git add . 2>>"$LOG_FILE"; then
        log "WARN" "Failed to add files to git repository"
        return 1
    fi
    
    # Create initial commit with descriptive message
    local commit_message="Initial commit: Context Engineering template applied

Project: $PROJECT_NAME
Type: $PROJECT_TYPE
Created: $(date '+%Y-%m-%d %H:%M:%S')"
    
    if ! git commit -m "$commit_message" 2>>"$LOG_FILE"; then
        log "WARN" "Failed to create initial commit"
        return 1
    fi
    
    log "DEBUG" "Initial git commit created successfully"
    return 0
}

#############################################################################
# Function: initialize_git
# Description: Main function that initializes git repository with proper configuration
# Arguments:
#   None
# Global Variables:
#   READS: None directly
# Returns:
#   0 - Git initialization successful
#   1 - Git initialization failed
# Side Effects:
#   - Configures git user for CI environments
#   - Creates git repository and initial commit
#   - Logs all git operations
# Example:
#   initialize_git
#############################################################################
initialize_git() {
    # Skip if git repository already exists
    if [[ -d ".git" ]]; then
        log "INFO" "Git repository already exists, skipping initialization"
        return 0
    fi
    
    log "INFO" "Initializing Git repository..."
    
    # Step 1: Configure git user settings (especially for CI)
    configure_git_user_for_ci
    
    # Step 2: Create git repository and initial commit
    if create_initial_git_commit; then
        log "INFO" "Git repository initialization completed successfully"
        return 0
    else
        log "WARN" "Git repository initialization failed"
        return 1
    fi
}

#############################################################################
# OUTPUT AND COMPLETION FUNCTIONS
#############################################################################

#############################################################################
# Function: print_next_steps
# Description: Displays completion message and next steps guide to user
# Arguments:
#   $1 - Git initialization success flag ("true" or "false")
# Global Variables:
#   READS: FULL_PROJECT_PATH, LOG_FILE, color constants
# Returns:
#   0 - Always succeeds
# Side Effects:
#   - Outputs formatted completion message
#   - Provides next steps and usage instructions
#   - Shows project structure overview
# Example:
#   print_next_steps "true"   # Git was initialized
#   print_next_steps "false"  # Git initialization failed
#############################################################################
print_next_steps() {
    local git_success=${1:-false}
    
    echo ""
    echo -e "${GREEN}✅ Context Engineering project structure for Claude Code creation completed!${NC}"
    echo ""
    echo -e "${BLUE}📋 Next steps:${NC}"
    echo "1. cd $FULL_PROJECT_PATH"
    echo "2. Edit CLAUDE.md to match your project requirements"
    echo "3. Add reference code patterns to examples/ folder"
    echo "4. Write your first feature request in INITIAL.md"
    echo "5. Run /orchestrate in Claude Code to begin development"
    echo ""
    
    if [[ "$git_success" == "true" ]]; then
        echo -e "${GREEN}🔧 Git repository initialized successfully${NC}"
    else
        echo -e "${YELLOW}ℹ️  To initialize Git repository later:${NC}"
        echo "   git init && git add . && git commit -m 'Initial commit'"
    fi
    echo ""
    
    echo -e "${YELLOW}📚 Key concepts:${NC}"
    echo "• CLAUDE.md: Global rules and context for AI assistant"
    echo "• INITIAL.md: Starting point for your project requirements"
    echo "• examples/: Code patterns and best practices"
    echo "• .claude/: Claude Code configuration and agents"
    echo ""
    
    echo -e "${CYAN}🛠️  Available Claude Code commands:${NC}"
    echo "• /orchestrate: Main coordination command"
    echo "• /review-agents: Review agent configurations"
    echo "• /analyze/*: Various analysis commands"
    echo "• /implement/*: Implementation commands"
    echo ""
    
    echo -e "${BLUE}📁 Project structure created:${NC}"
    echo "   $FULL_PROJECT_PATH/"
    echo "   ├── .claude/          # Claude Code configuration"
    echo "   ├── src/              # Source code"
    echo "   ├── tests/            # Test files"
    echo "   ├── examples/         # Code patterns"
    echo "   ├── PRPs/             # Product Requirements Prompts"
    echo "   ├── CLAUDE.md         # AI assistant guidelines"
    echo "   └── INITIAL.md        # Project starting point"
    echo ""
    
    if [[ -f "$LOG_FILE" ]]; then
        echo -e "${CYAN}📋 Setup log available at: $LOG_FILE${NC}"
    fi
    
    echo -e "${GREEN}🎉 Happy coding with Context Engineering!${NC}"
}

#############################################################################
# MAIN EXECUTION FUNCTIONS
#############################################################################

#############################################################################
# Function: setup_logging
# Description: Initializes logging system and log file
# Arguments:
#   None
# Global Variables:
#   READS: LOG_FILE
#   MODIFIES: LOG_FILE (creates/overwrites)
# Returns:
#   0 - Always succeeds
# Side Effects:
#   - Creates or overwrites log file
#   - Writes initial log header
# Example:
#   setup_logging
#############################################################################
setup_logging() {
    echo "Context Engineering Setup Log - $(date)" > "$LOG_FILE"
    log "INFO" "Logging initialized: $LOG_FILE"
}

#############################################################################
# Function: validate_setup_requirements
# Description: Validates all requirements needed for setup (deps, templates, etc.)
# Arguments:
#   None
# Global Variables:
#   READS: TEMPLATE_DIR, EXIT_TEMPLATE_ERROR
# Returns:
#   0 - All validations passed
#   Exits on validation failure
# Side Effects:
#   - May terminate script if requirements not met
#   - Logs validation progress
# Validation Steps:
#   1. Check system dependencies
#   2. Validate template directory existence
#   3. Validate template file integrity
# Example:
#   validate_setup_requirements
#############################################################################
validate_setup_requirements() {
    # Step 1: Check dependencies
    log "INFO" "Step 1/3: Checking system dependencies"
    check_dependencies
    
    # Step 2: Validate template directory
    log "INFO" "Step 2/3: Validating template directory"
    if [[ ! -d "$TEMPLATE_DIR" ]]; then
        safe_exit $EXIT_TEMPLATE_ERROR "Template directory not found: $TEMPLATE_DIR. Please ensure setup-claude-code.sh is being run from the correct location."
    fi
    
    # Step 3: Validate templates
    log "INFO" "Step 3/3: Validating template files"
    validate_templates
    
    log "INFO" "All setup requirements validated successfully"
}

#############################################################################
# Function: execute_project_creation
# Description: Executes the main project creation steps
# Arguments:
#   None
# Global Variables:
#   READS: None directly
# Returns:
#   0 - Project creation successful
#   Exits on creation failure
# Side Effects:
#   - Creates complete project structure
#   - Customizes project files
#   - May terminate script on failure
# Creation Steps:
#   1. Create project directory structure
#   2. Customize project files and settings
# Example:
#   execute_project_creation
#############################################################################
execute_project_creation() {
    # Step 1: Create project structure
    log "INFO" "Step 1/2: Creating project structure"
    create_project_structure
    
    # Step 2: Customize project
    log "INFO" "Step 2/2: Customizing project"
    customize_project
    
    log "INFO" "Project creation completed successfully"
}

#############################################################################
# Function: handle_git_initialization
# Description: Handles git repository initialization with user interaction or CI automation
# Arguments:
#   None
# Global Variables:
#   READS: CI, GITHUB_ACTIONS, BLUE, NC
# Returns:
#   Outputs "true" or "false" to indicate git init success
# Side Effects:
#   - May prompt user for git initialization (unless in CI)
#   - Initializes git repository if requested
#   - Logs git initialization results
# Example:
#   git_success=$(handle_git_initialization)
#############################################################################
handle_git_initialization() {
    local git_init_success=false
    
    log "INFO" "Handling Git repository setup"
    
    if [[ -n "${CI:-}" || -n "${GITHUB_ACTIONS:-}" ]]; then
        log "INFO" "CI environment detected: Automatically initializing Git repository"
        if initialize_git; then
            git_init_success=true
        fi
    else
        echo -e "${BLUE}Would you like to initialize a Git repository? (Y/n)${NC}"
        read -p "" -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            if initialize_git; then
                git_init_success=true
            fi
        else
            log "INFO" "Git initialization skipped by user choice"
        fi
    fi
    
    echo "$git_init_success"
}

#############################################################################
# Function: perform_final_validation
# Description: Performs final validation to ensure project was created correctly
# Arguments:
#   None
# Global Variables:
#   READS: FULL_PROJECT_PATH, EXIT_FILE_OPERATION_ERROR
# Returns:
#   0 - Validation passed
#   Exits on validation failure
# Side Effects:
#   - May terminate script if final validation fails
# Validation Checks:
#   - Project directory exists
#   - Essential template files were copied
# Example:
#   perform_final_validation
#############################################################################
perform_final_validation() {
    log "INFO" "Performing final validation"
    
    # Check project directory exists
    if [[ ! -d "$FULL_PROJECT_PATH" ]]; then
        safe_exit $EXIT_FILE_OPERATION_ERROR "Project directory was not created successfully"
    fi
    
    # Check essential files were copied
    if [[ ! -f "$FULL_PROJECT_PATH/CLAUDE.md" ]]; then
        safe_exit $EXIT_FILE_OPERATION_ERROR "Essential template files were not copied successfully"
    fi
    
    log "INFO" "Final validation passed"
}

#############################################################################
# Function: main
# Description: Main execution function that coordinates the entire setup process
# Arguments:
#   $* - All command line arguments (processed earlier)
# Global Variables:
#   READS: PROJECT_NAME, PROJECT_TYPE, FULL_PROJECT_PATH, LOG_FILE
# Returns:
#   0 - Setup completed successfully
#   Exits on any failure
# Side Effects:
#   - Coordinates entire project setup process
#   - Logs comprehensive execution information
#   - Outputs completion message and next steps
# Execution Flow:
#   1. Setup logging
#   2. Validate requirements
#   3. Execute project creation
#   4. Handle git initialization
#   5. Perform final validation
#   6. Display completion information
# Example:
#   main "$@"
#############################################################################
main() {
    log "INFO" "Starting Context Engineering project setup"
    log "INFO" "Project: $PROJECT_NAME, Type: $PROJECT_TYPE, Path: $FULL_PROJECT_PATH"
    
    # Initialize logging system
    setup_logging
    
    # Validate all setup requirements
    validate_setup_requirements
    
    # Execute main project creation
    execute_project_creation
    
    # Handle git repository initialization
    local git_init_success
    git_init_success=$(handle_git_initialization)
    
    # Perform final validation
    perform_final_validation
    
    # Display completion message and next steps
    print_next_steps "$git_init_success"
    
    log "INFO" "Context Engineering project setup completed successfully"
    log "INFO" "Log file available at: $LOG_FILE"
}

#############################################################################
# SCRIPT EXECUTION
#############################################################################

# Execute main function with comprehensive error handling
# If main function fails, exit with appropriate error code and message
if ! main "$@"; then
    safe_exit $EXIT_FILE_OPERATION_ERROR "Setup failed - check log file: $LOG_FILE"
fi