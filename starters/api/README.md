# API Starter Template

Context Engineering Template for API server projects with 23+ specialized AI agents and SDLC Pipeline System.

## 🚀 Project Structure

```
api-project/
├── src/
│   ├── routes/          # API route definitions
│   ├── middleware/      # Express middleware
│   ├── models/          # Data models
│   └── controllers/     # Route controllers
├── tests/               # Test files
├── docs/                # Documentation including SDLC guides
├── .claude/             # Claude Code configuration
├── package.json         # Node.js dependencies
├── server.js           # Main server file
└── .env.example        # Environment variables template
```

## 📊 SDLC Pipeline System

### Quick Start
```bash
# Initialize SDLC Pipeline for API project
/sdlc "api-feature" --init --template=standard

# Check pipeline status
/sdlc "api-feature" --status

# Generate progress report
/support:sdlc-report "api-feature"
```

### API Development Workflow
```bash
# Phase 1: Planning (Day 1-2)
/sdlc "api-feature" --phase=planning
/support:estimate api-endpoints

# Phase 2: Design (Day 3-5)
/sdlc "api-feature" --phase=design
/support:document api-specification

# Phase 3: Implementation (Day 6-10)
/sdlc "api-feature" --phase=implementation
/implement:feature api-endpoints
/implement:feature authentication
/implement:feature data-validation

# Phase 4: Review (Day 11)
/sdlc "api-feature" --phase=review
/analyze:security api-endpoints
/analyze:code-quality .

# Phase 5: Testing (Day 12-13)
/sdlc "api-feature" --phase=testing
/manage:test api-tests
/analyze:performance api-load

# Phase 6: Deployment (Day 14)
/sdlc "api-feature" --phase=deployment
/manage:build production
/manage:workflow deployment-pipeline

# Phase 7: Documentation (Day 15)
/sdlc "api-feature" --phase=documentation
/support:document openapi-spec
```

## 🛠️ Features

- RESTful API architecture
- Express.js framework setup
- Middleware configuration
- Model-View-Controller pattern
- Environment-based configuration
- Testing framework integration
- OpenAPI documentation
- Security best practices
- Performance monitoring

## 🚀 Getting Started

1. Install dependencies:
   ```bash
   npm install
   ```

2. Set up environment variables:
   ```bash
   cp .env.example .env
   ```

3. Initialize SDLC Pipeline (optional):
   ```bash
   /sdlc "my-api" --init
   ```

4. Start the development server:
   ```bash
   npm run dev
   ```

## 🤖 Claude Code Commands

### Analysis Commands
- `/analyze:architecture` - Review API architecture
- `/analyze:security` - Security audit
- `/analyze:performance` - Performance analysis
- `/analyze:code-quality` - Code quality metrics

### Implementation Commands
- `/implement:feature` - Add new API endpoints
- `/implement:enhancement` - Improve existing code
- `/implement:cleanup` - Code refactoring

### Management Commands
- `/manage:test` - Run test suites
- `/manage:build` - Build for production
- `/manage:git` - Version control
- `/manage:workflow` - CI/CD pipeline

### Support Commands
- `/support:document` - Generate documentation
- `/support:estimate` - Development time estimation
- `/support:diagnose` - Troubleshooting
- `/support:sdlc-report` - SDLC progress reports

## 📚 Documentation

- [SDLC Pipeline Guide](docs/SDLC_GUIDE.md) ([한국어](docs/SDLC_GUIDE.ko.md))
- [API Design Guidelines](docs/API_DESIGN.md)
- [Security Best Practices](docs/SECURITY.md)
- [Testing Strategy](docs/TESTING.md)

## 🌏 Languages

This document is also available in:
- [한국어](README.ko.md)