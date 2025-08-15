# Context Engineering Template for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

> 🚀 Advanced monorepo template system for Claude Code projects with 22+ specialized AI agents

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
./setup-claude-code.sh my-api api /path/to/projects

# Specify relative path
./setup-claude-code.sh my-frontend frontend ./projects

# Full options example
./setup-claude-code.sh awesome-app fullstack ~/Development
```

## 📁 Template Structure

```
templates/
├── .claude/                  # Claude Code settings
│   ├── commands/            # Custom command implementations
│   └── agents/              # Specialized AI agents
├── PRPs/                    # Product Requirements Prompts
│   └── templates/           # PRP templates
├── examples/                # Code patterns and examples
│   └── _patterns/          # Reusable patterns
├── docs/                    # Project documentation
├── CLAUDE.md               # AI assistant rules
├── INITIAL.md              # Feature request template
└── README.template.md      # Project README template
```

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

### 🛠️ **Support Commands**
| Command | Description |
|--------|------|
| `/support:diagnose [issue]` | Diagnose bugs, build failures, deployment issues, and unexpected system behavior |
| `/support:document [target]` | Generate accurate documentation for code components, functions, and features |
| `/support:estimate [task]` | Estimate development time for tasks, features, and entire projects |
| `/support:explain [concept]` | Provide clear explanations of code functionality and programming concepts |

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

## 🤝 Contributing

This project welcomes community contributions!

### How to Contribute

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-pattern`)
3. Commit your changes (`git commit -m 'Add amazing pattern'`)
4. Push to the branch (`git push origin feature/amazing-pattern`)
5. Open a Pull Request

For detailed information, please refer to [CONTRIBUTING.md](CONTRIBUTING.md).

## 📋 Template Customization

### Adding New Patterns
```bash
# Create new pattern file
templates/examples/_patterns/your-pattern.md
```

### Adding Project-Specific Rules
Add to the "Project-Specific Rules" section in `templates/CLAUDE.md`

### Adding New PRP Templates
```bash
templates/PRPs/templates/prp_your_type.md
```

## 🔄 Template Management

### Template Synchronization Tool

Use `sync-templates.sh` to perform template quality management and synchronization with existing projects.

#### Available Commands

```bash
# Validate template files
./sync-templates.sh validate

# List all template files
./sync-templates.sh list

# Analyze differences between templates and project
./sync-templates.sh diff my-project

# Update templates in existing project
./sync-templates.sh update my-project
```

#### Key Features

- **Validation**: JSON syntax check, required file verification, empty Markdown file detection
- **List**: Categorized template file listing (Claude settings, PRP templates, documentation, examples, etc.)
- **Difference Analysis**: Detect modified/added files between templates and project
- **Update**: Safe backup followed by selective template updates

#### Update Precautions

- Automatic backup creation before update (`.template-backup-[timestamp]`)
- Claude commands, PRP templates, example patterns are auto-updated
- Documentation templates are selectively updated after user confirmation
- Existing project files are preserved

## 🔧 Troubleshooting

For common issues and solutions, refer to `docs/TROUBLESHOOTING.md`.

### Frequently Asked Questions

**Q: Claude Code doesn't recognize commands**
- A: Ensure `.claude/settings.json` file is in the correct location (not `.local`!)

**Q: Template modifications are not reflected**
- A: Re-run `setup-claude-code.sh` or manually copy the files

## 📚 Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Context Engineering Guide](docs/CONTEXT_ENGINEERING.md)
- [Best Practices](docs/BEST_PRACTICES.md)

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