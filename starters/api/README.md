# API Project Template

This is an example of an API server project created with Claude Code Template.

## Project Structure

```
api-project/
├── src/
│   ├── routes/          # API route definitions
│   ├── middleware/      # Express middleware
│   ├── models/          # Data models
│   └── controllers/     # Route controllers
├── tests/               # Test files
├── .claude/             # Claude Code configuration
├── package.json         # Node.js dependencies
├── server.js           # Main server file
└── .env.example        # Environment variables template
```

## Features

- RESTful API architecture
- Express.js framework setup
- Middleware configuration
- Model-View-Controller pattern
- Environment-based configuration
- Testing framework integration

## Getting Started

1. Install dependencies:
   ```bash
   npm install
   ```

2. Set up environment variables:
   ```bash
   cp .env.example .env
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```

## Claude Code Commands

- `/analyze:architecture` - Review API architecture
- `/analyze:security` - Security audit
- `/implement:feature` - Add new API endpoints
- `/manage:test` - Run test suites