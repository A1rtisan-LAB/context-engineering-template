---
title: Workflows API Reference
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: api
tags: [workflows, api, reference, orchestration]
---

# Workflows API Reference

## Overview

Workflows in the Context Engineering Template provide structured, multi-step processes that orchestrate agents and commands to accomplish complex development tasks. The system includes 4 core workflows that can be customized and extended.

## Table of Contents

- [Core Workflows](#core-workflows)
- [Workflow Structure](#workflow-structure)
- [Workflow Execution](#workflow-execution)
- [Custom Workflows](#custom-workflows)
- [Workflow Orchestration](#workflow-orchestration)
- [Best Practices](#best-practices)

## Core Workflows

### development-lifecycle
Comprehensive development workflow from requirements to deployment.

**Purpose**: Orchestrates the complete development lifecycle  
**Duration**: 10-15 days (typical)  
**Phases**: 7 phases (Planning → Documentation)

**Structure**:
```yaml
workflow: development-lifecycle
description: Complete development lifecycle workflow
phases:
  - planning:
      duration: 1-2 days
      agents: [project-knowledge-curator, dev-estimator]
      outputs: [requirements.md, estimates.json]
  - design:
      duration: 2-3 days
      agents: [system-architect, architecture-analyzer]
      outputs: [architecture.md, api-spec.yaml]
  - implementation:
      duration: 3-5 days
      agents: [feature-implementer, code-enhancement-specialist]
      outputs: [source code, unit tests]
  - review:
      duration: 1 day
      agents: [code-quality-analyzer, security-analyzer]
      outputs: [review-report.md]
  - testing:
      duration: 2-3 days
      agents: [test-execution-manager, issue-diagnostician]
      outputs: [test-results.json, coverage.html]
  - deployment:
      duration: 1 day
      agents: [build-packager, git-workflow-manager]
      outputs: [build artifacts, deployment logs]
  - documentation:
      duration: 1 day
      agents: [focused-doc-generator, project-knowledge-curator]
      outputs: [api-docs.md, user-guide.md]
```

**Triggering**:
```bash
/orchestrate development-lifecycle "feature-name"
```

### quality-assurance
Comprehensive quality checks and validation workflow.

**Purpose**: Ensures code quality, security, and performance  
**Duration**: 4-6 hours  
**Components**: Static analysis, testing, security audit

**Structure**:
```yaml
workflow: quality-assurance
description: Quality assurance and validation workflow
stages:
  - code-analysis:
      tools: [eslint, prettier, tsc]
      agents: [code-quality-analyzer]
      metrics: [complexity, coverage, duplication]
  - security-scan:
      tools: [npm audit, security-analyzer]
      agents: [security-analyzer]
      checks: [vulnerabilities, secrets, permissions]
  - performance-test:
      tools: [benchmark suite]
      agents: [performance-analyzer]
      metrics: [response time, memory usage, throughput]
  - documentation-check:
      agents: [doc-manager]
      validations: [completeness, accuracy, synchronization]
```

**Triggering**:
```bash
/orchestrate quality-assurance
```

### prd-to-implementation
Transforms PRD into working implementation.

**Purpose**: Automates the journey from requirements to code  
**Duration**: Variable (based on PRD complexity)  
**Integration**: SDLC pipeline, PRD system

**Structure**:
```yaml
workflow: prd-to-implementation
description: PRD-driven implementation workflow
steps:
  - prd-analysis:
      agents: [prd-workflow-generator]
      actions:
        - Parse PRD requirements
        - Generate task breakdown
        - Create implementation plan
  - sdlc-initialization:
      agents: [sdlc-coordinator]
      actions:
        - Initialize pipeline
        - Configure phases
        - Set quality gates
  - automated-implementation:
      agents: [workflow-orchestrator]
      actions:
        - Execute implementation tasks
        - Track progress
        - Handle dependencies
  - validation:
      agents: [test-execution-manager]
      actions:
        - Validate against PRD
        - Run acceptance tests
        - Generate compliance report
```

**Triggering**:
```bash
/manage:prd approve "feature-name"  # Auto-triggers workflow
```

### issue-resolution
Rapid issue diagnosis and resolution workflow.

**Purpose**: Quickly identify and fix production issues  
**Duration**: 30 minutes - 4 hours  
**Priority**: Emergency response

**Structure**:
```yaml
workflow: issue-resolution
description: Emergency issue resolution workflow
phases:
  - diagnosis:
      duration: 15-30 minutes
      agents: [issue-diagnostician]
      outputs: [root-cause.md, impact-analysis.md]
  - solution-design:
      duration: 15-30 minutes
      agents: [system-architect, security-analyzer]
      outputs: [fix-strategy.md, risk-assessment.md]
  - implementation:
      duration: 30-120 minutes
      agents: [feature-implementer, code-cleanup-optimizer]
      outputs: [hotfix code, tests]
  - validation:
      duration: 15-30 minutes
      agents: [test-execution-manager]
      outputs: [test-results.json, regression-report.md]
  - deployment:
      duration: 15 minutes
      agents: [build-packager]
      outputs: [deployment logs, rollback plan]
```

**Triggering**:
```bash
/orchestrate issue-resolution "critical bug description"
```

## Workflow Structure

### Workflow Definition
Workflows are defined in YAML or JSON format with the following structure:

```yaml
# Workflow metadata
name: workflow-name
version: 1.0.0
description: Workflow description
author: Team/Author name

# Workflow configuration
config:
  parallel_execution: false
  auto_proceed: true
  notifications: true
  rollback_enabled: true

# Workflow phases/stages
phases:
  - phase_name:
      description: Phase description
      duration: estimated duration
      agents: [list of agents]
      commands: [list of commands]
      gates:
        entry: [entry conditions]
        exit: [exit conditions]
      outputs: [expected outputs]
      on_error: [error handling]
```

### Phase Definition
Each phase contains:

| Element | Type | Description |
|---------|------|-------------|
| `description` | string | Phase purpose and goals |
| `duration` | string | Estimated time to complete |
| `agents` | array | AI agents to use |
| `commands` | array | Commands to execute |
| `gates` | object | Quality gates and conditions |
| `outputs` | array | Expected deliverables |
| `on_error` | string | Error handling strategy |

### Gate Definition
Quality gates control phase transitions:

```yaml
gates:
  entry:
    - condition: "PRD approved"
    - condition: "Tests passing"
  exit:
    - condition: "Code coverage > 80%"
    - condition: "No critical issues"
    - condition: "Documentation complete"
```

## Workflow Execution

### Manual Execution
Execute workflows using the orchestrate command:

```bash
# Basic execution
/orchestrate [workflow-name] [parameters]

# With options
/orchestrate [workflow-name] --phase=specific-phase --debug
```

### Automatic Triggers
Workflows can be triggered by events:

| Event | Workflow | Trigger |
|-------|----------|---------|
| PRD Approval | prd-to-implementation | `/manage:prd approve` |
| Production Issue | issue-resolution | Error monitoring alert |
| PR Creation | quality-assurance | Git hook |
| Sprint Start | development-lifecycle | Calendar event |

### Execution Modes

#### Sequential Mode
Phases execute one after another:
```yaml
config:
  parallel_execution: false
```

#### Parallel Mode
Independent phases execute simultaneously:
```yaml
config:
  parallel_execution: true
  parallel_phases:
    - [design, documentation]
    - [testing, security-scan]
```

#### Conditional Mode
Phases execute based on conditions:
```yaml
phases:
  - optional_phase:
      condition: "feature_type == 'api'"
      agents: [api-specialist]
```

## Custom Workflows

### Creating Custom Workflows

1. **Define Workflow File**
Create `.claude/workflows/custom-workflow.yaml`:

```yaml
name: custom-workflow
version: 1.0.0
description: Custom workflow for specific needs

phases:
  - initialization:
      description: Setup and preparation
      agents: [project-context-analyzer]
      duration: 30 minutes
  - execution:
      description: Main execution phase
      agents: [task-orchestrator]
      duration: 2 hours
  - validation:
      description: Validate results
      agents: [test-execution-manager]
      duration: 1 hour
```

2. **Register Workflow**
Add to `.claude/settings.json`:

```json
{
  "workflows": {
    "custom-workflow": {
      "path": ".claude/workflows/custom-workflow.yaml",
      "enabled": true
    }
  }
}
```

3. **Test Workflow**
```bash
/orchestrate custom-workflow --dry-run
```

### Workflow Templates

#### Feature Development Template
```yaml
name: feature-development
phases:
  - requirements
  - design
  - implementation
  - testing
  - documentation
```

#### Bug Fix Template
```yaml
name: bug-fix
phases:
  - reproduce
  - diagnose
  - fix
  - test
  - deploy
```

#### Refactoring Template
```yaml
name: refactoring
phases:
  - analysis
  - planning
  - refactor
  - test
  - optimize
```

## Workflow Orchestration

### Orchestration Engine
The workflow orchestration engine manages:
- Phase execution order
- Resource allocation
- State management
- Error recovery
- Progress tracking

### State Management
Workflow state is persisted in:
```
.claude/workflows/state/
├── workflow-name/
│   ├── current-state.json
│   ├── history.json
│   └── artifacts/
```

### Progress Tracking
Monitor workflow progress:

```bash
# Check status
/orchestrate status [workflow-name]

# View detailed progress
/orchestrate progress [workflow-name] --verbose

# Get phase details
/orchestrate phase-status [workflow-name] [phase-name]
```

### Error Handling

#### Retry Strategies
```yaml
on_error:
  strategy: retry
  max_attempts: 3
  backoff: exponential
```

#### Rollback Strategies
```yaml
on_error:
  strategy: rollback
  checkpoint: last_successful_phase
```

#### Manual Intervention
```yaml
on_error:
  strategy: pause
  notification: slack
  require_approval: true
```

## Best Practices

### Workflow Design

1. **Keep Phases Focused**
   - Single responsibility per phase
   - Clear input/output contracts
   - Measurable success criteria

2. **Use Appropriate Agents**
   - Match agents to phase requirements
   - Avoid agent overload
   - Consider agent expertise

3. **Define Clear Gates**
   - Objective, measurable criteria
   - Automated validation where possible
   - Document gate requirements

### Performance Optimization

1. **Parallelize When Possible**
   - Identify independent phases
   - Use parallel execution mode
   - Monitor resource usage

2. **Cache Intermediate Results**
   - Store phase outputs
   - Reuse artifacts
   - Implement incremental processing

3. **Optimize Agent Selection**
   - Use specialized agents
   - Minimize agent switching
   - Batch similar operations

### Error Recovery

1. **Implement Checkpoints**
   - Save state after each phase
   - Enable resume from failure
   - Maintain audit trail

2. **Define Rollback Points**
   - Identify safe rollback states
   - Test rollback procedures
   - Document rollback impacts

3. **Monitor and Alert**
   - Set up progress monitoring
   - Configure failure alerts
   - Track success metrics

## Advanced Features

### Workflow Composition
Combine workflows for complex scenarios:

```yaml
name: composite-workflow
workflows:
  - development-lifecycle
  - quality-assurance
  - deployment-pipeline
```

### Dynamic Workflows
Generate workflows based on context:

```javascript
// Dynamic workflow generation
const workflow = generateWorkflow({
  projectType: 'api',
  complexity: 'high',
  timeline: '2-weeks'
});
```

### Workflow Analytics
Track workflow metrics:

| Metric | Description | Use Case |
|--------|-------------|----------|
| Completion Time | Total execution time | Performance optimization |
| Success Rate | Percentage of successful runs | Quality tracking |
| Phase Duration | Time per phase | Bottleneck identification |
| Error Frequency | Error rate by phase | Reliability improvement |

## Integration Points

### CI/CD Integration
```yaml
# GitHub Actions integration
on:
  pull_request:
    types: [opened, synchronize]
jobs:
  quality-workflow:
    runs-on: ubuntu-latest
    steps:
      - uses: claude-code/workflow-action@v1
        with:
          workflow: quality-assurance
```

### External Tools
Workflows can integrate with:
- Issue tracking (Jira, GitHub Issues)
- Monitoring (DataDog, New Relic)
- Communication (Slack, Teams)
- Documentation (Confluence, Notion)

### API Integration
```javascript
// Trigger workflow via API
const response = await claude.workflows.execute({
  name: 'development-lifecycle',
  parameters: {
    feature: 'user-authentication',
    priority: 'high'
  },
  options: {
    notify: true,
    async: true
  }
});
```

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Workflow not found | Missing definition | Check workflow file location |
| Phase timeout | Long-running operation | Increase timeout or optimize |
| Gate failure | Criteria not met | Review gate conditions |
| State corruption | Interrupted execution | Restore from checkpoint |

### Debug Mode
Enable detailed logging:
```bash
CLAUDE_WORKFLOW_DEBUG=true /orchestrate [workflow-name]
```

### Workflow Logs
Access detailed logs:
```bash
# View workflow logs
cat .claude/workflows/logs/[workflow-name].log

# Stream live logs
tail -f .claude/workflows/logs/[workflow-name].log
```

## See Also

- [Commands API](commands.md) - Available commands reference
- [AI Agents API](agents.md) - Agent capabilities
- [SDLC Guide](../guides/SDLC_GUIDE.md) - Pipeline documentation
- [Orchestration Tutorial](../tutorials/workflow-orchestration.md) - Hands-on guide