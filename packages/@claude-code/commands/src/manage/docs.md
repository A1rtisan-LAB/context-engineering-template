# /manage:docs

## Purpose
Comprehensive documentation management command for maintaining high-quality, synchronized, and up-to-date project documentation.

## Syntax
```
/manage:docs [action] [options]
```

## Actions

### check
Perform a comprehensive documentation health check.
```
/manage:docs check
```
- Validates all documentation
- Checks for broken links
- Verifies language synchronization
- Reports documentation coverage

### validate
Validate documentation for broken links and references.
```
/manage:docs validate [--pre-commit] [--pr=<number>]
```
- `--pre-commit`: Run as pre-commit validation
- `--pr=<number>`: Validate changes in specific PR

### sync
Synchronize English and Korean documentation versions.
```
/manage:docs sync [--post-merge]
```
- Compares document structures
- Identifies divergent content
- Reports synchronization status
- `--post-merge`: Run after git merge

### generate
Generate documentation from templates or code.
```
/manage:docs generate [type] [--template=<name>]
```
- `type`: Type of documentation (api, guide, architecture)
- `--template`: Specific template to use

### outdated
List all outdated documentation.
```
/manage:docs outdated
```
- Finds documents with old references
- Identifies stale content
- Reports documents needing updates

### coverage
Report documentation coverage for the project.
```
/manage:docs coverage [--feature=<name>]
```
- Shows percentage of documented features
- Lists undocumented APIs
- `--feature`: Check specific feature coverage

### structure
Analyze and reorganize documentation structure.
```
/manage:docs structure [--check] [--fix]
```
- `--check`: Only check structure without changes
- `--fix`: Automatically reorganize to standard structure

### report
Generate comprehensive documentation status report.
```
/manage:docs report [--format=<type>]
```
- `--format`: Output format (markdown, json, html)
- Includes all metrics and issues
- Provides actionable recommendations

### fix-links
Automatically fix broken internal links.
```
/manage:docs fix-links [--dry-run]
```
- `--dry-run`: Show what would be fixed without making changes
- Updates relative paths
- Fixes moved document references

### update-meta
Update document metadata (last_updated, version, etc.).
```
/manage:docs update-meta [--all] [--file=<path>]
```
- `--all`: Update all documents
- `--file`: Update specific file

### cleanup
Remove orphaned and obsolete documentation.
```
/manage:docs cleanup [--dry-run]
```
- Identifies unused documents
- Removes broken references
- `--dry-run`: Preview without deletion

### requirements
Generate documentation requirements for a feature.
```
/manage:docs requirements --feature=<name>
```
- Lists required documentation
- Creates templates
- Integrates with SDLC Phase 7

### checklist
Generate documentation checklist for PRs.
```
/manage:docs checklist --pr=<number>
```
- Creates review checklist
- Validates PR documentation
- Comments on GitHub PR

## Examples

### Basic health check
```bash
/manage:docs check
```
Output:
```
📋 Documentation Health Report
✅ Synchronized: 45/50
⚠️ Divergent: 3
❌ Broken Links: 2
❌ Missing Translations: 0
```

### Pre-commit validation
```bash
/manage:docs validate --pre-commit
```

### Synchronize after changes
```bash
/manage:docs sync
```

### Generate API documentation
```bash
/manage:docs generate api --template=openapi
```

### Fix documentation structure
```bash
/manage:docs structure --fix
```

### Generate PR checklist
```bash
/manage:docs checklist --pr=123
```

## Integration Points

### Git Hooks
```bash
# .git/hooks/pre-commit
#!/bin/sh
/manage:docs validate --pre-commit

# .git/hooks/post-merge
#!/bin/sh
/manage:docs sync --post-merge
```

### CI/CD Pipeline
```yaml
# .github/workflows/docs.yml
- name: Validate Documentation
  run: /manage:docs validate
  
- name: Check Coverage
  run: /manage:docs coverage
```

### SDLC Phase 7
```bash
# During documentation phase
/manage:docs requirements --feature="user-auth"
/manage:docs check --phase=documentation
```

## Output Format

### Standard Output
```
📋 Documentation Management
├── Status: [Success/Warning/Error]
├── Files Processed: X
├── Issues Found: Y
└── Recommendations: Z
```

### JSON Output
```json
{
  "status": "success",
  "stats": {
    "total": 50,
    "synchronized": 45,
    "issues": 5
  },
  "issues": [],
  "recommendations": []
}
```

## Error Handling

### Common Errors
- `No documentation found`: Project lacks documentation
- `Structure mismatch`: Documentation not following standard structure
- `Translation missing`: Korean version not found
- `Broken references`: Links pointing to non-existent files

### Recovery Actions
1. Run `/manage:docs structure --fix` to fix structure
2. Use `/manage:docs generate` to create missing docs
3. Execute `/manage:docs fix-links` to repair references
4. Apply `/manage:docs sync` to align versions

## Best Practices

1. **Regular Checks**: Run `/manage:docs check` weekly
2. **Pre-commit Hook**: Always validate before committing
3. **Post-merge Sync**: Check synchronization after merges
4. **PR Documentation**: Generate checklist for all PRs
5. **Coverage Goals**: Maintain >90% documentation coverage

## Performance Considerations

- Caches validation results for 1 hour
- Parallel processing for large documentation sets
- Incremental updates for metadata
- Batch operations for link fixing

## Related Commands

- `/support:document` - Generate documentation for specific components
- `/analyze:project-context` - Understand project for documentation
- `/manage:git` - Commit documentation changes
- `/sdlc` - Integration with SDLC documentation phase