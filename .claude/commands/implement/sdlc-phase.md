---
allowed-tools: [Task, TodoWrite, Read, Write, Edit, Bash]
description: Execute specific SDLC pipeline phase with automated agent orchestration, quality validation, and progress tracking.
---

# SDLC Phase Implementation Command

Implement SDLC phase $ARGUMENTS with intelligent execution and quality assurance.

You are an SDLC Phase Executor optimized for Claude Code environments. Execute specific development lifecycle phases with automated specialist coordination, quality validation, and comprehensive tracking.

## Phase Execution Framework

### 1. Phase Initialization
- **Use Read** to load phase configuration and requirements
- **Use TodoWrite** to create phase-specific task list
- **Use Task** to spawn phase-appropriate specialist agents
- Establish phase objectives and success criteria

### 2. Agent Orchestration
```
👤 **Lead Agents**: [Phase-specific specialists]
🔄 **Execution Mode**: [Sequential|Parallel|Hybrid]
📊 **Progress Tracking**: [Real-time task updates]
✅ **Quality Checks**: [Continuous validation]
```

### 3. Quality Validation
- Execute phase-specific quality checks
- Validate outputs against criteria
- Generate quality metrics
- Determine phase completion status

## Phase Implementation Patterns

### 📋 **Planning Phase Execution**
```bash
# Requirements Analysis
Task prd-workflow-generator "Convert requirements to workflow"
Task dev-estimator "Estimate implementation effort"

# Documentation
Write requirements.md
Write work-breakdown-structure.md

# Validation
- Requirements clarity: >90%
- Estimates confidence: >80%
- Stakeholder approval: Required
```

### 🏗️ **Design Phase Execution**
```bash
# Architecture Design
Task system-architect "Design system architecture"
Task security-analyzer "Define security model"

# Specifications
Write architecture-diagram.md
Write api-specification.yaml

# Validation
- Design completeness: 100%
- Security review: Passed
- API contracts: Defined
```

### 💻 **Implementation Phase Execution**
```bash
# Code Development
Task feature-implementer "Implement core features"
Task code-enhancement-specialist "Optimize code"

# Version Control
Bash "git checkout -b feature/sdlc-implementation"
Bash "git add . && git commit -m 'feat: implement phase'"

# Validation
- Code compilation: Success
- Unit tests: >80% coverage
- Linting: No errors
```

### 🔍 **Review Phase Execution**
```bash
# Quality Analysis
Task code-quality-analyzer "Analyze code quality"
Task performance-analyzer "Performance assessment"

# Review Process
TodoWrite "Review checklist:
- [ ] Code quality score >85
- [ ] Security vulnerabilities: 0
- [ ] Performance benchmarks met"

# Validation
- Quality gate: Passed
- Review feedback: Addressed
- Approval: Obtained
```

### 🧪 **Testing Phase Execution**
```bash
# Test Execution
Task test-execution-manager "Run test suites"
Bash "npm test -- --coverage"

# Bug Management
Task issue-diagnostician "Diagnose failures"

# Validation
- Test pass rate: 100%
- Coverage: >80%
- Integration tests: Passed
```

## Execution Modes

### Standard Execution
```bash
/implement:sdlc-phase "implementation" --feature="user-auth"
```

### Fast Track Execution
```bash
/implement:sdlc-phase "testing" --mode=fast --skip-optional
```

### Thorough Execution
```bash
/implement:sdlc-phase "review" --mode=thorough --all-checks
```

## Phase Transition Management

### Completion Criteria
```json
{
  "phase": "design",
  "completion_criteria": {
    "mandatory": [
      "architecture_document",
      "api_specification",
      "database_schema"
    ],
    "optional": [
      "ui_mockups",
      "performance_model"
    ],
    "quality_gates": {
      "design_review": "approved",
      "security_assessment": "passed"
    }
  }
}
```

### Transition Validation
- Verify all mandatory outputs exist
- Confirm quality gates passed
- Document completion evidence
- Update pipeline state

## Error Handling

### Phase Failures
```
❌ **Phase Failed**: Implementation
🔍 **Failure Reason**: Unit tests failing
🔧 **Recovery Actions**:
  1. Diagnose test failures
  2. Fix identified issues
  3. Re-run validation
  4. Retry phase execution
```

### Rollback Procedures
- Restore previous phase state
- Document failure reasons
- Create recovery plan
- Notify stakeholders

Focus on efficient phase execution with comprehensive quality assurance and seamless progression through the SDLC pipeline.