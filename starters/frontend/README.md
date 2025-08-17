# Frontend Starter Template

Context Engineering Template for frontend applications with 26 specialized AI agents and SDLC Pipeline System.

## 🚀 Project Structure

```
frontend-project/
├── src/
│   ├── components/      # React components
│   ├── pages/          # Page components
│   ├── styles/         # CSS/SCSS files
│   ├── hooks/          # Custom React hooks
│   └── utils/          # Utility functions
├── public/             # Static assets
├── tests/              # Test files
├── docs/               # Documentation including SDLC guides
├── .claude/            # Claude Code configuration
├── package.json        # Node.js dependencies
└── index.html         # Main HTML file
```

## 📝 PRD-Driven Development

### Product Requirements Documents
Start your development with structured PRD process for clear requirements and automatic SDLC integration:

```bash
# Create PRD for new feature
/manage:prd create "feature-name" --template=frontend

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
# Initialize SDLC Pipeline for frontend project
/sdlc "ui-feature" --init --template=agile

# Check pipeline status
/sdlc "ui-feature" --status

# Generate progress report
/support:sdlc-report "ui-feature"
```

### Frontend Development Workflow
```bash
# Phase 1: Planning (Sprint 1, Day 1-2)
/sdlc "ui-feature" --phase=planning
/support:estimate component-development

# Phase 2: Design (Sprint 1, Day 3-5)
/sdlc "ui-feature" --phase=design
/implement:feature ui-mockups
/analyze:architecture component-structure

# Phase 3: Implementation (Sprint 1-2)
/sdlc "ui-feature" --phase=implementation
/implement:feature react-components
/implement:enhancement accessibility
/implement:feature responsive-design

# Phase 4: Review (Sprint 2, Day 11)
/sdlc "ui-feature" --phase=review
/analyze:code-quality components
/analyze:performance rendering

# Phase 5: Testing (Sprint 2, Day 12-13)
/sdlc "ui-feature" --phase=testing
/manage:test component-tests
/manage:test e2e-tests

# Phase 6: Deployment (Sprint 2, Day 14)
/sdlc "ui-feature" --phase=deployment
/manage:build production
/analyze:performance bundle-size

# Phase 7: Documentation (Sprint 2, Day 14)
/sdlc "ui-feature" --phase=documentation
/support:document component-library
```

## 🛠️ Features

- Modern React application
- Component-based architecture
- Custom hooks for state management
- Styled components/CSS modules
- Build optimization
- Development server with hot reload
- Responsive design
- Accessibility compliance
- Performance optimization
- Testing framework integration

## 🚀 Getting Started

1. Install dependencies:
   ```bash
   npm install
   ```

2. Initialize SDLC Pipeline (optional):
   ```bash
   /sdlc "my-ui" --init --template=agile
   ```

3. Start the development server:
   ```bash
   npm start
   ```

4. Build for production:
   ```bash
   npm run build
   ```

## 🤖 Claude Code Commands

### Analysis Commands
- `/analyze:code-quality` - Code quality analysis
- `/analyze:performance` - Performance optimization
- `/analyze:architecture` - Component architecture review
- `/analyze:security` - Security audit

### Implementation Commands
- `/implement:feature` - Add new components
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

- [SDLC Pipeline Guide](docs/guides/SDLC_GUIDE.md) ([한국어](docs/guides/SDLC_GUIDE.ko.md))
- [PRD Guide](docs/guides/PRD_GUIDE.md) ([한국어](docs/guides/PRD_GUIDE.ko.md))
- [Quick Start Guide](docs/guides/QUICKSTART.md) ([한국어](docs/guides/QUICKSTART.ko.md))

## 🌏 Languages

This document is also available in:
- [한국어](README.ko.md)