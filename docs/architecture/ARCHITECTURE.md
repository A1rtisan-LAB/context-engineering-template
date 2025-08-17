---
title: Architecture Guide
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: architecture
tags: [architecture, system-design, monorepo, technical]
---

# Architecture Guide

## Table of Contents

- [System Overview](#system-overview)
- [Core Architecture](#core-architecture)
  - [1. Monorepo Structure](#1-monorepo-structure)
  - [2. Package System](#2-package-system-packagesclaudecode)
  - [3. CLI System](#3-cli-system-cli)
  - [4. Template Generation Engine](#4-template-generation-engine)
- [Component Architecture](#component-architecture)
  - [AI Agent System](#ai-agent-system)
  - [Command System](#command-system)
  - [Workflow System](#workflow-system)
- [SDLC Pipeline Architecture](#sdlc-pipeline-architecture)
- [PRD System Architecture](#prd-system-architecture)
- [Documentation Architecture](#documentation-architecture)
- [Security Architecture](#security-architecture)
- [Performance Optimizations](#performance-optimizations)
- [Extension Points](#extension-points)
- [Best Practices](#best-practices)

## System Overview

The Context Engineering Template is a sophisticated monorepo system designed to generate and manage Claude Code projects with AI-powered development assistance, structured workflows, and bilingual documentation support.

## Core Architecture

### 1. Monorepo Structure

```
context-engineering-template/
├── packages/                      # Modular packages
│   └── @claude-code/
│       ├── agents/               # AI agent definitions
│       │   └── src/             # 25 specialized agents
│       ├── commands/             # Command templates
│       │   └── src/             # 26 Claude Code commands
│       ├── workflows/            # Workflow definitions
│       │   └── src/             # 4 workflow patterns
│       └── core/                 # Core utilities
│           └── src/             # Template engine & tools
├── starters/                     # Project templates
│   ├── basic/                   # Basic starter template
│   ├── api/                     # API server template
│   ├── frontend/                # Frontend app template
│   └── fullstack/               # Full-stack template
├── cli/                         # CLI tools
│   └── claude-init.js          # Project initialization tool
├── docs/                        # Documentation
└── .github/                     # CI/CD workflows
```

### 2. Package System (`packages/@claude-code/`)

#### Agents Package
- **Location**: `packages/@claude-code/agents/src/`
- **Purpose**: AI agent definitions for specialized tasks
- **Count**: 25 agents
- **Categories**:
  - Analysis: architecture, security, performance, code-quality analyzers
  - Implementation: feature-implementer, code-enhancement-specialist, code-cleanup-optimizer
  - Management: git-workflow-manager, sdlc-coordinator, workflow-orchestrator
  - Support: issue-diagnostician, concept-explainer, doc-manager

#### Commands Package
- **Location**: `packages/@claude-code/commands/src/`
- **Purpose**: Claude Code command templates
- **Count**: 26 commands
- **Categories**:
  - `/analyze:*` - System analysis commands
  - `/implement:*` - Feature implementation commands
  - `/manage:*` - Project management commands
  - `/support:*` - Development support commands

#### Workflows Package
- **Location**: `packages/@claude-code/workflows/src/`
- **Purpose**: Development workflow patterns
- **Count**: 4 workflows
- **Types**:
  - development-lifecycle.md
  - prd-lifecycle.md
  - quality-assurance.md
  - sdlc-pipeline.md

#### Core Package
- **Location**: `packages/@claude-code/core/src/`
- **Purpose**: Core utilities and engine
- **Components**:
  - Template generation engine
  - Project validation tools
  - Documentation synchronization
  - PRD translation utilities

### 3. Starter Templates (`starters/`)

Each starter template provides:
```
starter-name/
├── .claude/                     # Claude Code configuration
│   ├── agents/                 # Selected AI agents
│   ├── commands/               # Available commands
│   ├── workflows/              # Workflow definitions
│   └── sdlc/                   # SDLC pipeline config
├── docs/                       # Project documentation
│   ├── guides/                 # User guides
│   ├── architecture/           # Technical docs
│   └── templates/              # Document templates
├── CLAUDE.md                   # AI assistant instructions
└── README.md/ko.md            # Bilingual documentation
```

### 4. CLI System (`cli/`)

#### Project Initializer
- **File**: `cli/claude-init.js`
- **Purpose**: Create new Claude Code projects
- **Features**:
  - Template selection (basic, api, frontend, fullstack)
  - SDLC pipeline integration
  - PRD system configuration
  - Bilingual documentation setup

### 5. Documentation System (`docs/`)

#### Structure
```
docs/
├── guides/                      # User guides
│   ├── QUICKSTART.md/ko.md
│   ├── PRD_GUIDE.md/ko.md
│   └── SDLC_GUIDE.md/ko.md
├── architecture/                # Technical documentation
│   ├── ARCHITECTURE.md/ko.md
│   └── API.md/ko.md
└── reports/                     # Analysis reports
    └── BENCHMARK_REPORT.md/ko.md
```

## Data Flow Architecture

### 1. Project Generation Flow
```mermaid
graph LR
    User --> CLI[claude-init.js]
    CLI --> TemplateSelector[Template Selection]
    TemplateSelector --> CoreEngine[Core Engine]
    CoreEngine --> FileGenerator[File Generation]
    FileGenerator --> ProjectStructure[Project Structure]
    ProjectStructure --> Validation[Validation]
    Validation --> Output[Generated Project]
```

### 2. SDLC Pipeline Flow
```mermaid
graph TD
    PRD[PRD Creation] --> Planning
    Planning --> Design
    Design --> Implementation
    Implementation --> Review
    Review --> Testing
    Testing --> Deployment
    Deployment --> Documentation
    Documentation --> Complete[Pipeline Complete]
```

### 3. Command Execution Flow
```mermaid
graph LR
    Command[User Command] --> Parser[Command Parser]
    Parser --> Agent[Agent Selection]
    Agent --> Execution[Task Execution]
    Execution --> Validation[Result Validation]
    Validation --> Response[User Response]
```

## Key Components

### 1. Agent System
- **Purpose**: Specialized AI assistants for specific tasks
- **Architecture**: Markdown-based prompt definitions
- **Integration**: Direct Claude Code recognition via `../api/agents.md`
- **Activation**: Command-based or automatic based on context

### 2. Command System
- **Purpose**: Structured task execution
- **Format**: `/category:action [parameters]`
- **Processing**: Command parser → Agent selection → Execution
- **Categories**: analyze, implement, manage, support

### 3. Workflow System
- **Purpose**: Multi-step development processes
- **Types**: Sequential, parallel, iterative
- **Integration**: SDLC phases, PRD lifecycle
- **Automation**: Quality gates, automatic progression

### 4. PRD System
- **Purpose**: Requirements-driven development
- **Flow**: Creation → Review → Approval → SDLC
- **Features**: Automatic translation, templates, validation
- **Integration**: Direct SDLC pipeline trigger

### 5. Documentation System
- **Purpose**: Bilingual project documentation
- **Structure**: Hierarchical with categories
- **Automation**: Sync validation, reference checking
- **Standards**: English/Korean parity requirement

## Technology Stack

### Core Technologies
- **Runtime**: Node.js (>= 16.0.0)
- **Package Manager**: npm with workspaces
- **Version Control**: Git
- **CI/CD**: GitHub Actions

### Development Tools
- **Testing**: Jest
- **Linting**: ESLint (planned)
- **Documentation**: Markdown
- **Automation**: Bash scripts, Node.js scripts

## Security Architecture

### 1. Input Validation
- Command parameter sanitization
- File path validation
- Template injection prevention

### 2. File System Safety
- Restricted directory access
- Safe file operations
- Permission checking

### 3. Code Generation Security
- Template sanitization
- No eval() or dynamic code execution
- Secure defaults

## Performance Considerations

### 1. Monorepo Optimization
- Workspace hoisting for shared dependencies
- Selective package installation
- Incremental builds

### 2. Template Generation
- Lazy loading of templates
- Parallel file operations
- Caching of common resources

### 3. Documentation
- Lightweight markdown processing
- Efficient file searching
- Indexed reference system

## Extensibility Points

### 1. Adding New Agents
- Create markdown file in `packages/@claude-code/agents/src/`
- Define capabilities and prompts
- Update agent count in documentation

### 2. Adding New Commands
- Create command file in `packages/@claude-code/commands/src/`
- Define parameters and execution
- Register in command system

### 3. Creating New Starters
- Add directory under `starters/`
- Include required structure
- Configure specific features

### 4. Extending Workflows
- Add workflow definition in `packages/@claude-code/workflows/src/`
- Define phases and quality gates
- Integrate with existing systems

## Integration Points

### 1. Claude Code Integration
- Direct file system access via `.claude/` directory
- Settings.json configuration
- Agent and command recognition

### 2. Version Control Integration
- Git hooks for validation
- Automated commit messages
- Branch management

### 3. CI/CD Integration
- GitHub Actions workflows
- Automated testing
- Documentation validation

## Best Practices

### 1. Development
- Follow monorepo conventions
- Maintain bilingual documentation
- Use semantic versioning
- Write comprehensive tests

### 2. Documentation
- Keep English/Korean synchronized
- Update with code changes
- Include examples
- Maintain metadata

### 3. Testing
- Unit test all utilities
- Integration test workflows
- Validate generated projects
- Check documentation links

## Future Architecture Plans

### 1. Plugin System
- Dynamic agent loading
- Third-party command support
- Custom workflow definitions

### 2. Cloud Integration
- Remote template storage
- Collaborative features
- Analytics and metrics

### 3. Enhanced Automation
- AI-powered documentation generation
- Automatic code review
- Intelligent refactoring suggestions

## Related Documentation

### Core Guides
- **[Quick Start Guide](../guides/QUICKSTART.md)** - Get started in 5 minutes
- **[PRD Guide](../guides/PRD_GUIDE.md)** - Product requirements documentation
- **[SDLC Pipeline Guide](../guides/SDLC_GUIDE.md)** - 7-phase development pipeline
- **[Document Management](../guides/DOCUMENT_MANAGEMENT.md)** - Documentation system

### API References
- **[API Index](../api/index.md)** - Complete API documentation
- **[Agents API](../api/agents.md)** - 26 AI agents reference
- **[Commands API](../api/commands.md)** - Command system reference
- **[Workflows API](../api/workflows.md)** - Workflow orchestration
- **[CLI API](API.md)** - CLI reference documentation

### Tutorials
- **[Getting Started](../tutorials/getting-started.md)** - Your first project
- **[PRD Development](../tutorials/prd-development.md)** - Building effective PRDs
- **[SDLC Pipeline Usage](../tutorials/sdlc-pipeline-usage.md)** - Pipeline mastery
- **[Agent Orchestration](../tutorials/agent-orchestration.md)** - Agent coordination

### Package Documentation
- [Agents Package](../../packages/@claude-code/agents/README.md)
- [Commands Package](../../packages/@claude-code/commands/README.md)
- [Workflows Package](../../packages/@claude-code/workflows/README.md)
- [Core Package](../../packages/@claude-code/core/README.md)

---

This architecture guide reflects the current monorepo structure and will be updated as the system evolves.