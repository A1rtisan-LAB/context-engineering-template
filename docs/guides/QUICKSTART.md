---
title: Quick Start Guide
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: guides
tags: [quickstart, setup, installation, getting-started]
---

# Quick Start Guide

Get up and running with Claude Code Context Engineering Template in under 5 minutes!

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Project Structure](#project-structure)
4. [Using Claude Code Commands](#using-claude-code-commands)
5. [Using PRD System](#using-prd-system)
6. [Using SDLC Pipeline](#using-sdlc-pipeline)
7. [Performance Tips](#performance-tips)
8. [Testing Your Setup](#testing-your-setup)
9. [Common Workflows](#common-workflows)
10. [Troubleshooting](#troubleshooting)
11. [Next Steps](#next-steps)
12. [Getting Help](#getting-help)

## Prerequisites

- Node.js 18.0.0 or higher
- npm 8.0.0 or higher
- Git configured (for version control and GitHub features)

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

# With PRD System (included by default)
node cli/claude-init.js my-project basic                        # PRD included
node cli/claude-init.js my-api api --no-prd                    # Without PRD
node cli/claude-init.js my-app frontend --prd-template=frontend # Custom PRD template
```

## Project Structure

After creating a project, you'll have:

```
my-project/
├── .claude/                 # Claude Code configuration
│   ├── agents/             # AI agent definitions
│   ├── commands/           # Custom commands
│   └── workflows/          # Workflow definitions
├── docs/
│   └── prd/                # PRD system (replaces INITIAL.md)
│       ├── draft/          # Draft PRDs
│       ├── review/         # PRDs under review
│       ├── approved/       # Approved PRDs
│       └── templates/      # PRD templates
├── CLAUDE.md               # AI assistant instructions
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

## Using PRD System

Start with Product Requirements Documents for structured development:

### Create PRD from Template
```
/manage:prd create "feature-name" --template=api
```

### Review PRD Quality
```
/support:prd-review "feature-name"
```

### Approve PRD and Start Development
```
/manage:prd approve "feature-name"
```

### List All PRDs
```
/manage:prd list --all
```

## Using SDLC Pipeline

The SDLC Pipeline System provides structured development through 7 phases:

### Initialize SDLC Pipeline
```
/sdlc "feature-name" --init

# Or initialize from approved PRD
/sdlc "feature-name" --init --from-prd
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

For comprehensive SDLC pipeline guidance, see the [SDLC Pipeline Guide](SDLC_GUIDE.md) and [SDLC Pipeline Tutorial](../tutorials/sdlc-pipeline-usage.md).

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

For detailed workflow patterns, see the [Workflows API](../api/workflows.md) and [Agent Orchestration Tutorial](../tutorials/agent-orchestration.md).

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

### Essential Reading
1. **[Architecture Overview](../architecture/ARCHITECTURE.md)** - Understand the system design
2. **[PRD Guide](PRD_GUIDE.md)** - Learn requirements-driven development
3. **[SDLC Pipeline Guide](SDLC_GUIDE.md)** - Master the development pipeline
4. **[Document Management](DOCUMENT_MANAGEMENT.md)** - Documentation best practices

### API References
1. **[API Index](../api/index.md)** - Complete API documentation
2. **[Agents API](../api/agents.md)** - Explore 26 AI agents
3. **[Commands API](../api/commands.md)** - All available commands
4. **[Workflows API](../api/workflows.md)** - Workflow patterns

### Tutorials
1. **[PRD Development](../tutorials/prd-development.md)** - Build your first PRD
2. **[SDLC Pipeline Usage](../tutorials/sdlc-pipeline-usage.md)** - Pipeline mastery
3. **[Agent Orchestration](../tutorials/agent-orchestration.md)** - Agent best practices

### Community
1. Read the [full documentation](../README.md)
2. Check the [CLI API](../architecture/API.md)
3. Review [Contributing Guidelines](../../CONTRIBUTING.md)
4. Join the community discussions

## Getting Help

- [GitHub Issues](https://github.com/A1rtisan-LAB/context-engineering-template/issues)
- [Documentation](https://docs.anthropic.com/claude-code)
- [Contributing Guide](../CONTRIBUTING.md)

---

Happy coding with Claude Code! 🚀