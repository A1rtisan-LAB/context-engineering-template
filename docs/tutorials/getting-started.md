---
title: Getting Started Tutorial
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: tutorials
tags: [tutorial, getting-started, quickstart, beginner]
---

# Getting Started Tutorial

## Your First Claude Code Project in 10 Minutes

This tutorial will guide you through creating your first Claude Code project using the Context Engineering Template.

## Prerequisites

- Node.js 18.0.0 or higher
- npm 8.0.0 or higher
- Git installed
- Claude Code CLI installed

## Step 1: Clone the Template Repository

```bash
git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
cd context-engineering-template
```

## Step 2: Install Dependencies

```bash
npm install
```

## Step 3: Create Your First Project

### Option A: Full-Featured Project (Recommended)

Create a project with all systems included (PRD, SDLC, Documentation):

```bash
node cli/claude-init.js my-awesome-project basic . --full
```

### Option B: Default Project

Create a project with PRD and SDLC included by default:

```bash
node cli/claude-init.js my-project basic .
```

### Option C: Minimal Project

Create a lightweight project without PRD/SDLC:

```bash
node cli/claude-init.js my-simple-project basic . --minimal
```

## Step 4: Navigate to Your Project

```bash
cd my-awesome-project
```

## Step 5: Explore the Project Structure

Your new project includes:

```
my-awesome-project/
├── .claude/                 # Claude Code configuration
│   ├── agents/             # AI agents (26 specialized agents)
│   ├── commands/           # Commands (26 commands)
│   └── workflows/          # Workflows
├── docs/                   # Documentation
│   ├── guides/            # User guides
│   ├── architecture/      # Technical docs
│   └── prd/              # PRD templates
├── CLAUDE.md              # AI assistant instructions
├── README.md              # Project documentation
└── README.ko.md           # Korean documentation
```

## Step 6: Start with a PRD (Product Requirements Document)

Create your first feature using the PRD system:

```bash
# In Claude Code, use:
/manage:prd create "user-authentication" --template=standard
```

This creates a structured requirements document for your feature.

## Step 7: Review and Approve the PRD

```bash
# Review the PRD quality
/support:prd-review "user-authentication"

# When ready, approve it
/manage:prd approve "user-authentication"
```

## Step 8: Start SDLC Pipeline

Once the PRD is approved, start the development pipeline:

```bash
# Initialize SDLC from the approved PRD
/sdlc "user-authentication" --init --from-prd

# Check status
/sdlc "user-authentication" --status
```

## Step 9: Use AI Agents for Development

### Analyze Your Project

```bash
# Understand project structure
/analyze:project-context .

# Check code quality
/analyze:code-quality .

# Review architecture
/analyze:architecture .
```

### Implement Features

```bash
# Implement a feature
/implement:feature "login-component"

# Enhance existing code
/implement:enhancement "optimize-database-queries"

# Clean up code
/implement:cleanup .
```

### Manage Your Workflow

```bash
# Commit changes
/manage:git commit

# Run tests
/manage:test .

# Build project
/manage:build .
```

## Step 10: Generate Documentation

```bash
# Document your code
/support:document "authentication-module"

# Generate API documentation
/manage:docs generate api

# Check documentation health
/manage:docs check
```

## Common Workflows

### PRD-Driven Development

1. Create PRD: `/manage:prd create "feature-name"`
2. Review: `/support:prd-review "feature-name"`
3. Approve: `/manage:prd approve "feature-name"`
4. Develop: SDLC automatically starts

### Quick Feature Implementation

1. Analyze: `/analyze:project-context .`
2. Implement: `/implement:feature "feature-name"`
3. Test: `/manage:test .`
4. Document: `/support:document "feature-name"`
5. Commit: `/manage:git commit`

### Bug Fixing Workflow

1. Diagnose: `/support:diagnose "issue-description"`
2. Fix: `/implement:enhancement "bug-fix"`
3. Test: `/manage:test .`
4. Commit: `/manage:git commit`

## Tips for Success

### 1. Use the Right Project Type

- **basic**: General purpose projects
- **api**: Backend API projects
- **frontend**: UI/UX projects
- **fullstack**: Complete web applications

### 2. Leverage AI Agents

Each agent specializes in specific tasks:
- `architecture-analyzer`: System design
- `security-analyzer`: Security audits
- `performance-analyzer`: Performance optimization
- `feature-implementer`: Feature development

### 3. Follow the SDLC Pipeline

The 7-phase pipeline ensures quality:
1. Planning
2. Design
3. Implementation
4. Review
5. Testing
6. Deployment
7. Documentation

### 4. Maintain Bilingual Documentation

Keep documentation in both English and Korean:
- English: `README.md`
- Korean: `README.ko.md`

## Next Steps

- Read the [PRD Guide](../guides/PRD_GUIDE.md) for requirements management
- Explore the [SDLC Pipeline Guide](../guides/SDLC_GUIDE.md) for structured development
- Check the [API Reference](../api/agents.md) for agent capabilities
- Review [Architecture Guide](../architecture/ARCHITECTURE.md) for system design

## Getting Help

- Check documentation: `/manage:docs check`
- Diagnose issues: `/support:diagnose "problem"`
- Explain concepts: `/support:explain "concept"`
- Estimate tasks: `/support:estimate "task"`

## Congratulations! 🎉

You've successfully created your first Claude Code project with the Context Engineering Template. You now have access to:

- 26 specialized AI agents
- 26 powerful commands
- PRD-driven development
- SDLC pipeline management
- Comprehensive documentation system

Happy coding with Claude Code!