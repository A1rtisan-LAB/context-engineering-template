---
title: Commands API Reference
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: api
tags: [commands, api, reference, documentation]
---

# Commands API Reference

## Overview

The Context Engineering Template includes 26 specialized commands for various development tasks. Commands are organized into four categories: analyze, implement, manage, and support.

## Table of Contents

- [Analysis Commands](#analysis-commands)
- [Implementation Commands](#implementation-commands)
- [Management Commands](#management-commands)
- [Support Commands](#support-commands)
- [Command Usage](#command-usage)
- [Command Customization](#command-customization)

## Analysis Commands

### /analyze:code-quality
Analyzes code quality metrics including readability, maintainability, and standards compliance.

**Syntax**: `/analyze:code-quality [path]`  
**Parameters**: 
- `path` - Directory or file to analyze (default: current directory)

**Example**:
```bash
/analyze:code-quality src/
```

### /analyze:performance
Identifies performance bottlenecks and optimization opportunities.

**Syntax**: `/analyze:performance [path]`  
**Parameters**:
- `path` - Code path to analyze

**Example**:
```bash
/analyze:performance src/api/handlers
```

### /analyze:project-context
Provides comprehensive project overview and context analysis.

**Syntax**: `/analyze:project-context [path]`  
**Parameters**:
- `path` - Project root directory

**Example**:
```bash
/analyze:project-context .
```

### /analyze:sdlc-readiness
Checks if project is ready for SDLC pipeline integration.

**Syntax**: `/analyze:sdlc-readiness`  
**Options**:
- `--verbose` - Detailed output
- `--fix` - Auto-fix issues

**Example**:
```bash
/analyze:sdlc-readiness --verbose
```

### /analyze:security
Performs security vulnerability analysis.

**Syntax**: `/analyze:security [path]`  
**Parameters**:
- `path` - Code path to analyze

**Example**:
```bash
/analyze:security src/auth
```

## Implementation Commands

### /implement:enhancement
Implements improvements to existing code.

**Syntax**: `/implement:enhancement [component] [description]`  
**Parameters**:
- `component` - Component to enhance
- `description` - Enhancement details

**Example**:
```bash
/implement:enhancement auth-module "add rate limiting"
```

### /implement:feature
Implements new features with intelligent agent assistance.

**Syntax**: `/implement:feature [feature-name]`  
**Parameters**:
- `feature-name` - Name of the feature to implement

**Example**:
```bash
/implement:feature user-authentication
```

### /implement:fix
Fixes bugs and issues in the codebase.

**Syntax**: `/implement:fix [issue-description]`  
**Parameters**:
- `issue-description` - Description of the issue

**Example**:
```bash
/implement:fix "login redirect loop"
```

### /implement:refactor
Refactors code for better structure and maintainability.

**Syntax**: `/implement:refactor [component]`  
**Parameters**:
- `component` - Component to refactor

**Example**:
```bash
/implement:refactor database-layer
```

### /implement:sdlc-phase
Executes a specific SDLC pipeline phase.

**Syntax**: `/implement:sdlc-phase [feature] --phase=[phase-name]`  
**Parameters**:
- `feature` - Feature name
- `phase-name` - Phase to execute (planning, design, implementation, etc.)

**Example**:
```bash
/implement:sdlc-phase payment-integration --phase=design
```

## Management Commands

### /manage:docs
Manages project documentation with validation and synchronization.

**Syntax**: `/manage:docs [action]`  
**Actions**:
- `validate` - Check documentation health
- `sync` - Synchronize translations
- `update` - Update outdated docs

**Example**:
```bash
/manage:docs validate
```

### /manage:git
Git workflow management with intelligent commit messages.

**Syntax**: `/manage:git [action]`  
**Actions**:
- `commit` - Create intelligent commit
- `pr` - Create pull request
- `branch` - Manage branches

**Example**:
```bash
/manage:git commit
```

### /manage:prd
Manages Product Requirements Documents.

**Syntax**: `/manage:prd [action] [prd-name] [options]`  
**Actions**:
- `create` - Create new PRD
- `status` - Check PRD status
- `approve` - Approve PRD
- `list` - List PRDs
- `move` - Change PRD state
- `archive` - Archive completed PRD

**Options**:
- `--template=[type]` - Template type (standard, api, frontend, fullstack)
- `--to=[state]` - Target state for move
- `--all` - List all PRDs

**Examples**:
```bash
/manage:prd create "user-auth" --template=api
/manage:prd approve "user-auth"
/manage:prd list --all
```

### /manage:sdlc-pipeline
Manages SDLC pipeline instances.

**Syntax**: `/manage:sdlc-pipeline [action] [pipeline-name]`  
**Actions**:
- `reset` - Reset pipeline state
- `rebuild` - Rebuild from history
- `archive` - Archive completed pipeline
- `restore` - Restore from backup

**Example**:
```bash
/manage:sdlc-pipeline reset "feature-x" --to-phase=design
```

### /manage:test
Test execution and management.

**Syntax**: `/manage:test [scope]`  
**Scopes**:
- `all` - Run all tests
- `unit` - Run unit tests
- `integration` - Run integration tests
- `e2e` - Run end-to-end tests

**Example**:
```bash
/manage:test all
```

## Support Commands

### /support:agent-review
Reviews and scores agent prompt quality.

**Syntax**: `/support:agent-review [agent-name]`  
**Parameters**:
- `agent-name` - Name of agent to review

**Example**:
```bash
/support:agent-review feature-implementer
```

### /support:claude-structure-audit
Audits Claude Code project structure against best practices.

**Syntax**: `/support:claude-structure-audit`  
**Options**:
- `--fix` - Auto-fix issues
- `--verbose` - Detailed output

**Example**:
```bash
/support:claude-structure-audit --fix
```

### /support:concept-explain
Explains code concepts and functionality.

**Syntax**: `/support:concept-explain [concept]`  
**Parameters**:
- `concept` - Concept or code to explain

**Example**:
```bash
/support:concept-explain "async/await pattern"
```

### /support:issue-diagnose
Diagnoses and troubleshoots issues.

**Syntax**: `/support:issue-diagnose [error-description]`  
**Parameters**:
- `error-description` - Description of the issue

**Example**:
```bash
/support:issue-diagnose "TypeScript build error TS2304"
```

### /support:prd-review
Reviews PRD quality and completeness.

**Syntax**: `/support:prd-review [prd-name] [options]`  
**Parameters**:
- `prd-name` - Name of PRD to review

**Options**:
- `--quick` - Quick validation only
- `--auto-fix` - Fix formatting issues

**Example**:
```bash
/support:prd-review "user-auth" --auto-fix
```

### /support:sdlc-report
Generates SDLC pipeline reports.

**Syntax**: `/support:sdlc-report [pipeline-name] [options]`  
**Parameters**:
- `pipeline-name` - Pipeline to report on

**Options**:
- `--format=[type]` - Output format (markdown, json, html)
- `--verbose` - Detailed report

**Example**:
```bash
/support:sdlc-report "feature-x" --format=markdown
```

## Command Usage

### Command Structure
All commands follow a consistent structure:
```
/category:action [required-params] [--optional-flags]
```

### Command Categories
- **analyze**: Analysis and inspection commands
- **implement**: Code implementation and modification
- **manage**: Project and workflow management
- **support**: Help and support utilities

### Command Discovery
To discover available commands in your project:
```bash
ls .claude/commands/
```

### Command Help
Most commands support a help flag:
```bash
/command --help
```

## Command Customization

### Creating Custom Commands
1. Create a new markdown file in `.claude/commands/`
2. Define the command structure and behavior
3. Specify required tools and agents
4. Test the command

### Command Template
```markdown
# Command: /category:action

## Description
Brief description of what the command does.

## Usage
/category:action [parameters] [options]

## Parameters
- parameter1: Description
- parameter2: Description

## Options
- --option1: Description
- --option2: Description

## Examples
/category:action example-param --option1

## Implementation
Detailed implementation instructions for the AI agent.
```

### Command Best Practices
1. **Naming**: Use descriptive, action-oriented names
2. **Categories**: Place in appropriate category
3. **Documentation**: Include clear usage examples
4. **Error Handling**: Define error cases
5. **Validation**: Include parameter validation

## Advanced Features

### Command Composition
Commands can be composed for complex operations:
```bash
/analyze:project-context . && /implement:feature authentication
```

### Command Aliases
Create aliases for frequently used commands:
```bash
# In .claude/settings.json
{
  "aliases": {
    "quick-fix": "/implement:fix",
    "full-analysis": "/orchestrate complete-analysis"
  }
}
```

### Command Pipelines
Chain commands for automated workflows:
```bash
/manage:prd create "feature" --template=api && \
/manage:prd approve "feature" && \
/sdlc "feature" --full
```

## API Integration

### Programmatic Command Execution
Commands can be executed programmatically:
```javascript
// Example: Execute command via API
const result = await claude.executeCommand('/analyze:code-quality', {
  path: 'src/',
  options: { verbose: true }
});
```

### Command Events
Commands emit events that can be monitored:
- `command:start` - Command execution started
- `command:progress` - Progress update
- `command:complete` - Command completed
- `command:error` - Command failed

## Error Handling

### Common Error Codes
| Code | Description | Resolution |
|------|-------------|------------|
| CMD001 | Command not found | Check command name and spelling |
| CMD002 | Missing required parameter | Provide all required parameters |
| CMD003 | Invalid parameter format | Check parameter syntax |
| CMD004 | Permission denied | Check file permissions |
| CMD005 | Agent not available | Ensure agent is configured |

### Debugging Commands
Enable debug mode for detailed output:
```bash
CLAUDE_DEBUG=true /command:action
```

## Performance Considerations

### Command Optimization
- Use specific paths instead of wildcards
- Batch operations when possible
- Cache results for repeated operations
- Use appropriate analysis depth

### Resource Usage
Commands are optimized for:
- Memory efficiency
- Fast execution
- Minimal disk I/O
- Parallel processing where applicable

## See Also

- [AI Agents API](agents.md) - Agent capabilities and usage
- [Workflows API](workflows.md) - Workflow orchestration
- [SDLC Guide](../guides/SDLC_GUIDE.md) - SDLC pipeline documentation
- [PRD Guide](../guides/PRD_GUIDE.md) - PRD system documentation