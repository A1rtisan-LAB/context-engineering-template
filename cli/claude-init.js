#!/usr/bin/env node

/**
 * Claude Code Project Initializer
 * Unified CLI entry point for creating new Claude Code projects
 */

const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

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

// Create project from starter
async function createProject(projectName, starterType, targetPath) {
  console.log(`\n🚀 Creating Claude Code project: ${projectName}`);
  console.log(`   Type: ${starterType}`);
  console.log(`   Location: ${targetPath}\n`);
  
  // Check if target directory exists
  if (fs.existsSync(targetPath)) {
    console.error(`Error: Directory ${targetPath} already exists`);
    process.exit(1);
  }
  
  // Create target directory
  fs.mkdirSync(targetPath, { recursive: true });
  
  // Copy starter files
  const starterPath = path.join(__dirname, '..', 'starters', starterType);
  
  if (!fs.existsSync(starterPath)) {
    console.error(`Error: Starter template '${starterType}' not found`);
    process.exit(1);
  }
  
  // Use the core package's generator if available
  const generatorPath = path.join(__dirname, '..', 'packages', '@claude-code', 'core', 'src', 'generator.sh');
  
  if (fs.existsSync(generatorPath)) {
    // Use the generator script
    const generator = spawn('bash', [generatorPath, projectName, starterType, targetPath], {
      stdio: 'inherit'
    });
    
    generator.on('close', (code) => {
      if (code === 0) {
        showSuccess(projectName, targetPath);
      } else {
        console.error('Error: Project generation failed');
        process.exit(1);
      }
    });
  } else {
    // Fallback: Simple copy
    copyRecursive(starterPath, targetPath);
    
    // Create .claude directory structure
    const claudeDir = path.join(targetPath, '.claude');
    fs.mkdirSync(claudeDir, { recursive: true });
    
    // Link to installed packages
    linkPackages(targetPath);
    
    // Replace placeholders
    replacePlaceholders(targetPath, projectName);
    
    showSuccess(projectName, targetPath);
  }
}

// Copy files recursively
function copyRecursive(src, dest) {
  const stats = fs.statSync(src);
  
  if (stats.isDirectory()) {
    fs.mkdirSync(dest, { recursive: true });
    fs.readdirSync(src).forEach(childItemName => {
      copyRecursive(
        path.join(src, childItemName),
        path.join(dest, childItemName)
      );
    });
  } else {
    fs.copyFileSync(src, dest);
  }
}

// Link Claude Code packages
function linkPackages(targetPath) {
  const packagesSource = path.join(__dirname, '..', 'packages', '@claude-code');
  const packagesTarget = path.join(targetPath, '.claude');
  
  // Link agents
  if (fs.existsSync(path.join(packagesSource, 'agents', 'src'))) {
    const agentsTarget = path.join(packagesTarget, 'agents');
    fs.mkdirSync(agentsTarget, { recursive: true });
    fs.symlinkSync(
      path.join(packagesSource, 'agents', 'src'),
      path.join(agentsTarget, 'src'),
      'dir'
    );
  }
  
  // Link commands
  if (fs.existsSync(path.join(packagesSource, 'commands', 'src'))) {
    const commandsTarget = path.join(packagesTarget, 'commands');
    fs.mkdirSync(commandsTarget, { recursive: true });
    fs.symlinkSync(
      path.join(packagesSource, 'commands', 'src'),
      path.join(commandsTarget, 'src'),
      'dir'
    );
  }
  
  // Link workflows
  if (fs.existsSync(path.join(packagesSource, 'workflows', 'src'))) {
    const workflowsTarget = path.join(packagesTarget, 'workflows');
    fs.mkdirSync(workflowsTarget, { recursive: true });
    fs.symlinkSync(
      path.join(packagesSource, 'workflows', 'src'),
      path.join(workflowsTarget, 'src'),
      'dir'
    );
  }
}

// Replace placeholders in files
function replacePlaceholders(targetPath, projectName) {
  const files = [
    'CLAUDE.md',
    'README.md',
    'package.json'
  ];
  
  files.forEach(file => {
    const filePath = path.join(targetPath, file);
    if (fs.existsSync(filePath)) {
      let content = fs.readFileSync(filePath, 'utf8');
      content = content.replace(/PROJECT_NAME/g, projectName);
      fs.writeFileSync(filePath, content);
    }
  });
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

// Main execution
async function main() {
  try {
    const { projectName, starterType, targetPath } = parseArgs();
    validateStarter(starterType);
    await createProject(projectName, starterType, targetPath);
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

// Run the CLI
main();