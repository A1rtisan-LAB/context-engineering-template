#!/usr/bin/env node

/**
 * Performance Benchmark Script for Claude Code Template
 * Measures initialization time, file operations, and overall performance
 */

const { performance } = require('perf_hooks');
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

// Colors for console output
const colors = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  red: '\x1b[31m',
  cyan: '\x1b[36m'
};

class Benchmark {
  constructor() {
    this.results = [];
    this.tempDir = path.join(os.tmpdir(), `benchmark-${Date.now()}`);
  }

  /**
   * Measure time for a specific operation
   */
  async measure(name, fn) {
    const start = performance.now();
    try {
      await fn();
      const end = performance.now();
      const duration = end - start;
      this.results.push({ name, duration, status: 'success' });
      return duration;
    } catch (error) {
      const end = performance.now();
      const duration = end - start;
      this.results.push({ name, duration, status: 'error', error: error.message });
      throw error;
    }
  }

  /**
   * Benchmark CLI initialization
   */
  async benchmarkCLIInit() {
    console.log(`\n${colors.cyan}📊 Benchmarking CLI Initialization...${colors.reset}`);
    
    // Create temp directory for testing
    if (!fs.existsSync(this.tempDir)) {
      fs.mkdirSync(this.tempDir, { recursive: true });
    }

    const testProjectName = 'benchmark-test';
    const testProjectPath = path.join(this.tempDir, testProjectName);

    try {
      // Measure basic project creation
      const basicTime = await this.measure('Basic Project Creation', async () => {
        execSync(`node ${path.join(__dirname, '../cli/claude-init.js')} ${testProjectName} basic ${this.tempDir}`, {
          stdio: 'pipe'
        });
      });
      console.log(`  ✓ Basic project: ${colors.green}${basicTime.toFixed(2)}ms${colors.reset}`);

      // Clean up for next test
      if (fs.existsSync(testProjectPath)) {
        fs.rmSync(testProjectPath, { recursive: true, force: true });
      }

      // Measure API project creation
      const apiTime = await this.measure('API Project Creation', async () => {
        execSync(`node ${path.join(__dirname, '../cli/claude-init.js')} ${testProjectName} api ${this.tempDir}`, {
          stdio: 'pipe'
        });
      });
      console.log(`  ✓ API project: ${colors.green}${apiTime.toFixed(2)}ms${colors.reset}`);

      // Clean up for next test
      if (fs.existsSync(testProjectPath)) {
        fs.rmSync(testProjectPath, { recursive: true, force: true });
      }

      // Measure frontend project creation
      const frontendTime = await this.measure('Frontend Project Creation', async () => {
        execSync(`node ${path.join(__dirname, '../cli/claude-init.js')} ${testProjectName} frontend ${this.tempDir}`, {
          stdio: 'pipe'
        });
      });
      console.log(`  ✓ Frontend project: ${colors.green}${frontendTime.toFixed(2)}ms${colors.reset}`);

      // Clean up for next test
      if (fs.existsSync(testProjectPath)) {
        fs.rmSync(testProjectPath, { recursive: true, force: true });
      }

      // Measure fullstack project creation
      const fullstackTime = await this.measure('Fullstack Project Creation', async () => {
        execSync(`node ${path.join(__dirname, '../cli/claude-init.js')} ${testProjectName} fullstack ${this.tempDir}`, {
          stdio: 'pipe'
        });
      });
      console.log(`  ✓ Fullstack project: ${colors.green}${fullstackTime.toFixed(2)}ms${colors.reset}`);

    } catch (error) {
      console.error(`  ✗ Error: ${colors.red}${error.message}${colors.reset}`);
    }
  }

  /**
   * Benchmark file operations
   */
  async benchmarkFileOperations() {
    console.log(`\n${colors.cyan}📊 Benchmarking File Operations...${colors.reset}`);

    // Ensure temp directory exists
    if (!fs.existsSync(this.tempDir)) {
      fs.mkdirSync(this.tempDir, { recursive: true });
    }

    const testFile = path.join(this.tempDir, 'test-file.txt');
    const testContent = 'Test content for benchmarking'.repeat(100);

    // Measure synchronous write
    const syncWriteTime = await this.measure('Sync File Write', () => {
      fs.writeFileSync(testFile, testContent);
    });
    console.log(`  ✓ Sync write: ${colors.green}${syncWriteTime.toFixed(2)}ms${colors.reset}`);

    // Measure synchronous read
    const syncReadTime = await this.measure('Sync File Read', () => {
      fs.readFileSync(testFile, 'utf8');
    });
    console.log(`  ✓ Sync read: ${colors.green}${syncReadTime.toFixed(2)}ms${colors.reset}`);

    // Measure async write
    const asyncWriteTime = await this.measure('Async File Write', async () => {
      await fs.promises.writeFile(testFile, testContent);
    });
    console.log(`  ✓ Async write: ${colors.green}${asyncWriteTime.toFixed(2)}ms${colors.reset}`);

    // Measure async read
    const asyncReadTime = await this.measure('Async File Read', async () => {
      await fs.promises.readFile(testFile, 'utf8');
    });
    console.log(`  ✓ Async read: ${colors.green}${asyncReadTime.toFixed(2)}ms${colors.reset}`);

    // Calculate improvement
    const writeImprovement = ((syncWriteTime - asyncWriteTime) / syncWriteTime * 100).toFixed(1);
    const readImprovement = ((syncReadTime - asyncReadTime) / syncReadTime * 100).toFixed(1);
    
    console.log(`  📈 Async improvement - Write: ${colors.yellow}${writeImprovement}%${colors.reset}, Read: ${colors.yellow}${readImprovement}%${colors.reset}`);
  }

  /**
   * Benchmark template validation
   */
  async benchmarkTemplateValidation() {
    console.log(`\n${colors.cyan}📊 Benchmarking Template Validation...${colors.reset}`);

    const validatorScript = path.join(__dirname, '../lib/template-validator.sh');
    
    if (fs.existsSync(validatorScript)) {
      const validationTime = await this.measure('Template Validation', () => {
        execSync(`bash ${validatorScript} validate`, {
          stdio: 'pipe'
        });
      });
      console.log(`  ✓ Validation time: ${colors.green}${validationTime.toFixed(2)}ms${colors.reset}`);
    } else {
      console.log(`  ⚠ Validator script not found`);
    }
  }

  /**
   * Generate performance report
   */
  generateReport() {
    console.log(`\n${colors.bright}${colors.blue}📊 Performance Report${colors.reset}`);
    console.log('═'.repeat(60));

    // Calculate statistics
    const successful = this.results.filter(r => r.status === 'success');
    const failed = this.results.filter(r => r.status === 'error');
    
    if (successful.length > 0) {
      const totalTime = successful.reduce((sum, r) => sum + r.duration, 0);
      const avgTime = totalTime / successful.length;
      const minTime = Math.min(...successful.map(r => r.duration));
      const maxTime = Math.max(...successful.map(r => r.duration));

      console.log(`\n${colors.bright}Summary:${colors.reset}`);
      console.log(`  Total operations: ${this.results.length}`);
      console.log(`  Successful: ${colors.green}${successful.length}${colors.reset}`);
      console.log(`  Failed: ${colors.red}${failed.length}${colors.reset}`);
      console.log(`  Total time: ${colors.yellow}${totalTime.toFixed(2)}ms${colors.reset}`);
      console.log(`  Average time: ${colors.yellow}${avgTime.toFixed(2)}ms${colors.reset}`);
      console.log(`  Min time: ${colors.green}${minTime.toFixed(2)}ms${colors.reset}`);
      console.log(`  Max time: ${colors.red}${maxTime.toFixed(2)}ms${colors.reset}`);

      // Find slowest operations
      const slowest = successful.sort((a, b) => b.duration - a.duration).slice(0, 3);
      console.log(`\n${colors.bright}Slowest Operations:${colors.reset}`);
      slowest.forEach((op, i) => {
        console.log(`  ${i + 1}. ${op.name}: ${colors.yellow}${op.duration.toFixed(2)}ms${colors.reset}`);
      });

      // Performance recommendations
      console.log(`\n${colors.bright}Recommendations:${colors.reset}`);
      
      const cliOps = successful.filter(r => r.name.includes('Project Creation'));
      if (cliOps.length > 0) {
        const avgCliTime = cliOps.reduce((sum, r) => sum + r.duration, 0) / cliOps.length;
        if (avgCliTime > 1000) {
          console.log(`  ⚠ CLI initialization is slow (${avgCliTime.toFixed(0)}ms avg)`);
          console.log(`    Consider converting to async/await for better performance`);
        }
      }

      const fileOps = successful.filter(r => r.name.includes('File'));
      if (fileOps.length > 0) {
        const syncOps = fileOps.filter(r => r.name.includes('Sync'));
        const asyncOps = fileOps.filter(r => r.name.includes('Async'));
        if (syncOps.length > 0 && asyncOps.length > 0) {
          const avgSyncTime = syncOps.reduce((sum, r) => sum + r.duration, 0) / syncOps.length;
          const avgAsyncTime = asyncOps.reduce((sum, r) => sum + r.duration, 0) / asyncOps.length;
          const improvement = ((avgSyncTime - avgAsyncTime) / avgSyncTime * 100).toFixed(1);
          console.log(`  ✓ Async operations are ${improvement}% faster than sync operations`);
        }
      }
    }

    // Save report to file
    const reportPath = path.join(__dirname, '../docs/BENCHMARK_REPORT.md');
    const reportContent = this.generateMarkdownReport();
    fs.writeFileSync(reportPath, reportContent);
    console.log(`\n${colors.green}✓ Report saved to: ${reportPath}${colors.reset}`);
  }

  /**
   * Generate markdown report
   */
  generateMarkdownReport() {
    const timestamp = new Date().toISOString();
    const successful = this.results.filter(r => r.status === 'success');
    const failed = this.results.filter(r => r.status === 'error');
    const totalTime = successful.reduce((sum, r) => sum + r.duration, 0);
    const avgTime = successful.length > 0 ? totalTime / successful.length : 0;

    let markdown = `# Performance Benchmark Report\n\n`;
    markdown += `**Generated**: ${timestamp}\n`;
    markdown += `**Platform**: ${os.platform()} ${os.release()}\n`;
    markdown += `**Node Version**: ${process.version}\n`;
    markdown += `**CPU**: ${os.cpus()[0].model}\n`;
    markdown += `**Memory**: ${(os.totalmem() / 1024 / 1024 / 1024).toFixed(2)} GB\n\n`;

    markdown += `## Summary\n\n`;
    markdown += `| Metric | Value |\n`;
    markdown += `|--------|-------|\n`;
    markdown += `| Total Operations | ${this.results.length} |\n`;
    markdown += `| Successful | ${successful.length} |\n`;
    markdown += `| Failed | ${failed.length} |\n`;
    markdown += `| Total Time | ${totalTime.toFixed(2)}ms |\n`;
    markdown += `| Average Time | ${avgTime.toFixed(2)}ms |\n\n`;

    markdown += `## Detailed Results\n\n`;
    markdown += `| Operation | Duration (ms) | Status |\n`;
    markdown += `|-----------|--------------|--------|\n`;
    this.results.forEach(r => {
      const status = r.status === 'success' ? '✅' : '❌';
      markdown += `| ${r.name} | ${r.duration.toFixed(2)} | ${status} |\n`;
    });

    if (failed.length > 0) {
      markdown += `\n## Errors\n\n`;
      failed.forEach(r => {
        markdown += `- **${r.name}**: ${r.error}\n`;
      });
    }

    return markdown;
  }

  /**
   * Clean up temporary files
   */
  cleanup() {
    if (fs.existsSync(this.tempDir)) {
      fs.rmSync(this.tempDir, { recursive: true, force: true });
    }
  }

  /**
   * Run all benchmarks
   */
  async run() {
    console.log(`${colors.bright}${colors.cyan}🚀 Claude Code Template Performance Benchmark${colors.reset}`);
    console.log('═'.repeat(60));

    try {
      await this.benchmarkFileOperations();
      await this.benchmarkTemplateValidation();
      await this.benchmarkCLIInit();
      
      this.generateReport();
    } catch (error) {
      console.error(`\n${colors.red}❌ Benchmark failed: ${error.message}${colors.reset}`);
    } finally {
      this.cleanup();
    }

    console.log(`\n${colors.green}✅ Benchmark complete!${colors.reset}\n`);
  }
}

// Run benchmark if executed directly
if (require.main === module) {
  const benchmark = new Benchmark();
  benchmark.run().catch(console.error);
}

module.exports = Benchmark;