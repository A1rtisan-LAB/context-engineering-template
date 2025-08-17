# PRD (Product Requirements Document) Guide

## Table of Contents
1. [Overview](#overview)
2. [Why PRD-First Development](#why-prd-first-development)
3. [PRD Lifecycle](#prd-lifecycle)
4. [Creating Your First PRD](#creating-your-first-prd)
5. [PRD Templates](#prd-templates)
6. [PRD Commands](#prd-commands)
7. [Language Support](#language-support)
8. [Integration with SDLC](#integration-with-sdlc)
9. [Best Practices](#best-practices)
10. [Troubleshooting](#troubleshooting)

## Overview

The PRD (Product Requirements Document) system provides a structured approach to defining, reviewing, and managing feature requirements before development begins. It ensures clear communication, reduces development rework, and maintains alignment between business needs and technical implementation.

### Key Benefits
- **Clear Requirements**: Define what needs to be built before coding starts
- **Quality Gates**: Review and approval process ensures completeness
- **Automatic Translation**: Korean PRDs are automatically translated to English
- **SDLC Integration**: Approved PRDs automatically trigger development pipelines
- **Documentation Trail**: Complete history from idea to implementation

## Why PRD-First Development

### Traditional Approach Problems
- Unclear requirements lead to rework
- Scope creep during development
- Misalignment between stakeholders
- Missing non-functional requirements
- Inadequate success metrics

### PRD-First Solutions
- **Requirements Clarity**: All requirements documented upfront
- **Stakeholder Alignment**: Review process ensures consensus
- **Scope Control**: Clear boundaries defined
- **Success Metrics**: Measurable outcomes specified
- **Risk Mitigation**: Issues identified early

## PRD Lifecycle

The PRD follows a structured lifecycle with clear state transitions:

```mermaid
graph LR
    Draft --> Review
    Review --> Approved
    Review --> Draft
    Approved --> InDevelopment[In Development]
    InDevelopment --> Completed
    Completed --> Archived
```

### States Explained

| State | Description | Next Actions |
|-------|-------------|--------------|
| **Draft** | PRD being written | Submit for review |
| **Review** | Under quality review | Approve or request changes |
| **Approved** | Ready for development | Start SDLC pipeline |
| **In Development** | Being implemented | Track progress |
| **Completed** | Development finished | Archive and document |
| **Archived** | Historical record | Reference only |

## Creating Your First PRD

### Step 1: Initialize PRD
```bash
/manage:prd create "feature-name" --template=api
```

This creates a new PRD in `docs/prd/draft/` with the appropriate template.

### Step 2: Fill Out the Template
Edit the generated PRD file with:
- Executive summary
- Problem statement
- Goals and success metrics
- Requirements (functional and non-functional)
- Technical specifications
- Dependencies and risks
- Timeline and milestones

### Step 3: Submit for Review
```bash
/manage:prd move "feature-name" --to=review
```

### Step 4: Review Process
```bash
/support:prd-review "feature-name"
```

This generates a comprehensive review report with:
- Completeness score (0-100)
- Clarity assessment
- Technical feasibility
- Risk analysis
- Required improvements

### Step 5: Approval
```bash
/manage:prd approve "feature-name"
```

This:
1. Moves PRD to `approved/` directory
2. Automatically initializes SDLC pipeline
3. Creates development tasks from requirements
4. Sets up progress tracking

## PRD Templates

### Available Templates

| Template | Use Case | Key Sections |
|----------|----------|--------------|
| **standard** | General features | Basic structure for any feature |
| **api** | Backend services | Endpoints, data models, authentication |
| **frontend** | UI features | UX flows, components, interactions |
| **fullstack** | End-to-end features | Complete stack specifications |

### Template Selection
```bash
# Basic features
/manage:prd create "feature" --template=standard

# API development
/manage:prd create "api-feature" --template=api

# Frontend features
/manage:prd create "ui-feature" --template=frontend

# Full-stack features
/manage:prd create "complete-feature" --template=fullstack
```

### Template Structure
All templates include:
- **Executive Summary**: High-level overview
- **Problem Statement**: What problem are we solving
- **Goals & Metrics**: Success criteria
- **Requirements**: Detailed specifications
- **Technical Design**: Implementation approach
- **Timeline**: Development phases
- **Risks**: Potential issues and mitigation

## PRD Commands

### Management Commands

#### Create PRD
```bash
/manage:prd create "feature-name" [options]
Options:
  --template    Template type (standard/api/frontend/fullstack)
```

#### Check Status
```bash
/manage:prd status "feature-name"
```
Shows current state, location, and metadata.

#### List PRDs
```bash
/manage:prd list --status=draft      # List draft PRDs
/manage:prd list --status=approved   # List approved PRDs
/manage:prd list --all               # List all PRDs
```

#### Move Between States
```bash
/manage:prd move "feature-name" --to=review
/manage:prd move "feature-name" --to=approved
```

#### Approve PRD
```bash
/manage:prd approve "feature-name"
```
Approves PRD and triggers SDLC pipeline.

#### Archive PRD
```bash
/manage:prd archive "feature-name"
```
Moves completed PRD to archive with timestamp.

### Review Commands

#### Comprehensive Review
```bash
/support:prd-review "feature-name"
```
Generates detailed review report.

#### Quick Review
```bash
/support:prd-review "feature-name" --quick
```
Fast validation of critical items only.

#### Auto-fix Issues
```bash
/support:prd-review "feature-name" --auto-fix
```
Automatically fixes formatting and minor issues.

## Language Support

### Automatic Translation
The PRD system supports automatic Korean to English translation:

1. **Write in Korean**: Create PRD in Korean if preferred
2. **Automatic Detection**: System detects language
3. **Translation**: Korean content is translated to English
4. **Preservation**: Original Korean version is saved
5. **Primary Document**: English version becomes primary

### How It Works
```javascript
// When PRD is saved
if (language === 'korean') {
  translateToEnglish(content);
  save('feature_original_ko.md');  // Korean original
  save('feature.md');               // English translation
}
```

### Translation Quality
- Technical terms preserved
- Code examples unchanged
- Formatting maintained
- Manual review recommended for critical PRDs

## Integration with SDLC

### Automatic Pipeline Trigger
When a PRD is approved:
```bash
/manage:prd approve "feature-name"
# Automatically executes:
# /sdlc "feature-name" --init --from-prd
```

### PRD to Task Conversion
Requirements are automatically converted to development tasks:
- Functional requirements → Implementation tasks
- Non-functional requirements → Quality criteria
- Success metrics → Test scenarios
- Timeline → Sprint planning

### Progress Tracking
```bash
/manage:prd status "feature-name"
```
Shows:
- Current SDLC phase
- Completion percentage
- Blockers and issues
- Estimated completion

### Documentation Updates
Upon completion:
- Release notes generated from PRD
- User guides updated
- API documentation created
- PRD archived with metrics

## Best Practices

### Writing Effective PRDs

#### DO:
✅ **Be Specific**: Use concrete, measurable requirements  
✅ **Include Examples**: Provide use cases and scenarios  
✅ **Define Success**: Clear, measurable success metrics  
✅ **Consider Edge Cases**: Document error scenarios  
✅ **Specify NFRs**: Performance, security, scalability  

#### DON'T:
❌ **Be Vague**: Avoid "fast", "user-friendly", "scalable"  
❌ **Skip Sections**: All sections have purpose  
❌ **Mix Implementation**: Separate what from how  
❌ **Ignore Dependencies**: Document all dependencies  
❌ **Forget Rollback**: Include rollback plans  

### Review Process

#### Review Checklist
- [ ] All sections complete
- [ ] Requirements are SMART (Specific, Measurable, Achievable, Relevant, Time-bound)
- [ ] Success metrics defined
- [ ] Technical feasibility confirmed
- [ ] Risks identified and mitigated
- [ ] Dependencies documented
- [ ] Timeline realistic
- [ ] Acceptance criteria clear

### Scoring Guidelines

| Score Range | Status | Action |
|------------|--------|--------|
| 90-100 | Excellent | Ready for approval |
| 80-89 | Good | Minor improvements needed |
| 70-79 | Fair | Significant improvements required |
| Below 70 | Poor | Major revision needed |

## Troubleshooting

### Common Issues

#### PRD Not Found
```bash
Error: PRD 'feature-name' not found
```
**Solution**: Check PRD name and current directory. Use `/manage:prd list --all` to see available PRDs.

#### Review Score Too Low
```bash
Review Score: 65/100 - Revision Required
```
**Solution**: Address identified issues, particularly:
- Missing requirements
- Vague success metrics
- Incomplete technical specifications

#### Translation Issues
```bash
Warning: Translation quality may need review
```
**Solution**: Review translated PRD manually, especially technical terms.

#### SDLC Integration Failed
```bash
Error: Failed to initialize SDLC pipeline
```
**Solution**: Ensure PRD is approved and use `/sdlc "feature-name" --init --from-prd` manually.

### Getting Help

#### Check PRD Status
```bash
/manage:prd status "feature-name"
```

#### List All Commands
```bash
/manage:prd --help
/support:prd-review --help
```

#### View PRD Location
```bash
/manage:prd list --all
```
Shows all PRDs with their current locations and states.

## Advanced Topics

### Custom Templates
Create custom PRD templates in `docs/prd/.config/templates/`:
1. Copy existing template
2. Modify for your needs
3. Use with `--template=custom`

### Bulk Operations
```bash
# Review all draft PRDs
for prd in $(ls docs/prd/draft/); do
  /support:prd-review "${prd%.md}"
done
```

### Integration with CI/CD
PRDs can trigger automated workflows:
- GitHub Actions on PRD approval
- Jenkins pipeline initialization
- JIRA ticket creation
- Slack notifications

### Metrics Collection
Track PRD metrics:
- Time from draft to approval
- Number of review iterations
- Requirements change frequency
- Success rate of approved PRDs

## Examples

### Complete PRD Workflow
```bash
# 1. Create PRD for authentication feature
/manage:prd create "user-authentication" --template=api

# 2. Edit PRD (manual step)
# Fill out all sections in docs/prd/draft/user-authentication.md

# 3. Submit for review
/manage:prd move "user-authentication" --to=review

# 4. Run review
/support:prd-review "user-authentication"

# 5. If score >= 80, approve
/manage:prd approve "user-authentication"

# 6. SDLC automatically starts
# Development proceeds...

# 7. After completion, archive
/manage:prd archive "user-authentication"
```

### API PRD Example
```markdown
# PRD: User Authentication API

## Executive Summary
**Feature**: RESTful API for user authentication
**Priority**: P0
**Target Release**: v2.0.0

## Problem Statement
Current system lacks secure user authentication...

## Requirements
### Functional Requirements
- FR1: JWT-based authentication
- FR2: OAuth2 social login support
- FR3: Password reset flow

### Non-Functional Requirements
- Response time < 200ms
- Support 10,000 concurrent users
- 99.9% availability
```

## Conclusion

The PRD system transforms ad-hoc development into a structured, predictable process. By starting with clear requirements, teams can:
- Reduce development rework
- Improve stakeholder alignment
- Deliver features that meet business needs
- Maintain comprehensive documentation
- Track success metrics effectively

Start your next feature with a PRD and experience the benefits of requirements-driven development!