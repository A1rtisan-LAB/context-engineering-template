/**
 * Unit tests for Performance Benchmark Script
 */

const Benchmark = require('../benchmark.js');
const fs = require('fs');
const path = require('path');
const os = require('os');

describe('Benchmark Script', () => {
  let benchmark;
  let restoreConsole;
  
  beforeEach(() => {
    benchmark = new Benchmark();
    // Mock console methods
    restoreConsole = global.testUtils.mockConsole();
  });
  
  afterEach(() => {
    // Clean up any temp files
    benchmark.cleanup();
    // Restore console
    if (restoreConsole) {
      restoreConsole();
    }
  });
  
  describe('Benchmark Class', () => {
    test('should initialize with empty results', () => {
      expect(benchmark.results).toEqual([]);
    });
    
    test('should create temp directory path', () => {
      expect(benchmark.tempDir).toContain('benchmark-');
      expect(benchmark.tempDir).toContain(os.tmpdir());
    });
  });
  
  describe('measure() method', () => {
    test('should measure successful operations', async () => {
      const duration = await benchmark.measure('Test Operation', async () => {
        await new Promise(resolve => setTimeout(resolve, 10));
      });
      
      expect(duration).toBeGreaterThan(9);
      expect(benchmark.results).toHaveLength(1);
      expect(benchmark.results[0]).toMatchObject({
        name: 'Test Operation',
        status: 'success'
      });
    });
    
    test('should handle failed operations', async () => {
      await expect(
        benchmark.measure('Failing Operation', async () => {
          throw new Error('Test error');
        })
      ).rejects.toThrow('Test error');
      
      expect(benchmark.results).toHaveLength(1);
      expect(benchmark.results[0]).toMatchObject({
        name: 'Failing Operation',
        status: 'error',
        error: 'Test error'
      });
    });
    
    test('should measure synchronous operations', async () => {
      const duration = await benchmark.measure('Sync Operation', () => {
        // Synchronous operation
        const arr = Array(1000).fill(0).map((_, i) => i * 2);
        return arr.length;
      });
      
      expect(duration).toBeGreaterThan(0);
      expect(benchmark.results[0].status).toBe('success');
    });
  });
  
  describe('benchmarkFileOperations()', () => {
    test('should benchmark file operations', async () => {
      await benchmark.benchmarkFileOperations();
      
      // Should have results for sync and async operations
      const operations = benchmark.results.map(r => r.name);
      expect(operations).toContain('Sync File Write');
      expect(operations).toContain('Sync File Read');
      expect(operations).toContain('Async File Write');
      expect(operations).toContain('Async File Read');
      
      // All operations should succeed
      const failures = benchmark.results.filter(r => r.status === 'error');
      expect(failures).toHaveLength(0);
    });
    
    test('should create temp directory if not exists', async () => {
      await benchmark.benchmarkFileOperations();
      
      // Temp directory should exist after operations
      expect(fs.existsSync(benchmark.tempDir)).toBe(true);
    });
  });
  
  describe('generateMarkdownReport()', () => {
    beforeEach(async () => {
      // Add some test results
      await benchmark.measure('Test Op 1', () => {});
      await benchmark.measure('Test Op 2', async () => {
        await new Promise(resolve => setTimeout(resolve, 5));
      });
    });
    
    test('should generate markdown report', () => {
      const report = benchmark.generateMarkdownReport();
      
      expect(report).toContain('# Performance Benchmark Report');
      expect(report).toContain('## Summary');
      expect(report).toContain('## Detailed Results');
      expect(report).toContain('Test Op 1');
      expect(report).toContain('Test Op 2');
    });
    
    test('should include system information', () => {
      const report = benchmark.generateMarkdownReport();
      
      expect(report).toContain(`Platform: ${os.platform()}`);
      expect(report).toContain(`Node Version: ${process.version}`);
      expect(report).toContain('CPU:');
      expect(report).toContain('Memory:');
    });
    
    test('should include statistics', () => {
      const report = benchmark.generateMarkdownReport();
      
      expect(report).toContain('Total Operations');
      expect(report).toContain('Successful');
      expect(report).toContain('Failed');
      expect(report).toContain('Total Time');
      expect(report).toContain('Average Time');
    });
  });
  
  describe('cleanup()', () => {
    test('should remove temp directory', async () => {
      // Create temp directory
      fs.mkdirSync(benchmark.tempDir, { recursive: true });
      fs.writeFileSync(path.join(benchmark.tempDir, 'test.txt'), 'test');
      
      expect(fs.existsSync(benchmark.tempDir)).toBe(true);
      
      benchmark.cleanup();
      
      expect(fs.existsSync(benchmark.tempDir)).toBe(false);
    });
    
    test('should handle non-existent directory', () => {
      // Should not throw even if directory doesn't exist
      expect(() => benchmark.cleanup()).not.toThrow();
    });
  });
  
  describe('generateReport()', () => {
    test('should save report to file', () => {
      // Mock fs.writeFileSync
      const writeFileSpy = jest.spyOn(fs, 'writeFileSync').mockImplementation(() => {});
      
      benchmark.generateReport();
      
      expect(writeFileSpy).toHaveBeenCalledWith(
        expect.stringContaining('BENCHMARK_REPORT.md'),
        expect.any(String)
      );
      
      writeFileSpy.mockRestore();
    });
    
    test('should calculate correct statistics', async () => {
      // Add known duration operations
      benchmark.results = [
        { name: 'Op1', duration: 10, status: 'success' },
        { name: 'Op2', duration: 20, status: 'success' },
        { name: 'Op3', duration: 30, status: 'success' },
        { name: 'Op4', duration: 0, status: 'error', error: 'Failed' }
      ];
      
      const consoleSpy = jest.spyOn(console, 'log');
      benchmark.generateReport();
      
      // Check if correct statistics are logged
      const output = consoleSpy.mock.calls.flat().join('\n');
      expect(output).toContain('Total operations: 4');
      expect(output).toContain('Successful: ');
      expect(output).toContain('3');
      expect(output).toContain('Failed: ');
      expect(output).toContain('1');
      expect(output).toContain('Total time: ');
      expect(output).toContain('60.00ms');
      expect(output).toContain('Average time: ');
      expect(output).toContain('20.00ms');
      
      consoleSpy.mockRestore();
    });
  });
});