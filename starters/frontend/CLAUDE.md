# Claude Assistant Rules for Frontend Project

## 🚀 Context Engineering System for Frontend Development

This frontend project leverages the advanced Context Engineering Template with 25+ specialized commands, 25+ AI agents, SDLC Pipeline System, and PRD-driven development for comprehensive UI/UX lifecycle management.

## 🎯 Frontend Development Principles

### Claude Code Integration
- Utilize `/analyze:*` commands for component architecture and performance analysis
- Apply `/implement:*` commands for production-ready UI component development
- Execute `/manage:*` commands for build optimization and deployment
- Leverage `/support:*` commands for UI testing and documentation
- Orchestrate complex UI workflows using `/orchestrate` for feature coordination

### Frontend-Specialized AI Agents
- **Analysis Agents**: architecture-analyzer (component structure), performance-analyzer (bundle size, rendering)
- **Implementation Agents**: feature-implementer (React/Vue/Angular components), code-enhancement-specialist (UI optimization)
- **Management Agents**: git-workflow-manager (feature branches), build-packager (webpack/vite optimization)
- **Support Agents**: issue-diagnostician (UI debugging), focused-doc-generator (component documentation)
- **PRD Agents**: prd-creator, prd-reviewer, prd-workflow-generator (UI/UX requirements management)

## 📋 Frontend Project Recognition & Context Awareness

### Pre-Work Analysis Protocol
1. **Component Discovery**: Execute `/analyze:project-context .` to understand component hierarchy
2. **Performance Assessment**: Run `/analyze:performance .` for bundle analysis and optimization
3. **Accessibility Audit**: Apply `/analyze:code-quality .` with focus on a11y standards
4. **Design System Review**: Check existing component library and design tokens

### Frontend Documentation-First Development
- Maintain `docs/COMPONENT_LIBRARY.md` for reusable components
- Keep Storybook stories updated for component showcase
- Reference `docs/DESIGN_SYSTEM.md` for UI patterns and tokens
- Update `docs/ACCESSIBILITY.md` with WCAG compliance notes
- Document responsive breakpoints and browser compatibility

## 🏗️ Frontend Architecture Standards

### Component Design Principles
- **Atomic Design**: Atoms → Molecules → Organisms → Templates → Pages
- **Single Responsibility**: Each component has one clear purpose
- **Props Interface**: Well-typed props with TypeScript/PropTypes
- **Composition Over Inheritance**: Favor component composition
- **Performance First**: Lazy loading, code splitting, memoization

### State Management Best Practices
- **Local State**: useState/useReducer for component state
- **Global State**: Context API, Redux, Zustand for app state
- **Server State**: React Query, SWR for API data caching
- **Form State**: React Hook Form, Formik for form management
- **URL State**: React Router for navigation state

### Frontend Testing Strategy
- **Unit Testing**: 85%+ coverage for components and hooks
- **Integration Testing**: User flow testing with React Testing Library
- **Visual Testing**: Snapshot and visual regression testing
- **E2E Testing**: Cypress/Playwright for critical user journeys
- **Accessibility Testing**: Automated a11y testing with axe-core

## 📝 PRD-Driven Frontend Development

### UI/UX Requirements Documents
Start frontend features with structured PRD process:
```bash
# Create frontend feature PRD
/manage:prd create "dashboard-ui" --template=frontend

# Review PRD quality
/support:prd-review "dashboard-ui"

# Approve and start development
/manage:prd approve "dashboard-ui"  # Auto-starts SDLC
```

### Frontend PRD Template Sections
- **UI Specifications**: Wireframes, mockups, interaction patterns
- **Component Requirements**: Reusable components and props
- **State Management**: Data flow and state requirements
- **Performance Goals**: Load time, FPS, bundle size targets
- **Accessibility Requirements**: WCAG compliance level

## 🔄 SDLC Pipeline for Frontend Projects

### Frontend Development Pipeline
```bash
# Initialize frontend feature pipeline
/sdlc "ui-feature" --init --template=agile

# Or start from approved PRD
/sdlc "ui-feature" --init --from-prd
```

### Frontend-Specific Pipeline Phases
1. **Planning**: UI/UX requirements and user stories
2. **Design**: Component architecture and design system
3. **Implementation**: Component development and styling
4. **Review**: Code review and design QA
5. **Testing**: Component and E2E testing
6. **Deployment**: Build optimization and CDN deployment
7. **Documentation**: Component docs and Storybook

## 🚀 Advanced Frontend Workflows

### Complex UI Orchestration
```bash
# Design system implementation
/orchestrate "implement design system with tokens, components, and documentation"

# Micro-frontend architecture
/orchestrate "implement micro-frontend with module federation"

# Performance optimization
/orchestrate "optimize React app performance with code splitting and lazy loading"
```

### Frontend Development Commands
```bash
# Analyze component architecture
/analyze:architecture . --focus=components

# Implement new component
/implement:feature "data-visualization-dashboard"

# Generate component documentation
/support:document "component-library" --format=storybook

# Run frontend tests
/manage:test "component-tests"
```

## 🎨 UI/UX Best Practices

### Design System Integration
- **Design Tokens**: Consistent colors, spacing, typography
- **Component Library**: Reusable, documented components
- **Icon System**: Consistent iconography with SVG sprites
- **Animation Library**: Performant, accessible animations
- **Theme Support**: Light/dark mode with CSS variables

### Performance Optimization
- **Bundle Optimization**: Tree shaking, minification, compression
- **Image Optimization**: WebP, lazy loading, responsive images
- **Code Splitting**: Route-based and component-based splitting
- **Caching Strategy**: Service workers and browser caching
- **Rendering Optimization**: Virtual scrolling, memoization

## 🔧 Frontend Troubleshooting

### Common Frontend Issues
1. **Performance Issues**: Use `/analyze:performance .` for bundle analysis
2. **Rendering Problems**: Run `/support:diagnose "rendering-issue"`
3. **State Management**: Apply `/analyze:architecture . --focus=state`
4. **Build Failures**: Execute `/manage:build . --debug`

## 📊 Frontend Success Metrics

### Performance KPIs
- **Core Web Vitals**: LCP < 2.5s, FID < 100ms, CLS < 0.1
- **Bundle Size**: Initial bundle < 200KB (gzipped)
- **Time to Interactive**: TTI < 3.8s
- **Lighthouse Score**: 90+ for performance

### Quality Metrics
- **Component Coverage**: 100% documented components
- **Test Coverage**: Minimum 85% for components
- **Accessibility Score**: WCAG AA compliance
- **Browser Compatibility**: Support for 95%+ users

## 📚 Bilingual Documentation Requirements

All frontend documentation MUST be provided in both English and Korean:
- Component documentation (COMPONENTS.md / COMPONENTS.ko.md)
- Design system guide (DESIGN.md / DESIGN.ko.md)
- Accessibility guide (A11Y.md / A11Y.ko.md)
- Performance guide (PERFORMANCE.md / PERFORMANCE.ko.md)

Transform your frontend development with intelligent AI assistance, PRD-driven requirements, and SDLC Pipeline System, ensuring exceptional user experiences while accelerating delivery through systematic automation.