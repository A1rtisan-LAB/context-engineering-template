# Claude Assistant Rules for Full-Stack Project

## 🚀 Context Engineering System for Full-Stack Development

This full-stack project leverages the advanced Context Engineering Template with 26 specialized commands, 26 AI agents, SDLC Pipeline System, and PRD-driven development for comprehensive end-to-end application lifecycle management.

## 🎯 Full-Stack Development Principles

### Claude Code Integration
- Utilize `/analyze:*` commands for full-stack architecture analysis before implementation
- Apply `/implement:*` commands for production-ready feature development across all layers
- Execute `/manage:*` commands for deployment orchestration and infrastructure management
- Leverage `/support:*` commands for end-to-end testing and documentation
- Orchestrate complex full-stack workflows using `/orchestrate` for seamless integration

### Full-Stack Specialized AI Agents
- **Analysis Agents**: architecture-analyzer (system-wide), security-analyzer (full-stack security), performance-analyzer (end-to-end)
- **Implementation Agents**: feature-implementer (full-stack features), code-enhancement-specialist (cross-layer optimization)
- **Management Agents**: git-workflow-manager (monorepo), build-packager (full-stack builds), workflow-orchestrator (CI/CD)
- **Support Agents**: issue-diagnostician (cross-layer debugging), focused-doc-generator (API + UI docs)
- **PRD Agents**: prd-creator, prd-reviewer, prd-workflow-generator (full-stack requirements)

## 📋 Full-Stack Project Recognition & Context Awareness

### Pre-Work Analysis Protocol
1. **System Architecture Discovery**: Execute `/analyze:project-context .` to understand full-stack architecture
2. **Security Assessment**: Run `/analyze:security .` for comprehensive vulnerability scanning
3. **Performance Profile**: Apply `/analyze:performance .` for end-to-end optimization opportunities
4. **Integration Points**: Identify API contracts, database schemas, and service boundaries

### Full-Stack Documentation-First Development
- Maintain `docs/ARCHITECTURE.md` for system-wide architecture decisions
- Keep `docs/API_DOCUMENTATION.md` for backend API specifications
- Reference `docs/COMPONENT_LIBRARY.md` for frontend components
- Update `docs/DATABASE_SCHEMA.md` with data model documentation
- Document deployment architecture in `docs/INFRASTRUCTURE.md`

## 🏗️ Full-Stack Architecture Standards

### System Design Principles
- **Separation of Concerns**: Clear boundaries between frontend, backend, and data layers
- **API-First Design**: Design APIs before implementation
- **Database Design**: Normalized schemas with proper indexing
- **Microservices Ready**: Service-oriented architecture with clear boundaries
- **Infrastructure as Code**: Reproducible infrastructure with Terraform/CloudFormation

### Full-Stack Technology Stack
- **Frontend**: React/Vue/Angular with TypeScript
- **Backend**: Node.js/Python/Go with RESTful or GraphQL APIs
- **Database**: PostgreSQL/MongoDB with proper migrations
- **Caching**: Redis for session and data caching
- **Message Queue**: RabbitMQ/Kafka for async processing
- **Container**: Docker with Kubernetes orchestration

### End-to-End Testing Strategy
- **Unit Testing**: 85%+ coverage for both frontend and backend
- **Integration Testing**: API and database integration tests
- **E2E Testing**: Critical user journeys with Cypress/Playwright
- **Performance Testing**: Load testing across all layers
- **Security Testing**: Penetration testing and vulnerability scanning

## 📝 PRD-Driven Full-Stack Development

### Full-Stack Requirements Documents
Start full-stack features with structured PRD process:
```bash
# Create full-stack feature PRD
/manage:prd create "e-commerce-platform" --template=fullstack

# Review PRD quality
/support:prd-review "e-commerce-platform"

# Approve and start development
/manage:prd approve "e-commerce-platform"  # Auto-starts SDLC
```

### Full-Stack PRD Template Sections
- **System Requirements**: Frontend, backend, and infrastructure needs
- **API Specifications**: Endpoint design and data contracts
- **UI/UX Requirements**: User interface and experience design
- **Database Design**: Schema, relationships, and migrations
- **Integration Requirements**: Third-party services and APIs
- **Performance Requirements**: Response time, throughput, scalability

## 🔄 SDLC Pipeline for Full-Stack Projects

### Full-Stack Development Pipeline
```bash
# Initialize full-stack feature pipeline
/sdlc "fullstack-feature" --init --template=standard

# Or start from approved PRD
/sdlc "fullstack-feature" --init --from-prd
```

### Full-Stack Pipeline Phases
1. **Planning**: System requirements and technical specifications
2. **Design**: Architecture, API design, UI/UX mockups, database schema
3. **Implementation**: Parallel frontend and backend development
4. **Review**: Cross-layer code review and architecture validation
5. **Testing**: Unit, integration, and E2E testing
6. **Deployment**: Container orchestration and infrastructure provisioning
7. **Documentation**: API docs, component library, deployment guides

## 🚀 Advanced Full-Stack Workflows

### Complex System Orchestration
```bash
# Microservices implementation
/orchestrate "implement microservices architecture with API gateway, service discovery, and monitoring"

# Real-time features
/orchestrate "implement real-time chat with WebSockets, message queue, and React frontend"

# E-commerce platform
/orchestrate "implement complete e-commerce with product catalog, cart, checkout, and payment integration"
```

### Full-Stack Development Commands
```bash
# Analyze system architecture
/analyze:architecture . --full-stack

# Implement feature across stack
/implement:feature "user-dashboard" --layers=frontend,backend,database

# Generate comprehensive documentation
/support:document "system" --include=api,components,database

# Run full test suite
/manage:test "all" --parallel
```

## 🔗 Integration Best Practices

### API Contract Management
- **OpenAPI Specification**: Define API contracts upfront
- **Mock Servers**: Enable parallel frontend/backend development
- **Version Management**: Backward compatible API versioning
- **Error Handling**: Consistent error responses across services
- **Rate Limiting**: Protect APIs with appropriate limits

### Data Layer Management
- **Database Migrations**: Version-controlled schema changes
- **Data Validation**: Schema validation at API and database levels
- **Transaction Management**: ACID compliance for critical operations
- **Caching Strategy**: Multi-layer caching for performance
- **Backup Strategy**: Automated backups with point-in-time recovery

## 🔧 Full-Stack Troubleshooting

### Cross-Layer Debugging
1. **Performance Issues**: Use `/analyze:performance . --trace` for request tracing
2. **Integration Failures**: Run `/support:diagnose "api-integration"`
3. **Database Issues**: Apply `/analyze:architecture . --focus=database`
4. **Deployment Problems**: Execute `/manage:deploy --debug`

### System Monitoring
- **Application Monitoring**: APM with distributed tracing
- **Infrastructure Monitoring**: Metrics and alerts for all services
- **Log Aggregation**: Centralized logging with search capabilities
- **Error Tracking**: Real-time error monitoring and alerting

## 📊 Full-Stack Success Metrics

### System Performance KPIs
- **API Response Time**: P95 < 200ms for critical endpoints
- **Frontend Performance**: Core Web Vitals targets met
- **Database Performance**: Query response < 100ms
- **System Availability**: 99.9% uptime SLA

### Development Efficiency Metrics
- **Feature Velocity**: Time from PRD to production
- **Test Coverage**: 85%+ across all layers
- **Deployment Frequency**: Daily deployments capability
- **MTTR**: Mean time to recovery < 1 hour

## 🚢 Deployment & DevOps

### Container Orchestration
- **Docker**: Multi-stage builds for optimized images
- **Kubernetes**: Deployment manifests with auto-scaling
- **CI/CD Pipeline**: Automated testing and deployment
- **Infrastructure as Code**: Terraform for cloud resources
- **Monitoring Stack**: Prometheus, Grafana, ELK stack

### Environment Management
- **Development**: Local development with Docker Compose
- **Staging**: Production-like environment for testing
- **Production**: High availability with load balancing
- **Disaster Recovery**: Backup and recovery procedures

## 📚 Bilingual Documentation Requirements

All full-stack documentation MUST be provided in both English and Korean:
- System architecture (ARCHITECTURE.md / ARCHITECTURE.ko.md)
- API documentation (API.md / API.ko.md)
- Deployment guide (DEPLOYMENT.md / DEPLOYMENT.ko.md)
- Database documentation (DATABASE.md / DATABASE.ko.md)

Transform your full-stack development with intelligent AI assistance, PRD-driven requirements, and SDLC Pipeline System, ensuring enterprise-grade applications while accelerating delivery through systematic automation across all layers.