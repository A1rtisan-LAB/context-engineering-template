# @claude-code/commands

Collection of Claude Code commands for the Context Engineering Template.

## Overview

This package contains 26 specialized commands organized by category to streamline development workflows.

## Command Categories

### Analysis Commands (6)
- `analyze:architecture` - System architecture review
- `analyze:security` - Security vulnerability assessment  
- `analyze:performance` - Performance optimization analysis
- `analyze:code-quality` - Code quality metrics
- `analyze:project-context` - Project understanding
- `analyze:sdlc-readiness` - SDLC readiness check

### Implementation Commands (5)
- `implement:feature` - New feature development
- `implement:enhancement` - Code improvements
- `implement:cleanup` - Code refactoring
- `implement:build` - Build management
- `implement:prd` - PRD implementation

### Management Commands (8)
- `manage:test` - Test execution
- `manage:git` - Git workflow management
- `manage:workflow` - CI/CD pipeline
- `manage:build` - Build processes
- `manage:prd` - PRD management
- `manage:doc` - Documentation management
- `manage:sdlc` - SDLC pipeline control
- `manage:deploy` - Deployment management

### Support Commands (6)
- `support:document` - Documentation generation
- `support:estimate` - Development estimation
- `support:diagnose` - Issue diagnosis
- `support:explain` - Concept explanation
- `support:prd-review` - PRD quality review
- `support:sdlc-report` - SDLC progress reports

### Orchestration Commands (1)
- `orchestrate` - Multi-agent coordination

## Usage

Commands are automatically available in Claude Code when the Context Engineering Template is initialized.

## Structure

```
commands/
├── src/
│   ├── analyze/
│   ├── implement/
│   ├── manage/
│   ├── support/
│   └── orchestrate.md
├── package.json
└── README.md
```

## License

MIT