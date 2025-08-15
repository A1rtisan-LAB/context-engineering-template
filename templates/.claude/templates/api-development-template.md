# API Development Template

## 🌐 RESTful API Specification

### API Context & Design Philosophy
**API Name**: [Descriptive API name with version identifier]
**Business Domain**: [Core business functionality this API exposes]
**Target Consumers**: [Client applications, third-party integrations, internal services]

### V2 API Analysis Foundation
```bash
# Comprehensive API Analysis
/analyze:architecture [api-design-patterns]    # RESTful design principles validation
/analyze:security [api-security-model]        # Authentication and authorization assessment
/analyze:performance [api-scalability]        # Performance and throughput analysis
```

---

## 📋 API Design Specification

### RESTful Resource Design
```bash
# API Implementation Orchestration
/orchestrate "design and implement RESTful API with OpenAPI specification, comprehensive validation, rate limiting, and security integration"

# Core API Components
/implement:feature [resource-endpoints]       # REST resource CRUD operations
/implement:feature [data-validation]         # Input validation and sanitization
/implement:feature [error-handling]          # Consistent error response patterns
/implement:feature [response-formatting]     # Standardized response structure
```

### OpenAPI Specification
- **API Documentation**: Comprehensive OpenAPI 3.0 specification with examples
- **Schema Definitions**: Detailed request/response schemas with validation rules
- **Authentication Schemes**: Security scheme definitions and implementation
- **Code Generation**: Automatic client SDK generation for multiple languages

### HTTP Method Implementation
- **GET**: Idempotent data retrieval with filtering, pagination, and sorting
- **POST**: Resource creation with proper status codes and location headers
- **PUT**: Complete resource replacement with idempotency guarantees
- **PATCH**: Partial resource updates with conflict resolution
- **DELETE**: Resource removal with cascade handling and soft deletes

---

## 🔐 Security & Authentication

### Authentication Strategy
```bash
# Security Implementation
/implement:feature [oauth2-integration]       # OAuth2/OIDC authentication flow
/implement:feature [jwt-validation]          # JWT token validation and refresh
/implement:feature [api-key-management]      # API key generation and validation
/implement:feature [rate-limiting]           # Request rate limiting and throttling
```

### Authorization & Access Control
- **Role-Based Access Control**: Fine-grained permissions with role hierarchies
- **Resource-Level Authorization**: Context-aware access control decisions
- **Scoped API Access**: OAuth2 scopes for limited API access permissions
- **Audit Logging**: Comprehensive access logging with security event tracking

### API Security Best Practices
- **Input Validation**: Strict input validation with schema-based sanitization
- **Output Encoding**: Proper response encoding to prevent injection attacks
- **HTTPS Enforcement**: TLS 1.3 encryption with certificate pinning
- **CORS Configuration**: Strict cross-origin resource sharing policies

---

## 📊 Data Management & Validation

### Request/Response Patterns
```bash
# Data Handling Implementation
/implement:feature [request-validation]      # Comprehensive input validation
/implement:feature [response-transformation] # Data transformation and formatting
/implement:feature [pagination-support]     # Efficient pagination with cursor-based navigation
/implement:feature [filtering-sorting]      # Advanced query capabilities
```

### Data Validation Strategy
- **Schema Validation**: JSON Schema validation with detailed error messages
- **Business Rule Validation**: Domain-specific validation with custom validators
- **Data Sanitization**: Input sanitization to prevent security vulnerabilities
- **Type Safety**: Strong typing with runtime type checking

### Error Handling & Status Codes
- **Standardized Error Format**: Consistent error response structure with error codes
- **HTTP Status Codes**: Appropriate status code usage with detailed descriptions
- **Error Recovery**: Client-friendly error messages with recovery suggestions
- **Debugging Information**: Development-only debug information with production security

---

## ⚡ Performance & Optimization

### Performance Implementation
```bash
# Performance Optimization
/analyze:performance [api-bottlenecks]       # Performance bottleneck identification
/implement:enhancement [caching-strategy]    # Multi-level caching implementation
/implement:enhancement [query-optimization] # Database query performance tuning
/implement:enhancement [async-processing]   # Background processing for heavy operations
```

### Caching Strategy
- **HTTP Caching**: Proper cache headers with ETags and conditional requests
- **Application Caching**: Redis-based caching for frequently accessed data
- **Query Result Caching**: Database query result caching with invalidation
- **CDN Integration**: Content delivery network for static assets and responses

### Scalability Patterns
- **Horizontal Scaling**: Stateless API design with load balancer compatibility
- **Database Optimization**: Connection pooling and query optimization
- **Async Processing**: Background job processing for long-running operations
- **Rate Limiting**: Fair usage enforcement with burst capacity handling

---

## 🧪 Testing & Quality Assurance

### Comprehensive Testing Strategy
```bash
# API Testing Implementation
/implement:feature [unit-tests]             # Business logic and validation testing
/implement:feature [integration-tests]     # API endpoint and database testing
/implement:feature [contract-tests]        # API contract validation with consumers
/implement:feature [load-tests]            # Performance testing under various loads
```

### API Testing Patterns
- **Unit Testing**: Business logic, validation rules, and error handling
- **Integration Testing**: Database interactions and external service calls
- **Contract Testing**: API contract validation with consumer expectations
- **End-to-End Testing**: Complete user journey testing with realistic data

### Quality Gates Validation
```bash
# Automated Quality Checks
/analyze:code-quality [api-implementation]  # Code quality metrics and standards
/analyze:security [api-vulnerabilities]    # Security vulnerability scanning
/analyze:performance [api-benchmarks]      # Performance profiling and optimization
```

---

## 🚀 Documentation & Developer Experience

### API Documentation Strategy
```bash
# Documentation Generation
/support:document [api-specification]      # Automated API documentation generation
/support:document [integration-guides]    # Developer integration guides
/support:document [code-examples]         # Client implementation examples
/support:explain [api-design-decisions]   # Architecture and design rationale
```

### Developer Experience Optimization
- **Interactive Documentation**: Swagger UI with live API testing capabilities
- **SDK Generation**: Automatic client SDK generation for popular languages
- **Postman Collections**: Comprehensive API collections with example requests
- **Integration Examples**: Sample code for common integration patterns

### Versioning & Evolution
- **Semantic Versioning**: Clear versioning strategy with backward compatibility
- **Deprecation Strategy**: Graceful API deprecation with migration guidance
- **Change Documentation**: Comprehensive changelog with migration instructions
- **Beta/Alpha Endpoints**: Safe preview of upcoming API changes

---

## 📈 Monitoring & Analytics

### API Observability
```bash
# Monitoring Implementation
/implement:feature [metrics-collection]     # API usage and performance metrics
/implement:feature [distributed-tracing]   # Request flow tracing across services
/implement:feature [health-monitoring]     # API health checks and status endpoints
/implement:feature [alerting-integration]  # Proactive monitoring with alerts
```

### Metrics & Analytics
- **Usage Analytics**: API endpoint usage patterns and consumer behavior
- **Performance Metrics**: Response times, throughput, and error rates
- **Business Metrics**: Feature adoption and user engagement tracking
- **Security Monitoring**: Authentication failures and suspicious activity detection

### Operational Excellence
- **Health Checks**: Comprehensive health endpoints with dependency status
- **Circuit Breakers**: Automatic failure detection with graceful degradation
- **Retry Mechanisms**: Intelligent retry patterns with exponential backoff
- **Load Balancing**: Traffic distribution with health-based routing

---

## 🔄 Integration & Deployment

### API Gateway Integration
```bash
# Gateway Orchestration
/orchestrate "integrate API with gateway for routing, authentication, rate limiting, and monitoring with zero-downtime deployment"

# Gateway Features
/implement:feature [request-routing]        # Intelligent request routing and load balancing
/implement:feature [authentication-proxy]  # Centralized authentication and authorization
/implement:feature [rate-limiting-policies] # Flexible rate limiting with quota management
```

### CI/CD Pipeline Integration
- **Automated Testing**: Comprehensive test execution in deployment pipeline
- **Security Scanning**: Static and dynamic security analysis
- **Performance Validation**: Automated performance regression testing
- **Blue-Green Deployment**: Zero-downtime deployment with automatic rollback

---

*Implement this API using V2 Context Engineering system for production-ready, secure, and performant API development with comprehensive documentation and monitoring.*