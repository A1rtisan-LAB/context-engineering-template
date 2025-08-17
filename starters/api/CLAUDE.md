# Claude Assistant Rules for API Project

## 🚀 Context Engineering System for API Development

This API project leverages the advanced Context Engineering Template with 26 specialized commands, 26 AI agents, SDLC Pipeline System, and PRD-driven development for comprehensive API lifecycle management.

## 🎯 API Development Principles

### Claude Code Integration
- Utilize `/analyze:*` commands for API architecture and security analysis before implementation
- Apply `/implement:*` commands for production-ready API endpoint development
- Execute `/manage:*` commands for API versioning and deployment management
- Leverage `/support:*` commands for API documentation and testing
- Orchestrate complex API workflows using `/orchestrate` for multi-service coordination

### API-Specialized AI Agents
- **Analysis Agents**: architecture-analyzer, security-analyzer (API security focus), performance-analyzer (API performance)
- **Implementation Agents**: feature-implementer (REST/GraphQL APIs), code-enhancement-specialist (API optimization)
- **Management Agents**: git-workflow-manager (API versioning), build-packager (API deployment)
- **Support Agents**: issue-diagnostician (API debugging), focused-doc-generator (OpenAPI/Swagger)
- **PRD Agents**: prd-creator, prd-reviewer, prd-workflow-generator (API requirements management)

## 📋 API Project Recognition & Context Awareness

### Pre-Work Analysis Protocol
1. **API Context Discovery**: Execute `/analyze:project-context .` to understand API architecture
2. **Security Assessment**: Run `/analyze:security .` for API vulnerability scanning
3. **Performance Profile**: Apply `/analyze:performance .` for API optimization opportunities
4. **Documentation Review**: Check existing API documentation and OpenAPI specifications

### API Documentation-First Development
- Always maintain `docs/API_DOCUMENTATION.md` for endpoint specifications
- Keep OpenAPI/Swagger specs updated in `docs/openapi.yaml`
- Reference `docs/SECURITY.md` for API security patterns
- Update `docs/PERFORMANCE.md` with API benchmarks
- Document rate limiting, authentication, and authorization

## 🏗️ API Architecture Standards

### RESTful API Design Principles
- **Resource-Based URLs**: Use nouns for resources, HTTP verbs for actions
- **Consistent Naming**: camelCase for JSON, snake_case for query parameters
- **Versioning Strategy**: URL path versioning (e.g., /api/v1/resources)
- **Error Handling**: Standardized error response format with error codes
- **Pagination**: Cursor-based or offset pagination for large datasets

### API Security Best Practices
- **Authentication**: JWT tokens with refresh token rotation
- **Authorization**: Role-based access control (RBAC) or OAuth2 scopes
- **Rate Limiting**: Per-user and per-IP rate limiting
- **Input Validation**: Schema validation for all request payloads
- **CORS Configuration**: Properly configured for allowed origins

### API Testing Strategy
- **Unit Testing**: 90%+ coverage for business logic
- **Integration Testing**: API endpoint testing with real database
- **Contract Testing**: Consumer-driven contract testing
- **Load Testing**: Performance testing with realistic load patterns
- **Security Testing**: OWASP API Security Top 10 compliance

## 📝 PRD-Driven API Development

### API Requirements Documents
Start API features with structured PRD process:
```bash
# Create API feature PRD
/manage:prd create "payment-api" --template=api

# Review PRD quality
/support:prd-review "payment-api"

# Approve and start development
/manage:prd approve "payment-api"  # Auto-starts SDLC
```

### API PRD Template Sections
- **Endpoint Specifications**: Methods, paths, request/response schemas
- **Authentication Requirements**: Auth mechanisms and security policies
- **Performance Requirements**: Response time, throughput, concurrency
- **Data Models**: Database schemas and relationships
- **Integration Points**: External services and dependencies

## 🔄 SDLC Pipeline for API Projects

### API Development Pipeline
```bash
# Initialize API feature pipeline
/sdlc "api-feature" --init --template=standard

# Or start from approved PRD
/sdlc "api-feature" --init --from-prd
```

### API-Specific Pipeline Phases
1. **Planning**: API requirements and endpoint design
2. **Design**: OpenAPI specification and data modeling
3. **Implementation**: Endpoint development and middleware
4. **Review**: API design review and security audit
5. **Testing**: Integration and contract testing
6. **Deployment**: API gateway configuration and monitoring
7. **Documentation**: API documentation and client SDKs

## 🚀 Advanced API Workflows

### Multi-Service API Orchestration
```bash
# Microservices API development
/orchestrate "implement microservices API gateway with service discovery"

# GraphQL API implementation
/orchestrate "implement GraphQL API with resolvers and subscriptions"

# API migration
/orchestrate "migrate REST API v1 to v2 with backward compatibility"
```

### API Development Commands
```bash
# Analyze existing API
/analyze:architecture . --focus=api

# Implement new endpoint
/implement:feature "user-authentication-endpoint"

# Generate API documentation
/support:document "api-endpoints" --format=openapi

# Test API endpoints
/manage:test "api-integration-tests"
```

## 🔧 API Troubleshooting

### Common API Issues
1. **Performance Issues**: Use `/analyze:performance .` for bottleneck identification
2. **Security Vulnerabilities**: Run `/analyze:security .` for vulnerability scanning
3. **Integration Failures**: Apply `/support:diagnose "api-integration-error"`
4. **Documentation Sync**: Execute `/support:document "sync-api-docs"`

## 📊 API Success Metrics

### API Performance KPIs
- **Response Time**: P50, P95, P99 latency metrics
- **Throughput**: Requests per second capacity
- **Error Rate**: 4xx and 5xx error percentages
- **Availability**: Uptime percentage (target: 99.9%)

### API Quality Metrics
- **Test Coverage**: Minimum 90% for API endpoints
- **Documentation Coverage**: 100% endpoint documentation
- **Security Score**: OWASP compliance rating
- **API Version Adoption**: Migration metrics for version updates

## 📚 Bilingual Documentation Requirements

All API documentation MUST be provided in both English and Korean:
- API specifications (API.md / API.ko.md)
- Integration guides (INTEGRATION.md / INTEGRATION.ko.md)
- Security documentation (SECURITY.md / SECURITY.ko.md)
- Error code references (ERRORS.md / ERRORS.ko.md)

Transform your API development with intelligent AI assistance, PRD-driven requirements, and SDLC Pipeline System, ensuring enterprise-grade API quality while accelerating delivery through systematic automation.