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
    includedByDefault: true,  // Changed to true - SDLC now included by default
    templates: ['standard', 'agile', 'hotfix'],
    defaultTemplate: 'standard'
  },
  prd: {
    available: true,
    includedByDefault: true,
    templates: ['standard', 'api', 'frontend', 'fullstack']
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
  
  // Full installation option (includes everything)
  const fullInstall = args.includes('--full');
  
  // Minimal installation option (excludes SDLC and PRD)
  const minimalInstall = args.includes('--minimal');
  
  // Validate conflicting options
  if (minimalInstall && fullInstall) {
    console.error('❌ Error: --minimal and --full options cannot be used together');
    process.exit(1);
  }
  
  if (minimalInstall && (args.includes('--with-sdlc') || args.includes('--with-prd'))) {
    console.error('❌ Error: --minimal cannot be used with --with-sdlc or --with-prd');
    console.error('  Use --full or remove --minimal to include SDLC/PRD features');
    process.exit(1);
  }
  
  // SDLC options
  const withSDLC = fullInstall || (!minimalInstall && !args.includes('--no-sdlc')); // SDLC is included by default
  const sdlcTemplateIndex = args.findIndex(arg => arg.startsWith('--sdlc-template='));
  const sdlcTemplate = sdlcTemplateIndex !== -1 
    ? args[sdlcTemplateIndex].split('=')[1] 
    : CONFIG.sdlc.defaultTemplate;
  
  // PRD options
  const withPRD = fullInstall || (!minimalInstall && !args.includes('--no-prd')); // PRD is included by default
  const prdTemplateIndex = args.findIndex(arg => arg.startsWith('--prd-template='));
  const prdTemplate = prdTemplateIndex !== -1
    ? args[prdTemplateIndex].split('=')[1]
    : starterType; // Use starter type as PRD template by default
  
  return { projectName, starterType, targetPath, withSDLC, sdlcTemplate, withPRD, prdTemplate };
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
  --full               Include all systems (PRD, SDLC, Doc) - recommended
  --minimal            Minimal installation without PRD and SDLC
  --no-sdlc            Exclude SDLC pipeline (SDLC included by default)
  --no-prd             Exclude PRD system (PRD included by default)
  --sdlc-template=     SDLC template: ${CONFIG.sdlc.templates.join(', ')} (default: ${CONFIG.sdlc.defaultTemplate})
  --prd-template=      PRD template: ${CONFIG.prd.templates.join(', ')} (default: matches starter type)

Examples:
  claude-init                                    # Create project with PRD & SDLC (default)
  claude-init my-project basic . --full          # Include all systems (recommended)
  claude-init my-api api                         # API project with PRD & SDLC
  claude-init my-app frontend ~/apps             # Frontend app with full features
  claude-init my-simple basic . --minimal        # Minimal setup without PRD/SDLC
  claude-init my-api api . --sdlc-template=agile # Use Agile SDLC template
  claude-init my-project basic . --no-sdlc       # Exclude only SDLC
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
async function copyRecursive(src, dest, excludePaths = []) {
  const stats = await fs.stat(src);
  
  if (stats.isDirectory()) {
    await fs.mkdir(dest, { recursive: true });
    const items = await fs.readdir(src);
    
    // Copy all items in parallel for better performance
    await Promise.all(
      items
        .filter(item => {
          // Check if this path should be excluded
          const fullPath = path.join(src, item);
          return !excludePaths.some(excludePath => fullPath.endsWith(excludePath));
        })
        .map(item =>
          copyRecursive(
            path.join(src, item),
            path.join(dest, item),
            excludePaths
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

// Setup PRD system
async function setupPRDSystem(projectPath, starterType, prdTemplate = null) {
  const template = prdTemplate || starterType;
  
  // Create PRD directory structure
  const prdDirs = [
    'docs/prd/draft',
    'docs/prd/review',
    'docs/prd/approved',
    'docs/prd/in-development',
    'docs/prd/archived/2024',
    'docs/prd/templates',  // Changed from .config/templates to templates
    'docs/prd/.config',
    'docs/releases',
    'docs/guides/user',
    'docs/guides/developer'
  ];
  
  // Create all directories in parallel
  await Promise.all(
    prdDirs.map(dir => fs.mkdir(path.join(projectPath, dir), { recursive: true }))
  );
  
  // Copy PRD template from starter's docs/templates/prd
  const templateSource = path.join(__dirname, '..', 'starters', starterType, 'docs', 'templates', 'prd');
  const templateDest = path.join(projectPath, 'docs', 'prd', 'templates');
  
  // Copy the appropriate template
  const templateFile = template === 'basic' ? 'standard.md' : `${template}.md`;
  const sourceFile = path.join(templateSource, templateFile);
  
  if (await pathExists(sourceFile)) {
    await fs.copyFile(sourceFile, path.join(templateDest, 'standard.md'));
    // Also copy as the specific template name if different
    if (template !== 'standard' && template !== 'basic') {
      await fs.copyFile(sourceFile, path.join(templateDest, `${template}.md`));
    }
  }
  
  // Create PRD config file
  const prdConfig = {
    enabled: true,
    template: template,
    autoTranslate: true,
    states: ['draft', 'review', 'approved', 'in-development', 'completed', 'archived'],
    templates_path: 'docs/prd/templates',  // Changed path
    storage_path: 'docs/prd'
  };
  
  await fs.writeFile(
    path.join(projectPath, 'docs', 'prd', '.config', 'config.json'),
    JSON.stringify(prdConfig, null, 2)
  );
  
  console.log('📝 PRD system configured');
}

// Create project from starter (async version)
async function createProject(projectName, starterType, targetPath, withSDLC = false, sdlcTemplate = 'standard', withPRD = true, prdTemplate = null) {
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
  
  // Copy starter files (excluding templates since PRD templates will be handled by setupPRDSystem)
  operations.push(copyRecursive(starterPath, projectPath, ['docs/templates']));
  
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
  
  // Add PRD system if enabled
  if (withPRD) {
    parallelOps.push(setupPRDSystem(projectPath, starterType, prdTemplate));
    console.log(`📝 Including PRD System with ${prdTemplate || starterType} template`);
  }
  
  await Promise.all(parallelOps);
  
  const duration = Date.now() - startTime;
  console.log(`⏱️  Project created in ${duration}ms`);
  showSuccess(projectName, projectPath, withSDLC, withPRD);
}

// Show success message
function showSuccess(projectName, targetPath, withSDLC = false, withPRD = false) {
  const sdlcInfo = withSDLC 
    ? '\n  • SDLC Pipeline System for structured development\n  • 7-phase development lifecycle management'
    : '';
  
  const prdInfo = withPRD
    ? '\n  • PRD System for requirements management\n  • Automatic Korean to English translation\n  • Templates optimized for your project type'
    : '';
    
  console.log(`
✅ Project created successfully!

Next steps:
  cd ${path.relative(process.cwd(), targetPath)}
  # Start developing with Claude Code

Your project includes:
  • Claude Code agents for AI-assisted development
  • Pre-configured commands and workflows
  • Project templates and best practices${sdlcInfo}${prdInfo}

${withPRD ? 'Start with PRD:\n  /manage:prd create "feature-name"\n' : ''}
Happy coding! 🎉
`);
}

// Main execution (async)
async function main() {
  try {
    const { projectName, starterType, targetPath, withSDLC, sdlcTemplate, withPRD, prdTemplate } = parseArgs();
    validateStarter(starterType);
    await createProject(projectName, starterType, targetPath, withSDLC, sdlcTemplate, withPRD, prdTemplate);
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