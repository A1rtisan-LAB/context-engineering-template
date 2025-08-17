# Fullstack Starter Template

Context Engineering Template for full-stack applications with 23+ specialized AI agents and SDLC Pipeline System.

## 🚀 Project Structure

```
fullstack-project/
├── client/
│   └── src/            # Frontend React application
├── server/
│   └── src/            # Backend Node.js API
├── shared/             # Shared utilities and types
├── docs/               # Documentation including SDLC guides
├── tests/              # End-to-end tests
├── .claude/            # Claude Code configuration
├── package.json        # Root package.json
└── docker-compose.yml  # Development environment
```

## 📝 PRD-Driven Development

### Product Requirements Documents
Start your development with structured PRD process for clear requirements and automatic SDLC integration:

```bash
# Create PRD for new feature
/manage:prd create "feature-name" --template=fullstack

# Review PRD quality (80+ score required)
/support:prd-review "feature-name"

# Approve PRD (automatically starts SDLC)
/manage:prd approve "feature-name"
```

### PRD Workflow Benefits
- **Clear Requirements**: Define what needs to be built before coding
- **Quality Gates**: Review process ensures completeness
- **Auto Translation**: Korean PRDs automatically translated to English
- **SDLC Integration**: Approved PRDs trigger development pipeline
- **Documentation Trail**: Complete history from idea to implementation

For detailed guidance, see [PRD Guide](docs/guides/PRD_GUIDE.md) ([한국어](docs/guides/PRD_GUIDE.ko.md))
## 📊 SDLC Pipeline System

### Quick Start
```bash
# Initialize SDLC Pipeline for fullstack project
/sdlc "fullstack-app" --init --template=agile

# Check pipeline status
/sdlc "fullstack-app" --status

# Generate progress report
/support:sdlc-report "fullstack-app"
```

### Fullstack Development Workflow
```bash
# Phase 1: Planning (Sprint 1, Day 1-2)
/sdlc "fullstack-app" --phase=planning
/support:estimate fullstack-features
/orchestrate "architecture planning"

# Phase 2: Design (Sprint 1, Day 3-5)
/sdlc "fullstack-app" --phase=design
/analyze:architecture system-design
/support:document api-contracts

# Phase 3: Implementation (Sprint 1-2)
/sdlc "fullstack-app" --phase=implementation
# Backend development
/implement:feature api-server
/implement:feature database-layer
/analyze:security backend
# Frontend development
/implement:feature ui-components
/implement:feature state-management
/analyze:performance frontend

# Phase 4: Review (Sprint 2, Day 11)
/sdlc "fullstack-app" --phase=review
/analyze:code-quality .
/analyze:architecture integration-points

# Phase 5: Testing (Sprint 2, Day 12-13)
/sdlc "fullstack-app" --phase=testing
/manage:test unit-tests
/manage:test integration-tests
/manage:test e2e-scenarios

# Phase 6: Deployment (Sprint 2, Day 14)
/sdlc "fullstack-app" --phase=deployment
/manage:build docker-images
/manage:workflow ci-cd-pipeline
/orchestrate "production deployment"

# Phase 7: Documentation (Sprint 2, Day 14)
/sdlc "fullstack-app" --phase=documentation
/support:document architecture-guide
/support:document deployment-guide
```

## 🛠️ Features

- Monorepo structure with client and server
- Shared type definitions
- Docker development environment
- End-to-end testing
- Continuous integration
- Database integration
- Microservices ready
- API Gateway pattern
- Real-time capabilities
- Scalable architecture

## 🏗️ Architecture

```
┌─────────────┐     ┌─────────────┐
│  Frontend   │────▶│ API Gateway │
└─────────────┘     └─────────────┘
                            │
                ┌───────────┼───────────┐
                ▼           ▼           ▼
        ┌──────────┐ ┌──────────┐ ┌──────────┐
        │ Auth API │ │ Core API │ │ Data API │
        └──────────┘ └──────────┘ └──────────┘
                │           │           │
                └───────────┼───────────┘
                            ▼
                    ┌──────────────┐
                    │   Database   │
                    └──────────────┘
```

## 🚀 Getting Started

1. Install dependencies:
   ```bash
   npm install
   ```

2. Initialize SDLC Pipeline (optional):
   ```bash
   /sdlc "my-app" --init --template=agile
   ```

3. Start the development environment:
   ```bash
   docker-compose up
   ```

4. Run tests:
   ```bash
   npm test
   ```

## 🤖 Claude Code Commands

### Orchestration
- `/orchestrate` - Coordinate full-stack development
- `/workflow-orchestrator` - Complex workflow management

### Analysis Commands
- `/analyze:architecture` - System architecture review
- `/analyze:security` - Security audit
- `/analyze:performance` - Performance analysis
- `/analyze:code-quality` - Code quality metrics

### Implementation Commands
- `/implement:feature` - Add new features
- `/implement:enhancement` - Improve existing code
- `/implement:cleanup` - Code refactoring

### Management Commands
- `/manage:build` - Build and deployment
- `/manage:workflow` - Development workflow management
- `/manage:test` - Run test suites
- `/manage:git` - Version control

### Support Commands
- `/support:document` - Generate documentation
- `/support:estimate` - Development time estimation
- `/support:diagnose` - Troubleshooting
- `/support:sdlc-report` - SDLC progress reports

## 📚 Documentation

- [SDLC Pipeline Guide](docs/guides/SDLC_GUIDE.md) ([한국어](docs/guides/SDLC_GUIDE.ko.md))
- [Architecture Guide](docs/ARCHITECTURE.md)
- [API Documentation](docs/API.md)
- [Deployment Guide](docs/DEPLOYMENT.md)
- [Testing Strategy](docs/TESTING.md)

## 🌏 Languages

This document is also available in:
- [한국어](README.ko.md)