# Microservices Architecture Template

## 🏗️ Service Design Specification

### Service Context & Boundaries
**Service Name**: [Descriptive service name following domain boundaries]
**Business Capability**: [Core business function this service provides]
**Team Ownership**: [Responsible development team with contact information]

### V2 Analysis Foundation
```bash
# Service Architecture Analysis
/analyze:architecture [service-domain]        # Domain boundary validation
/analyze:security [service-security-model]   # Security requirements assessment
/analyze:performance [service-scalability]   # Performance and scalability analysis
```

---

## 📐 Technical Architecture

### Service Implementation Pattern
```bash
# Service Development Orchestration
/orchestrate "implement microservice with domain-driven design, event sourcing, CQRS patterns, and comprehensive observability"

# API Gateway Integration
/implement:feature [api-gateway-integration]  # Service registration and routing
/implement:feature [service-discovery]       # Consul/Eureka integration
/implement:feature [circuit-breaker]         # Resilience patterns
```

### Data Management Strategy
- **Database per Service**: Dedicated database with appropriate technology choice
- **Event Sourcing**: Immutable event log for audit trails and temporal queries
- **CQRS Implementation**: Separate read/write models for optimal performance
- **Data Consistency**: Eventual consistency with saga patterns for distributed transactions

### Communication Patterns
- **Synchronous**: REST APIs for real-time queries with OpenAPI specifications
- **Asynchronous**: Event-driven messaging with Apache Kafka/RabbitMQ
- **Streaming**: Real-time data processing with Apache Kafka Streams
- **Service Mesh**: Istio/Linkerd for traffic management and security

---

## 🔧 Implementation Components

### Core Service Structure
```bash
# Service Foundation
/implement:feature [domain-entities]         # Core business entities
/implement:feature [business-logic]          # Domain services and use cases
/implement:feature [data-access]            # Repository pattern with ORM
/implement:feature [api-controllers]        # RESTful API endpoints
```

### Infrastructure Integration
```bash
# Infrastructure Components
/implement:feature [health-checks]          # Service health monitoring
/implement:feature [metrics-collection]     # Prometheus metrics integration
/implement:feature [distributed-tracing]   # Jaeger/Zipkin tracing
/implement:feature [configuration-management] # Environment-specific configs
```

### Security Implementation
- **Authentication**: JWT token validation with OAuth2/OIDC integration
- **Authorization**: Role-based access control with fine-grained permissions
- **API Security**: Rate limiting, input validation, and output sanitization
- **Communication Security**: mTLS for service-to-service communication

---

## 📊 Quality Assurance & Testing

### Testing Strategy Implementation
```bash
# Comprehensive Testing Suite
/implement:feature [unit-tests]             # Domain logic and business rules testing
/implement:feature [integration-tests]     # API contract and database testing
/implement:feature [contract-tests]        # Consumer-driven contract testing
/implement:feature [performance-tests]     # Load testing and benchmark validation
```

### Quality Gates Validation
```bash
# Automated Quality Checks
/analyze:code-quality [service-implementation] # Code quality metrics validation
/analyze:security [service-vulnerabilities]   # Security vulnerability assessment
/analyze:performance [service-performance]    # Performance profiling and optimization
```

### Monitoring & Observability
- **Metrics Collection**: Business and technical metrics with Prometheus
- **Distributed Tracing**: Request flow analysis with correlation IDs
- **Structured Logging**: Centralized logging with ELK stack integration
- **Alerting**: Proactive monitoring with PagerDuty/OpsGenie integration

---

## 🚀 Deployment & Operations

### Container & Orchestration
```bash
# Deployment Orchestration
/orchestrate "containerize microservice with Docker, deploy to Kubernetes with Helm charts, configure auto-scaling and rolling deployments"

# Infrastructure as Code
/implement:feature [kubernetes-manifests]   # Service deployment configurations
/implement:feature [helm-charts]           # Package management and templating
/implement:feature [terraform-modules]     # Infrastructure provisioning
```

### CI/CD Pipeline Integration
- **Build Pipeline**: Automated testing, security scanning, and artifact creation
- **Deployment Pipeline**: Blue-green deployments with automated rollback
- **Environment Promotion**: Staged deployments with approval workflows
- **Feature Flags**: Runtime configuration with gradual feature rollouts

### Service Mesh Integration
- **Traffic Management**: Load balancing, routing, and failover strategies
- **Security Policies**: mTLS, authentication, and authorization enforcement
- **Observability**: Automatic metrics collection and distributed tracing
- **Policy Enforcement**: Rate limiting, circuit breaking, and retry policies

---

## 🔄 Event-Driven Integration

### Event Design Patterns
```bash
# Event Architecture Implementation
/implement:feature [event-producers]        # Domain event publishing
/implement:feature [event-consumers]        # Event handling and processing
/implement:feature [event-schema-registry] # Schema evolution and compatibility
/implement:feature [saga-orchestration]    # Distributed transaction management
```

### Message Reliability
- **At-Least-Once Delivery**: Guaranteed message delivery with idempotent consumers
- **Dead Letter Queues**: Failed message handling and replay mechanisms
- **Event Replay**: Historical event processing and system recovery
- **Schema Evolution**: Backward and forward compatibility for event schemas

---

## 📈 Scalability & Performance

### Horizontal Scaling Strategy
```bash
# Scalability Implementation
/analyze:performance [scaling-patterns]     # Identify scaling bottlenecks
/implement:enhancement [caching-layers]     # Multi-level caching strategy
/implement:enhancement [database-sharding] # Data partitioning for scalability
/implement:enhancement [load-balancing]     # Traffic distribution optimization
```

### Performance Optimization
- **Database Optimization**: Query optimization, indexing, and connection pooling
- **Caching Strategy**: Redis/Memcached for frequently accessed data
- **Async Processing**: Background jobs and event-driven processing
- **Resource Management**: CPU and memory optimization with profiling

---

## 🎯 Service Governance

### API Management
- **API Versioning**: Semantic versioning with backward compatibility
- **Documentation**: Automated OpenAPI documentation generation
- **Rate Limiting**: Fair usage policies with quota management
- **Analytics**: API usage monitoring and optimization insights

### Service Lifecycle Management
```bash
# Service Evolution
/support:estimate [service-enhancement]     # Feature development estimation
/implement:enhancement [service-upgrade]    # Service capability enhancement
/analyze:architecture [service-integration] # Integration impact assessment
/manage:workflow [service-deployment]       # Deployment orchestration
```

---

*Implement this microservice using V2 Context Engineering commands for systematic development, comprehensive testing, and production-ready deployment with full observability and operational excellence.*