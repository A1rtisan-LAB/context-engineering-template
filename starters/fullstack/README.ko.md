# 풀스택 스타터 템플릿

23+ 전문 AI 에이전트와 SDLC 파이프라인 시스템을 갖춘 풀스택 애플리케이션용 Context Engineering 템플릿입니다.

## 🚀 프로젝트 구조

```
fullstack-project/
├── client/
│   └── src/            # 프론트엔드 React 애플리케이션
├── server/
│   └── src/            # 백엔드 Node.js API
├── shared/             # 공유 유틸리티 및 타입
├── docs/               # SDLC 가이드를 포함한 문서
├── tests/              # End-to-end 테스트
├── .claude/            # Claude Code 설정
├── package.json        # 루트 package.json
└── docker-compose.yml  # 개발 환경
```

## 📊 SDLC 파이프라인 시스템

### 빠른 시작
```bash
# 풀스택 프로젝트용 SDLC 파이프라인 초기화
/sdlc "fullstack-app" --init --template=agile

# 파이프라인 상태 확인
/sdlc "fullstack-app" --status

# 진행 보고서 생성
/support:sdlc-report "fullstack-app"
```

### 풀스택 개발 워크플로우
```bash
# 1단계: 계획 (스프린트 1, 1-2일차)
/sdlc "fullstack-app" --phase=planning
/support:estimate fullstack-features
/orchestrate "architecture planning"

# 2단계: 설계 (스프린트 1, 3-5일차)
/sdlc "fullstack-app" --phase=design
/analyze:architecture system-design
/support:document api-contracts

# 3단계: 구현 (스프린트 1-2)
/sdlc "fullstack-app" --phase=implementation
# 백엔드 개발
/implement:feature api-server
/implement:feature database-layer
/analyze:security backend
# 프론트엔드 개발
/implement:feature ui-components
/implement:feature state-management
/analyze:performance frontend

# 4단계: 검토 (스프린트 2, 11일차)
/sdlc "fullstack-app" --phase=review
/analyze:code-quality .
/analyze:architecture integration-points

# 5단계: 테스트 (스프린트 2, 12-13일차)
/sdlc "fullstack-app" --phase=testing
/manage:test unit-tests
/manage:test integration-tests
/manage:test e2e-scenarios

# 6단계: 배포 (스프린트 2, 14일차)
/sdlc "fullstack-app" --phase=deployment
/manage:build docker-images
/manage:workflow ci-cd-pipeline
/orchestrate "production deployment"

# 7단계: 문서화 (스프린트 2, 14일차)
/sdlc "fullstack-app" --phase=documentation
/support:document architecture-guide
/support:document deployment-guide
```

## 🛠️ 기능

- 클라이언트와 서버가 포함된 모노레포 구조
- 공유 타입 정의
- Docker 개발 환경
- End-to-end 테스팅
- 지속적 통합
- 데이터베이스 통합
- 마이크로서비스 준비
- API 게이트웨이 패턴
- 실시간 기능
- 확장 가능한 아키텍처

## 🏗️ 아키텍처

```
┌─────────────┐     ┌─────────────┐
│  Frontend   │────▶│ API Gateway │
└─────────────┘     └─────────────┘
                            │
                ┌───────────┼───────────┐
                ▼           ▼           ▼
        ┌──────────┐ ┌──────────┐ ┌──────────┐
        │ Auth API │ │ Core API │ │ Data API │
        └──────────┘ └──────────┘ └──────────┘
                │           │           │
                └───────────┼───────────┘
                            ▼
                    ┌──────────────┐
                    │   Database   │
                    └──────────────┘
```

## 🚀 시작하기

1. 의존성 설치:
   ```bash
   npm install
   ```

2. SDLC 파이프라인 초기화 (선택사항):
   ```bash
   /sdlc "my-app" --init --template=agile
   ```

3. 개발 환경 시작:
   ```bash
   docker-compose up
   ```

4. 테스트 실행:
   ```bash
   npm test
   ```

## 🤖 Claude Code 명령어

### 오케스트레이션
- `/orchestrate` - 풀스택 개발 조정
- `/workflow-orchestrator` - 복잡한 워크플로우 관리

### 분석 명령어
- `/analyze:architecture` - 시스템 아키텍처 검토
- `/analyze:security` - 보안 감사
- `/analyze:performance` - 성능 분석
- `/analyze:code-quality` - 코드 품질 메트릭

### 구현 명령어
- `/implement:feature` - 새로운 기능 추가
- `/implement:enhancement` - 기존 코드 개선
- `/implement:cleanup` - 코드 리팩토링

### 관리 명령어
- `/manage:build` - 빌드 및 배포
- `/manage:workflow` - 개발 워크플로우 관리
- `/manage:test` - 테스트 스위트 실행
- `/manage:git` - 버전 관리

### 지원 명령어
- `/support:document` - 문서 생성
- `/support:estimate` - 개발 시간 추정
- `/support:diagnose` - 문제 해결
- `/support:sdlc-report` - SDLC 진행 보고서

## 📚 문서

- [SDLC 파이프라인 가이드](docs/SDLC_GUIDE.ko.md) ([English](docs/SDLC_GUIDE.md))
- [아키텍처 가이드](docs/ARCHITECTURE.md)
- [API 문서](docs/API.md)
- [배포 가이드](docs/DEPLOYMENT.md)
- [테스팅 전략](docs/TESTING.md)

## 🌏 언어

이 문서는 다음 언어로도 제공됩니다:
- [English](README.md)