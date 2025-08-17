# Project Name

*Context Engineering Template with SDLC Pipeline System*

## 🚀 Overview

Brief description of your project with business value proposition and target users.

**Built with**: Context Engineering Template featuring 23+ specialized commands, 23+ AI agents, and SDLC Pipeline System for enterprise-grade development.

## 📋 Quick Start

### Prerequisites
- Node.js 18+ or your technology stack requirements
- Docker and Docker Compose for containerized development
- Access to required cloud services and databases

### Development Setup
```bash
# Clone and setup
git clone <repository-url>
cd <project-name>

# Context Engineering initialization
cp CLAUDE.md.template CLAUDE.md
# Customize CLAUDE.md with project-specific requirements

# Environment setup
cp .env.example .env
# Configure environment variables for your setup
```

### Development Workflow
```bash
# Initial project analysis
/analyze:project-context .
/analyze:architecture .
/analyze:code-quality .

# Feature development
/implement:feature [feature-name]
/analyze:security [security-assessment]
/manage:test [test-execution]

# Quality assurance
/analyze:performance [performance-validation]
/support:document [documentation-generation]
/manage:git [semantic-commit]
```

## 📝 PRD-Driven Development

### Product Requirements Documents
Start your development with structured PRD process for clear requirements and automatic SDLC integration:

```bash
# Create PRD for new feature
/manage:prd create "feature-name" --template=standard

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

### 8-Phase Development Lifecycle
The SDLC Pipeline System provides structured development through 8 phases (including optional PRD phase):

```bash
# Option 1: Start with PRD (Recommended)
/manage:prd create "feature-name" --template=standard
# ... write and refine PRD ...
/manage:prd approve "feature-name"  # Auto-starts SDLC

# Option 2: Direct SDLC initialization
/sdlc "feature-name" --init --template=standard

# Available Templates:
# - standard: Traditional waterfall (10-12 days)
# - agile: Sprint-based iterative (2-week sprints)  
# - hotfix: Emergency fixes (4-hour SLA)
```

### Pipeline Commands
```bash
/sdlc "feature-name" --status       # Check pipeline status
/sdlc "feature-name" --continue     # Continue to next phase
/sdlc "feature-name" --full         # Run full pipeline
/support:sdlc-report "feature-name" # Generate progress report
```

### Development Phases
0. **PRD Creation** (Optional) - Product requirements documentation
1. **Planning** - Requirements analysis and task breakdown
2. **Design** - Architecture and API specifications
3. **Implementation** - Feature development with AI agents
4. **Review** - Code quality and security analysis
5. **Testing** - Comprehensive test execution
6. **Deployment** - Production release management
7. **Documentation** - Complete knowledge management

For detailed guidance, see [SDLC Pipeline Guide](docs/guides/SDLC_GUIDE.md) ([한국어](docs/guides/SDLC_GUIDE.ko.md))

## 🏗️ Architecture

### System Design
- **Architecture Pattern**: [Microservices/Monolith/Serverless]
- **Communication**: [REST APIs/GraphQL/Event-driven]
- **Data Storage**: [Database technology and patterns]
- **Caching**: [Caching strategy and technology]

### Technology Stack
- **Backend**: Node.js/TypeScript with Express.js
- **Frontend**: React with TypeScript and modern tooling
- **Database**: PostgreSQL with Redis for caching
- **Infrastructure**: Docker, Kubernetes, cloud-native deployment

### Memory Integration
Project leverages hierarchical memory management:
- **Project Context**: `@import .claude/memory/project-context.md`
- **Team Standards**: `@import .claude/memory/team-preferences.md`
- **Domain Knowledge**: `@import .claude/memory/domain-knowledge.md`

## 🛠️ Development

### Command Usage
Essential Context Engineering commands for this project:

```bash
# Analysis Commands
/analyze:project-context .        # Project understanding and context
/analyze:architecture .           # Architecture validation and insights
/analyze:security .              # Security posture assessment
/analyze:performance .           # Performance profiling and optimization
/analyze:code-quality .          # Code quality metrics and improvements

# Implementation Commands  
/implement:feature [component]   # New feature development
/implement:enhancement [module]  # Existing code improvement
/implement:cleanup [codebase]    # Technical debt reduction

# Management Commands
/manage:test [test-suite]        # Automated testing execution
/manage:build [deployment]       # Build and deployment processes  
/manage:git [version-control]    # Version control with semantic commits
/manage:workflow [automation]    # Workflow automation and optimization

# Support Commands
/support:document [component]    # Documentation generation
/support:estimate [task]         # Development effort estimation
/support:diagnose [issue]        # Problem diagnosis and resolution
/support:explain [concept]       # Technical explanation and knowledge transfer

# Orchestration
/orchestrate "[complex-task-description]"  # Multi-agent coordination
```

### Agent Specializations
This project utilizes specialized AI agents:

- **feature-implementer**: New feature development with expert personas
- **code-enhancement-specialist**: Code quality and performance improvements
- **security-analyzer**: Security assessment and vulnerability management
- **performance-analyzer**: Performance optimization and scalability analysis
- **system-architect**: Architecture design and pattern validation

### Testing Strategy
```bash
# Comprehensive testing with Context Engineering commands
/manage:test unit-tests          # Unit test execution
/manage:test integration-tests   # Integration test validation
/manage:test e2e-tests          # End-to-end user journey testing
/manage:test performance-tests   # Performance and load testing
```

## 🔐 Security

Security implementation with security-analyzer agent:
- **Authentication**: [Authentication method and implementation]
- **Authorization**: [Access control and permission model]
- **Data Protection**: [Encryption and data handling practices]
- **Compliance**: [Regulatory requirements and standards]

```bash
# Security validation workflow
/analyze:security .                    # Comprehensive security assessment
/implement:enhancement security-controls # Security improvement implementation
/manage:test security-test-suite       # Security testing and validation
```

## ⚡ Performance

Performance optimization with performance-analyzer agent:
- **Response Time**: Target < 200ms for 95th percentile
- **Throughput**: [Expected requests per second]
- **Scalability**: [Scaling strategy and capacity planning]
- **Monitoring**: [Performance monitoring and alerting]

```bash
# Performance optimization workflow
/analyze:performance .                 # Performance baseline and analysis
/implement:enhancement performance     # Performance optimization implementation
/manage:test performance-benchmarks    # Performance regression testing
```

## 📚 Documentation

### Documentation Generation
Documentation is automatically generated and maintained using Context Engineering commands:

```bash
/support:document api-specification    # OpenAPI documentation generation
/support:document architecture-guide   # Architecture documentation
/support:document deployment-guide     # Deployment and operations guide
/support:document troubleshooting      # Problem resolution documentation
```

### Project Documentation Structure
- **API Documentation**: Auto-generated OpenAPI specifications
- **Architecture Guide**: System design and integration patterns
- **Development Guide**: Setup, workflow, and contribution guidelines
- **Deployment Guide**: Infrastructure and deployment procedures
- **Troubleshooting**: Common issues and resolution procedures

## 🚀 Deployment

### Deployment Orchestration
```bash
# Production deployment with Context Engineering system
/manage:build production-deployment    # Production-ready build
/analyze:security deployment-security  # Security validation
/manage:workflow ci-cd-pipeline       # Automated deployment pipeline
```

### Environment Configuration
- **Development**: Local development with Docker Compose
- **Staging**: Staging environment for integration testing
- **Production**: Production deployment with monitoring and alerting

### Infrastructure as Code
- **Containerization**: Docker multi-stage builds
- **Orchestration**: Kubernetes deployment manifests
- **Infrastructure**: Terraform or CloudFormation templates
- **Monitoring**: Observability stack with metrics and tracing

## 🤝 Contributing

### Development Workflow
1. **Project Analysis**: `/analyze:project-context .`
2. **Feature Planning**: `/support:estimate [feature-implementation]`
3. **Development**: `/implement:feature [feature-name]`
4. **Quality Assurance**: `/analyze:code-quality [changes]`
5. **Testing**: `/manage:test [comprehensive-suite]`
6. **Documentation**: `/support:document [changes]`
7. **Integration**: `/manage:git [semantic-commit]`

### Code Standards
- Follow team preferences defined in `.claude/memory/team-preferences.md`
- Maintain code coverage above 85%
- Apply security-first development practices
- Document all architectural decisions (ADRs)

### Pull Request Process
1. Create feature branch with descriptive name
2. Implement changes using Context Engineering commands for quality assurance
3. Run comprehensive test suite: `/manage:test all-tests`
4. Update documentation: `/support:document [changes]`
5. Submit pull request with detailed description and validation results

## 📊 Monitoring & Observability

### Metrics & Alerting
- **Application Metrics**: Business and technical KPIs
- **Performance Monitoring**: Response times and throughput
- **Error Tracking**: Centralized error monitoring and alerting
- **Security Monitoring**: Security event tracking and analysis

### Health Checks
```bash
# System health validation
/analyze:architecture health-check     # Architecture health assessment
/analyze:performance system-metrics    # Performance metrics analysis
/support:diagnose system-issues        # System issue diagnosis
```

## 🔄 Continuous Improvement

### Quality Enhancement
```bash
# Continuous improvement workflow
/analyze:code-quality technical-debt   # Technical debt assessment
/implement:cleanup systematic-refactor # Code quality improvements
/analyze:performance optimization      # Performance optimization opportunities
/support:document improvements         # Document improvements and lessons learned
```

## 📞 Support

### Issue Resolution
```bash
# Problem diagnosis and resolution
/support:diagnose [issue-description]  # Systematic issue diagnosis
/analyze:architecture [problem-area]   # Architecture impact assessment
/implement:enhancement [fix-solution]  # Solution implementation
/manage:test [validation-suite]        # Fix validation and testing
```

### Contact & Resources
- **Technical Issues**: Use GitHub issues with diagnostic information
- **Architecture Questions**: Reference architecture documentation
- **Performance Issues**: Include performance analysis results
- **Security Concerns**: Follow security incident response procedures

## ☕ Support This Project

If this Context Engineering Template has enhanced your development workflow, consider supporting continued innovation:

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-☕-yellow.svg)](https://buymeacoffee.com/a1rtisan)

Your support drives the development of advanced AI-assisted development tools and enterprise-grade templates. 🚀

## 📄 License

[License information]

---

*This project leverages the Context Engineering Template with SDLC Pipeline System for systematic development, comprehensive quality assurance, and enterprise-grade software delivery. Use Context Engineering commands for all development, testing, and maintenance activities.*