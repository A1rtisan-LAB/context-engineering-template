#!/bin/bash
#
# File: core/lib/common.sh
# Description: Common utilities and functions for Claude Code Template system
# Version: 2.0
#

# Color definitions for output formatting
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly RED='\033[0;31m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

# Exit codes
readonly EXIT_SUCCESS=0
readonly EXIT_INVALID_INPUT=1
readonly EXIT_FILE_OPERATION_ERROR=4
readonly EXIT_PERMISSION_ERROR=5

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
readonly CONFIG_FILE="$SCRIPT_DIR/core/config/claude-template.config.json"

#############################################################################
# Function: log
# Description: Centralized logging function with color support
# Arguments:
#   $1 - Log level (INFO, WARN, ERROR, DEBUG)  
#   $2 - Log message
#############################################################################
log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    case "$level" in
        "INFO")
            echo -e "${GREEN}[${timestamp}] [INFO]${NC} $message" >&1
            ;;
        "WARN")
            echo -e "${YELLOW}[${timestamp}] [WARN]${NC} $message" >&2
            ;;
        "ERROR")  
            echo -e "${RED}[${timestamp}] [ERROR]${NC} $message" >&2
            ;;
        "DEBUG")
            if [[ "${DEBUG:-}" == "true" ]]; then
                echo -e "${CYAN}[${timestamp}] [DEBUG]${NC} $message" >&2
            fi
            ;;
        *)
            echo -e "${BLUE}[${timestamp}] [$level]${NC} $message" >&1
            ;;
    esac
}

#############################################################################
# Function: safe_exit  
# Description: Exit with error message and cleanup
# Arguments:
#   $1 - Exit code
#   $2 - Error message
#############################################################################
safe_exit() {
    local exit_code="$1"
    local message="$2"
    
    if [[ $exit_code -ne $EXIT_SUCCESS ]]; then
        log "ERROR" "$message"
    else
        log "INFO" "$message" 
    fi
    
    # Cleanup temporary files if any
    cleanup_temp_files
    
    exit "$exit_code"
}

#############################################################################
# Function: cleanup_temp_files
# Description: Clean up temporary files and directories
#############################################################################
cleanup_temp_files() {
    # Remove any temporary files created during operation
    if [[ -n "${TEMP_LOG_FILE:-}" ]] && [[ -f "$TEMP_LOG_FILE" ]]; then
        rm -f "$TEMP_LOG_FILE" 2>/dev/null || true
    fi
}

#############################################################################
# Function: validate_dependencies
# Description: Check for required system dependencies
#############################################################################
validate_dependencies() {
    local missing_deps=()
    
    # Check for required commands
    local required_commands=("jq" "git" "find" "grep" "sed")
    
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log "ERROR" "Missing required dependencies: ${missing_deps[*]}"
        log "INFO" "Please install missing dependencies and try again"
        return 1
    fi
    
    return 0
}

#############################################################################  
# Function: load_config
# Description: Load and validate configuration file
# Arguments:
#   $1 - Config file path (optional, defaults to CONFIG_FILE)
#############################################################################
load_config() {
    local config_file="${1:-$CONFIG_FILE}"
    
    if [[ ! -f "$config_file" ]]; then
        log "ERROR" "Configuration file not found: $config_file"
        return 1
    fi
    
    # Validate JSON syntax
    if ! jq . "$config_file" > /dev/null 2>&1; then
        log "ERROR" "Invalid JSON in configuration file: $config_file"
        return 1
    fi
    
    log "DEBUG" "Configuration loaded from: $config_file"
    return 0
}

#############################################################################
# Function: get_config_value
# Description: Get value from configuration file
# Arguments:
#   $1 - JSON path (e.g., ".projectTypes.api.description")
#   $2 - Config file path (optional)
#############################################################################
get_config_value() {
    local json_path="$1"
    local config_file="${2:-$CONFIG_FILE}"
    
    if ! load_config "$config_file"; then
        return 1
    fi
    
    jq -r "$json_path" "$config_file" 2>/dev/null || echo "null"
}

# Set up signal handlers for cleanup
trap cleanup_temp_files EXIT INT TERM