# API Security Best Practices

## Overview
This guide provides essential security practices for developing and deploying APIs using this template.

## 🔐 Authentication & Authorization

### JWT Token Management
- **Use strong secrets**: Generate cryptographically secure random strings for JWT secrets
- **Token expiration**: Implement short-lived access tokens (15-30 minutes)
- **Refresh tokens**: Use refresh tokens with longer expiration for session management
- **Token rotation**: Implement refresh token rotation to prevent replay attacks

```javascript
// Example: Secure JWT configuration
const jwt = require('jsonwebtoken');

const accessToken = jwt.sign(
  { userId, role }, 
  process.env.JWT_SECRET, 
  { expiresIn: '15m' }
);
```

### API Key Management
- Store API keys in environment variables, never in code
- Use different keys for different environments (dev, staging, prod)
- Implement API key rotation policies
- Monitor API key usage for anomalies

## 🛡️ Input Validation & Sanitization

### Request Validation
- Validate all input data against expected schemas
- Use validation libraries (e.g., Joi, Yup, express-validator)
- Reject requests with unexpected fields
- Sanitize user inputs to prevent injection attacks

```javascript
// Example: Input validation with express-validator
const { body, validationResult } = require('express-validator');

app.post('/api/users',
  body('email').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }).matches(/^(?=.*[A-Za-z])(?=.*\d)/),
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    // Process valid input
  }
);
```

## 🚦 Rate Limiting

### Implementation Strategies
- Per-user rate limiting based on authentication
- Per-IP rate limiting for public endpoints
- Different limits for different endpoint types
- Progressive delays for repeated failures

```javascript
// Example: Rate limiting with express-rate-limit
const rateLimit = require('express-rate-limit');

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP'
});

app.use('/api/', apiLimiter);
```

## 🔒 HTTPS & Transport Security

### SSL/TLS Configuration
- **Always use HTTPS in production**
- Implement HSTS (HTTP Strict Transport Security)
- Use TLS 1.2 or higher
- Implement certificate pinning for mobile clients

```javascript
// Example: HSTS header
app.use((req, res, next) => {
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
  next();
});
```

## 🌐 CORS Configuration

### Secure CORS Setup
- Specify allowed origins explicitly
- Avoid using wildcard (*) in production
- Configure allowed methods and headers
- Validate Origin header

```javascript
// Example: Secure CORS configuration
const cors = require('cors');

const corsOptions = {
  origin: function (origin, callback) {
    const allowedOrigins = process.env.ALLOWED_ORIGINS.split(',');
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
  optionsSuccessStatus: 200
};

app.use(cors(corsOptions));
```

## 🗄️ Database Security

### SQL Injection Prevention
- Use parameterized queries or ORM/ODM
- Never concatenate user input into queries
- Validate data types before database operations
- Use least privilege principle for database users

```javascript
// Example: Parameterized query
const userId = req.params.id;
// Good
db.query('SELECT * FROM users WHERE id = ?', [userId]);
// Bad - SQL injection vulnerability
// db.query('SELECT * FROM users WHERE id = ' + userId);
```

## 🔍 Security Headers

### Essential Headers
```javascript
const helmet = require('helmet');

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", "data:", "https:"],
    },
  },
}));
```

### Recommended Headers
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: DENY`
- `X-XSS-Protection: 1; mode=block`
- `Referrer-Policy: no-referrer`

## 📊 Logging & Monitoring

### Security Logging
- Log authentication attempts (success and failure)
- Log authorization failures
- Log input validation failures
- Monitor for unusual patterns

```javascript
// Example: Security event logging
const winston = require('winston');

const securityLogger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'security.log' })
  ]
});

// Log failed login attempt
securityLogger.warn('Failed login attempt', {
  ip: req.ip,
  email: req.body.email,
  timestamp: new Date().toISOString()
});
```

## 🚨 Error Handling

### Secure Error Responses
- Never expose stack traces in production
- Use generic error messages for clients
- Log detailed errors server-side only
- Implement proper error status codes

```javascript
// Example: Secure error handling
app.use((err, req, res, next) => {
  // Log error details
  console.error(err.stack);
  
  // Send generic response to client
  res.status(500).json({
    error: 'An error occurred processing your request',
    reference: generateErrorReference()
  });
});
```

## 🔄 Security Updates

### Maintenance Practices
- Regularly update dependencies
- Monitor security advisories
- Implement automated vulnerability scanning
- Conduct periodic security audits

```bash
# Check for vulnerabilities
npm audit

# Fix vulnerabilities
npm audit fix

# Update dependencies
npm update
```

## 📚 Additional Resources

- [OWASP API Security Top 10](https://owasp.org/www-project-api-security/)
- [Node.js Security Checklist](https://blog.risingstack.com/node-js-security-checklist/)
- [Express Security Best Practices](https://expressjs.com/en/advanced/best-practice-security.html)
- [JWT Best Practices](https://tools.ietf.org/html/rfc8725)

## 🎯 Security Checklist

Before deploying to production, ensure:

- [ ] All endpoints require authentication (except public ones)
- [ ] Input validation is implemented for all endpoints
- [ ] Rate limiting is configured
- [ ] HTTPS is enforced
- [ ] CORS is properly configured
- [ ] Security headers are set
- [ ] Error handling doesn't leak sensitive information
- [ ] Logging and monitoring are configured
- [ ] Dependencies are up to date
- [ ] Environment variables are used for secrets
- [ ] Database connections use least privilege
- [ ] API documentation doesn't expose sensitive endpoints

---

Remember: Security is not a one-time task but an ongoing process. Stay informed about new vulnerabilities and best practices.