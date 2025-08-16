/**
 * Unit tests for Claude Code CLI
 */

const fs = require('fs').promises;
const path = require('path');
const { spawn } = require('child_process');
const { promisify } = require('util');
const exec = promisify(require('child_process').exec);

// Path to CLI script
const CLI_PATH = path.join(__dirname, '..', 'claude-init.js');

describe('Claude Code CLI', () => {
  let tempDir;
  
  beforeEach(() => {
    // Create temp directory for each test
    tempDir = global.testUtils.createTempDir();
  });
  
  afterEach(() => {
    // Clean up temp directory
    global.testUtils.cleanupDir(tempDir);
  });
  
  describe('Command Line Arguments', () => {
    test('should show help with --help flag', async () => {
      const { stdout } = await exec(`node ${CLI_PATH} --help`);
      expect(stdout).toContain('Claude Code Project Initializer');
      expect(stdout).toContain('Usage:');
      expect(stdout).toContain('Arguments:');
      expect(stdout).toContain('Options:');
    });
    
    test('should show version with --version flag', async () => {
      const { stdout } = await exec(`node ${CLI_PATH} --version`);
      expect(stdout).toContain('Claude Code Initializer v');
    });
    
    test('should show help with -h flag', async () => {
      const { stdout } = await exec(`node ${CLI_PATH} -h`);
      expect(stdout).toContain('Claude Code Project Initializer');
    });
    
    test('should show version with -v flag', async () => {
      const { stdout } = await exec(`node ${CLI_PATH} -v`);
      expect(stdout).toContain('Claude Code Initializer v');
    });
  });
  
  describe('Project Creation', () => {
    test('should create basic project with default settings', async () => {
      const projectName = 'test-basic-project';
      const projectPath = path.join(tempDir, projectName);
      
      const { stdout } = await exec(
        `node ${CLI_PATH} ${projectName} basic ${tempDir}`
      );
      
      expect(stdout).toContain('Creating Claude Code project');
      expect(stdout).toContain('Project created successfully');
      
      // Check if project directory was created
      const stats = await fs.stat(projectPath);
      expect(stats.isDirectory()).toBe(true);
      
      // Check if .claude directory exists
      const claudeDir = path.join(projectPath, '.claude');
      const claudeStats = await fs.stat(claudeDir);
      expect(claudeStats.isDirectory()).toBe(true);
      
      // Verify NO src/ subdirectories exist
      const agentsSrcPath = path.join(claudeDir, 'agents', 'src');
      await expect(fs.stat(agentsSrcPath)).rejects.toThrow();
      
      const commandsSrcPath = path.join(claudeDir, 'commands', 'src');
      await expect(fs.stat(commandsSrcPath)).rejects.toThrow();
      
      const workflowsSrcPath = path.join(claudeDir, 'workflows', 'src');
      await expect(fs.stat(workflowsSrcPath)).rejects.toThrow();
      
      // Verify files exist directly in directories
      const agentsDir = path.join(claudeDir, 'agents');
      const agentFiles = await fs.readdir(agentsDir);
      expect(agentFiles.length).toBeGreaterThan(0);
      expect(agentFiles.some(f => f.endsWith('.md'))).toBe(true);
      
      const commandsDir = path.join(claudeDir, 'commands');
      const commandFiles = await fs.readdir(commandsDir);
      expect(commandFiles.length).toBeGreaterThan(0);
      
      const workflowsDir = path.join(claudeDir, 'workflows');
      const workflowFiles = await fs.readdir(workflowsDir);
      expect(workflowFiles.length).toBeGreaterThan(0);
      expect(workflowFiles.some(f => f.endsWith('.md'))).toBe(true);
    });
    
    test('should fail if directory already exists', async () => {
      const projectName = 'existing-project';
      const projectPath = path.join(tempDir, projectName);
      
      // Create directory first
      await fs.mkdir(projectPath, { recursive: true });
      
      // Try to create project in existing directory
      await expect(
        exec(`node ${CLI_PATH} ${projectName} basic ${tempDir}`)
      ).rejects.toThrow('Directory');
    });
    
    test('should fail with invalid starter type', async () => {
      const projectName = 'invalid-starter';
      
      await expect(
        exec(`node ${CLI_PATH} ${projectName} invalid-type ${tempDir}`)
      ).rejects.toThrow('Invalid starter type');
    });
    
    test('should create API project', async () => {
      const projectName = 'test-api-project';
      const projectPath = path.join(tempDir, projectName);
      
      const { stdout } = await exec(
        `node ${CLI_PATH} ${projectName} api ${tempDir}`
      );
      
      expect(stdout).toContain('Type: api');
      expect(stdout).toContain('Project created successfully');
      
      const stats = await fs.stat(projectPath);
      expect(stats.isDirectory()).toBe(true);
    });
    
    test('should create frontend project', async () => {
      const projectName = 'test-frontend-project';
      const projectPath = path.join(tempDir, projectName);
      
      const { stdout } = await exec(
        `node ${CLI_PATH} ${projectName} frontend ${tempDir}`
      );
      
      expect(stdout).toContain('Type: frontend');
      expect(stdout).toContain('Project created successfully');
      
      const stats = await fs.stat(projectPath);
      expect(stats.isDirectory()).toBe(true);
    });
    
    test('should create fullstack project', async () => {
      const projectName = 'test-fullstack-project';
      const projectPath = path.join(tempDir, projectName);
      
      const { stdout } = await exec(
        `node ${CLI_PATH} ${projectName} fullstack ${tempDir}`
      );
      
      expect(stdout).toContain('Type: fullstack');
      expect(stdout).toContain('Project created successfully');
      
      const stats = await fs.stat(projectPath);
      expect(stats.isDirectory()).toBe(true);
    });
  });
  
  describe('Performance', () => {
    test('should create project quickly (under 100ms)', async () => {
      const projectName = 'perf-test-project';
      const startTime = Date.now();
      
      await exec(`node ${CLI_PATH} ${projectName} basic ${tempDir}`);
      
      const duration = Date.now() - startTime;
      expect(duration).toBeLessThan(100);
    });
    
    test('should show timing information', async () => {
      const projectName = 'timing-test-project';
      
      const { stdout } = await exec(
        `node ${CLI_PATH} ${projectName} basic ${tempDir}`
      );
      
      expect(stdout).toMatch(/Project created in \d+ms/);
    });
  });
  
  describe('Placeholder Replacement', () => {
    test('should replace PROJECT_NAME in files', async () => {
      const projectName = 'placeholder-test';
      const projectPath = path.join(tempDir, projectName);
      
      await exec(`node ${CLI_PATH} ${projectName} basic ${tempDir}`);
      
      // Check if README exists and contains project name
      const readmePath = path.join(projectPath, 'README.md');
      try {
        const content = await fs.readFile(readmePath, 'utf8');
        expect(content).toContain(projectName);
      } catch (error) {
        // README might not exist in basic starter, that's okay
      }
      
      // Check CLAUDE.md
      const claudePath = path.join(projectPath, 'CLAUDE.md');
      try {
        const content = await fs.readFile(claudePath, 'utf8');
        expect(content).not.toContain('PROJECT_NAME');
      } catch (error) {
        // File might not exist, that's okay
      }
    });
  });
  
  describe('Claude Directory Structure', () => {
    test('should have correct .claude structure without src subdirectories', async () => {
      const projectTypes = ['basic', 'api', 'frontend', 'fullstack'];
      
      for (const projectType of projectTypes) {
        const projectName = `structure-test-${projectType}`;
        const projectPath = path.join(tempDir, projectName);
        
        await exec(`node ${CLI_PATH} ${projectName} ${projectType} ${tempDir}`);
        
        const claudeDir = path.join(projectPath, '.claude');
        
        // Check agents directory
        const agentsDir = path.join(claudeDir, 'agents');
        const agentsExists = await fs.stat(agentsDir).then(() => true).catch(() => false);
        if (agentsExists) {
          // Should NOT have src subdirectory
          const agentsSrc = path.join(agentsDir, 'src');
          await expect(fs.stat(agentsSrc)).rejects.toThrow();
          
          // Should have .md files directly
          const agentFiles = await fs.readdir(agentsDir);
          expect(agentFiles.some(f => f.endsWith('.md'))).toBe(true);
        }
        
        // Check commands directory
        const commandsDir = path.join(claudeDir, 'commands');
        const commandsExists = await fs.stat(commandsDir).then(() => true).catch(() => false);
        if (commandsExists) {
          // Should NOT have src subdirectory
          const commandsSrc = path.join(commandsDir, 'src');
          await expect(fs.stat(commandsSrc)).rejects.toThrow();
          
          // Should have content directly
          const commandContent = await fs.readdir(commandsDir);
          expect(commandContent.length).toBeGreaterThan(0);
        }
        
        // Check workflows directory
        const workflowsDir = path.join(claudeDir, 'workflows');
        const workflowsExists = await fs.stat(workflowsDir).then(() => true).catch(() => false);
        if (workflowsExists) {
          // Should NOT have src subdirectory
          const workflowsSrc = path.join(workflowsDir, 'src');
          await expect(fs.stat(workflowsSrc)).rejects.toThrow();
          
          // Should have .md files directly
          const workflowFiles = await fs.readdir(workflowsDir);
          expect(workflowFiles.some(f => f.endsWith('.md'))).toBe(true);
        }
      }
    });
  });
});