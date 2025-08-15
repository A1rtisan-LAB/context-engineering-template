#!/bin/bash
#
# File: core/lib/security.sh  
# Description: Security utilities for Claude Code Template system
# Version: 2.0
#

# Source common utilities
if [[ -z "${SCRIPT_DIR:-}" ]]; then
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

source "$SCRIPT_DIR/common.sh"

#############################################################################
# Function: validate_project_name
# Description: Validates project name for security and compatibility
# Arguments:
#   $1 - Project name to validate
#############################################################################
validate_project_name() {
    local name="$1"
    
    # Check if name is provided
    if [[ -z "$name" ]]; then
        log "ERROR" "Project name cannot be empty"
        return 1
    fi
    
    # Check length constraints
    if [[ ${#name} -lt 1 || ${#name} -gt 50 ]]; then
        log "ERROR" "Project name must be between 1 and 50 characters"
        return 1
    fi
    
    # Check for valid characters (alphanumeric, hyphens, underscores)
    if [[ ! $name =~ ^[a-zA-Z0-9_-]+$ ]]; then
        log "ERROR" "Project name can only contain letters, numbers, hyphens, and underscores"
        return 1
    fi
    
    # Check if it starts with alphanumeric
    if [[ ! $name =~ ^[a-zA-Z0-9] ]]; then
        log "ERROR" "Project name must start with a letter or number"
        return 1
    fi
    
    log "DEBUG" "Project name validation passed: $name"
    return 0
}

#############################################################################
# Function: validate_and_normalize_path
# Description: Validates and normalizes file paths to prevent security issues
# Arguments:
#   $1 - Input path to validate and normalize
# Returns:
#   Normalized path on stdout
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
    
    # Security check: prevent path traversal attacks
    if [[ "$normalized_path" == *"../"* ]] || [[ "$normalized_path" == *"/../"* ]] || [[ "$normalized_path" == "../"* ]] || [[ "$normalized_path" == *"/.." ]]; then
        log "ERROR" "Path contains invalid directory traversal: $input_path"
        return 1
    fi
    
    # Additional security: check for null bytes and other dangerous characters
    if [[ "$normalized_path" == *$'\0'* ]] || [[ "$normalized_path" == *$'\n'* ]] || [[ "$normalized_path" == *$'\r'* ]]; then
        log "ERROR" "Path contains invalid characters: $input_path"
        return 1
    fi
    
    # Check permissions based on path type
    if [[ "$input_path" == "." ]]; then
        # Current directory case - check if we can write to current directory
        if [[ ! -w "$normalized_path" ]]; then
            log "ERROR" "No write permission to current directory: $normalized_path"
            return 1
        fi
    else
        # Other path case - check if parent directory exists and is writable
        local parent_dir="$(dirname "$normalized_path")"
        if [[ ! -d "$parent_dir" ]]; then
            log "ERROR" "Parent directory does not exist: $parent_dir"
            return 1
        fi
        
        if [[ ! -w "$parent_dir" ]]; then
            log "ERROR" "No write permission to parent directory: $parent_dir"
            return 1
        fi
    fi
    
    echo "$normalized_path"
    return 0
}

#############################################################################
# Function: create_secure_temp_file
# Description: Creates a secure temporary file with proper permissions
# Arguments:
#   $1 - Prefix for temp file (optional)
# Returns:
#   Temporary file path on stdout
#############################################################################
create_secure_temp_file() {
    local prefix="${1:-claude-temp}"
    local temp_file
    
    # Create secure temporary file
    if ! temp_file=$(mktemp -t "${prefix}-XXXXXX"); then
        log "ERROR" "Failed to create secure temporary file"
        return 1
    fi
    
    # Set restrictive permissions (owner read/write only)
    chmod 600 "$temp_file"
    
    echo "$temp_file"
    return 0
}

#############################################################################
# Function: validate_file_permissions
# Description: Validates file permissions for security
# Arguments:
#   $1 - File path to check
#   $2 - Expected permissions (optional, defaults to checking basic safety)
#############################################################################
validate_file_permissions() {
    local file_path="$1"
    local expected_perms="${2:-}"
    
    if [[ ! -f "$file_path" ]]; then
        log "ERROR" "File does not exist: $file_path"
        return 1
    fi
    
    # Check if file is world-writable (security risk)
    if [[ -w "$file_path" ]] && stat -c "%a" "$file_path" 2>/dev/null | grep -q "[0-9][0-9][2367]"; then
        log "WARN" "File is world-writable (potential security risk): $file_path"
    fi
    
    # Check if file is executable when it shouldn't be
    local extension="${file_path##*.}"
    if [[ "$extension" =~ ^(json|md|txt|yml|yaml)$ ]] && [[ -x "$file_path" ]]; then
        log "WARN" "Non-executable file has execute permissions: $file_path"
    fi
    
    return 0
}

#############################################################################
# Function: sanitize_input
# Description: Sanitizes user input to prevent injection attacks
# Arguments:
#   $1 - Input string to sanitize
# Returns:
#   Sanitized string on stdout
#############################################################################
sanitize_input() {
    local input="$1"
    
    # Remove null bytes
    input="${input//$'\0'/}"
    
    # Remove carriage returns and line feeds from single-line inputs
    input="${input//$'\r'/}"
    input="${input//$'\n'/}"
    
    # Trim leading and trailing whitespace
    input="${input#"${input%%[![:space:]]*}"}"  
    input="${input%"${input##*[![:space:]]}"}"
    
    echo "$input"
}

#############################################################################
# Function: check_system_security
# Description: Performs basic system security checks
#############################################################################
check_system_security() {
    local warnings=0
    
    # Check if running as root (generally not recommended)
    if [[ $EUID -eq 0 ]]; then
        log "WARN" "Running as root is not recommended for security reasons"
        ((warnings++))
    fi
    
    # Check umask
    local current_umask=$(umask)
    if [[ "$current_umask" == "0000" ]]; then
        log "WARN" "Overly permissive umask detected: $current_umask"
        ((warnings++))
    fi
    
    # Check for basic security tools
    if ! command -v git &> /dev/null; then
        log "WARN" "Git not found - version control recommended for security"
        ((warnings++))
    fi
    
    if [[ $warnings -gt 0 ]]; then
        log "INFO" "Found $warnings security warnings"
        return 1
    fi
    
    log "DEBUG" "Basic security checks passed"
    return 0
}