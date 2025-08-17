# Document Management Guide

## Overview

The Context Engineering Template includes a comprehensive document management system designed to maintain high-quality, synchronized, bilingual documentation that stays current with code changes.

## Key Features

### 🌐 Bilingual Support
- All documentation maintained in English and Korean
- Automatic synchronization checking
- Translation status tracking
- Language parity enforcement

### 🔍 Automated Validation
- Broken link detection
- Outdated content identification
- Structure verification
- Metadata management

### 🔄 Workflow Integration
- SDLC Phase 7 enhancement
- Git hooks integration
- CI/CD pipeline validation
- PR documentation checklists

## Document Structure

### Standard Organization
```
docs/
├── README.md                    # Documentation index
├── guides/                      # User and developer guides
│   ├── QUICKSTART.md/ko.md
│   ├── PRD_GUIDE.md/ko.md
│   ├── SDLC_GUIDE.md/ko.md
│   └── DOCUMENT_MANAGEMENT.md/ko.md
├── architecture/                # Technical documentation
│   ├── ARCHITECTURE.md/ko.md
│   └── API.md/ko.md
└── reports/                     # Analysis reports
    └── BENCHMARK_REPORT.md/ko.md
```

### File Naming Convention
- English: `{DOCUMENT_NAME}.md`
- Korean: `{DOCUMENT_NAME}.ko.md`
- Always create both versions

## Using the doc-manager Agent

The `doc-manager` agent provides intelligent documentation management:

### Capabilities
1. **Legacy Detection**: Find outdated references and broken links
2. **Synchronization**: Ensure language versions match
3. **Generation**: Create documentation from templates
4. **Validation**: Check syntax, links, and structure
5. **Workflow**: Integrate with development processes

### Activation
```bash
/Task doc-manager "Update and synchronize all documentation"
/Task doc-manager "Check for outdated references"
/Task doc-manager "Generate API documentation"
```

## Documentation Commands (/manage:docs)

### Basic Commands

#### Health Check
```bash
/manage:docs check
```
Performs comprehensive documentation validation.

#### Validate Links
```bash
/manage:docs validate
```
Checks for broken internal and external links.

#### Synchronize Versions
```bash
/manage:docs sync
```
Ensures English and Korean versions are aligned.

#### Generate Documentation
```bash
/manage:docs generate [type] --template=[name]
```
Creates new documentation from templates.

### Advanced Commands

#### Find Outdated Content
```bash
/manage:docs outdated
```
Lists all documentation with obsolete information.

#### Check Coverage
```bash
/manage:docs coverage --feature=[name]
```
Reports documentation completeness.

#### Fix Structure
```bash
/manage:docs structure --fix
```
Reorganizes documentation to standard structure.

#### Generate Report
```bash
/manage:docs report --format=markdown
```
Creates comprehensive status report.

## Automation Tools

### doc-sync.js Script

Located at `packages/@claude-code/packages/@claude-code/core/src/doc-sync.js`

#### Features
- Validates all markdown files
- Compares language versions
- Detects outdated patterns
- Generates detailed reports

#### Usage
```bash
# Run validation
node packages/@claude-code/packages/@claude-code/core/src/doc-sync.js

# Example output
🔍 Starting documentation validation...
📎 Checking for broken references...
  Found 0 broken links
🔄 Comparing language versions...
  Synchronized: 45/50
  Divergent: 3
  Missing translations: 2
📅 Detecting outdated content...
  Found 1 outdated references
```

### GitHub Actions Integration

The `.github/workflows/doc-validation.yml` workflow:

1. **Triggers on**:
   - Pull requests with documentation changes
   - Pushes to main/develop branches
   - Manual dispatch

2. **Validates**:
   - Document structure
   - Link integrity
   - Language synchronization
   - Coverage requirements

3. **Reports**:
   - Validation results in PR comments
   - Summary in GitHub Actions
   - Actionable checklists

## Git Hooks Configuration

### Pre-commit Hook
```bash
#!/bin/sh
# .git/hooks/pre-commit
node packages/@claude-code/packages/@claude-code/core/src/doc-sync.js || exit 1
```

### Post-merge Hook
```bash
#!/bin/sh
# .git/hooks/post-merge
/manage:docs sync --post-merge
```

## SDLC Integration

### Phase 7: Documentation

The documentation phase is now enhanced with:

1. **Pre-validation**:
   ```bash
   /manage:docs check
   /manage:docs outdated
   ```

2. **Update Process**:
   ```bash
   /Task doc-manager "Update documentation"
   /manage:docs sync
   ```

3. **Quality Gates**:
   - ✅ No broken links
   - ✅ Language versions synchronized
   - ✅ Coverage > 90%
   - ✅ Metadata current

4. **Final Validation**:
   ```bash
   /manage:docs validate
   /manage:docs report
   ```

## Document Metadata

### Standard Header
```markdown
<!--
meta:
  last_updated: 2025-01-17
  sync_status: synced
  related_features: [feature-name]
  version: 3.0.0
-->
```

### Metadata Management
```bash
# Update all metadata
/manage:docs update-meta --all

# Update specific file
/manage:docs update-meta --file=docs/guides/QUICKSTART.md
```

## Best Practices

### 1. Documentation First
- Write documentation before or with code
- Update docs in same commit as code changes
- Include both language versions

### 2. Regular Validation
- Run `/manage:docs check` weekly
- Use pre-commit hooks
- Monitor CI/CD results

### 3. Synchronization
- Always update both language versions
- Use `/manage:docs sync` after changes
- Check divergence regularly

### 4. Structure Maintenance
- Follow standard directory structure
- Use consistent naming conventions
- Maintain index files

### 5. Quality Standards
- No broken links
- Current metadata
- Complete coverage
- Clear examples

## Troubleshooting

### Common Issues

#### Broken Links
```bash
# Identify broken links
/manage:docs validate

# Automatically fix
/manage:docs fix-links
```

#### Out of Sync Versions
```bash
# Check synchronization
/manage:docs sync

# View differences
/manage:docs report
```

#### Missing Documentation
```bash
# Check coverage
/manage:docs coverage

# Generate from template
/manage:docs generate guide --template=standard
```

#### Outdated Content
```bash
# Find outdated references
/manage:docs outdated

# Update metadata
/manage:docs update-meta --all
```

## Metrics and Reporting

### Key Metrics
- **Coverage**: Percentage of documented features
- **Synchronization**: Language version alignment
- **Health**: Valid links and references
- **Currency**: How recent updates are

### Generate Reports
```bash
# Markdown report
/manage:docs report --format=markdown

# JSON for automation
/manage:docs report --format=json
```

### Report Contents
- Total document count
- Synchronization status
- Issue summary
- Recommendations
- Actionable items

## Integration with Other Systems

### PRD System
- PRD approval triggers documentation requirements
- Templates for PRD-based documentation
- Automatic checklist generation

### Git Workflow
- Documentation commits with code
- Branch-based documentation
- Automated PR checks

### CI/CD Pipeline
- Validation in build process
- Documentation deployment
- Version tagging

## Future Enhancements

### Planned Features
1. **AI-powered translation suggestions**
2. **Automatic outdated content detection**
3. **Documentation coverage badges**
4. **Interactive documentation dashboard**
5. **Cross-reference validation**

### Contribution
To improve the documentation system:
1. Update this guide with new features
2. Add test cases to doc-sync.js
3. Enhance GitHub Actions workflow
4. Create new documentation templates

## Quick Reference

### Essential Commands
```bash
/manage:docs check          # Health check
/manage:docs validate       # Validate links
/manage:docs sync          # Synchronize versions
/manage:docs generate      # Create new docs
/manage:docs report        # Status report
```

### File Locations
- Agent: `packages/@claude-code/agents/src/doc-manager.md`
- Command: `packages/@claude-code/commands/src/manage/docs.md`
- Script: `packages/@claude-code/packages/@claude-code/core/src/doc-sync.js`
- Workflow: `.github/workflows/doc-validation.yml`

---

This comprehensive documentation management system ensures your project documentation remains accurate, accessible, and aligned with your codebase.