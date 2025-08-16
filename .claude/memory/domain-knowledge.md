# Domain Knowledge & Business Context

## Business Rules & Logic
- Apply domain-driven design principles with ubiquitous language
- Implement business rules in domain layer, not in controllers
- Use value objects for complex business concepts
- Maintain clear separation between business logic and infrastructure

## Integration Patterns
- Prefer event-driven architecture for service communication
- Implement idempotent operations for reliable message processing
- Use saga pattern for distributed transactions
- Apply circuit breaker pattern for external service calls

## Data Management
- Follow database-per-service pattern in microservices
- Implement event sourcing for audit trails and temporal queries
- Use appropriate consistency models (eventual vs strong consistency)
- Apply data encryption at rest and in transit

## Monitoring & Observability
- Implement distributed tracing for request flow analysis
- Use structured logging with correlation IDs
- Set up comprehensive metrics collection and alerting
- Maintain health checks for all services and dependencies

## Error Handling & Resilience
- Implement graceful degradation for non-critical features
- Use retry patterns with exponential backoff
- Apply timeout configurations for all external calls
- Maintain detailed error logs with actionable information