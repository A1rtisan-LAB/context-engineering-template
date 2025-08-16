/**
 * Jest Test Setup
 * Global test configuration and utilities
 */

// Set test environment
process.env.NODE_ENV = 'test';

// Global test utilities
global.testUtils = {
  /**
   * Create a temporary directory for testing
   */
  createTempDir: () => {
    const os = require('os');
    const path = require('path');
    const fs = require('fs');
    const tempDir = path.join(os.tmpdir(), `test-${Date.now()}`);
    fs.mkdirSync(tempDir, { recursive: true });
    return tempDir;
  },
  
  /**
   * Clean up a directory
   */
  cleanupDir: (dir) => {
    const fs = require('fs');
    if (fs.existsSync(dir)) {
      fs.rmSync(dir, { recursive: true, force: true });
    }
  },
  
  /**
   * Mock console methods
   * Call this in your beforeEach/afterEach hooks
   */
  mockConsole: () => {
    const originalConsole = {
      log: console.log,
      error: console.error,
      warn: console.warn
    };
    
    console.log = jest.fn();
    console.error = jest.fn();
    console.warn = jest.fn();
    
    return () => {
      console.log = originalConsole.log;
      console.error = originalConsole.error;
      console.warn = originalConsole.warn;
    };
  }
};

// Increase timeout for CI environments
if (process.env.CI) {
  jest.setTimeout(30000);
}