# SDLC Pipeline Workflow

## 🎯 Software Development Lifecycle Pipeline

### Complete SDLC Execution Framework
Systematic development process with phase-based progression, quality gates, and automated agent orchestration.

```bash
# Full Pipeline Execution
/sdlc [feature-name] --full

# Phase-by-phase Execution
/sdlc [feature-name] --phase=planning
/sdlc [feature-name] --phase=design
/sdlc [feature-name] --phase=implementation
/sdlc [feature-name] --phase=review
/sdlc [feature-name] --phase=testing
/sdlc [feature-name] --phase=deployment
```

---

## 📋 Phase 1: Planning & Requirements

### Workflow Sequence
```bash
# Requirements Analysis
/analyze:project-context . --focus=feature-requirements →
/support:estimate [feature-complexity] →
/Task prd-workflow-generator "Convert requirements to actionable workflow" →
/support:document [requirements-specification]

# Success Criteria Definition
/TodoWrite "Planning Phase Checklist:
- [ ] Clear problem statement defined
- [ ] User stories documented
- [ ] Acceptance criteria specified
- [ ] Dependencies identified
- [ ] Time estimates validated
- [ ] Risks assessed"
```

### Quality Gate: Planning Approval
```
✅ Requirements document complete
✅ Estimates reviewed and approved
✅ Dependencies mapped
✅ Success metrics defined
```

---

## 🏗️ Phase 2: System Design

### Workflow Sequence
```bash
# Architecture Design
/Task system-architect "Design system architecture for [feature]" →
/analyze:architecture . --impact-assessment →
/analyze:security [design-security-requirements] →
/support:document [architecture-decisions]

# Technical Specifications
/TodoWrite "Design Phase Checklist:
- [ ] System architecture diagram created
- [ ] API contracts defined
- [ ] Database schema designed
- [ ] Security model established
- [ ] Integration points identified
- [ ] Performance targets set"
```

### Quality Gate: Design Review
```
✅ Architecture approved by team
✅ API specifications complete
✅ Security requirements met
✅ Scalability considered
```

---

## 💻 Phase 3: Implementation

### Workflow Sequence
```bash
# Core Development
/Task feature-implementer "Implement [feature] core functionality" →
/implement:enhancement [code-optimization] →
/implement:cleanup [technical-debt] →
/manage:git [feature-commits]

# Development Tracking
/TodoWrite "Implementation Phase Checklist:
- [ ] Core functionality implemented
- [ ] Unit tests written
- [ ] Code documented
- [ ] Error handling added
- [ ] Logging implemented
- [ ] Configuration externalized"
```

### Quality Gate: Code Complete
```
✅ All features implemented
✅ Unit tests passing (>80% coverage)
✅ No compilation errors
✅ Documentation updated
```

---

## 🔍 Phase 4: Quality Review

### Workflow Sequence
```bash
# Comprehensive Review
/analyze:code-quality [feature-code] →
/analyze:security [vulnerability-scan] →
/analyze:performance [performance-metrics] →
/Task code-quality-analyzer "Generate quality report"

# Review Checklist
/TodoWrite "Review Phase Checklist:
- [ ] Code review completed
- [ ] Security audit passed
- [ ] Performance benchmarks met
- [ ] Best practices followed
- [ ] No critical issues
- [ ] Technical debt documented"
```

### Quality Gate: Review Approval
```
✅ Code quality score > 85%
✅ No critical security vulnerabilities
✅ Performance within targets
✅ Peer review completed
```

---

## 🧪 Phase 5: Testing & Validation

### Workflow Sequence
```bash
# Test Execution
/manage:test [comprehensive-test-suite] →
/Task test-execution-manager "Run integration tests" →
/support:diagnose [test-failures] →
/manage:build [test-build]

# Testing Coverage
/TodoWrite "Testing Phase Checklist:
- [ ] Unit tests executed
- [ ] Integration tests passed
- [ ] E2E tests completed
- [ ] Performance tests run
- [ ] Security tests passed
- [ ] User acceptance testing"
```

### Quality Gate: Testing Complete
```
✅ All tests passing
✅ Code coverage > 80%
✅ No critical bugs
✅ Performance validated
```

---

## 🚀 Phase 6: Deployment & Release

### Workflow Sequence
```bash
# Deployment Preparation
/manage:build [production-build] →
/manage:git [release-tagging] →
/support:document [release-notes] →
/Task build-packager "Create deployment package"

# Deployment Checklist
/TodoWrite "Deployment Phase Checklist:
- [ ] Build artifacts created
- [ ] Release notes documented
- [ ] Deployment scripts tested
- [ ] Rollback plan prepared
- [ ] Monitoring configured
- [ ] Documentation published"
```

### Quality Gate: Deployment Ready
```
✅ Production build successful
✅ All tests in production environment
✅ Rollback procedure tested
✅ Monitoring active
```

---

## 📝 Phase 7: Documentation & Knowledge Management

### Workflow Sequence
```bash
# Documentation Update
/Task project-knowledge-curator "Update comprehensive documentation" →
/Task focused-doc-generator "Generate API documentation" →
/support:document [changelog-update] →
/support:document [user-guide-update]

# Documentation Checklist
/TodoWrite "Documentation Phase Checklist:
- [ ] README.md updated with latest features
- [ ] API documentation complete
- [ ] docs/changelog/CHANGELOG.md updated
- [ ] User guide reflects current functionality
- [ ] Code examples tested and updated
- [ ] Troubleshooting guide updated
- [ ] Architecture diagrams current
- [ ] Configuration documentation complete"
```

### Quality Gate: Documentation Complete
```
✅ All public APIs documented
✅ README reflects current state
✅ Changelog includes all changes
✅ Examples run successfully
✅ No outdated information
```

### Documentation Artifacts
```bash
# Generate comprehensive documentation
/orchestrate "generate complete project documentation including API reference, user guides, and examples"

# Validate documentation
/analyze:code-quality --check-documentation
/Bash "npm run docs:validate" # If documentation validation script exists

# Publish documentation
/manage:git "commit documentation updates"
```

---

## 🔄 Pipeline Orchestration Patterns

### Sequential Execution
```bash
# Traditional waterfall approach
/sdlc "feature" --mode=sequential --phases=all
```

### Iterative Development
```bash
# Agile sprint-based approach
/sdlc "feature" --mode=iterative --sprint=2-weeks
```

### Parallel Phases
```bash
# Concurrent phase execution where possible
/sdlc "feature" --mode=parallel --phases=design,prototype
```

### Fast Track
```bash
# Expedited pipeline for hotfixes
/sdlc "hotfix" --mode=fast-track --skip-approval
```

---

## 📊 Pipeline Monitoring & Reporting

### Progress Tracking
```bash
# Real-time status
/sdlc "feature" --status --watch

# Progress dashboard
/orchestrate "generate SDLC dashboard for feature"

# Velocity metrics
/support:document [sdlc-metrics-report]
```

### Quality Metrics
```bash
# Quality scorecard
/analyze:code-quality --sdlc-metrics

# Cumulative metrics
/orchestrate "analyze SDLC pipeline efficiency"
```

---

## 🎯 Templates & Configurations

### API Development Pipeline
```yaml
name: api-sdlc
phases:
  - planning:
      focus: "API requirements, endpoints, data models"
      duration: "1 day"
  - design:
      focus: "OpenAPI spec, database schema, auth strategy"
      duration: "2 days"
  - implementation:
      focus: "Controllers, services, models, middleware"
      duration: "5 days"
  - review:
      focus: "API testing, security, performance"
      duration: "1 day"
  - testing:
      focus: "Integration tests, load testing, security testing"
      duration: "2 days"
```

### Frontend Pipeline
```yaml
name: frontend-sdlc
phases:
  - planning:
      focus: "UI/UX requirements, user flows, wireframes"
      duration: "2 days"
  - design:
      focus: "Component architecture, state management, routing"
      duration: "2 days"
  - implementation:
      focus: "Components, hooks, styling, integration"
      duration: "5 days"
  - review:
      focus: "Accessibility, performance, code quality"
      duration: "1 day"
  - testing:
      focus: "Unit tests, E2E tests, visual regression"
      duration: "2 days"
```

### Microservice Pipeline
```yaml
name: microservice-sdlc
phases:
  - planning:
      focus: "Service boundaries, communication, data flow"
      duration: "2 days"
  - design:
      focus: "Service contracts, event schemas, persistence"
      duration: "3 days"
  - implementation:
      focus: "Service logic, messaging, data layer"
      duration: "5 days"
  - review:
      focus: "Service isolation, fault tolerance, observability"
      duration: "2 days"
  - testing:
      focus: "Contract testing, chaos testing, performance"
      duration: "3 days"
```

---

## 🚨 Exception Handling

### Pipeline Failures
```bash
# Rollback to previous phase
/sdlc "feature" --rollback

# Skip failing quality gate (with justification)
/sdlc "feature" --override-gate "emergency fix required"

# Pause pipeline
/sdlc "feature" --pause "waiting for external dependency"

# Resume pipeline
/sdlc "feature" --resume
```

### Recovery Procedures
```bash
# Restart failed phase
/sdlc "feature" --restart-phase=testing

# Restore from checkpoint
/sdlc "feature" --restore-checkpoint="phase-3-complete"

# Force completion (dangerous)
/sdlc "feature" --force-complete "manual validation performed"
```

---

## 📈 Continuous Improvement

### Pipeline Analytics
```bash
# Analyze pipeline performance
/orchestrate "analyze SDLC pipeline metrics and identify bottlenecks"

# Generate improvement recommendations
/support:explain [sdlc-optimization-opportunities]

# Update pipeline configuration
/implement:enhancement [sdlc-pipeline-improvements]
```

### Retrospectives
```bash
# Phase retrospective
/support:document [phase-retrospective-report]

# Full pipeline retrospective
/orchestrate "conduct SDLC pipeline retrospective and generate learnings"

# Apply learnings
/implement:enhancement [pipeline-optimizations]
```

---

*This SDLC Pipeline Workflow provides a comprehensive, systematic approach to software development with built-in quality assurance, progress tracking, and intelligent automation. Adapt phases and configurations based on project requirements and team preferences.*