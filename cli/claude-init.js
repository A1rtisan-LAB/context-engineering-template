#!/usr/bin/env node

/**
 * Claude Code Project Initializer
 * Unified CLI entry point for creating new Claude Code projects
 * 
 * Performance optimized version using async/await for parallel operations
 */

const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs').promises;
const fsSync = require('fs');
const { promisify } = require('util');
const execAsync = promisify(require('child_process').exec);

// Configuration
const CONFIG = {
  starters: ['basic', 'api', 'frontend', 'fullstack'],
  defaultStarter: 'basic'
};

// Parse command line arguments
function parseArgs() {
  const args = process.argv.slice(2);
  
  if (args.includes('--help') || args.includes('-h')) {
    showHelp();
    process.exit(0);
  }
  
  if (args.includes('--version') || args.includes('-v')) {
    showVersion();
    process.exit(0);
  }
  
  const projectName = args[0] || 'my-claude-project';
  const starterType = args[1] || CONFIG.defaultStarter;
  const targetPath = args[2] || path.join(process.cwd(), projectName);
  
  return { projectName, starterType, targetPath };
}

// Show help message
function showHelp() {
  console.log(`
Claude Code Project Initializer

Usage:
  claude-init [project-name] [starter-type] [target-path]

Arguments:
  project-name   Name of your project (default: my-claude-project)
  starter-type   Type of starter: ${CONFIG.starters.join(', ')} (default: ${CONFIG.defaultStarter})
  target-path    Where to create the project (default: ./<project-name>)

Options:
  --help, -h     Show this help message
  --version, -v  Show version information

Examples:
  claude-init                           # Create basic project in ./my-claude-project
  claude-init my-api api                # Create API project
  claude-init my-app frontend ~/apps    # Create frontend app in ~/apps/my-app
`);
}

// Show version
function showVersion() {
  const packageJson = require('../package.json');
  console.log(`Claude Code Initializer v${packageJson.version}`);
}

// Validate starter type
function validateStarter(starterType) {
  if (!CONFIG.starters.includes(starterType)) {
    console.error(`Error: Invalid starter type '${starterType}'`);
    console.error(`Available starters: ${CONFIG.starters.join(', ')}`);
    process.exit(1);
  }
}

// Check if path exists (async version)
async function pathExists(path) {
  try {
    await fs.access(path);
    return true;
  } catch {
    return false;
  }
}

// Get all files in directory recursively (async)
async function getFiles(dir) {
  const dirents = await fs.readdir(dir, { withFileTypes: true });
  const files = await Promise.all(
    dirents.map((dirent) => {
      const res = path.join(dir, dirent.name);
      return dirent.isDirectory() ? getFiles(res) : res;
    })
  );
  return files.flat();
}

// Copy files recursively (async version)
async function copyRecursive(src, dest) {
  const stats = await fs.stat(src);
  
  if (stats.isDirectory()) {
    await fs.mkdir(dest, { recursive: true });
    const items = await fs.readdir(src);
    
    // Copy all items in parallel for better performance
    await Promise.all(
      items.map(item =>
        copyRecursive(
          path.join(src, item),
          path.join(dest, item)
        )
      )
    );
  } else {
    await fs.copyFile(src, dest);
  }
}

// Link Claude Code packages (async version)
async function linkPackages(targetPath) {
  const packagesSource = path.join(__dirname, '..', 'packages', '@claude-code');
  const packagesTarget = path.join(targetPath, '.claude');
  
  // Check and link packages in parallel
  const linkOperations = [];
  
  // Link agents
  const agentsSourcePath = path.join(packagesSource, 'agents', 'src');
  if (await pathExists(agentsSourcePath)) {
    const agentsTarget = path.join(packagesTarget, 'agents');
    linkOperations.push(
      fs.mkdir(agentsTarget, { recursive: true }).then(() =>
        fs.symlink(
          agentsSourcePath,
          path.join(agentsTarget, 'src'),
          'dir'
        )
      )
    );
  }
  
  // Link commands
  const commandsSourcePath = path.join(packagesSource, 'commands', 'src');
  if (await pathExists(commandsSourcePath)) {
    const commandsTarget = path.join(packagesTarget, 'commands');
    linkOperations.push(
      fs.mkdir(commandsTarget, { recursive: true }).then(() =>
        fs.symlink(
          commandsSourcePath,
          path.join(commandsTarget, 'src'),
          'dir'
        )
      )
    );
  }
  
  // Link workflows
  const workflowsSourcePath = path.join(packagesSource, 'workflows', 'src');
  if (await pathExists(workflowsSourcePath)) {
    const workflowsTarget = path.join(packagesTarget, 'workflows');
    linkOperations.push(
      fs.mkdir(workflowsTarget, { recursive: true }).then(() =>
        fs.symlink(
          workflowsSourcePath,
          path.join(workflowsTarget, 'src'),
          'dir'
        )
      )
    );
  }
  
  // Execute all link operations in parallel
  await Promise.all(linkOperations);
}

// Replace placeholders in files (async version)
async function replacePlaceholders(targetPath, projectName) {
  const files = [
    'CLAUDE.md',
    'README.md',
    'package.json'
  ];
  
  // Process all files in parallel
  await Promise.all(
    files.map(async (file) => {
      const filePath = path.join(targetPath, file);
      if (await pathExists(filePath)) {
        let content = await fs.readFile(filePath, 'utf8');
        content = content.replace(/PROJECT_NAME/g, projectName);
        await fs.writeFile(filePath, content);
      }
    })
  );
}

// Create project from starter (async version)
async function createProject(projectName, starterType, targetPath) {
  const startTime = Date.now();
  
  // Determine the actual project path
  const projectPath = path.basename(targetPath) === projectName 
    ? targetPath 
    : path.join(targetPath, projectName);
  
  console.log(`\n🚀 Creating Claude Code project: ${projectName}`);
  console.log(`   Type: ${starterType}`);
  console.log(`   Location: ${projectPath}\n`);
  
  // Check if project directory exists
  if (await pathExists(projectPath)) {
    console.error(`Error: Directory ${projectPath} already exists`);
    process.exit(1);
  }
  
  // Create project directory
  await fs.mkdir(projectPath, { recursive: true });
  
  // Check if starter exists
  const starterPath = path.join(__dirname, '..', 'starters', starterType);
  
  if (!await pathExists(starterPath)) {
    console.error(`Error: Starter template '${starterType}' not found`);
    process.exit(1);
  }
  
  // Optimized async copy
  console.log('📁 Copying starter files...');
  
  // Perform operations in parallel where possible
  const operations = [];
  
  // Copy starter files
  operations.push(copyRecursive(starterPath, projectPath));
  
  // Create .claude directory structure
  const claudeDir = path.join(projectPath, '.claude');
  operations.push(fs.mkdir(claudeDir, { recursive: true }));
  
  // Wait for initial operations
  await Promise.all(operations);
  
  // Link packages and replace placeholders in parallel
  await Promise.all([
    linkPackages(projectPath),
    replacePlaceholders(projectPath, projectName)
  ]);
  
  const duration = Date.now() - startTime;
  console.log(`⏱️  Project created in ${duration}ms`);
  showSuccess(projectName, projectPath);
}

// Show success message
function showSuccess(projectName, targetPath) {
  console.log(`
✅ Project created successfully!

Next steps:
  cd ${path.relative(process.cwd(), targetPath)}
  # Start developing with Claude Code

Your project includes:
  • Claude Code agents for AI-assisted development
  • Pre-configured commands and workflows
  • Project templates and best practices

Happy coding! 🎉
`);
}

// Main execution (async)
async function main() {
  try {
    const { projectName, starterType, targetPath } = parseArgs();
    validateStarter(starterType);
    await createProject(projectName, starterType, targetPath);
  } catch (error) {
    console.error('Error:', error.message);
    if (error.stack) {
      console.error('Stack:', error.stack);
    }
    process.exit(1);
  }
}

// Run the CLI
main().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});