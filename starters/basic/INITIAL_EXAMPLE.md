# SDLC Pipeline Example: E-commerce Checkout Feature

## 🎯 Feature Specification
Implement a complete checkout system using SDLC Pipeline

### Business Requirements
- Shopping cart management
- Payment processing (multiple methods)
- Order confirmation and notifications
- Inventory management integration

## 📊 SDLC Pipeline Initialization

### Step 1: Initialize Pipeline
```bash
/sdlc "checkout-feature" --init --template=standard
```

### Step 2: Planning Phase (Day 1-2)
```bash
/sdlc "checkout-feature" --phase=planning

# Activities:
- Requirements gathering
- User story creation
- Task breakdown
- Time estimation with /support:estimate
```

### Step 3: Design Phase (Day 3-5)
```bash
/sdlc "checkout-feature" --phase=design

# Outputs:
- System architecture
- API specifications
- Database schema
- UI/UX mockups
```

### Step 4: Implementation Phase (Day 6-10)
```bash
/sdlc "checkout-feature" --phase=implementation

# Using specialized agents:
/implement:feature checkout-cart
/implement:feature payment-gateway
/implement:feature order-processing
```

### Step 5: Review Phase (Day 11)
```bash
/sdlc "checkout-feature" --phase=review

# Quality checks:
/analyze:code-quality .
/analyze:security .
/analyze:architecture .
```

### Step 6: Testing Phase (Day 12-13)
```bash
/sdlc "checkout-feature" --phase=testing

# Test execution:
/manage:test unit-tests
/manage:test integration-tests
/manage:test e2e-tests
```

### Step 7: Deployment Phase (Day 14)
```bash
/sdlc "checkout-feature" --phase=deployment

# Deployment steps:
/manage:build production
/manage:workflow deployment-pipeline
```

### Step 8: Documentation Phase (Day 15)
```bash
/sdlc "checkout-feature" --phase=documentation

# Documentation generation:
/support:document api-reference
/support:document user-guide
```

## 📈 Pipeline Monitoring

### Check Status
```bash
/sdlc "checkout-feature" --status
```

### Generate Report
```bash
/support:sdlc-report "checkout-feature"
```

## 🎨 Alternative Templates

### Agile Sprint
```bash
/sdlc "mobile-app" --init --template=agile
```

### Emergency Hotfix
```bash
/sdlc "critical-bug-fix" --init --template=hotfix
```

## 📚 Further Reading
- [SDLC Pipeline Guide](docs/SDLC_GUIDE.md)
- [Command Reference](.claude/commands/)
- [Agent Documentation](.claude/agents/)