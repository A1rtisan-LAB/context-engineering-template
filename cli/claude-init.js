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
  defaultStarter: 'basic',
  sdlc: {
    available: true,
    templates: ['standard', 'agile', 'hotfix'],
    defaultTemplate: 'standard'
  }
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
  
  // SDLC options
  const withSDLC = args.includes('--with-sdlc');
  const sdlcTemplateIndex = args.findIndex(arg => arg.startsWith('--sdlc-template='));
  const sdlcTemplate = sdlcTemplateIndex !== -1 
    ? args[sdlcTemplateIndex].split('=')[1] 
    : CONFIG.sdlc.defaultTemplate;
  
  return { projectName, starterType, targetPath, withSDLC, sdlcTemplate };
}

// Show help message
function showHelp() {
  console.log(`
Claude Code Project Initializer

Usage:
  claude-init [project-name] [starter-type] [target-path] [options]

Arguments:
  project-name   Name of your project (default: my-claude-project)
  starter-type   Type of starter: ${CONFIG.starters.join(', ')} (default: ${CONFIG.defaultStarter})
  target-path    Where to create the project (default: ./<project-name>)

Options:
  --help, -h           Show this help message
  --version, -v        Show version information
  --with-sdlc          Include SDLC pipeline configuration
  --sdlc-template=     SDLC template: ${CONFIG.sdlc.templates.join(', ')} (default: ${CONFIG.sdlc.defaultTemplate})

Examples:
  claude-init                                    # Create basic project
  claude-init my-api api                         # Create API project
  claude-init my-app frontend ~/apps             # Create frontend app in ~/apps
  claude-init my-project basic . --with-sdlc     # Include SDLC pipeline
  claude-init my-api api . --with-sdlc --sdlc-template=agile  # With Agile SDLC
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

// Copy Claude Code package contents dynamically
async function copyPackageContents(targetPath) {
  const packagesSource = path.join(__dirname, '..', 'packages', '@claude-code');
  const claudeTarget = path.join(targetPath, '.claude');
  
  // Packages to skip (internal tools, not needed in projects)
  const skipPackages = ['core'];
  
  // Files/patterns to exclude when copying
  const excludePatterns = [
    'package.json',
    'README.md',
    'README.ko.md',
    'node_modules',
    '__tests__',
    '*.test.js',
    '*.spec.js',
    '.DS_Store'
  ];
  
  // Check if file/dir should be excluded
  const shouldExclude = (name) => {
    return excludePatterns.some(pattern => {
      if (pattern.includes('*')) {
        const regex = new RegExp(pattern.replace('*', '.*'));
        return regex.test(name);
      }
      return name === pattern;
    });
  };
  
  // Recursively copy directory contents
  const copyDirContents = async (srcDir, destDir) => {
    await fs.mkdir(destDir, { recursive: true });
    const items = await fs.readdir(srcDir, { withFileTypes: true });
    
    const copyOperations = items
      .filter(item => !shouldExclude(item.name))
      .map(async (item) => {
        const srcPath = path.join(srcDir, item.name);
        const destPath = path.join(destDir, item.name);
        
        if (item.isDirectory()) {
          await copyDirContents(srcPath, destPath);
        } else {
          await fs.copyFile(srcPath, destPath);
        }
      });
    
    await Promise.all(copyOperations);
  };
  
  // Get all package directories
  const packageDirs = await fs.readdir(packagesSource, { withFileTypes: true });
  
  // Process each package in parallel
  const copyOperations = packageDirs
    .filter(dir => dir.isDirectory() && !skipPackages.includes(dir.name))
    .map(async (dir) => {
      const packageName = dir.name;
      const packagePath = path.join(packagesSource, packageName);
      const targetDir = path.join(claudeTarget, packageName);
      
      // Check if package has a src directory
      const srcPath = path.join(packagePath, 'src');
      if (await pathExists(srcPath)) {
        // Copy contents of src/ to .claude/[package-name]/
        await copyDirContents(srcPath, targetDir);
      } else {
        // Check if package has any content files to copy
        const packageContents = await fs.readdir(packagePath, { withFileTypes: true });
        const hasContent = packageContents.some(item => 
          !shouldExclude(item.name) && (item.isFile() || item.isDirectory())
        );
        
        if (hasContent) {
          // Copy package contents directly
          await copyDirContents(packagePath, targetDir);
        }
      }
    });
  
  await Promise.all(copyOperations);
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

// Copy SDLC guides if enabled
async function copySDLCGuides(projectPath) {
  const docsDir = path.join(projectPath, 'docs');
  await fs.mkdir(docsDir, { recursive: true });
  
  const guidesSource = path.join(__dirname, '..', 'docs');
  const sdlcGuideEn = path.join(guidesSource, 'SDLC_GUIDE.md');
  const sdlcGuideKo = path.join(guidesSource, 'SDLC_GUIDE.ko.md');
  
  if (await pathExists(sdlcGuideEn)) {
    await fs.copyFile(sdlcGuideEn, path.join(docsDir, 'SDLC_GUIDE.md'));
  }
  
  if (await pathExists(sdlcGuideKo)) {
    await fs.copyFile(sdlcGuideKo, path.join(docsDir, 'SDLC_GUIDE.ko.md'));
  }
  
  console.log('📚 SDLC guides copied');
}

// Create project from starter (async version)
async function createProject(projectName, starterType, targetPath, withSDLC = false, sdlcTemplate = 'standard') {
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
  
  // Copy package contents and replace placeholders in parallel
  const parallelOps = [
    copyPackageContents(projectPath),
    replacePlaceholders(projectPath, projectName)
  ];
  
  // Add SDLC guide copying if enabled
  if (withSDLC) {
    parallelOps.push(copySDLCGuides(projectPath));
    console.log(`📋 Including SDLC Pipeline with ${sdlcTemplate} template`);
  }
  
  await Promise.all(parallelOps);
  
  const duration = Date.now() - startTime;
  console.log(`⏱️  Project created in ${duration}ms`);
  showSuccess(projectName, projectPath, withSDLC);
}

// Show success message
function showSuccess(projectName, targetPath, withSDLC = false) {
  const sdlcInfo = withSDLC 
    ? '\n  • SDLC Pipeline System for structured development\n  • 7-phase development lifecycle management'
    : '';
    
  console.log(`
✅ Project created successfully!

Next steps:
  cd ${path.relative(process.cwd(), targetPath)}
  # Start developing with Claude Code

Your project includes:
  • Claude Code agents for AI-assisted development
  • Pre-configured commands and workflows
  • Project templates and best practices${sdlcInfo}

Happy coding! 🎉
`);
}

// Main execution (async)
async function main() {
  try {
    const { projectName, starterType, targetPath, withSDLC, sdlcTemplate } = parseArgs();
    validateStarter(starterType);
    await createProject(projectName, starterType, targetPath, withSDLC, sdlcTemplate);
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