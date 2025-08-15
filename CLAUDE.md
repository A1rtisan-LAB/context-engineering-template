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
│       ├── agents/               # 22 AI agents
│       ├── commands/             # 18 commands
│       ├── workflows/            # Workflow definitions
│       └── core/                 # Core engine
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