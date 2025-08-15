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
1. Template files located and processed
2. Placeholder replacement performed
3. Directory structure created
4. Files copied with safety checks

### 4. Validation
1. Generated project structure validated
2. JSON syntax checks
3. Claude Code compliance verification
4. Final quality assurance

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

## Future Architecture

### Planned Enhancements
1. **Plugin System** - Extensible agent and command plugins
2. **Web Interface** - Optional web-based project generator
3. **Template Registry** - Community template sharing
4. **Advanced Validation** - Schema-based template validation

### Migration Path
The current system is designed to support gradual migration to more advanced architectures while maintaining backward compatibility.