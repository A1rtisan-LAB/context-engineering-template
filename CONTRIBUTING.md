---
title: Contributing Guide
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: documentation
tags: [contributing, guidelines, development, collaboration]
language: en
---

# Contributing to Context Engineering Template

First, thank you for considering contributing to this project! 🎉

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Environment](#development-environment)
- [Coding Standards](#coding-standards)
- [Documentation Guidelines](#documentation-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)

## Code of Conduct

This project strives to create an environment where all participants are respected and welcomed. All participants must comply with the following:

- Provide constructive and friendly feedback
- Respect diverse perspectives and experiences
- Accept criticism gracefully
- Focus on what's best for the community

## How to Contribute

### 1. Adding New Agents

```bash
# Create new agent package
mkdir -p packages/@claude-code/agents/src
touch packages/@claude-code/agents/src/your-agent.md

# Update README (English + Korean)
# packages/@claude-code/agents/README.md
# packages/@claude-code/agents/README.ko.md
```

### 2. Adding New Commands

```bash
# Add command to appropriate category
mkdir -p packages/@claude-code/commands/src/[category]
touch packages/@claude-code/commands/src/[category]/your-command.md
```

### 3. Documentation Improvements

All documentation must be written in both languages (English/Korean):
- English: `filename.md`
- Korean: `filename.ko.md`

Documentation structure:
```
docs/
├── api/          # API reference docs
├── tutorials/    # Step-by-step guides
├── guides/       # User and developer guides
└── architecture/ # Technical documentation
```

When adding documentation:
1. Add metadata header (title, author, date, version, category, tags, language)
2. Include table of contents for documents > 200 lines
3. Add examples and code snippets
4. Create both English and Korean versions
5. Update docs/README.md and docs/README.ko.md indexes

## Development Environment

### Prerequisites

- Node.js 16.0.0 or higher
- npm 8.0.0 or higher
- Git

### Setup Steps

```bash
# 1. Fork and clone repository
git clone https://github.com/your-username/context-engineering-template.git
cd context-engineering-template

# 2. Install dependencies
npm install

# 3. Create development branch
git checkout -b feature/your-feature-name
```

## Coding Standards

### Agent Writing Guide

Agent files must follow this structure:

```markdown
# agent: agent-name

## Role
Clear description of the agent's role and purpose

## Capabilities
- Key capability 1
- Key capability 2
- Key capability 3

## Instructions
Detailed work instructions
```

### Command Writing Guide

```markdown
# command: command-name

## Description
Purpose and usage scenarios of the command

## Usage
`/command-name [parameters]`

## Parameters
- parameter1: description
- parameter2: description

## Examples
Real usage examples
```

## Documentation Guidelines

**Important**: All documentation must follow the [Documentation Guidelines in CLAUDE.md](CLAUDE.md#documentation-guidelines).

### Bilingual Documentation

1. **File Naming Convention**:
   - English: `README.md`
   - Korean: `README.ko.md`

2. **Translation Standards**:
   - Technical terms should include English: "monorepo(모노레포)"
   - Only translate comments in code examples
   - Ensure natural and clear translations

3. **Keep Synchronized**:
   - Update Korean version when modifying English version
   - Specify language version in commit messages

## Pull Request Process

### 1. PR Checklist

- [ ] Code follows project style guide
- [ ] All tests pass (`npm test --workspaces`)
- [ ] Documentation is bilingual
- [ ] Commit messages are clear

### 2. PR Template

```markdown
## Changes
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation improvement
- [ ] Performance improvement

## Testing
Describe how you tested

## Checklist
- [ ] Code style guide compliance
- [ ] Tests added/updated
- [ ] Documentation updated (English/Korean)
```

### 3. Commit Message Format

```
type(scope): brief description

Detailed description (optional)

Closes #issue-number
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding/modifying tests
- `chore`: Build process or tool changes

## Issue Reporting

### Bug Reports

When finding a bug, please create an issue with the following information:

1. **Bug Description**: Clear and concise description
2. **Reproduction Steps**: Steps to reproduce the bug
3. **Expected Behavior**: What you expected to happen
4. **Actual Behavior**: What actually happened
5. **Screenshots**: If applicable
6. **Environment Information**:
   - OS and version
   - Node.js version
   - npm version

### Feature Requests

To suggest a new feature:

1. **Feature Description**: Clear description of the proposed feature
2. **Use Case**: Why this feature is needed and scenarios
3. **Alternatives**: Other alternatives considered
4. **Additional Context**: Related screenshots or references

## Getting Help

If you have questions:

1. First check the [documentation](docs/)
2. Search [existing issues](https://github.com/A1rtisan-LAB/context-engineering-template/issues)
3. If you still can't find an answer, create a new issue or start a discussion

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for making Context Engineering Template better for everyone! 🚀

## 🌏 Languages

This document is also available in:
- [한국어](CONTRIBUTING.ko.md)