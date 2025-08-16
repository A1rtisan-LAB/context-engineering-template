/**
 * Jest Configuration for Claude Code Template
 * @type {import('jest').Config}
 */
module.exports = {
  // Test environment
  testEnvironment: 'node',
  
  // File extensions Jest will look for
  moduleFileExtensions: ['js', 'json'],
  
  // Test match patterns
  testMatch: [
    '**/__tests__/**/*.js',
    '**/*.test.js',
    '**/*.spec.js'
  ],
  
  // Coverage configuration
  collectCoverageFrom: [
    'cli/**/*.js',
    'scripts/**/*.js',
    'packages/**/*.js',
    '!**/node_modules/**',
    '!**/dist/**',
    '!**/coverage/**',
    '!**/__tests__/**'
  ],
  
  // Coverage thresholds
  coverageThreshold: {
    global: {
      branches: 60,
      functions: 70,
      lines: 70,
      statements: 70
    }
  },
  
  // Coverage reporters
  coverageReporters: ['text', 'lcov', 'html'],
  
  // Ignore patterns
  testPathIgnorePatterns: [
    '/node_modules/',
    '/dist/',
    '/starters/',
    '/templates/'
  ],
  
  // Transform ignore patterns
  transformIgnorePatterns: [
    '/node_modules/'
  ],
  
  // Module name mapper for aliases
  moduleNameMapper: {
    '^@claude-code/(.*)$': '<rootDir>/packages/@claude-code/$1'
  },
  
  // Setup files
  setupFilesAfterEnv: ['<rootDir>/test/setup.js'],
  
  // Verbose output
  verbose: true,
  
  // Test timeout
  testTimeout: 10000,
  
  // Clear mocks automatically between tests
  clearMocks: true,
  
  // Collect code coverage
  collectCoverage: false,
  
  // Coverage directory
  coverageDirectory: 'coverage',
  
  // Maximum worker threads
  maxWorkers: '50%'
};