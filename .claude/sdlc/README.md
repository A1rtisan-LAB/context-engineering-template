# SDLC Pipeline System

> 📚 **For comprehensive documentation, see the [SDLC Pipeline Guide](../../docs/SDLC_GUIDE.md)**

## Overview

The SDLC (Software Development Lifecycle) Pipeline System provides a structured, automated approach to managing software development through defined phases with quality gates, progress tracking, and intelligent agent orchestration.

## Quick Start

### Initialize a New Pipeline
```bash
# Start a new feature with SDLC pipeline
/sdlc "user-authentication" --init

# Use a specific template
/sdlc "payment-integration" --init --template=agile

# Check readiness before starting
/analyze:sdlc-readiness
```

### Execute Pipeline
```bash
# Run full pipeline automatically
/sdlc "user-authentication" --full

# Execute specific phase
/sdlc "user-authentication" --phase=design

# Continue from last phase
/sdlc "user-authentication" --continue
```

### Monitor Progress
```bash
# Check current status
/sdlc "user-authentication" --status

# Generate progress report
/support:sdlc-report "user-authentication"

# View pipeline metrics
/manage:sdlc-pipeline metrics "user-authentication"
```

## Pipeline Templates

### Available Templates

1. **Standard** - Traditional waterfall approach with sequential phases
2. **Agile** - Sprint-based iterative development
3. **Hotfix** - Expedited pipeline for critical issues
4. **Custom** - Create your own pipeline configuration

### Template Selection Guide

| Scenario | Recommended Template | Duration |
|----------|---------------------|----------|
| New Feature | Standard | 10-12 days |
| Sprint Development | Agile | 2 weeks |
| Bug Fix | Hotfix | 4 hours |
| POC/Prototype | Custom | Variable |

## Pipeline Phases

### Standard Pipeline Phases

1. **Planning** (1 day)
   - Requirements gathering
   - User story creation
   - Effort estimation
   - Risk assessment

2. **Design** (2 days)
   - System architecture
   - API design
   - Database schema
   - Security model

3. **Implementation** (5 days)
   - Code development
   - Unit testing
   - Documentation
   - Code review

4. **Review** (1 day)
   - Quality analysis
   - Security audit
   - Performance review
   - Best practices check

5. **Testing** (2 days)
   - Integration testing
   - E2E testing
   - Performance testing
   - User acceptance

6. **Deployment** (1 day, optional)
   - Release preparation
   - Production deployment
   - Monitoring setup
   - Documentation

## Quality Gates

Quality gates ensure standards are met before phase progression:

### Automated Gates
- Code coverage > 80%
- All tests passing
- No critical security issues
- Performance within targets
- Linting errors = 0

### Manual Gates
- Requirements approval
- Design review
- Deployment authorization

### Override Policy
```bash
# Override with justification (requires approval)
/sdlc "feature" --override-gate "emergency fix required"
```

## State Management

### Pipeline State Location
```
.claude/sdlc/
├── pipelines/          # Active pipeline states
│   └── {pipeline-id}.json
├── history/            # Completed pipelines
├── templates/          # Pipeline templates
└── config/            # Configuration files
```

### State Structure
```json
{
  "pipeline_id": "auth-2024-01",
  "feature": "user-authentication",
  "current_phase": "implementation",
  "progress": 45,
  "quality_score": 88,
  "phases_completed": ["planning", "design"],
  "estimated_completion": "2024-01-20",
  "blockers": [],
  "artifacts": {}
}
```

## Commands Reference

### Main SDLC Command
```bash
/sdlc [feature] [options]
```

Options:
- `--init` - Initialize new pipeline
- `--full` - Run complete pipeline
- `--phase=[name]` - Execute specific phase
- `--status` - Show current status
- `--continue` - Continue from last phase
- `--template=[name]` - Use specific template
- `--list` - List all pipelines

### Supporting Commands

#### Analysis
```bash
/analyze:sdlc-readiness              # Check project readiness
```

#### Implementation
```bash
/implement:sdlc-phase [phase]        # Execute specific phase
```

#### Management
```bash
/manage:sdlc-pipeline [action]       # Pipeline lifecycle management
```

#### Support
```bash
/support:sdlc-report [feature]       # Generate reports
```

## Integration

### With Orchestrate
```bash
# Use orchestrate within SDLC phases
/orchestrate "complex implementation task" --sdlc-context
```

### With Workflow-Orchestrator
```bash
# For multi-session projects
/Task workflow-orchestrator "manage long-term SDLC pipeline"
```

### With TodoWrite
```bash
# Automatic task tracking
/TodoWrite --sdlc-pipeline="user-authentication"
```

## Metrics & Reporting

### Available Metrics
- **Velocity**: Story points per day
- **Cycle Time**: Phase duration
- **Quality Score**: Overall quality metrics
- **Coverage**: Test coverage percentage
- **Defect Rate**: Bugs per phase

### Report Types
- Pipeline Status Report
- Analytics Dashboard
- Completion Summary
- Retrospective Report

### Generate Reports
```bash
# Markdown report
/support:sdlc-report "feature" --format=markdown

# Interactive dashboard
/support:sdlc-report "feature" --format=html --interactive
```

## Best Practices

1. **Always start with readiness check**
   ```bash
   /analyze:sdlc-readiness
   ```

2. **Use appropriate templates**
   - Standard for features
   - Agile for sprints
   - Hotfix for emergencies

3. **Don't skip quality gates**
   - Override only with justification
   - Document all overrides

4. **Track metrics continuously**
   - Monitor velocity trends
   - Review quality scores
   - Analyze bottlenecks

5. **Maintain documentation**
   - Update phase outputs
   - Document decisions
   - Create retrospectives

## Troubleshooting

### Common Issues

#### Pipeline Stuck
```bash
# Check blockers
/sdlc "feature" --status --verbose

# Force progression (with caution)
/manage:sdlc-pipeline force-progress "feature"
```

#### Quality Gate Failures
```bash
# Get detailed failure report
/support:sdlc-report "feature" --quality-details

# Retry phase
/implement:sdlc-phase [phase] --retry
```

#### State Corruption
```bash
# Restore from backup
/manage:sdlc-pipeline restore "feature" --from-backup

# Reinitialize pipeline
/sdlc "feature" --reinit --preserve-progress
```

## Configuration

### Global Settings
Edit `.claude/sdlc/config/default.json`:
```json
{
  "pipeline": {
    "auto_progression": false,
    "quality_gates_enabled": true
  }
}
```

### Custom Templates
Create `.claude/sdlc/templates/custom.yaml`:
```yaml
name: Custom Pipeline
phases:
  - name: your-phase
    duration: 1 day
    required: true
```

## Examples

### Complete Feature Development
```bash
# 1. Check readiness
/analyze:sdlc-readiness

# 2. Initialize pipeline
/sdlc "shopping-cart" --init --template=standard

# 3. Run planning phase
/sdlc "shopping-cart" --phase=planning

# 4. Continue through phases
/sdlc "shopping-cart" --continue

# 5. Monitor progress
/sdlc "shopping-cart" --status

# 6. Generate final report
/support:sdlc-report "shopping-cart" --format=markdown
```

### Sprint Development
```bash
# Initialize sprint
/sdlc "sprint-23" --init --template=agile

# Daily execution
/sdlc "sprint-23" --daily-cycle

# Sprint review
/sdlc "sprint-23" --phase=sprint-review

# Retrospective
/sdlc "sprint-23" --phase=retrospective
```

### Emergency Hotfix
```bash
# Quick fix pipeline
/sdlc "critical-bug-fix" --init --template=hotfix --auto

# Monitor closely
/sdlc "critical-bug-fix" --watch

# Post-mortem
/support:sdlc-report "critical-bug-fix" --post-mortem
```

## Support

For issues or questions about the SDLC Pipeline System:
1. Check this README
2. Review pipeline logs in `.claude/sdlc/logs/`
3. Use `/support:explain sdlc-pipeline` for detailed help
4. Contact the development team

---

*The SDLC Pipeline System ensures consistent, high-quality software delivery through structured processes and intelligent automation.*