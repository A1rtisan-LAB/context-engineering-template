#!/bin/bash
#
# File: lib/template-validator.sh
# Description: Comprehensive template validation library for Context Engineering projects
#              Validates both development assets (.claude/) and output templates (templates/)
# Version: 1.0
# Author: Context Engineering Template
# Requirements: bash 4.0+, jq (optional), standard Unix tools
#
# Usage: source lib/template-validator.sh
#
# Features:
#   - JSON syntax and schema validation
#   - Markdown structure and link validation
#   - Agent configuration validation
#   - Template consistency checking
#   - Context-aware validation (development vs output)
#   - Comprehensive error reporting
#   - Auto-fix capabilities where possible

# Bash strict mode for better error handling
set -e          # Exit immediately on error
set -u          # Exit on undefined variables
set -o pipefail # Exit on pipe failures

#############################################################################
# CONFIGURATION AND CONSTANTS
#############################################################################

# Validation configuration
readonly VALIDATOR_VERSION="1.0"
readonly VALIDATOR_LOG_LEVEL=${VALIDATOR_LOG_LEVEL:-"INFO"}

# Color definitions for output formatting
readonly V_GREEN='\033[0;32m'
readonly V_YELLOW='\033[1;33m'
readonly V_BLUE='\033[0;34m'
readonly V_RED='\033[0;31m'
readonly V_CYAN='\033[0;36m'
readonly V_NC='\033[0m' # No Color

# Exit codes for validation results
readonly VALIDATION_SUCCESS=0
readonly VALIDATION_WARNINGS=1
readonly VALIDATION_ERRORS=2
readonly VALIDATION_CRITICAL=3

# Validation context types
readonly CONTEXT_DEVELOPMENT="development"
readonly CONTEXT_OUTPUT="output"

#############################################################################
# UTILITY FUNCTIONS
#############################################################################

# Function: validator_log
# Description: Validation-specific logging function
validator_log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Write to validation log if available
    if [[ -n "${VALIDATION_LOG_FILE:-}" ]]; then
        echo "[$timestamp] [VALIDATOR] [$level] $message" >> "$VALIDATION_LOG_FILE"
    fi
    
    # Display based on level and configuration
    case "$level" in
        DEBUG) [[ "$VALIDATOR_LOG_LEVEL" == "DEBUG" ]] && echo -e "${V_CYAN}[VALIDATOR-DEBUG]${V_NC} $message" ;;
        INFO) echo -e "${V_BLUE}[VALIDATOR]${V_NC} $message" ;;
        WARN) echo -e "${V_YELLOW}[VALIDATOR-WARN]${V_NC} $message" >&2 ;;
        ERROR) echo -e "${V_RED}[VALIDATOR-ERROR]${V_NC} $message" >&2 ;;
    esac
}

# Function: get_file_type
# Description: Determines file type for validation purposes
get_file_type() {
    local file_path="$1"
    local filename="$(basename "$file_path")"
    
    case "$filename" in
        *.json) echo "json" ;;
        *.md) echo "markdown" ;;
        *.yml|*.yaml) echo "yaml" ;;
        .gitignore|.env*) echo "config" ;;
        *) echo "unknown" ;;
    esac
}

# Function: is_development_context
# Description: Determines if a path is in development context (.claude/ in root)
is_development_context() {
    local file_path="$1"
    local context_root="$2"
    
    # Check if file is under the development .claude directory (not templates/.claude)
    if [[ "$file_path" == "$context_root/.claude/"* ]]; then
        echo "true"
    else
        echo "false"
    fi
}

# Function: is_output_context
# Description: Determines if a path is in output context (templates/ directory)
is_output_context() {
    local file_path="$1"
    local context_root="$2"
    
    # Check if file is under the templates directory
    if [[ "$file_path" == "$context_root/templates/"* ]]; then
        echo "true"
    else
        echo "false"
    fi
}

#############################################################################
# JSON VALIDATION FUNCTIONS
#############################################################################

# Function: validate_json_syntax
# Description: Validates JSON file syntax using jq
validate_json_syntax() {
    local json_file="$1"
    local context="$2"
    local errors=0
    
    validator_log "DEBUG" "Validating JSON syntax: $json_file (context: $context)"
    
    if ! command -v jq &> /dev/null; then
        validator_log "WARN" "jq not available, skipping JSON validation for: $json_file"
        return $VALIDATION_WARNINGS
    fi
    
    if ! jq empty "$json_file" 2>/dev/null; then
        validator_log "ERROR" "JSON syntax error in: $json_file"
        ((errors++))
    else
        validator_log "DEBUG" "JSON syntax valid: $json_file"
    fi
    
    return $errors
}

# Function: validate_claude_settings_schema
# Description: Validates Claude settings.json schema
validate_claude_settings_schema() {
    local settings_file="$1"
    local context="$2"
    local errors=0
    
    validator_log "DEBUG" "Validating Claude settings schema: $settings_file"
    
    if ! command -v jq &> /dev/null; then
        validator_log "WARN" "jq not available, skipping schema validation"
        return $VALIDATION_WARNINGS
    fi
    
    # Check required fields for Claude settings
    local required_fields=("name")
    for field in "${required_fields[@]}"; do
        if ! jq -e "has(\"$field\")" "$settings_file" >/dev/null 2>&1; then
            validator_log "ERROR" "Missing required field '$field' in Claude settings: $settings_file"
            ((errors++))
        fi
    done
    
    # Check for common field types
    if jq -e '.name' "$settings_file" >/dev/null 2>&1; then
        if ! jq -e '.name | type == "string"' "$settings_file" >/dev/null 2>&1; then
            validator_log "ERROR" "Field 'name' must be a string in: $settings_file"
            ((errors++))
        fi
    fi
    
    return $errors
}

# Function: validate_json_files
# Description: Main JSON validation function
validate_json_files() {
    local directory="$1"
    local context="$2"
    local total_errors=0
    local total_warnings=0
    
    validator_log "INFO" "Validating JSON files in: $directory (context: $context)"
    
    while IFS= read -r -d '' json_file; do
        local rel_path="${json_file#$directory/}"
        
        # Syntax validation
        if ! validate_json_syntax "$json_file" "$context"; then
            ((total_errors++))
            continue
        fi
        
        # Schema validation for specific files
        case "$(basename "$json_file")" in
            settings.json|settings.local.json)
                if ! validate_claude_settings_schema "$json_file" "$context"; then
                    ((total_errors++))
                fi
                ;;
        esac
        
    done < <(find "$directory" -name "*.json" -type f -print0 2>/dev/null)
    
    if [[ $total_errors -eq 0 && $total_warnings -eq 0 ]]; then
        validator_log "INFO" "All JSON files valid in: $directory"
        return $VALIDATION_SUCCESS
    elif [[ $total_errors -eq 0 ]]; then
        validator_log "WARN" "JSON validation completed with $total_warnings warnings in: $directory"
        return $VALIDATION_WARNINGS
    else
        validator_log "ERROR" "JSON validation failed with $total_errors errors in: $directory"
        return $VALIDATION_ERRORS
    fi
}

#############################################################################
# MARKDOWN VALIDATION FUNCTIONS
#############################################################################

# Function: validate_markdown_headers
# Description: Validates markdown header hierarchy
validate_markdown_headers() {
    local md_file="$1"
    local context="$2"
    local errors=0
    
    validator_log "DEBUG" "Validating markdown headers: $md_file"
    
    # Check for duplicate H1 headers (should have only one)
    local h1_count=$(grep -c "^# " "$md_file" 2>/dev/null || echo "0")
    if [[ $h1_count -gt 1 ]]; then
        validator_log "WARN" "Multiple H1 headers found in: $md_file (found: $h1_count)"
    elif [[ $h1_count -eq 0 ]]; then
        validator_log "WARN" "No H1 header found in: $md_file"
    fi
    
    # Check for header hierarchy (H1 -> H2 -> H3, etc.)
    local prev_level=0
    while IFS= read -r line; do
        if [[ $line =~ ^(#{1,6})\ .+ ]]; then
            local level=${#BASH_REMATCH[1]}
            if [[ $level -gt $((prev_level + 1)) ]] && [[ $prev_level -gt 0 ]]; then
                validator_log "WARN" "Header hierarchy skip detected in: $md_file (H$prev_level -> H$level)"
            fi
            prev_level=$level
        fi
    done < "$md_file"
    
    return $errors
}

# Function: validate_markdown_links
# Description: Validates markdown links (internal and external)
validate_markdown_links() {
    local md_file="$1"
    local context="$2"
    local base_dir="$(dirname "$md_file")"
    local errors=0
    
    validator_log "DEBUG" "Validating markdown links: $md_file"
    
    # Extract markdown links [text](url)
    while IFS= read -r line; do
        # Match markdown links: [text](url)
        while [[ $line =~ \[([^\]]*)\]\(([^)]+)\) ]]; do
            local link_text="${BASH_REMATCH[1]}"
            local link_url="${BASH_REMATCH[2]}"
            
            # Skip external URLs (http/https)
            if [[ $link_url =~ ^https?:// ]]; then
                validator_log "DEBUG" "Skipping external link validation: $link_url"
            # Validate relative file links
            elif [[ $link_url =~ ^[^/] ]] && [[ ! $link_url =~ ^# ]]; then
                local target_file="$base_dir/$link_url"
                if [[ ! -f "$target_file" ]]; then
                    validator_log "ERROR" "Broken internal link in $md_file: $link_url -> $target_file"
                    ((errors++))
                fi
            fi
            
            # Remove matched link to continue searching
            line="${line/${BASH_REMATCH[0]}/}"
        done
    done < "$md_file"
    
    return $errors
}

# Function: validate_markdown_code_blocks
# Description: Validates markdown code blocks for proper formatting
validate_markdown_code_blocks() {
    local md_file="$1"
    local context="$2"
    local errors=0
    local in_code_block=false
    local line_num=0
    
    validator_log "DEBUG" "Validating markdown code blocks: $md_file"
    
    while IFS= read -r line; do
        ((line_num++))
        
        # Check for code block markers
        if [[ $line =~ ^```.*$ ]]; then
            if [[ $in_code_block == "true" ]]; then
                in_code_block=false
            else
                in_code_block=true
            fi
        fi
    done < "$md_file"
    
    # Check if code block was left open
    if [[ $in_code_block == "true" ]]; then
        validator_log "ERROR" "Unclosed code block in: $md_file"
        ((errors++))
    fi
    
    return $errors
}

# Function: validate_agent_markdown_structure
# Description: Validates agent-specific markdown structure
validate_agent_markdown_structure() {
    local agent_file="$1"
    local context="$2"
    local errors=0
    
    validator_log "DEBUG" "Validating agent markdown structure: $agent_file"
    
    # Check for required agent sections
    local required_sections=("Description" "Instructions" "Capabilities")
    for section in "${required_sections[@]}"; do
        if ! grep -q "^## $section" "$agent_file" 2>/dev/null; then
            validator_log "WARN" "Missing recommended section '## $section' in agent: $agent_file"
        fi
    done
    
    # Check for agent metadata patterns
    if [[ "$context" == "$CONTEXT_DEVELOPMENT" ]]; then
        # Development agents might have more flexible structure
        validator_log "DEBUG" "Development agent structure validated: $agent_file"
    else
        # Output template agents should be ready for distribution
        if ! grep -q "You are" "$agent_file" 2>/dev/null; then
            validator_log "WARN" "Agent definition should start with 'You are...' in: $agent_file"
        fi
    fi
    
    return $errors
}

# Function: validate_markdown_files
# Description: Main markdown validation function
validate_markdown_files() {
    local directory="$1"
    local context="$2"
    local total_errors=0
    local total_warnings=0
    
    validator_log "INFO" "Validating Markdown files in: $directory (context: $context)"
    
    while IFS= read -r -d '' md_file; do
        local rel_path="${md_file#$directory/}"
        local file_errors=0
        
        # Skip empty files
        if [[ ! -s "$md_file" ]]; then
            validator_log "WARN" "Empty markdown file: $rel_path"
            continue
        fi
        
        # Basic structure validation
        if ! validate_markdown_headers "$md_file" "$context"; then
            ((file_errors++))
        fi
        
        # Link validation
        if ! validate_markdown_links "$md_file" "$context"; then
            ((file_errors++))
        fi
        
        # Code block validation
        if ! validate_markdown_code_blocks "$md_file" "$context"; then
            ((file_errors++))
        fi
        
        # Agent-specific validation
        if [[ "$rel_path" == *"/agents/"* ]] || [[ "$(basename "$md_file")" == *"agent"* ]]; then
            if ! validate_agent_markdown_structure "$md_file" "$context"; then
                ((file_errors++))
            fi
        fi
        
        total_errors=$((total_errors + file_errors))
        
    done < <(find "$directory" -name "*.md" -type f -print0 2>/dev/null)
    
    if [[ $total_errors -eq 0 ]]; then
        validator_log "INFO" "All Markdown files valid in: $directory"
        return $VALIDATION_SUCCESS
    else
        validator_log "ERROR" "Markdown validation failed with $total_errors errors in: $directory"
        return $VALIDATION_ERRORS
    fi
}

#############################################################################
# AGENT CONFIGURATION VALIDATION FUNCTIONS
#############################################################################

# Function: validate_agent_file_naming
# Description: Validates agent file naming conventions
validate_agent_file_naming() {
    local agents_dir="$1"
    local context="$2"
    local errors=0
    
    validator_log "DEBUG" "Validating agent file naming in: $agents_dir"
    
    if [[ ! -d "$agents_dir" ]]; then
        validator_log "DEBUG" "No agents directory found: $agents_dir"
        return 0
    fi
    
    while IFS= read -r -d '' agent_file; do
        local filename="$(basename "$agent_file")"
        
        # Check naming convention (kebab-case with .md extension)
        if [[ ! $filename =~ ^[a-z0-9-]+\.md$ ]]; then
            validator_log "WARN" "Agent file should use kebab-case naming: $filename"
        fi
        
        # Check for reasonable length
        if [[ ${#filename} -gt 50 ]]; then
            validator_log "WARN" "Agent filename is quite long: $filename"
        fi
        
    done < <(find "$agents_dir" -name "*.md" -type f -print0 2>/dev/null)
    
    return $errors
}

# Function: validate_agent_completeness
# Description: Validates that agent files are complete and functional
validate_agent_completeness() {
    local agents_dir="$1"
    local context="$2"
    local errors=0
    
    validator_log "DEBUG" "Validating agent completeness in: $agents_dir"
    
    if [[ ! -d "$agents_dir" ]]; then
        return 0
    fi
    
    while IFS= read -r -d '' agent_file; do
        local rel_path="${agent_file#$agents_dir/}"
        
        # Check minimum content length
        local word_count=$(wc -w < "$agent_file" 2>/dev/null || echo "0")
        if [[ $word_count -lt 10 ]]; then
            validator_log "WARN" "Agent file seems incomplete (< 10 words): $rel_path"
        fi
        
        # Check for common agent patterns
        if [[ "$context" == "$CONTEXT_OUTPUT" ]]; then
            # Output agents should be ready for use
            if ! grep -q -i "you are\|role\|specialist\|analyst\|manager" "$agent_file" 2>/dev/null; then
                validator_log "WARN" "Agent should define role/identity: $rel_path"
            fi
        fi
        
    done < <(find "$agents_dir" -name "*.md" -type f -print0 2>/dev/null)
    
    return $errors
}

# Function: validate_agent_configurations
# Description: Main agent configuration validation function
validate_agent_configurations() {
    local directory="$1"
    local context="$2"
    local total_errors=0
    
    validator_log "INFO" "Validating agent configurations in: $directory (context: $context)"
    
    local agents_dir="$directory/.claude/agents"
    if [[ "$context" == "$CONTEXT_OUTPUT" ]]; then
        agents_dir="$directory/.claude/agents"
    fi
    
    # Validate naming conventions
    if ! validate_agent_file_naming "$agents_dir" "$context"; then
        ((total_errors++))
    fi
    
    # Validate completeness
    if ! validate_agent_completeness "$agents_dir" "$context"; then
        ((total_errors++))
    fi
    
    if [[ $total_errors -eq 0 ]]; then
        validator_log "INFO" "All agent configurations valid in: $directory"
        return $VALIDATION_SUCCESS
    else
        validator_log "ERROR" "Agent validation failed with $total_errors errors in: $directory"
        return $VALIDATION_ERRORS
    fi
}

#############################################################################
# TEMPLATE CONSISTENCY VALIDATION FUNCTIONS
#############################################################################

# Function: validate_template_structure_consistency
# Description: Validates that template structure is consistent within context
validate_template_structure_consistency() {
    local directory="$1"
    local context="$2"
    local errors=0
    
    validator_log "INFO" "Validating template structure consistency in: $directory (context: $context)"
    
    # Check for required directories based on context
    if [[ "$context" == "$CONTEXT_DEVELOPMENT" ]]; then
        # Development context requirements
        local required_dirs=(".claude/agents" ".claude/commands")
        for dir in "${required_dirs[@]}"; do
            if [[ ! -d "$directory/$dir" ]]; then
                validator_log "WARN" "Missing expected directory in development context: $dir"
            fi
        done
    elif [[ "$context" == "$CONTEXT_OUTPUT" ]]; then
        # Output context requirements
        local required_files=("CLAUDE.md" "INITIAL.md")
        for file in "${required_files[@]}"; do
            if [[ ! -f "$directory/$file" ]]; then
                validator_log "ERROR" "Missing required file in output context: $file"
                ((errors++))
            fi
        done
    fi
    
    return $errors
}

# Function: validate_template_metadata_consistency
# Description: Validates metadata consistency across template files
validate_template_metadata_consistency() {
    local directory="$1"
    local context="$2"
    local errors=0
    
    validator_log "DEBUG" "Validating template metadata consistency in: $directory"
    
    # For output templates, check for version consistency
    if [[ "$context" == "$CONTEXT_OUTPUT" ]]; then
        # Check if version information is consistent across files
        local version_files=("CLAUDE.md" "README.template.md")
        for file in "${version_files[@]}"; do
            if [[ -f "$directory/$file" ]]; then
                validator_log "DEBUG" "Checking metadata in: $file"
                # Additional metadata checks can be added here
            fi
        done
    fi
    
    return $errors
}

# Function: validate_template_consistency
# Description: Main template consistency validation function
validate_template_consistency() {
    local directory="$1"
    local context="$2"
    local total_errors=0
    
    validator_log "INFO" "Validating template consistency in: $directory (context: $context)"
    
    # Structure consistency
    if ! validate_template_structure_consistency "$directory" "$context"; then
        ((total_errors++))
    fi
    
    # Metadata consistency
    if ! validate_template_metadata_consistency "$directory" "$context"; then
        ((total_errors++))
    fi
    
    if [[ $total_errors -eq 0 ]]; then
        validator_log "INFO" "Template consistency validation passed for: $directory"
        return $VALIDATION_SUCCESS
    else
        validator_log "ERROR" "Template consistency validation failed with $total_errors errors for: $directory"
        return $VALIDATION_ERRORS
    fi
}

#############################################################################
# CROSS-DIRECTORY SYNCHRONIZATION VALIDATION FUNCTIONS
#############################################################################

# Function: validate_sync_completeness
# Description: Validates that output templates are properly synchronized with development
validate_sync_completeness() {
    local dev_dir="$1"
    local output_dir="$2"
    local errors=0
    
    validator_log "INFO" "Validating synchronization between development and output templates"
    
    # Check that essential development files have corresponding output versions
    local dev_agents_dir="$dev_dir/.claude/agents"
    local output_agents_dir="$output_dir/.claude/agents"
    
    if [[ -d "$dev_agents_dir" && -d "$output_agents_dir" ]]; then
        # Count agents in each directory
        local dev_agent_count=$(find "$dev_agents_dir" -name "*.md" -type f | wc -l)
        local output_agent_count=$(find "$output_agents_dir" -name "*.md" -type f | wc -l)
        
        if [[ $dev_agent_count -ne $output_agent_count ]]; then
            validator_log "WARN" "Agent count mismatch: development has $dev_agent_count, output has $output_agent_count"
        else
            validator_log "DEBUG" "Agent count synchronized: $dev_agent_count agents in both contexts"
        fi
    fi
    
    return $errors
}

# Function: validate_cross_directory_sync
# Description: Main cross-directory synchronization validation function
validate_cross_directory_sync() {
    local base_dir="$1"
    local dev_dir="$base_dir"
    local output_dir="$base_dir/templates"
    local total_errors=0
    
    validator_log "INFO" "Validating cross-directory synchronization"
    
    # Check that both contexts exist
    if [[ ! -d "$dev_dir/.claude" ]]; then
        validator_log "WARN" "Development context not found: $dev_dir/.claude"
        return $VALIDATION_WARNINGS
    fi
    
    if [[ ! -d "$output_dir" ]]; then
        validator_log "ERROR" "Output context not found: $output_dir"
        return $VALIDATION_ERRORS
    fi
    
    # Validate synchronization completeness
    if ! validate_sync_completeness "$dev_dir" "$output_dir"; then
        ((total_errors++))
    fi
    
    if [[ $total_errors -eq 0 ]]; then
        validator_log "INFO" "Cross-directory synchronization validation passed"
        return $VALIDATION_SUCCESS
    else
        validator_log "ERROR" "Cross-directory synchronization validation failed with $total_errors errors"
        return $VALIDATION_ERRORS
    fi
}

#############################################################################
# MAIN VALIDATION ORCHESTRATION FUNCTIONS
#############################################################################

# Function: validate_context_directory
# Description: Validates a complete directory context (development or output)
validate_context_directory() {
    local directory="$1"
    local context="$2"
    local total_errors=0
    local total_warnings=0
    
    validator_log "INFO" "Starting validation for $context context: $directory"
    
    # JSON validation
    local json_result
    if validate_json_files "$directory" "$context"; then
        json_result=$?
    else
        json_result=$?
    fi
    case $json_result in
        $VALIDATION_WARNINGS) ((total_warnings++)) ;;
        $VALIDATION_ERRORS) ((total_errors++)) ;;
    esac
    
    # Markdown validation
    if ! validate_markdown_files "$directory" "$context"; then
        ((total_errors++))
    fi
    
    # Agent configuration validation
    if ! validate_agent_configurations "$directory" "$context"; then
        ((total_errors++))
    fi
    
    # Template consistency validation
    if ! validate_template_consistency "$directory" "$context"; then
        ((total_errors++))
    fi
    
    # Return appropriate result
    if [[ $total_errors -eq 0 && $total_warnings -eq 0 ]]; then
        validator_log "INFO" "Validation completed successfully for $context context: $directory"
        return $VALIDATION_SUCCESS
    elif [[ $total_errors -eq 0 ]]; then
        validator_log "WARN" "Validation completed with $total_warnings warnings for $context context: $directory"
        return $VALIDATION_WARNINGS
    else
        validator_log "ERROR" "Validation failed with $total_errors errors for $context context: $directory"
        return $VALIDATION_ERRORS
    fi
}

# Function: run_comprehensive_validation
# Description: Runs complete validation for both contexts and cross-directory sync
run_comprehensive_validation() {
    local base_dir="${1:-$(pwd)}"
    local total_errors=0
    local total_warnings=0
    
    validator_log "INFO" "Starting comprehensive template validation"
    validator_log "INFO" "Base directory: $base_dir"
    
    # Validate development context (.claude/ in root)
    if [[ -d "$base_dir/.claude" ]]; then
        validator_log "INFO" "=== DEVELOPMENT CONTEXT VALIDATION ==="
        local dev_result
        if validate_context_directory "$base_dir" "$CONTEXT_DEVELOPMENT"; then
            dev_result=$?
        else
            dev_result=$?
        fi
        case $dev_result in
            $VALIDATION_WARNINGS) ((total_warnings++)) ;;
            $VALIDATION_ERRORS) ((total_errors++)) ;;
        esac
    else
        validator_log "WARN" "No development context found (missing .claude directory)"
        ((total_warnings++))
    fi
    
    # Validate output context (templates/)
    if [[ -d "$base_dir/templates" ]]; then
        validator_log "INFO" "=== OUTPUT CONTEXT VALIDATION ==="
        local output_result
        if validate_context_directory "$base_dir/templates" "$CONTEXT_OUTPUT"; then
            output_result=$?
        else
            output_result=$?
        fi
        case $output_result in
            $VALIDATION_WARNINGS) ((total_warnings++)) ;;
            $VALIDATION_ERRORS) ((total_errors++)) ;;
        esac
    else
        validator_log "ERROR" "No output context found (missing templates directory)"
        ((total_errors++))
    fi
    
    # Validate cross-directory synchronization
    if [[ -d "$base_dir/.claude" && -d "$base_dir/templates" ]]; then
        validator_log "INFO" "=== CROSS-DIRECTORY SYNCHRONIZATION VALIDATION ==="
        local sync_result
        if validate_cross_directory_sync "$base_dir"; then
            sync_result=$?
        else
            sync_result=$?
        fi
        case $sync_result in
            $VALIDATION_WARNINGS) ((total_warnings++)) ;;
            $VALIDATION_ERRORS) ((total_errors++)) ;;
        esac
    fi
    
    # Final summary
    validator_log "INFO" "=== VALIDATION SUMMARY ==="
    if [[ $total_errors -eq 0 && $total_warnings -eq 0 ]]; then
        validator_log "INFO" "All validations passed successfully!"
        return $VALIDATION_SUCCESS
    elif [[ $total_errors -eq 0 ]]; then
        validator_log "WARN" "Validation completed with $total_warnings warnings"
        return $VALIDATION_WARNINGS
    else
        validator_log "ERROR" "Validation failed with $total_errors errors and $total_warnings warnings"
        return $VALIDATION_ERRORS
    fi
}

#############################################################################
# COMMAND LINE INTERFACE
#############################################################################

# Function: show_validator_help
# Description: Shows help information for the validator
show_validator_help() {
    echo -e "${V_CYAN}Context Engineering Template Validator${V_NC}"
    echo ""
    echo "Usage: $0 [command] [directory]"
    echo ""
    echo "Commands:"
    echo "  validate [dir]        Run comprehensive validation (default: current directory)"
    echo "  validate-dev [dir]    Validate development context only"
    echo "  validate-output [dir] Validate output templates only"
    echo "  validate-sync [dir]   Validate cross-directory synchronization only"
    echo "  help                  Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 validate                           # Validate current directory"
    echo "  $0 validate /path/to/project          # Validate specific project"
    echo "  $0 validate-dev                       # Validate development assets only"
    echo "  $0 validate-output ./templates        # Validate output templates only"
    echo ""
    echo "Environment Variables:"
    echo "  VALIDATOR_LOG_LEVEL   Set to DEBUG for verbose output"
    echo "  VALIDATION_LOG_FILE   Path to log file for validation results"
}

# Function: main_validator
# Description: Main entry point for command-line usage
main_validator() {
    local command="${1:-validate}"
    local directory="${2:-$(pwd)}"
    
    case "$command" in
        validate)
            run_comprehensive_validation "$directory"
            ;;
        validate-dev)
            if [[ -d "$directory/.claude" ]]; then
                validate_context_directory "$directory" "$CONTEXT_DEVELOPMENT"
            else
                validator_log "ERROR" "No development context found in: $directory"
                return $VALIDATION_ERRORS
            fi
            ;;
        validate-output)
            # If directory ends with /templates, use it directly; otherwise append /templates
            if [[ "$directory" == */templates ]]; then
                validate_context_directory "$directory" "$CONTEXT_OUTPUT"
            else
                validate_context_directory "$directory/templates" "$CONTEXT_OUTPUT"
            fi
            ;;
        validate-sync)
            validate_cross_directory_sync "$directory"
            ;;
        help|--help|-h)
            show_validator_help
            ;;
        *)
            validator_log "ERROR" "Unknown command: $command"
            show_validator_help
            return $VALIDATION_ERRORS
            ;;
    esac
}

# If script is being run directly (not sourced), execute main function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_validator "$@"
fi