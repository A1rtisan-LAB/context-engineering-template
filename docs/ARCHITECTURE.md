# Architecture Guide

## System Overview

The Claude Code Template system uses a modular architecture designed for maintainability, extensibility, and ease of use.

## Core Components

### 1. Core System (`core/`)

#### Engine (`core/engine/`)
- **generator.sh** - Project generation engine
- **validator.sh** - Validation and quality assurance  
- **synchronizer.sh** - Template synchronization

#### Configuration (`core/config/`)
- **claude-template.config.json** - Unified configuration system
- Centralized settings for project types, permissions, and validation rules

#### Libraries (`core/lib/`)
- **common.sh** - Shared utilities and logging
- **security.sh** - Security validation and safe operations
- **filesystem.sh** - File system operations with safety checks

### 2. Template System (`templates/`)

```
templates/
├── .claude/                    # Claude Code configuration
│   ├── agents/                # 22 specialized AI agents
│   ├── commands/              # 18 Claude Code commands  
│   ├── memory/                # Context and knowledge templates
│   ├── workflows/             # Development workflow templates
│   └── settings.json          # Default Claude Code settings
├── CLAUDE.md                  # Project instructions template
├── INITIAL.md                 # Initial setup documentation
└── README.template.md         # README template
```

### 3. Scripts (`scripts/`)

- **setup.sh** - Main project creation script (replaces 1,761-line monolith)
- **validate.sh** - Validation and quality checks
- **migrate-config.sh** - Configuration migration utilities

### 4. Examples (`examples/`)

Project-type specific examples and documentation:
- **api-project/** - API server template example
- **frontend-project/** - Frontend application example  
- **fullstack-project/** - Full-stack application example

## Architecture Principles

### 1. Modularity
- Each component has a single responsibility
- Maximum file size: 300 lines
- Clear interfaces between modules

### 2. Security by Design
- All user inputs validated and sanitized
- Path traversal attack prevention
- Secure temporary file handling
- Principle of least privilege

### 3. Configuration Management
- Unified configuration system
- Environment-specific overrides
- Schema validation
- Backward compatibility

### 4. Error Handling
- Comprehensive error reporting
- Graceful degradation
- Automatic cleanup on failures
- Detailed logging

## Data Flow

```
User Input → Security Validation → Configuration Loading → 
Template Processing → File Generation → Validation → Output
```

### 1. Input Processing
1. Command line arguments parsed
2. Input sanitization and validation
3. Security checks performed

### 2. Configuration
1. Unified config loaded and validated
2. Project-type specific settings applied
3. Permission profiles activated

### 3. Generation
1. Starter template files copied to target
2. `.claude/` directory structure created
3. Package contents dynamically discovered and copied:
   - Packages under `@claude-code/` automatically found
   - Contents from `src/` directories copied without the `src/` level
   - Internal packages (e.g., 'core') skipped
   - Unnecessary files excluded (package.json, tests, etc.)
4. Placeholder replacement performed
5. Files written with safety checks

### 4. Validation
1. Generated project structure validated
2. Correct `.claude/` structure verified (no `src/` subdirectories)
3. JSON syntax checks
4. Claude Code compliance verification
5. Final quality assurance

## Performance Characteristics

- **File Operations**: Optimized with batch processing
- **Memory Usage**: Minimal footprint (~5MB)
- **Execution Time**: <2 seconds for typical project
- **Scalability**: Linear scaling with template count

## Integration Points

### Claude Code Integration
- Native `.claude/` directory support
- Agent and command templates
- Settings.json compatibility
- Permission system integration

### External Tools
- Git repository initialization
- Package manager integration
- Docker environment setup
- CI/CD pipeline templates

## Generated Project Architecture

### Directory Structure
Projects created by the CLI have a clean, Claude Code-compliant structure:

```
my-project/
├── .claude/                     # Claude Code configuration
│   ├── agents/                 # AI agents (files directly here)
│   │   ├── *.md               # No src/ subdirectory
│   ├── commands/               # Commands (files directly here)
│   │   ├── *.md               # Command definitions
│   │   ├── analyze/           # Organized by category
│   │   ├── implement/
│   │   ├── manage/
│   │   └── support/
│   └── workflows/              # Workflows (files directly here)
│       └── *.md               # Workflow definitions
├── CLAUDE.md                   # AI assistant instructions
├── INITIAL.md                  # Feature request template
└── README.md                   # Project documentation
```

### Key Design Decisions
- **No symlinks**: Projects are self-contained with actual file copies
- **No src/ subdirectories**: Files appear directly in their categories
- **Dynamic discovery**: Automatically handles new package types
- **Future-proof**: New packages in monorepo are automatically included

## Future Architecture

### Planned Enhancements
1. **Plugin System** - Extensible agent and command plugins
2. **Web Interface** - Optional web-based project generator
3. **Template Registry** - Community template sharing
4. **Advanced Validation** - Schema-based template validation

### Migration Path
The current system is designed to support gradual migration to more advanced architectures while maintaining backward compatibility.