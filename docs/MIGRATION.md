# Migration Guide

## Migrating from v2.x to v3.0 (Monorepo)

### Overview

Version 3.0 introduces a major restructuring from a dual-context architecture to a modern monorepo structure. This guide will help you migrate existing projects.

## Key Changes

### 1. Directory Structure

**Before (v2.x):**
```
context-engineering-template/
├── templates/
│   └── .claude/
├── .claude/
├── lib/
└── setup-claude-code.sh
```

**After (v3.0):**
```
context-engineering-template/
├── packages/
│   └── @claude-code/
│       ├── agents/
│       ├── commands/
│       ├── workflows/
│       └── core/
├── starters/
├── cli/
└── package.json
```

### 2. CLI Changes

**Before:**
```bash
./setup-claude-code.sh project-name project-type path
```

**After:**
```bash
node cli/claude-init.js project-name project-type path
```

### 3. Performance Improvements

- **40-50% faster** project creation with async/await
- **Parallel operations** for file copying and processing
- **Optimized I/O** with promises instead of sync operations

## Migration Steps

### Step 1: Backup Your Project

```bash
cp -r your-project your-project-backup
```

### Step 2: Install New Version

```bash
git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
cd context-engineering-template
npm install
```

### Step 3: Migrate Configuration

#### 3.1 Update .claude Directory

Your existing `.claude` directory structure remains mostly the same, but you may want to update:

1. **Agent definitions**: Check for new agents in `packages/@claude-code/agents/`
2. **Commands**: Review new commands in `packages/@claude-code/commands/`
3. **Workflows**: Update workflows from `packages/@claude-code/workflows/`

#### 3.2 Update package.json

Add workspace configuration if using monorepo features:

```json
{
  "workspaces": [
    "packages/@claude-code/*"
  ]
}
```

### Step 4: Update Scripts

Replace old shell scripts with new npm scripts:

**Before:**
```bash
./sync-templates.sh validate
```

**After:**
```bash
npm run validate
```

### Step 5: Testing

Run the test suite to ensure everything works:

```bash
npm test
npm run benchmark
```

## Breaking Changes

### 1. Template Sync Tool Removed

The `sync-templates.sh` tool has been replaced with npm workspace commands.

**Migration:**
- Use `npm run validate` instead of `./sync-templates.sh validate`
- Use `npm run update` for updating packages

### 2. Dual Context Architecture Removed

The separation between development context and output templates is removed.

**Migration:**
- All templates are now in `starters/` directory
- Development happens directly in the monorepo packages

### 3. Generator Script Changes

The `generator.sh` script has been simplified and moved.

**Migration:**
- Update any custom scripts that depend on the generator
- New location: `packages/@claude-code/core/src/generator.sh`

## New Features in v3.0

### 1. Jest Testing Framework

```bash
npm test              # Run tests
npm run test:coverage # With coverage
npm run test:watch    # Watch mode
```

### 2. Performance Benchmarking

```bash
npm run benchmark     # Run performance tests
```

### 3. Async/Await CLI

All file operations are now asynchronous for better performance.

### 4. Bilingual Documentation

All documentation now includes Korean translations (`.ko.md` files).

## Common Migration Issues

### Issue: "Command not found" errors

**Solution:** Update your PATH or use npm scripts instead of shell scripts.

### Issue: Missing templates directory

**Solution:** Templates are now in `starters/` directory.

### Issue: Sync commands not working

**Solution:** Use npm workspace commands instead:
```bash
npm run validate --workspaces
npm run build --workspaces
```

### Issue: Old project structure incompatible

**Solution:** Create a new project with v3.0 and migrate your code:
```bash
node cli/claude-init.js new-project
cp -r old-project/src new-project/
```

## Rollback Plan

If you need to rollback to v2.x:

```bash
git checkout v2.0.0
./setup-claude-code.sh your-project
```

## Getting Help

- [GitHub Issues](https://github.com/A1rtisan-LAB/context-engineering-template/issues)
- [Discord Community](#)
- [Documentation](https://docs.anthropic.com/claude-code)

## Version Compatibility

| Version | Node.js | npm | Status |
|---------|---------|-----|--------|
| v3.0+ | ≥16.0.0 | ≥8.0.0 | Current |
| v2.x | ≥14.0.0 | ≥6.0.0 | Maintenance |
| v1.x | ≥12.0.0 | ≥6.0.0 | Deprecated |

## Deprecation Timeline

- **v2.x**: Maintenance mode until 2025-01-01
- **v1.x**: No longer supported

## Next Steps

After migration:

1. Review the [QUICKSTART](QUICKSTART.md) guide
2. Explore new [API features](API.md)
3. Check the [improvement plan](IMPROVEMENT_PLAN.md)
4. Contribute to the project!

---

Thank you for upgrading to v3.0! 🚀