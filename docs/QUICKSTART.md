# Quick Start Guide

Get up and running with Claude Code Context Engineering Template in under 5 minutes!

## Prerequisites

- Node.js 16.0.0 or higher
- npm 8.0.0 or higher
- Git (optional, for version control)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
cd context-engineering-template
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Create Your First Project

```bash
# Basic project
node cli/claude-init.js my-project

# API project
node cli/claude-init.js my-api api

# Frontend project
node cli/claude-init.js my-app frontend

# Full-stack project
node cli/claude-init.js my-fullstack fullstack

# With SDLC Pipeline System
node cli/claude-init.js my-project basic . --with-sdlc
node cli/claude-init.js my-api api . --with-sdlc --sdlc-template=agile
```

## Project Structure

After creating a project, you'll have:

```
my-project/
├── .claude/                 # Claude Code configuration
│   ├── agents/             # AI agent definitions
│   ├── commands/           # Custom commands
│   └── workflows/          # Workflow definitions
├── CLAUDE.md               # AI assistant instructions
├── INITIAL.md              # Feature request template
└── README.md               # Project documentation
```

## Using Claude Code Commands

Open your project in Claude Code and use these commands:

### Quick Analysis
```
/analyze:project-context .
```

### Implement a Feature
```
/implement:feature user-authentication
```

### Run Tests
```
/manage:test all
```

### Commit Changes
```
/manage:git commit
```

## Using SDLC Pipeline

The SDLC Pipeline System provides structured development through 7 phases:

### Initialize SDLC Pipeline
```
/sdlc "feature-name" --init
```

### Run Full Pipeline
```
/sdlc "feature-name" --full
```

### Execute Specific Phase
```
/sdlc "feature-name" --phase=design
```

### Check Pipeline Status
```
/sdlc "feature-name" --status
```

### Generate Pipeline Report
```
/support:sdlc-report "feature-name"
```

**Available Templates**: `standard` (waterfall), `agile` (sprint-based), `hotfix` (emergency)

For comprehensive SDLC pipeline guidance, see the [SDLC Pipeline Guide](SDLC_GUIDE.md).

## Performance Tips

1. **Use Async Operations**: The CLI has been optimized with async/await for 40-50% faster project creation
2. **Run Benchmarks**: Use `npm run benchmark` to measure performance
3. **Enable Caching**: Claude Code caches agent responses for faster subsequent operations

## Testing Your Setup

Run the test suite to ensure everything is working:

```bash
# Run all tests
npm test

# Run with coverage
npm run test:coverage

# Run benchmarks
npm run benchmark
```

## Common Workflows

### 1. Starting a New Feature
```bash
# Create feature branch
git checkout -b feature/my-feature

# Use Claude Code to implement
/implement:feature my-feature

# Test your changes
npm test

# Commit with intelligent message
/manage:git commit
```

### 2. Analyzing Code Quality
```bash
# Full project analysis
/orchestrate "complete project analysis"

# Specific module analysis
/analyze:code-quality src/modules/auth
```

### 3. Performance Optimization
```bash
# Run performance analysis
/analyze:performance .

# Apply optimizations
/implement:enhancement performance-critical-module
```

## Troubleshooting

### Issue: Command not recognized
**Solution**: Ensure `.claude/settings.json` is present in your project root

### Issue: Slow project creation
**Solution**: The async CLI should create projects in <100ms. If slower, check disk I/O

### Issue: Tests failing
**Solution**: Run `npm install` to ensure all dependencies are installed

## Next Steps

1. Read the [full documentation](../README.md)
2. Explore [available agents](.claude/agents/)
3. Check the [API documentation](API.md)
4. Join the community discussions

## Getting Help

- [GitHub Issues](https://github.com/A1rtisan-LAB/context-engineering-template/issues)
- [Documentation](https://docs.anthropic.com/claude-code)
- [Contributing Guide](../CONTRIBUTING.md)

---

Happy coding with Claude Code! 🚀