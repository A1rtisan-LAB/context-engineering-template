# Full-stack Project Template

This is an example of a full-stack application created with Claude Code Template.

## Project Structure

```
fullstack-project/
├── client/
│   └── src/            # Frontend React application
├── server/
│   └── src/            # Backend Node.js API
├── shared/             # Shared utilities and types
├── docs/               # Project documentation
├── tests/              # End-to-end tests
├── .claude/            # Claude Code configuration
├── package.json        # Root package.json
└── docker-compose.yml  # Development environment
```

## Features

- Monorepo structure with client and server
- Shared type definitions
- Docker development environment
- End-to-end testing
- Continuous integration
- Database integration

## Getting Started

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the development environment:
   ```bash
   docker-compose up
   ```

3. Run tests:
   ```bash
   npm test
   ```

## Claude Code Commands

- `/orchestrate` - Coordinate full-stack development
- `/analyze:architecture` - System architecture review
- `/manage:build` - Build and deployment
- `/manage:workflow` - Development workflow management