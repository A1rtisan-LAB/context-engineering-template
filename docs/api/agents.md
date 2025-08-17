---
title: AI Agents API Reference
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: api
tags: [agents, api, reference, documentation]
---

# AI Agents API Reference

## Overview

The Context Engineering Template includes 26 specialized AI agents designed to assist with various development tasks. Each agent has specific capabilities, tools, and expertise areas.

## Table of Contents

- [Analysis Agents](#analysis-agents)
- [Implementation Agents](#implementation-agents)
- [Management Agents](#management-agents)
- [Support Agents](#support-agents)
- [PRD & Documentation Agents](#prd--documentation-agents)

## Analysis Agents

### architecture-analyzer
Analyzes software architecture, design patterns, and system structure.

**Tools**: Read, Glob, Grep, TodoWrite, Bash, BashOutput  
**Use Cases**: Architecture reviews, system design assessments, technical debt analysis

### security-analyzer
Identifies security vulnerabilities and provides security recommendations.

**Tools**: Read, Glob, Grep, TodoWrite, Bash  
**Use Cases**: Security audits, vulnerability scanning, compliance checks

### performance-analyzer
Analyzes performance bottlenecks and optimization opportunities.

**Tools**: Read, Glob, Grep, TodoWrite, Bash, BashOutput, KillBash  
**Use Cases**: Performance profiling, bottleneck identification, scalability analysis

### code-quality-analyzer
Evaluates code quality metrics and standards compliance.

**Tools**: Read, Glob, Grep, TodoWrite, Bash, BashOutput  
**Use Cases**: Code reviews, quality assessments, standards compliance

## Implementation Agents

### feature-implementer
Implements new features with intelligent expert persona activation.

**Tools**: Read, Write, Edit, MultiEdit, Glob, Grep, TodoWrite, Bash, Task  
**Use Cases**: Feature development, component creation, API implementation

### code-enhancement-specialist
Systematically improves existing code for better performance and maintainability.

**Tools**: Read, Glob, Grep, TodoWrite, Edit, MultiEdit  
**Use Cases**: Code refactoring, optimization, modernization

### code-cleanup-optimizer
Cleans up codebases by removing dead code and optimizing structure.

**Tools**: Read, Write, Edit, MultiEdit, Glob, Grep, TodoWrite, Bash  
**Use Cases**: Dead code removal, import optimization, project structure cleanup

## Management Agents

### git-workflow-manager
Manages Git operations with intelligent automation.

**Tools**: Bash, Read, Write, Edit, Glob, Grep, TodoWrite  
**Use Cases**: Commit management, branch strategy, workflow automation

### sdlc-coordinator
Coordinates SDLC pipeline phases and quality gates.

**Tools**: Read, Write, Edit, TodoWrite, Task, Bash, Glob  
**Use Cases**: Pipeline orchestration, phase management, quality gate enforcement

### workflow-orchestrator
Executes complex multi-step tasks with workflow management.

**Tools**: Read, Write, Edit, TodoWrite, Task, Bash, Glob, Grep  
**Use Cases**: Complex workflows, cross-session persistence, task organization

### build-packager
Builds and packages software projects across different languages.

**Tools**: Bash, Read, Write, Edit, Glob, Grep, TodoWrite  
**Use Cases**: Build automation, packaging, CI/CD setup

### test-execution-manager
Runs test suites and generates comprehensive test reports.

**Tools**: Bash, Read, Write, Edit, Glob, Grep, TodoWrite  
**Use Cases**: Test execution, coverage analysis, report generation

## Support Agents

### issue-diagnostician
Systematically investigates and resolves technical issues.

**Tools**: Read, Glob, Grep, TodoWrite, Bash, BashOutput, Edit  
**Use Cases**: Bug diagnosis, troubleshooting, root cause analysis

### concept-explainer
Provides clear explanations of code and technical concepts.

**Tools**: Read, Glob, Grep, TodoWrite  
**Use Cases**: Code explanation, concept clarification, documentation

### dev-estimator
Provides development time estimates for tasks and features.

**Tools**: Read, Glob, Grep, TodoWrite, Sequential-thinking  
**Use Cases**: Sprint planning, project estimation, complexity analysis

### project-context-analyzer
Understands project structure and dependencies.

**Tools**: Read, Glob, Grep, Bash, TodoWrite  
**Use Cases**: Project analysis, dependency mapping, setup guidance

## PRD & Documentation Agents

### prd-creator
Creates structured Product Requirements Documents.

**Tools**: Read, Write, Edit, TodoWrite, Task  
**Use Cases**: PRD generation, requirements documentation, specification writing

### prd-reviewer
Reviews and scores PRD quality.

**Tools**: Read, Glob, Grep, TodoWrite  
**Use Cases**: PRD validation, quality scoring, improvement suggestions

### prd-workflow-generator
Transforms PRDs into implementation workflows.

**Tools**: Read, Write, Edit, TodoWrite, Task  
**Use Cases**: Workflow generation, task breakdown, dependency mapping

### doc-manager
Manages comprehensive documentation with bilingual support.

**Tools**: Read, Write, Edit, MultiEdit, Glob, Grep, TodoWrite, Bash  
**Use Cases**: Documentation management, synchronization, validation

### focused-doc-generator
Creates precise documentation for specific components.

**Tools**: Read, Write, Edit, Glob, Grep, TodoWrite  
**Use Cases**: Component documentation, API docs, targeted documentation

### project-knowledge-curator
Creates and maintains comprehensive project knowledge bases.

**Tools**: Read, Write, Edit, MultiEdit, Glob, Grep, TodoWrite, Bash, Task  
**Use Cases**: Knowledge base creation, documentation curation, best practices

## Agent Activation

To use an agent, invoke it through the Task tool:

```bash
/Task [agent-name] "[task description]"
```

### Examples

```bash
# Architecture analysis
/Task architecture-analyzer "Analyze the system architecture and identify improvements"

# Feature implementation
/Task feature-implementer "Implement user authentication with JWT"

# Security audit
/Task security-analyzer "Perform security audit on the API endpoints"

# Documentation generation
/Task focused-doc-generator "Document the authentication module"
```

## Best Practices

1. **Choose the Right Agent**: Select agents based on their specialization
2. **Provide Clear Context**: Give detailed task descriptions
3. **Use TodoWrite Integration**: Agents use TodoWrite for task tracking
4. **Leverage Expertise**: Each agent has domain-specific knowledge
5. **Combine Agents**: Use multiple agents for complex tasks

## See Also

### Related API Documentation
- **[Commands API](commands.md)** - Command reference and usage
- **[Workflows API](workflows.md)** - Workflow orchestration patterns
- **[API Index](index.md)** - Complete API reference

### Guides and Tutorials
- **[Agent Orchestration Tutorial](../tutorials/agent-orchestration.md)** - Best practices for agent coordination
- **[SDLC Pipeline Guide](../guides/SDLC_GUIDE.md#agent-support)** - Using agents in pipelines
- **[Architecture Overview](../architecture/ARCHITECTURE.md#ai-agent-system)** - System design

### Command Integration
- **[analyze commands](commands.md#analysis-commands)** - Analysis agent commands
- **[implement commands](commands.md#implementation-commands)** - Implementation agent commands
- **[manage commands](commands.md#management-commands)** - Management agent commands
- **[support commands](commands.md#support-commands)** - Support agent commands

### Workflow Integration
- **[development-lifecycle](workflows.md#development-lifecycle)** - Agents in development workflow
- **[quality-assurance](workflows.md#quality-assurance)** - Agents in QA workflow
- **[issue-resolution](workflows.md#issue-resolution)** - Agents in emergency response

### External Resources
- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Package Documentation](../../packages/@claude-code/agents/)