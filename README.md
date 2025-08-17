# Context Engineering Template for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

> 🚀 Advanced monorepo template system for Claude Code projects with 23+ specialized AI agents, SDLC Pipeline System, and PRD-driven development workflow

## 📦 New Monorepo Structure (v3.0)

This project has been restructured as a modern monorepo for better modularity and maintainability:

```
context-engineering-template/
├── packages/                      # Modular packages
│   ├── @claude-code/agents/      # AI agent definitions
│   ├── @claude-code/commands/    # Command templates
│   ├── @claude-code/workflows/   # Workflow definitions
│   └── @claude-code/core/        # Core engine
├── starters/                      # Project starter templates
│   ├── basic/                    # Basic project template
│   ├── api/                      # API server template
│   ├── frontend/                 # Frontend app template
│   └── fullstack/               # Full-stack template
├── cli/                          # CLI tools
│   └── claude-init.js           # Project initializer
└── package.json                  # Workspace configuration
```

## 🎯 Key Benefits

### Modularity
- Each package is independently versioned and maintained
- Easy to update or replace individual components
- Clear separation of concerns

### Scalability
- Community can contribute new agents/commands as packages
- Plugin ecosystem support
- Easy to extend with new functionality

### Developer Experience
- Single entry point: `node cli/claude-init.js`
- npm/yarn workspace support
- Modern tooling compatibility

## 🚀 Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
cd context-engineering-template
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Create New Project
```bash
# Using the new CLI
node cli/claude-init.js my-project [starter-type] [target-path]

# Examples:
node cli/claude-init.js                        # Basic project in ./my-claude-project
node cli/claude-init.js my-api api             # API project
node cli/claude-init.js my-app frontend ~/apps # Frontend app in ~/apps

# With SDLC Pipeline System:
node cli/claude-init.js my-project basic . --with-sdlc
node cli/claude-init.js my-api api . --with-sdlc --sdlc-template=agile

# With PRD System (included by default):
node cli/claude-init.js my-project basic              # PRD included
node cli/claude-init.js my-api api --no-prd          # Without PRD
node cli/claude-init.js my-app frontend --prd-template=frontend  # Custom PRD template
```

## 📁 Project Structure

### Understanding the Three Structures

This repository contains three distinct structures that work together:

#### 1️⃣ **Template Repository Structure** (This Repo)
```
context-engineering-template/        # Development and maintenance
├── packages/@claude-code/          # Source code (for development)
│   ├── agents/src/*.md            # Agent source files
│   ├── commands/src/*.md          # Command source files
│   └── workflows/src/*.md         # Workflow source files
├── starters/                       # Project templates
│   ├── basic/                     # Basic template
│   ├── api/                       # API template
│   ├── frontend/                  # Frontend template
│   └── fullstack/                 # Full-stack template
├── cli/claude-init.js            # Project generation tool
└── docs/                          # Template system documentation
```
**Purpose**: Template development and maintenance

#### 2️⃣ **Starter Template Structure** (Blueprint)
```
starters/basic/                     # Files to be copied
├── CLAUDE.md                      # AI instructions (copied)
├── README.md                      # Project docs (copied)
└── docs/                          # Project guides (copied)
    ├── QUICKSTART.md
    ├── PRD_GUIDE.md
    └── SDLC_GUIDE.md
```
**Purpose**: Blueprint for new projects

#### 3️⃣ **Generated Project Structure** (What Users Get)
```
my-project/                        # User's new project
├── .claude/                       # Claude Code configuration ⭐
│   ├── agents/                   # AI agents (NO src/ directory!)
│   │   ├── feature-implementer.md
│   │   └── code-analyzer.md
│   ├── commands/                 # Commands (NO src/ directory!)
│   │   ├── analyze/*.md
│   │   └── implement/*.md
│   └── workflows/                # Workflows (NO src/ directory!)
├── docs/                         # Project documentation
│   ├── QUICKSTART.md
│   └── guides/
├── CLAUDE.md                     # AI instructions
└── README.md                     # Project description
```
**Purpose**: Ready-to-use Claude Code project

### 🔄 Key Transformation Process

```
Template Repository              →    Generated Project
─────────────────               →    ─────────────────
packages/@claude-code/          →    .claude/
  └── agents/src/*.md          →      └── agents/*.md (src/ removed!)
  └── commands/src/*.md        →      └── commands/*.md (src/ removed!)
  
starters/[type]/*              →    [project root files]
```

### 💡 Simple Analogy
Think of it as:
- **This repository** = Factory (parts + blueprints + assembly tools)
- **Generated project** = Product (clean, ready-to-use Claude Code project)

Users don't need to understand the factory's complexity - they just receive a clean, well-organized product.

### Generated Project Structure Details
When you create a new project, it will have this structure:

```
my-project/
├── .claude/                  # Claude Code configuration
│   ├── agents/              # AI agents (*.md files directly here)
│   ├── commands/            # Commands organized by category
│   │   ├── analyze/         # Analysis commands
│   │   ├── implement/       # Implementation commands
│   │   ├── manage/          # Management commands (includes PRD)
│   │   └── support/         # Support commands (includes PRD review)
│   ├── workflows/           # Workflow definitions
│   └── sdlc/                # SDLC and PRD configuration
├── docs/
│   ├── prd/                 # PRD documents (when PRD system enabled)
│   │   ├── draft/           # PRDs being written
│   │   ├── approved/        # Approved PRDs
│   │   └── archived/        # Completed PRDs
│   └── guides/              # User and developer guides
├── CLAUDE.md                # AI assistant instructions
├── INITIAL.md               # Feature request template
└── README.md                # Project documentation
```

### Monorepo Structure (Development)
This template repository uses a monorepo structure:

```
context-engineering-template/
├── packages/@claude-code/    # Modular packages
│   ├── agents/src/          # Agent definitions
│   ├── commands/src/        # Command implementations
│   ├── workflows/src/       # Workflow definitions
│   └── core/src/            # Core engine (internal)
├── starters/                # Starter templates
├── cli/                     # CLI tools
└── docs/                    # Documentation
```

**Note:** The CLI copies content from `packages/@claude-code/*/src/` to generated projects' `.claude/*/` directories without the `src/` subdirectory.

## 🛠️ Claude Code Commands

Expert-level commands available in generated projects:

### 🔍 **Analysis Commands**
| Command | Description |
|--------|------|
| `/analyze:architecture [target]` | Analyze software architecture, design patterns, and structural quality |
| `/analyze:code-quality [target]` | Analyze code quality, readability, maintainability, and standards compliance |
| `/analyze:performance [target]` | Analyze performance bottlenecks, memory usage, and scalability issues |
| `/analyze:project-context [target]` | Analyze project structure, dependencies, and configuration |
| `/analyze:security [target]` | Analyze security vulnerabilities, authentication flaws, and data protection issues |

### 🚀 **Implementation Commands**  
| Command | Description |
|--------|------|
| `/implement:feature [feature-name]` | Implement new features and components with expert personas |
| `/implement:enhancement [target]` | Improve existing code performance, maintainability, and readability |
| `/implement:cleanup [target]` | Clean up codebase, remove unused code, and optimize structure |

### 🔧 **Management Commands**
| Command | Description |
|--------|------|
| `/manage:git [task]` | Intelligent Git operations, automatic commit messages, strategic branch management |
| `/manage:build [project]` | Build, compile, and package across various languages and build systems |
| `/manage:test [scope]` | Run tests, analyze results, generate comprehensive test reports |
| `/manage:workflow [task]` | Intelligent workflow management for complex multi-step tasks |
| `/manage:prd create [name]` | Create PRD from template |
| `/manage:prd status [name]` | Check PRD status |
| `/manage:prd approve [name]` | Approve PRD and start SDLC |
| `/manage:prd list` | List all PRDs |

### 🛠️ **Support Commands**
| Command | Description |
|--------|------|
| `/support:diagnose [issue]` | Diagnose bugs, build failures, deployment issues, and unexpected system behavior |
| `/support:document [target]` | Generate accurate documentation for code components, functions, and features |
| `/support:estimate [task]` | Estimate development time for tasks, features, and entire projects |
| `/support:explain [concept]` | Provide clear explanations of code functionality and programming concepts |
| `/support:sdlc-report [feature]` | Generate comprehensive SDLC pipeline reports with metrics and insights |
| `/support:prd-review [name]` | Review PRD quality and suggest improvements |

### 🎯 **SDLC Pipeline Commands**
| Command | Description |
|--------|------|
| `/sdlc [feature] [options]` | Execute comprehensive Software Development Lifecycle pipeline |
| `/analyze:sdlc-readiness` | Analyze project readiness for SDLC pipeline execution |
| `/implement:sdlc-phase [phase]` | Execute specific SDLC pipeline phase |
| `/manage:sdlc-pipeline [action]` | Manage SDLC pipeline lifecycle and state |

### 🎭 **Orchestration Commands**
| Command | Description |
|--------|------|
| `/orchestrate [complex-task]` | Decompose and coordinate complex single-session requests into multi-agent workflows |
| `/review-agents [agent]` | Review and analyze agent prompt quality, consistency, and effectiveness |

## 📝 Workflow

### 🎯 **Basic Development Workflow**
1. **Project Understanding**: Use `/analyze:project-context .` to understand project structure
2. **Feature Implementation**: Use `/implement:feature [feature-name]` to develop new features
3. **Quality Verification**: Use `/analyze:code-quality .` to check code quality
4. **Test Execution**: Use `/manage:test all` to run all tests
5. **Version Control**: Use `/manage:git commit` for intelligent commits and branch management

### 🔧 **Advanced Workflow Patterns**
- **Comprehensive Analysis**: `/orchestrate "complete project architecture, performance, and security analysis"`
- **Refactoring**: `/implement:enhancement [module]` + `/implement:cleanup [module]`
- **Problem Resolution**: `/support:diagnose [issue]` + `/support:explain [solution]`
- **Project Estimation**: `/support:estimate [entire project]`

### 📝 **PRD-Driven Development Workflow**
Start with Product Requirements Documents for structured development:

```bash
# Create PRD from template
/manage:prd create "user-authentication" --template=api

# Review and validate PRD quality
/support:prd-review "user-authentication"

# Approve PRD and start development
/manage:prd approve "user-authentication"
```

### 🚀 **SDLC Pipeline Workflow**
Execute systematic development lifecycle with 7 phases (optionally starting from PRD):

```bash
# Initialize SDLC pipeline for a new feature
/sdlc "user-authentication" --init

# Initialize from approved PRD
/sdlc "user-authentication" --init --from-prd

# Run complete pipeline (Planning → Design → Implementation → Review → Testing → Deployment → Documentation)
/sdlc "user-authentication" --full

# Execute specific phase
/sdlc "user-authentication" --phase=design

# Check pipeline status
/sdlc "user-authentication" --status

# Generate pipeline report
/support:sdlc-report "user-authentication"
```

**SDLC Templates Available**: `standard` (waterfall), `agile` (sprint-based), `hotfix` (emergency)

## 🤝 Contributing

This project welcomes community contributions!

### How to Contribute

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-pattern`)
3. Commit your changes (`git commit -m 'Add amazing pattern'`)
4. Push to the branch (`git push origin feature/amazing-pattern`)
5. Open a Pull Request

For detailed information, please refer to [CONTRIBUTING.md](CONTRIBUTING.md).

## 🔧 Troubleshooting

For common issues and solutions, refer to `docs/TROUBLESHOOTING.md`.

### Frequently Asked Questions

**Q: Claude Code doesn't recognize commands**
- A: Ensure `.claude/settings.json` file is in the correct location (not `.local`!)

**Q: Template modifications are not reflected**
- A: Run `node cli/claude-init.js` again or manually copy the updated files from the starters directory

## 📚 Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [PRD Guide](docs/PRD_GUIDE.md) - Product Requirements Document guide
- [SDLC Pipeline Guide](docs/SDLC_GUIDE.md) - Comprehensive guide to the SDLC Pipeline System
- [Architecture Overview](docs/ARCHITECTURE.md)
- **[📋 Improvement Plan](docs/IMPROVEMENT_PLAN.md)** - Track project enhancement progress
- **[📋 개선 계획 (Korean)](docs/IMPROVEMENT_PLAN.ko.md)** - 프로젝트 개선 진행 상황

## 📄 License

This project is distributed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

This project is evolving through feedback and contributions from the Claude Code community.

## ☕ Support This Project

If this template has improved your development workflow, consider supporting with a cup of coffee!

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-☕-yellow.svg)](https://buymeacoffee.com/a1rtisan)

Your support provides great motivation for developing better Context Engineering tools and templates. 🚀

---

Made with ❤️ for better AI collaboration