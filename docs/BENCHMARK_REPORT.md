# Performance Benchmark Report

**Generated**: 2025-08-15T18:14:52.019Z
**Platform**: darwin 24.6.0
**Node Version**: v23.10.0
**CPU**: Apple M1 Pro
**Memory**: 16.00 GB

## Summary

| Metric | Value |
|--------|-------|
| Total Operations | 5 |
| Successful | 4 |
| Failed | 1 |
| Total Time | 2.02ms |
| Average Time | 0.51ms |

## Detailed Results

| Operation | Duration (ms) | Status |
|-----------|--------------|--------|
| Sync File Write | 0.28 | ✅ |
| Sync File Read | 0.05 | ✅ |
| Async File Write | 1.31 | ✅ |
| Async File Read | 0.39 | ✅ |
| Basic Project Creation | 48.20 | ❌ |

## Errors

- **Basic Project Creation**: Command failed: node /Users/leo/project/context-engineering-template/cli/claude-init.js benchmark-test basic /var/folders/qk/0tqdn5hs5d911dj532dks9380000gn/T/benchmark-1755281691965
Error: Directory /var/folders/qk/0tqdn5hs5d911dj532dks9380000gn/T/benchmark-1755281691965 already exists

