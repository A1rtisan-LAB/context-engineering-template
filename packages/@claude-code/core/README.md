# @claude-code/core

Core engine for the Context Engineering Template system.

## Overview

This package provides the internal tools and utilities for template generation, validation, and synchronization.

## Features

### Template Generation
- Project initialization from starters
- Custom configuration support
- SDLC and PRD system integration

### Validation Engine
- Configuration validation
- Documentation consistency checks
- Bilingual content verification

### Synchronization
- Agent and command deployment
- Workflow integration
- Memory management setup

## Internal Tools

- `claude-init.js` - Project initialization
- `validate.js` - Configuration validation
- `sync.js` - Resource synchronization
- `memory.js` - Memory management

## Usage

This is an internal package used by the Context Engineering Template CLI tools.

```bash
# Used internally by
node cli/claude-init.js [project-name] [starter-type]
```

## Structure

```
core/
├── src/
│   ├── generators/
│   ├── validators/
│   ├── synchronizers/
│   └── utils/
├── package.json
└── README.md
```

## Dependencies

- Node.js 18+
- File system utilities
- Template processing

## License

MIT