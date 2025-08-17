# API 스타터 템플릿

26개의 전문 AI 에이전트와 SDLC 파이프라인 시스템을 갖춘 API 서버 프로젝트용 Context Engineering 템플릿입니다.

## 🚀 프로젝트 구조

```
api-project/
├── src/
│   ├── routes/          # API 라우트 정의
│   ├── middleware/      # Express 미들웨어
│   ├── models/          # 데이터 모델
│   └── controllers/     # 라우트 컨트롤러
├── tests/               # 테스트 파일
├── docs/                # SDLC 가이드를 포함한 문서
├── .claude/             # Claude Code 설정
├── package.json         # Node.js 의존성
├── server.js           # 메인 서버 파일
└── .env.example        # 환경 변수 템플릿
```

## 📝 PRD 기반 개발

### 제품 요구사항 문서
명확한 요구사항과 자동 SDLC 통합을 위해 구조화된 PRD 프로세스로 개발을 시작하세요:

```bash
# 새 기능을 위한 PRD 생성
/manage:prd create "기능-이름" --template=api

# PRD 품질 검토 (80점 이상 필요)
/support:prd-review "기능-이름"

# PRD 승인 (자동으로 SDLC 시작)
/manage:prd approve "기능-이름"
```

### PRD 워크플로우 장점
- **명확한 요구사항**: 코딩 전에 무엇을 만들지 정의
- **품질 게이트**: 검토 프로세스로 완성도 보장
- **자동 번역**: 한국어 PRD가 자동으로 영어로 번역
- **SDLC 통합**: 승인된 PRD가 개발 파이프라인 트리거
- **문서화 추적**: 아이디어부터 구현까지 완전한 이력

자세한 안내는 [PRD 가이드](docs/guides/PRD_GUIDE.ko.md) ([English](docs/guides/PRD_GUIDE.md))를 참조하세요.
## 📊 SDLC 파이프라인 시스템

### 빠른 시작
```bash
# API 프로젝트용 SDLC 파이프라인 초기화
/sdlc "api-feature" --init --template=standard

# 파이프라인 상태 확인
/sdlc "api-feature" --status

# 진행 보고서 생성
/support:sdlc-report "api-feature"
```

### API 개발 워크플로우
```bash
# 1단계: 계획 (1-2일차)
/sdlc "api-feature" --phase=planning
/support:estimate api-endpoints

# 2단계: 설계 (3-5일차)
/sdlc "api-feature" --phase=design
/support:document api-specification

# 3단계: 구현 (6-10일차)
/sdlc "api-feature" --phase=implementation
/implement:feature api-endpoints
/implement:feature authentication
/implement:feature data-validation

# 4단계: 검토 (11일차)
/sdlc "api-feature" --phase=review
/analyze:security api-endpoints
/analyze:code-quality .

# 5단계: 테스트 (12-13일차)
/sdlc "api-feature" --phase=testing
/manage:test api-tests
/analyze:performance api-load

# 6단계: 배포 (14일차)
/sdlc "api-feature" --phase=deployment
/manage:build production
/manage:workflow deployment-pipeline

# 7단계: 문서화 (15일차)
/sdlc "api-feature" --phase=documentation
/support:document openapi-spec
```

## 🛠️ 기능

- RESTful API 아키텍처
- Express.js 프레임워크 설정
- 미들웨어 구성
- Model-View-Controller 패턴
- 환경 기반 구성
- 테스팅 프레임워크 통합
- OpenAPI 문서화
- 보안 모범 사례
- 성능 모니터링

## 🚀 시작하기

1. 의존성 설치:
   ```bash
   npm install
   ```

2. 환경 변수 설정:
   ```bash
   cp .env.example .env
   ```

3. SDLC 파이프라인 초기화 (선택사항):
   ```bash
   /sdlc "my-api" --init
   ```

4. 개발 서버 시작:
   ```bash
   npm run dev
   ```

## 🤖 Claude Code 명령어

### 분석 명령어
- `/analyze:architecture` - API 아키텍처 검토
- `/analyze:security` - 보안 감사
- `/analyze:performance` - 성능 분석
- `/analyze:code-quality` - 코드 품질 메트릭

### 구현 명령어
- `/implement:feature` - 새로운 API 엔드포인트 추가
- `/implement:enhancement` - 기존 코드 개선
- `/implement:cleanup` - 코드 리팩토링

### 관리 명령어
- `/manage:test` - 테스트 스위트 실행
- `/manage:build` - 프로덕션 빌드
- `/manage:git` - 버전 관리
- `/manage:workflow` - CI/CD 파이프라인

### 지원 명령어
- `/support:document` - 문서 생성
- `/support:estimate` - 개발 시간 추정
- `/support:diagnose` - 문제 해결
- `/support:sdlc-report` - SDLC 진행 보고서

## 📚 문서

- [SDLC 파이프라인 가이드](docs/guides/SDLC_GUIDE.ko.md) ([English](docs/guides/SDLC_GUIDE.md))
- [PRD 가이드](docs/guides/PRD_GUIDE.ko.md) ([English](docs/guides/PRD_GUIDE.md))
- [빠른 시작 가이드](docs/guides/QUICKSTART.ko.md) ([English](docs/guides/QUICKSTART.md))

## 🌏 언어

이 문서는 다음 언어로도 제공됩니다:
- [English](README.md)