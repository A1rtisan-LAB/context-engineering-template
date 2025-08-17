# API 보안 모범 사례

## 개요
이 가이드는 템플릿을 사용하여 API를 개발하고 배포할 때 필수적인 보안 사례를 제공합니다.

## 🔐 인증 및 권한 부여

### JWT 토큰 관리
- **강력한 시크릿 사용**: JWT 시크릿에 암호학적으로 안전한 무작위 문자열 생성
- **토큰 만료**: 짧은 수명의 액세스 토큰 구현 (15-30분)
- **리프레시 토큰**: 세션 관리를 위해 더 긴 만료 시간의 리프레시 토큰 사용
- **토큰 순환**: 재생 공격 방지를 위한 리프레시 토큰 순환 구현

```javascript
// 예제: 안전한 JWT 설정
const jwt = require('jsonwebtoken');

const accessToken = jwt.sign(
  { userId, role }, 
  process.env.JWT_SECRET, 
  { expiresIn: '15m' }
);
```

### API 키 관리
- API 키는 환경 변수에 저장, 코드에 직접 작성 금지
- 환경별로 다른 키 사용 (개발, 스테이징, 프로덕션)
- API 키 순환 정책 구현
- 이상 징후 감지를 위한 API 키 사용 모니터링

## 🛡️ 입력 검증 및 살균

### 요청 검증
- 예상 스키마와 대조하여 모든 입력 데이터 검증
- 검증 라이브러리 사용 (예: Joi, Yup, express-validator)
- 예상치 못한 필드가 있는 요청 거부
- 인젝션 공격 방지를 위한 사용자 입력 살균

```javascript
// 예제: express-validator를 사용한 입력 검증
const { body, validationResult } = require('express-validator');

app.post('/api/users',
  body('email').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }).matches(/^(?=.*[A-Za-z])(?=.*\d)/),
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    // 유효한 입력 처리
  }
);
```

## 🚦 속도 제한

### 구현 전략
- 인증 기반 사용자별 속도 제한
- 공개 엔드포인트에 대한 IP별 속도 제한
- 엔드포인트 유형별 다른 제한
- 반복 실패에 대한 점진적 지연

```javascript
// 예제: express-rate-limit을 사용한 속도 제한
const rateLimit = require('express-rate-limit');

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15분
  max: 100, // 각 IP를 windowMs당 100개 요청으로 제한
  message: '이 IP에서 너무 많은 요청이 발생했습니다'
});

app.use('/api/', apiLimiter);
```

## 🔒 HTTPS 및 전송 보안

### SSL/TLS 구성
- **프로덕션에서는 항상 HTTPS 사용**
- HSTS (HTTP Strict Transport Security) 구현
- TLS 1.2 이상 사용
- 모바일 클라이언트를 위한 인증서 고정 구현

```javascript
// 예제: HSTS 헤더
app.use((req, res, next) => {
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
  next();
});
```

## 🌐 CORS 구성

### 안전한 CORS 설정
- 허용된 출처를 명시적으로 지정
- 프로덕션에서 와일드카드(*) 사용 금지
- 허용된 메서드 및 헤더 구성
- Origin 헤더 검증

```javascript
// 예제: 안전한 CORS 구성
const cors = require('cors');

const corsOptions = {
  origin: function (origin, callback) {
    const allowedOrigins = process.env.ALLOWED_ORIGINS.split(',');
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('CORS에 의해 허용되지 않음'));
    }
  },
  credentials: true,
  optionsSuccessStatus: 200
};

app.use(cors(corsOptions));
```

## 🗄️ 데이터베이스 보안

### SQL 인젝션 방지
- 매개변수화된 쿼리 또는 ORM/ODM 사용
- 사용자 입력을 쿼리에 직접 연결하지 않음
- 데이터베이스 작업 전 데이터 타입 검증
- 데이터베이스 사용자에 최소 권한 원칙 적용

```javascript
// 예제: 매개변수화된 쿼리
const userId = req.params.id;
// 좋음
db.query('SELECT * FROM users WHERE id = ?', [userId]);
// 나쁨 - SQL 인젝션 취약점
// db.query('SELECT * FROM users WHERE id = ' + userId);
```

## 🔍 보안 헤더

### 필수 헤더
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

### 권장 헤더
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: DENY`
- `X-XSS-Protection: 1; mode=block`
- `Referrer-Policy: no-referrer`

## 📊 로깅 및 모니터링

### 보안 로깅
- 인증 시도 로깅 (성공 및 실패)
- 권한 부여 실패 로깅
- 입력 검증 실패 로깅
- 비정상 패턴 모니터링

```javascript
// 예제: 보안 이벤트 로깅
const winston = require('winston');

const securityLogger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'security.log' })
  ]
});

// 실패한 로그인 시도 로깅
securityLogger.warn('로그인 시도 실패', {
  ip: req.ip,
  email: req.body.email,
  timestamp: new Date().toISOString()
});
```

## 🚨 오류 처리

### 안전한 오류 응답
- 프로덕션에서 스택 추적 노출 금지
- 클라이언트에는 일반적인 오류 메시지 사용
- 상세 오류는 서버 측에만 로깅
- 적절한 오류 상태 코드 구현

```javascript
// 예제: 안전한 오류 처리
app.use((err, req, res, next) => {
  // 오류 상세 로깅
  console.error(err.stack);
  
  // 클라이언트에 일반 응답 전송
  res.status(500).json({
    error: '요청 처리 중 오류가 발생했습니다',
    reference: generateErrorReference()
  });
});
```

## 🔄 보안 업데이트

### 유지보수 사례
- 정기적인 의존성 업데이트
- 보안 권고 모니터링
- 자동화된 취약점 스캔 구현
- 주기적인 보안 감사 실시

```bash
# 취약점 확인
npm audit

# 취약점 수정
npm audit fix

# 의존성 업데이트
npm update
```

## 📚 추가 리소스

- [OWASP API Security Top 10](https://owasp.org/www-project-api-security/)
- [Node.js 보안 체크리스트](https://blog.risingstack.com/node-js-security-checklist/)
- [Express 보안 모범 사례](https://expressjs.com/en/advanced/best-practice-security.html)
- [JWT 모범 사례](https://tools.ietf.org/html/rfc8725)

## 🎯 보안 체크리스트

프로덕션 배포 전 확인사항:

- [ ] 모든 엔드포인트에 인증 필요 (공개 엔드포인트 제외)
- [ ] 모든 엔드포인트에 입력 검증 구현
- [ ] 속도 제한 구성
- [ ] HTTPS 강제
- [ ] CORS 적절히 구성
- [ ] 보안 헤더 설정
- [ ] 오류 처리가 민감한 정보를 노출하지 않음
- [ ] 로깅 및 모니터링 구성
- [ ] 의존성 최신 상태 유지
- [ ] 시크릿에 환경 변수 사용
- [ ] 데이터베이스 연결에 최소 권한 사용
- [ ] API 문서가 민감한 엔드포인트를 노출하지 않음

---

기억하세요: 보안은 일회성 작업이 아니라 지속적인 프로세스입니다. 새로운 취약점과 모범 사례에 대해 항상 정보를 업데이트하세요.