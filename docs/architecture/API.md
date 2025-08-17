---
title: API Documentation
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: architecture
tags: [api, cli, commands, reference]
---

# API Documentation

## Table of Contents
1. [CLI API](#cli-api)
2. [Commands](#commands)
3. [Package API](#package-api)
4. [Extension API](#extension-api)

## CLI API

### `claude-init`

Main CLI entry point for creating new Claude Code projects.

#### Synopsis

```bash
node cli/claude-init.js [project-name] [starter-type] [target-path]
```

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `project-name` | string | `my-claude-project` | Name of your project |
| `starter-type` | string | `basic` | Type of starter template (`basic`, `api`, `frontend`, `fullstack`) |
| `target-path` | string | `./<project-name>` | Where to create the project |

#### Options

| Option | Alias | Description |
|--------|-------|-------------|
| `--help` | `-h` | Show help message |
| `--version` | `-v` | Show version information |
| `--with-sdlc` | | Include SDLC pipeline configuration in the project |
| `--sdlc-template=<type>` | | SDLC template type: `standard`, `agile`, or `hotfix` (default: `standard`) |

#### Examples

```bash
# Create a basic project
node cli/claude-init.js my-project

# Create an API project
node cli/claude-init.js my-api api

# Create a frontend project in a specific directory
node cli/claude-init.js my-app frontend ~/projects

# Create a project with SDLC pipeline
node cli/claude-init.js my-project basic . --with-sdlc

# Create an API project with Agile SDLC template
node cli/claude-init.js my-api api . --with-sdlc --sdlc-template=agile
```

## Programmatic API

### Using as a Module

```javascript
const { createProject } = require('./cli/claude-init');

// Create a project programmatically
await createProject('my-project', 'basic', '/path/to/projects');
```

### Core Functions

#### `createProject(projectName, starterType, targetPath)`

Creates a new Claude Code project.

**Parameters:**
- `projectName` (string): Name of the project
- `starterType` (string): Type of starter template
- `targetPath` (string): Target directory path

**Returns:** Promise<void>

**Throws:** Error if directory exists or starter not found

#### `pathExists(path)`

Checks if a path exists asynchronously.

**Parameters:**
- `path` (string): Path to check

**Returns:** Promise<boolean>

#### `copyRecursive(src, dest)`

Recursively copies files and directories.

**Parameters:**
- `src` (string): Source path
- `dest` (string): Destination path

**Returns:** Promise<void>

#### `replacePlaceholders(targetPath, projectName)`

Replaces PROJECT_NAME placeholders in files.

**Parameters:**
- `targetPath` (string): Project directory path
- `projectName` (string): Name to replace with

**Returns:** Promise<void>

#### `copyPackageContents(targetPath)`

Dynamically copies package contents from monorepo to generated project.

**Parameters:**
- `targetPath` (string): Target project directory path

**Returns:** Promise<void>

**Description:**
This function dynamically discovers all packages under `@claude-code/` and copies their contents to the generated project's `.claude/` directory. It handles the following:
- Automatically discovers all package directories
- For packages with `src/` directories, copies contents directly to `.claude/[package-name]/` (without src/)
- Skips internal packages like 'core' that aren't needed in projects
- Excludes unnecessary files (package.json, tests, node_modules, etc.)
- Future-proof: automatically handles new packages added to the monorepo

**Example Result:**
```
.claude/
├── agents/          # Contents from packages/@claude-code/agents/src/
│   ├── *.md        # Agent files directly here, no src/ subdirectory
├── commands/        # Contents from packages/@claude-code/commands/src/
│   ├── *.md        # Command files directly here
│   └── analyze/    # Subdirectories preserved
└── workflows/       # Contents from packages/@claude-code/workflows/src/
    └── *.md        # Workflow files directly here
```

## Benchmark API

### `Benchmark` Class

Performance benchmarking utility.

```javascript
const Benchmark = require('./scripts/benchmark');
const benchmark = new Benchmark();
```

#### Methods

##### `measure(name, fn)`

Measures the execution time of a function.

**Parameters:**
- `name` (string): Name of the operation
- `fn` (Function): Function to measure

**Returns:** Promise<number> - Duration in milliseconds

##### `benchmarkFileOperations()`

Benchmarks file I/O operations.

**Returns:** Promise<void>

##### `benchmarkCLIInit()`

Benchmarks CLI initialization for all starter types.

**Returns:** Promise<void>

##### `generateReport()`

Generates and saves a performance report.

**Returns:** void

##### `generateMarkdownReport()`

Generates a markdown-formatted report.

**Returns:** string

##### `cleanup()`

Cleans up temporary files.

**Returns:** void

##### `run()`

Runs all benchmarks.

**Returns:** Promise<void>

### Example Usage

```javascript
const Benchmark = require('./scripts/benchmark');

async function runBenchmarks() {
  const benchmark = new Benchmark();
  
  // Measure a custom operation
  const duration = await benchmark.measure('Custom Operation', async () => {
    // Your code here
    await someAsyncOperation();
  });
  
  console.log(`Operation took ${duration}ms`);
  
  // Run all benchmarks
  await benchmark.run();
}
```

## Testing API

### Test Utilities

Located in `test/setup.js`:

#### `testUtils.createTempDir()`

Creates a temporary directory for testing.

**Returns:** string - Path to temp directory

#### `testUtils.cleanupDir(dir)`

Cleans up a directory.

**Parameters:**
- `dir` (string): Directory to clean up

**Returns:** void

#### `testUtils.mockConsole()`

Mocks console methods for testing.

**Returns:** Function - Restore function

### Running Tests

```javascript
// Run all tests
npm test

// Run with coverage
npm run test:coverage

// Run specific test file
npx jest path/to/test.js

// Run in watch mode
npm run test:watch
```

## Package Scripts

Available npm scripts:

| Script | Description |
|--------|-------------|
| `npm run init` | Run the CLI initializer |
| `npm run test` | Run Jest tests |
| `npm run test:watch` | Run tests in watch mode |
| `npm run test:coverage` | Run tests with coverage |
| `npm run test:ci` | Run tests for CI environment |
| `npm run benchmark` | Run performance benchmarks |
| `npm run validate` | Validate workspace packages |
| `npm run build` | Build workspace packages |
| `npm run clean` | Clean node_modules and coverage |
| `npm run setup` | Install and build everything |

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `NODE_ENV` | Environment mode | `development` |
| `CI` | CI environment flag | `false` |

## Error Codes

| Code | Description |
|------|-------------|
| 1 | General error |
| 2 | Directory already exists |
| 3 | Invalid starter type |
| 4 | Starter template not found |

## Performance Metrics

Expected performance benchmarks:

| Operation | Target Time | Actual (Async) |
|-----------|------------|----------------|
| Project Creation | < 100ms | ~5-10ms |
| File Copy (small) | < 5ms | ~1-2ms |
| Placeholder Replace | < 10ms | ~2-5ms |
| Total CLI Operation | < 150ms | ~10-20ms |

## Monorepo Structure

### Workspace Packages

```
packages/
├── @claude-code/agents     # AI agent definitions
├── @claude-code/commands   # Command implementations
├── @claude-code/workflows  # Workflow definitions
└── @claude-code/core       # Core engine
```

### Package Conventions

Each package follows this structure:

```
package-name/
├── package.json
├── README.md
├── README.ko.md
├── src/
│   └── index.js
└── __tests__/
    └── index.test.js
```

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for development guidelines.

## License

MIT - See [LICENSE](../LICENSE) for details.