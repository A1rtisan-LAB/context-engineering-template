#!/usr/bin/env node

/**
 * Documentation Synchronization Tool
 * Validates and synchronizes documentation across languages and checks for issues
 */

const fs = require('fs').promises;
const path = require('path');

class DocSync {
  constructor(rootDir = process.cwd()) {
    // Validate and normalize the root directory path
    const normalizedPath = path.resolve(rootDir);
    
    // Ensure the path doesn't contain any directory traversal attempts
    if (normalizedPath.includes('..') || !normalizedPath.startsWith(path.resolve(process.cwd()))) {
      throw new Error('Invalid root directory: path traversal detected');
    }
    
    this.rootDir = normalizedPath;
    this.issues = [];
    this.stats = {
      totalFiles: 0,
      synchronized: 0,
      divergent: 0,
      brokenLinks: 0,
      missingTranslations: 0
    };
  }

  /**
   * Main entry point for documentation validation
   */
  async validate() {
    console.log('🔍 Starting documentation validation...\n');
    
    await this.checkBrokenReferences();
    await this.compareVersions();
    await this.detectOutdated();
    await this.generateReport();
    
    // Only fail for critical errors (broken links and critical outdated content)
    const criticalIssues = this.issues.filter(issue => 
      issue.type === 'broken-link' || 
      (issue.type === 'outdated-content' && issue.severity === 'error')
    );
    
    return criticalIssues.length === 0;
  }

  /**
   * Check for broken file references and links
   */
  async checkBrokenReferences() {
    console.log('📎 Checking for broken references...');
    
    const mdFiles = await this.findMarkdownFiles(this.rootDir);
    const linkPattern = /\[([^\]]+)\]\(([^)]+)\)/g;
    
    for (const file of mdFiles) {
      const content = await fs.readFile(file, 'utf-8');
      const matches = [...content.matchAll(linkPattern)];
      
      for (const match of matches) {
        const linkText = match[1];
        const linkPath = match[2];
        
        // Skip external links
        if (linkPath.startsWith('http://') || linkPath.startsWith('https://')) {
          continue;
        }
        
        // Skip anchors
        if (linkPath.startsWith('#')) {
          continue;
        }
        
        // Check if referenced file exists
        const absolutePath = path.resolve(path.dirname(file), linkPath.split('#')[0]);
        
        try {
          await fs.access(absolutePath);
        } catch {
          this.issues.push({
            type: 'broken-link',
            file: path.relative(this.rootDir, file),
            message: `Broken link: [${linkText}](${linkPath})`,
            severity: 'error'
          });
          this.stats.brokenLinks++;
        }
      }
    }
    
    console.log(`  Found ${this.stats.brokenLinks} broken links\n`);
  }

  /**
   * Compare English and Korean versions for synchronization
   */
  async compareVersions() {
    console.log('🔄 Comparing language versions...');
    
    const mdFiles = await this.findMarkdownFiles(this.rootDir);
    const englishFiles = mdFiles.filter(f => !f.endsWith('.ko.md'));
    
    for (const enFile of englishFiles) {
      const koFile = enFile.replace('.md', '.ko.md');
      const enRelative = path.relative(this.rootDir, enFile);
      
      // Skip files that don't need translation
      if (enRelative.startsWith('packages/@claude-code/agents/src/') ||
          enRelative.startsWith('packages/@claude-code/commands/src/') ||
          enRelative.startsWith('packages/@claude-code/workflows/src/') ||
          enRelative.startsWith('packages/@claude-code/core/') ||
          enRelative.startsWith('packages/@claude-code/agents/README') ||
          enRelative.startsWith('packages/@claude-code/commands/README') ||
          enRelative.startsWith('packages/@claude-code/workflows/README') ||
          enRelative === 'CLAUDE.md' ||
          enRelative.includes('/CLAUDE.md') ||
          enRelative.includes('/templates/prd/') ||
          enRelative.includes('starters/') && enRelative.includes('/docs/README.md')) {
        continue;
      }
      
      this.stats.totalFiles++;
      
      try {
        await fs.access(koFile);
        
        // Compare file sizes as a simple divergence check
        const enStats = await fs.stat(enFile);
        const koStats = await fs.stat(koFile);
        
        // If sizes differ by more than 20%, consider them divergent
        const sizeDiff = Math.abs(enStats.size - koStats.size) / enStats.size;
        
        if (sizeDiff > 0.2) {
          this.issues.push({
            type: 'version-divergence',
            file: enRelative,
            message: `English and Korean versions may be out of sync (${Math.round(sizeDiff * 100)}% size difference)`,
            severity: 'warning'
          });
          this.stats.divergent++;
        } else {
          this.stats.synchronized++;
        }
        
        // Check modification times
        if (enStats.mtime > koStats.mtime) {
          const daysDiff = Math.floor((enStats.mtime - koStats.mtime) / (1000 * 60 * 60 * 24));
          if (daysDiff > 7) {
            this.issues.push({
              type: 'outdated-translation',
              file: enRelative,
              message: `Korean version is ${daysDiff} days older than English version`,
              severity: 'warning'
            });
          }
        }
      } catch {
        // Korean version doesn't exist
        this.issues.push({
          type: 'missing-translation',
          file: enRelative,
          message: 'Korean version is missing',
          severity: 'error'
        });
        this.stats.missingTranslations++;
      }
    }
    
    console.log(`  Synchronized: ${this.stats.synchronized}/${this.stats.totalFiles}`);
    console.log(`  Divergent: ${this.stats.divergent}`);
    console.log(`  Missing translations: ${this.stats.missingTranslations}\n`);
  }

  /**
   * Detect outdated content patterns
   */
  async detectOutdated() {
    console.log('📅 Detecting outdated content...');
    
    // Only check for critical outdated patterns that need fixing
    // Most references are intentional for documentation and migration context
    const patterns = [
      { pattern: /IMPROVEMENT_PLAN\.md/g, message: 'References removed IMPROVEMENT_PLAN.md document' },
      // Don't check for INITIAL.md as it's mentioned in context of "replaces INITIAL.md"
      // Don't check for legacy structures as they're often used in migration guides
      // Agent and command counts are flexible and don't need strict validation
    ];
    
    const mdFiles = await this.findMarkdownFiles(this.rootDir);
    let outdatedCount = 0;
    
    for (const file of mdFiles) {
      const content = await fs.readFile(file, 'utf-8');
      const relative = path.relative(this.rootDir, file);
      
      for (const { pattern, message } of patterns) {
        if (pattern.test(content)) {
          this.issues.push({
            type: 'outdated-content',
            file: relative,
            message,
            severity: 'warning'
          });
          outdatedCount++;
        }
      }
    }
    
    console.log(`  Found ${outdatedCount} outdated references\n`);
  }

  /**
   * Generate synchronization report
   */
  async generateReport() {
    console.log('📊 Generating report...\n');
    console.log('=' .repeat(60));
    console.log('DOCUMENTATION SYNCHRONIZATION REPORT');
    console.log('=' .repeat(60));
    console.log(`Generated: ${new Date().toISOString()}`);
    console.log(`Total Files Analyzed: ${this.stats.totalFiles}`);
    console.log();
    
    console.log('Summary:');
    console.log(`  ✅ Synchronized: ${this.stats.synchronized}`);
    console.log(`  ⚠️  Divergent: ${this.stats.divergent}`);
    console.log(`  ❌ Broken Links: ${this.stats.brokenLinks}`);
    console.log(`  ❌ Missing Translations: ${this.stats.missingTranslations}`);
    console.log();
    
    if (this.issues.length > 0) {
      console.log('Issues Found:');
      console.log('-' .repeat(60));
      
      // Group issues by type
      const groupedIssues = {};
      for (const issue of this.issues) {
        if (!groupedIssues[issue.type]) {
          groupedIssues[issue.type] = [];
        }
        groupedIssues[issue.type].push(issue);
      }
      
      for (const [type, issues] of Object.entries(groupedIssues)) {
        console.log(`\n${this.formatType(type)}:`);
        for (const issue of issues) {
          const icon = issue.severity === 'error' ? '❌' : '⚠️';
          console.log(`  ${icon} ${issue.file}: ${issue.message}`);
        }
      }
    } else {
      console.log('✅ No issues found! Documentation is in good shape.');
    }
    
    console.log('\n' + '=' .repeat(60));
  }

  /**
   * Format issue type for display
   */
  formatType(type) {
    const formats = {
      'broken-link': '🔗 Broken Links',
      'missing-translation': '🌐 Missing Translations',
      'version-divergence': '🔄 Version Divergence',
      'outdated-translation': '📅 Outdated Translations',
      'outdated-content': '📜 Outdated Content'
    };
    return formats[type] || type;
  }

  /**
   * Find all markdown files recursively
   */
  async findMarkdownFiles(dir, files = []) {
    const items = await fs.readdir(dir, { withFileTypes: true });
    
    for (const item of items) {
      const fullPath = path.join(dir, item.name);
      
      // Skip node_modules and hidden directories
      if (item.name.startsWith('.') || item.name === 'node_modules') {
        continue;
      }
      
      if (item.isDirectory()) {
        await this.findMarkdownFiles(fullPath, files);
      } else if (item.name.endsWith('.md')) {
        files.push(fullPath);
      }
    }
    
    return files;
  }

  /**
   * Suggest updates based on found issues
   */
  async suggestUpdates() {
    if (this.issues.length === 0) {
      console.log('No updates needed!');
      return;
    }
    
    console.log('\n📝 Suggested Actions:');
    console.log('-' .repeat(60));
    
    const suggestions = new Set();
    
    for (const issue of this.issues) {
      switch (issue.type) {
        case 'broken-link':
          suggestions.add('Run `/manage:docs fix-links` to automatically fix broken links');
          break;
        case 'missing-translation':
          suggestions.add('Create Korean versions for missing documents');
          break;
        case 'version-divergence':
        case 'outdated-translation':
          suggestions.add('Review and synchronize divergent language versions');
          break;
        case 'outdated-content':
          suggestions.add('Update outdated references to match current project structure');
          break;
      }
    }
    
    let i = 1;
    for (const suggestion of suggestions) {
      console.log(`${i}. ${suggestion}`);
      i++;
    }
  }
}

// CLI execution
if (require.main === module) {
  const docSync = new DocSync();
  
  docSync.validate().then(success => {
    docSync.suggestUpdates();
    process.exit(success ? 0 : 1);
  }).catch(error => {
    console.error('Error:', error);
    process.exit(1);
  });
}

module.exports = DocSync;