# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Context Engineering Template repository that provides a structured framework for creating new Claude Code projects. It uses a modern monorepo architecture with modular packages for AI agents, commands, workflows, and core functionality.

## Current Resources
- **26 AI Agents** - Specialized agents for different development tasks
- **26 Commands** - Comprehensive command suite organized by category
- **4 Workflows** - Core development workflows
- **PRD System** - Product Requirements Document management (included by default)
- **SDLC Pipeline** - 7-phase development lifecycle (included by default)
- **Document Management** - Bilingual documentation with validation and sync

## Key Commands

### Project Creation
```bash
# Create new project using CLI
node cli/claude-init.js [project-name] [starter-type] [target-path]

# Available starter types: basic, api, frontend, fullstack
node cli/claude-init.js my-api api ~/projects

# Examples (PRD and SDLC included by default)
node cli/claude-init.js                        # Basic project with PRD & SDLC (default)
node cli/claude-init.js my-app frontend        # Frontend project with all features
node cli/claude-init.js my-api api ./projects  # API project in specific path

# Full installation (explicitly include everything - recommended)
node cli/claude-init.js my-project basic . --full          # All systems included

# Customizing SDLC template (SDLC included by default)
node cli/claude-init.js my-project basic . --sdlc-template=agile     # Use Agile template
node cli/claude-init.js my-api api . --sdlc-template=hotfix         # Use Hotfix template

# Excluding features (when you don't want them)
node cli/claude-init.js my-project basic --no-prd        # Exclude PRD system only
node cli/claude-init.js my-api api --no-sdlc            # Exclude SDLC pipeline only
node cli/claude-init.js my-app frontend --minimal       # Minimal setup (no PRD/SDLC)
```

### PRD Management Commands
```bash
# Create and manage PRDs
/manage:prd create "feature-name" --template=api     # Create new PRD
/manage:prd status "feature-name"                    # Check PRD status
/manage:prd approve "feature-name"                   # Approve and start SDLC
/manage:prd list --all                               # List all PRDs

# PRD review and validation
/support:prd-review "feature-name"                   # Review PRD quality
```

### SDLC Pipeline Commands
```bash
# Initialize and run SDLC pipeline
/sdlc "feature-name" --init            # Initialize pipeline
/sdlc "feature-name" --full            # Run all phases
/sdlc "feature-name" --phase=design    # Run specific phase
/sdlc "feature-name" --status          # Check status
/sdlc "feature-name" --from-prd        # Start from approved PRD

# SDLC support commands
/analyze:sdlc-readiness                # Check project readiness
/support:sdlc-report "feature-name"    # Generate report
```

### Document Management Commands
```bash
# Check documentation health
/manage:docs check                     # Comprehensive health check
/manage:docs validate                  # Validate links and references
/manage:docs outdated                  # List outdated documentation

# Synchronize bilingual documentation
/manage:docs sync                      # Sync English/Korean versions
/manage:docs sync --post-merge         # Sync after git merge

# Generate documentation
/manage:docs generate api              # Generate API documentation
/manage:docs generate guide            # Generate guide documentation
/manage:docs generate architecture     # Generate architecture docs

# Coverage and quality
/manage:docs coverage                  # Check documentation coverage
/manage:docs quality                   # Assess documentation quality
```

### Development Commands
```bash
# Install dependencies
npm install

# Run tests across all packages
npm test --workspaces

# Build all packages
npm run build --workspaces

# Clean install
npm run clean && npm install
```

## Architecture

### Monorepo Structure
```
context-engineering-template/
├── packages/                      # Modular packages
│   └── @claude-code/
│       ├── agents/               # 26 AI agents (including sdlc-coordinator, doc-manager)
│       │   └── src/             # Agent .md files
│       ├── commands/             # 26 commands (including SDLC, PRD, and doc commands)
│       │   └── src/             # Command .md files
│       ├── workflows/            # Workflow definitions
│       │   └── src/             # Workflow .md files
│       └── core/                 # Core engine (internal tools)
├── starters/                     # Project templates
│   ├── basic/                   # Basic starter
│   ├── api/                     # API starter
│   ├── frontend/                # Frontend starter
│   └── fullstack/               # Full-stack starter
├── cli/                         # CLI tools
│   └── claude-init.js          # Project initializer
├── docs/                        # Documentation
└── .claude/                     # Project's own Claude config
```

### Generated Project Structure
When you create a new project using `node cli/claude-init.js`, the generated project has a clean structure:

```
my-project/
├── .claude/                     # Claude Code configuration
│   ├── agents/                 # AI agents (files directly here)
│   │   ├── agent-prompt-reviewer.md
│   │   ├── architecture-analyzer.md
│   │   └── ... (other .md files)
│   ├── commands/               # Commands (files directly here)
│   │   ├── orchestrate.md
│   │   ├── review-agents.md
│   │   ├── analyze/           # Organized subdirectories
│   │   │   └── *.md
│   │   └── ...
│   └── workflows/              # Workflows (files directly here)
│       ├── development-lifecycle.md
│       └── quality-assurance.md
├── docs/
│   └── prd/                   # PRD system (replaces INITIAL.md)
│       ├── draft/             # Draft PRDs
│       ├── review/            # PRDs under review
│       ├── approved/          # Approved PRDs
│       └── templates/         # PRD templates
├── CLAUDE.md                   # AI assistant instructions
└── README.md                   # Project documentation
```

**Important:** The monorepo stores files in `packages/@claude-code/*/src/` directories, but generated projects receive these files directly in `.claude/*/` without the `src/` subdirectory. This ensures Claude Code can properly recognize and use the agents, commands, and workflows.

### Package Categories
- **Agent Packages**: 26 specialized AI agents for different development tasks
- **Command Packages**: 26 Claude Code commands organized by category (analyze, implement, manage, support)
- **Workflow Packages**: Development lifecycle and quality assurance workflows
- **Core Package**: Template generation, validation, and synchronization engine

## Documentation Guidelines

### Bilingual Documentation Policy
All major documentation must be provided in both English (default) and Korean versions to ensure accessibility for both international and Korean developers.

### File Naming Convention
- English (default): `{filename}.md`
- Korean version: `{filename}.ko.md`
- Place both versions in the same directory

### Required Documents
Each of these documents must have both English and Korean versions:
- `README.md` / `README.ko.md` - Project overview and getting started
- `CONTRIBUTING.md` / `CONTRIBUTING.ko.md` - Contribution guidelines
- `docs/architecture/ARCHITECTURE.md` / `ARCHITECTURE.ko.md` - System architecture
- `docs/architecture/API.md` / `API.ko.md` - API reference  
- `docs/guides/QUICKSTART.md` / `QUICKSTART.ko.md` - Quick start guide
- `docs/guides/PRD_GUIDE.md` / `PRD_GUIDE.ko.md` - PRD development guide
- `docs/guides/SDLC_GUIDE.md` / `SDLC_GUIDE.ko.md` - SDLC pipeline guide
- `docs/guides/DOCUMENT_MANAGEMENT.md` / `DOCUMENT_MANAGEMENT.ko.md` - Document management guide
- Package READMEs - Each package should have bilingual documentation

### Translation Standards
- **Technical Terms**: Keep English terms with Korean explanation
  - Example: "모노레포(monorepo)", "워크스페이스(workspace)"
- **Code Examples**: Translate only comments, keep code as-is
- **Version Sync**: Korean version must be updated whenever English version changes
- **Quality**: Translations should be natural and clear, not literal

### Documentation Structure Example
```
docs/
├── architecture/
│   ├── ARCHITECTURE.md      # English version
│   ├── ARCHITECTURE.ko.md   # Korean version
│   ├── API.md              # English version
│   └── API.ko.md           # Korean version
├── guides/
│   ├── QUICKSTART.md       # English version
│   ├── QUICKSTART.ko.md    # Korean version
│   ├── PRD_GUIDE.md        # English version
│   ├── PRD_GUIDE.ko.md     # Korean version
│   ├── SDLC_GUIDE.md       # English version
│   └── SDLC_GUIDE.ko.md    # Korean version
└── api/                     # API documentation
    ├── agents.md
    ├── commands.md
    └── workflows.md
```

## Development Workflow

### Adding New Packages
1. Create package directory under `packages/@claude-code/`
2. Add package.json with proper naming convention
3. Include bilingual README.md and README.ko.md
4. Update root package.json if needed
5. Run `npm install` to link the package

### Testing and Validation
- Use `npm test --workspaces` to run tests across all packages
- Validate package structure before publishing
- Ensure all documentation is bilingual and synchronized

## Important Notes

- This is a monorepo using npm workspaces
- All packages are under `@claude-code/` namespace
- The CLI tool (`cli/claude-init.js`) is the main entry point for users
- Documentation must always be bilingual (English and Korean)
- Follow the documentation guidelines for consistency