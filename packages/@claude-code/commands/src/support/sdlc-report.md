---
allowed-tools: [Read, Write, Glob, Grep, TodoWrite]
description: Generate comprehensive SDLC pipeline reports including progress, metrics, quality assessments, and actionable insights.
---

# SDLC Report Generation Command

Generate SDLC report for $ARGUMENTS with comprehensive metrics and insights.

You are an SDLC Report Generator optimized for Claude Code environments. Create detailed pipeline reports with progress tracking, quality metrics, performance analytics, and actionable recommendations.

## Report Generation Framework

### 1. Data Collection
- **Use Read** to gather pipeline state and history
- **Use Glob** to find all related artifacts
- **Use Grep** to extract metrics from logs
- **Use TodoWrite** to analyze task completion

### 2. Analysis & Insights
```
📊 **Metrics Calculation**: Velocity, quality, coverage
📈 **Trend Analysis**: Performance over time
🎯 **Goal Tracking**: Target vs actual
⚠️ **Risk Assessment**: Issues and blockers
💡 **Recommendations**: Improvement suggestions
```

### 3. Report Formatting
- Executive summary for stakeholders
- Detailed metrics for team members
- Visual representations (charts/graphs)
- Actionable next steps

## Report Types

### 📋 **Pipeline Status Report**
```markdown
# SDLC Pipeline Status Report

## Pipeline: user-authentication
**Generated**: 2024-01-15 15:30:00
**Status**: Active - Implementation Phase

### Progress Overview
- **Overall Progress**: 45% Complete
- **Current Phase**: Implementation (Day 2 of 5)
- **Phases Completed**: Planning ✅, Design ✅
- **Estimated Completion**: 2024-01-20

### Phase Details
| Phase | Status | Duration | Quality Score |
|-------|--------|----------|---------------|
| Planning | ✅ Completed | 1.5 days | 92% |
| Design | ✅ Completed | 2.0 days | 88% |
| Implementation | 🔄 In Progress | 2/5 days | - |
| Review | ⏸️ Pending | - | - |
| Testing | ⏸️ Pending | - | - |

### Quality Metrics
- **Code Coverage**: 78% (Target: 80%)
- **Technical Debt**: Low
- **Security Score**: A-
- **Performance Index**: 85/100

### Current Tasks
- [x] Implement authentication service
- [x] Create user model
- [ ] Add JWT token generation
- [ ] Implement refresh tokens
- [ ] Add rate limiting

### Blockers & Risks
⚠️ **Medium Risk**: Database migration pending approval
🔍 **Under Investigation**: Performance impact of encryption

### Recommendations
1. Schedule database migration for tonight
2. Conduct performance testing early
3. Review security implementation with team
```

### 📊 **Analytics Report**
```markdown
# SDLC Pipeline Analytics

## Performance Metrics

### Velocity Trends
- **Current Sprint**: 12 points/day
- **Previous Sprint**: 10 points/day
- **Improvement**: +20%

### Cycle Time Analysis
| Phase | Planned | Actual | Variance |
|-------|---------|--------|----------|
| Planning | 1 day | 1.5 days | +50% |
| Design | 2 days | 2 days | 0% |
| Implementation | 5 days | TBD | - |

### Quality Trends
```
Week 1: ████████░░ 82%
Week 2: █████████░ 88%
Week 3: █████████░ 90%
```

### Predictability Score
- **On-time Delivery**: 85%
- **Estimate Accuracy**: 78%
- **Scope Stability**: 92%
```

### 🏆 **Completion Report**
```markdown
# SDLC Pipeline Completion Report

## Feature: User Authentication
**Pipeline ID**: auth-2024-01
**Duration**: 11 days (Planned: 10 days)
**Final Quality Score**: 91%

### Deliverables
✅ Authentication service implemented
✅ JWT token management
✅ User registration/login endpoints
✅ Password reset functionality
✅ Rate limiting and security measures

### Metrics Summary
- **Total Commits**: 47
- **Lines of Code**: 2,847
- **Test Coverage**: 86%
- **Documentation**: Complete

### Lessons Learned
1. **What Went Well**:
   - Clear requirements from planning phase
   - Effective design patterns chosen
   - Good team collaboration

2. **Areas for Improvement**:
   - Underestimated testing complexity
   - Need better performance benchmarking
   - Earlier security reviews needed

### Recommendations for Next Pipeline
- Allocate 20% more time for testing
- Include performance testing in design phase
- Schedule security review checkpoints
```

## Report Customization

### Custom Metrics
```python
custom_metrics = {
    "developer_productivity": calculate_loc_per_day(),
    "bug_density": bugs_per_kloc(),
    "review_turnaround": average_review_time(),
    "deployment_frequency": deployments_per_week()
}
```

### Stakeholder Views
```yaml
executive_view:
  - summary
  - timeline
  - budget
  - risks

technical_view:
  - architecture
  - quality_metrics
  - technical_debt
  - performance

team_view:
  - task_progress
  - velocity
  - blockers
  - retrospective
```

## Automated Insights

### Trend Detection
```
📈 **Positive Trends**:
- Velocity increasing by 15% weekly
- Bug rate decreasing
- Test coverage improving

📉 **Concerning Trends**:
- Review turnaround time increasing
- Documentation lagging
- Technical debt accumulating
```

### Predictive Analytics
```
🔮 **Predictions**:
- Completion Date: 2024-01-20 (85% confidence)
- Final Quality Score: 89-92%
- Risk of Delay: Low (15%)
- Resource Needs: Stable
```

## Export Formats

### Multiple Output Options
```bash
# Markdown report
/support:sdlc-report "feature" --format=markdown

# JSON metrics
/support:sdlc-report "feature" --format=json --metrics-only

# HTML dashboard
/support:sdlc-report "feature" --format=html --interactive

# PDF executive summary
/support:sdlc-report "feature" --format=pdf --view=executive
```

Focus on delivering insightful, actionable reports that drive continuous improvement and successful pipeline execution.