# Project Specification Template

## 🎯 Project Overview & V2 Context Engineering Integration

### Feature Name
**[Clear, descriptive feature name with business impact]**

### V2 Analysis Phase
Execute comprehensive analysis before implementation:
```bash
/analyze:project-context .     # Understanding current system architecture
/analyze:security .           # Security baseline and vulnerability assessment
/analyze:performance .        # Performance profile and optimization opportunities
/analyze:code-quality .       # Quality metrics and technical debt assessment
/analyze:architecture .       # System design and integration points
```

### Business Value Proposition
**Impact**: [Quantifiable business value and user benefits]
**Success Metrics**: [KPIs and measurable outcomes]
**Risk Assessment**: [Technical and business risks with mitigation strategies]

---

## 📋 Technical Requirements & Implementation

### V2 Implementation Strategy
```bash
# Feature Development Phase
/implement:feature [feature-name]           # Core functionality development
/implement:enhancement [existing-modules]   # Integration with existing systems
/implement:cleanup [affected-areas]        # Code quality and optimization

# Quality Assurance Phase
/analyze:security [new-components]         # Security validation
/analyze:performance [performance-impact] # Performance regression testing
/manage:test [comprehensive-test-suite]   # Automated testing execution
```

### Architecture Integration
- **Service Boundaries**: Clear microservice boundaries with well-defined APIs
- **Data Consistency**: Appropriate consistency models and transaction boundaries
- **Communication Patterns**: Event-driven architecture with message reliability
- **Security Integration**: Zero-trust principles with defense-in-depth

### Technology Stack Alignment
- **Backend**: Node.js/TypeScript with Express.js framework
- **Database**: PostgreSQL with appropriate indexing and query optimization
- **Caching**: Redis for session management and query result caching
- **Messaging**: Apache Kafka for event streaming and service communication

---

## 🧪 Quality Gates & Validation

### Automated Quality Validation
```bash
# Comprehensive Quality Review
/orchestrate "complete code quality, security, and performance validation"

# Documentation Generation
/support:document [feature-components]     # Automated documentation generation
/support:explain [complex-algorithms]     # Algorithm explanation and rationale
```

### Testing Strategy
- **Unit Testing**: 85%+ coverage with behavior-driven test design
- **Integration Testing**: API contract validation and service interaction testing
- **End-to-End Testing**: Critical user journey validation with realistic data
- **Performance Testing**: Load testing under expected and peak traffic conditions

### Security Requirements
- **Authentication**: Multi-factor authentication with OAuth2/OIDC integration
- **Authorization**: Role-based access control with fine-grained permissions
- **Data Protection**: Encryption at rest and in transit with key rotation
- **Vulnerability Management**: Regular security scanning and patch management

---

## 🔄 V2 Orchestration & Workflow Integration

### Complex Development Orchestration
```bash
# Full-Stack Feature Implementation
/orchestrate "implement [feature-name] with microservices architecture, event-driven communication, comprehensive testing, and deployment automation"

# System Integration Orchestration
/orchestrate "integrate [feature-name] across existing services with API versioning, backward compatibility, and zero-downtime deployment"

# Quality & Performance Orchestration
/orchestrate "optimize [feature-name] for performance, security, and scalability with monitoring and alerting integration"
```

### Continuous Development Workflow
```bash
# Daily Development Cycle
/support:estimate [implementation-phase] →
/implement:feature [component] →
/analyze:code-quality [changes] →
/manage:test [automated-test-suite] →
/manage:git [semantic-commit]
```

### Release Management
```bash
# Pre-Release Validation
/analyze:architecture [system-impact] →
/analyze:security [security-assessment] →
/analyze:performance [performance-validation] →
/manage:build [production-deployment]
```

---

## 📊 Success Criteria & Monitoring

### Definition of Done
- [ ] All functional requirements implemented with comprehensive validation
- [ ] Non-functional requirements met with measurable performance metrics
- [ ] Security review completed with zero critical vulnerabilities
- [ ] Performance benchmarks achieved under expected load conditions
- [ ] Comprehensive documentation generated and validated
- [ ] Production deployment successful with monitoring integration

### Key Performance Indicators
- **Technical Metrics**: Response time < 200ms, error rate < 0.1%, availability > 99.9%
- **Business Metrics**: User adoption rate, feature utilization, business impact measurement
- **Quality Metrics**: Test coverage > 85%, technical debt reduction, security posture improvement

### Continuous Improvement
```bash
# Post-Implementation Analysis
/analyze:performance [production-metrics] →
/support:diagnose [performance-bottlenecks] →
/implement:enhancement [optimization-opportunities]
```

---

## 🎭 Expert Persona Integration

### Technology-Specific Expertise Activation
- **Cloud Architecture**: AWS/Azure/GCP best practices with serverless integration
- **Security Engineering**: Zero-trust architecture with comprehensive threat modeling
- **Performance Engineering**: Application profiling with systematic optimization
- **DevOps Excellence**: Infrastructure as code with automated deployment pipelines

### Development Methodology Integration
- **Domain-Driven Design**: Bounded context identification with ubiquitous language
- **Event-Driven Architecture**: Asynchronous processing with eventual consistency
- **Microservices Patterns**: Service discovery, circuit breakers, and distributed tracing
- **Test-Driven Development**: Red-Green-Refactor cycle with comprehensive coverage

---

*Transform this specification into production-ready implementation using the V2 Context Engineering system with `/orchestrate` for complex multi-agent coordination and systematic quality assurance.*