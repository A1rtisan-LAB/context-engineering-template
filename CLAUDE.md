# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Context Engineering Template repository that provides a structured framework for creating new Claude Code projects. It uses a modern monorepo architecture with modular packages for AI agents, commands, workflows, and core functionality.

## Key Commands

### Project Creation
```bash
# Create new project using CLI
node cli/claude-init.js [project-name] [starter-type] [target-path]

# Available starter types: basic, api, frontend, fullstack
node cli/claude-init.js my-api api ~/projects

# Examples
node cli/claude-init.js                        # Basic project
node cli/claude-init.js my-app frontend        # Frontend project
node cli/claude-init.js my-api api ./projects  # API project in ./projects

# With SDLC Pipeline System
node cli/claude-init.js my-project basic . --with-sdlc
node cli/claude-init.js my-api api . --with-sdlc --sdlc-template=agile

# With PRD System (included by default)
node cli/claude-init.js my-project basic       # PRD included by default
node cli/claude-init.js my-api api --no-prd    # Exclude PRD system
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
│       ├── agents/               # 23 AI agents (including sdlc-coordinator)
│       │   └── src/             # Agent .md files
│       ├── commands/             # 24 commands (including 5 SDLC commands)
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
├── CLAUDE.md                   # AI assistant instructions
├── INITIAL.md                  # Feature request template
└── README.md                   # Project documentation
```

**Important:** The monorepo stores files in `packages/@claude-code/*/src/` directories, but generated projects receive these files directly in `.claude/*/` without the `src/` subdirectory. This ensures Claude Code can properly recognize and use the agents, commands, and workflows.

### Package Categories
- **Agent Packages**: 22 specialized AI agents for different development tasks
- **Command Packages**: 18 Claude Code commands organized by category (analyze, implement, manage, support)
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
- `docs/ARCHITECTURE.md` / `ARCHITECTURE.ko.md` - System architecture
- `docs/QUICKSTART.md` / `QUICKSTART.ko.md` - Quick start guide
- `docs/API.md` / `API.ko.md` - API reference
- `docs/MIGRATION.md` / `MIGRATION.ko.md` - Migration guide
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
├── ARCHITECTURE.md          # English version
├── ARCHITECTURE.ko.md       # Korean version
├── QUICKSTART.md           # English version
├── QUICKSTART.ko.md        # Korean version
├── API.md                  # English version
└── API.ko.md              # Korean version
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