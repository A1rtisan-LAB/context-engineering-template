# 프로젝트 이름

*SDLC 파이프라인 시스템을 갖춘 Context Engineering 템플릿*

## 🚀 개요

비즈니스 가치 제안과 대상 사용자를 포함한 프로젝트에 대한 간략한 설명.

**구축 기술**: 23개 이상의 전문 명령어, 23개 이상의 AI 에이전트, 엔터프라이즈급 개발을 위한 SDLC 파이프라인 시스템을 갖춘 Context Engineering 템플릿.

## 📋 빠른 시작

### 사전 요구사항
- Node.js 18+ 또는 귀하의 기술 스택 요구사항
- 컨테이너화된 개발을 위한 Docker 및 Docker Compose
- 필요한 클라우드 서비스 및 데이터베이스 접근 권한

### 개발 설정
```bash
# 클론 및 설정
git clone <repository-url>
cd <project-name>

# Context Engineering 초기화
cp CLAUDE.md.template CLAUDE.md
# 프로젝트별 요구사항으로 CLAUDE.md 사용자 정의

# 환경 설정
cp .env.example .env
# 설정에 맞게 환경 변수 구성
```

### 개발 워크플로우
```bash
# 초기 프로젝트 분석
/analyze:project-context .
/analyze:architecture .
/analyze:code-quality .

# 기능 개발
/implement:feature [feature-name]
/analyze:security [security-assessment]
/manage:test [test-execution]

# 품질 보증
/analyze:performance [performance-validation]
/support:document [documentation-generation]
/manage:git [semantic-commit]
```

## 📝 PRD 기반 개발

### 제품 요구사항 문서
명확한 요구사항과 자동 SDLC 통합을 위해 구조화된 PRD 프로세스로 개발을 시작하세요:

```bash
# 새 기능을 위한 PRD 생성
/manage:prd create "기능-이름" --template=standard

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

### 8단계 개발 생명주기
SDLC 파이프라인 시스템은 8단계를 통해 체계적인 개발을 제공합니다 (선택적 PRD 단계 포함):

```bash
# 옵션 1: PRD로 시작 (권장)
/manage:prd create "기능-이름" --template=standard
# ... PRD 작성 및 개선 ...
/manage:prd approve "기능-이름"  # 자동으로 SDLC 시작

# 옵션 2: 직접 SDLC 초기화
/sdlc "기능-이름" --init --template=standard

# 사용 가능한 템플릿:
# - standard: 전통적인 폭포수 (10-12일)
# - agile: 스프린트 기반 반복 (2주 스프린트)  
# - hotfix: 긴급 수정 (4시간 SLA)
```

### 파이프라인 명령어
```bash
/sdlc "기능-이름" --status       # 파이프라인 상태 확인
/sdlc "기능-이름" --continue     # 다음 단계로 진행
/sdlc "기능-이름" --full         # 전체 파이프라인 실행
/support:sdlc-report "기능-이름" # 진행 보고서 생성
```

### 개발 단계
0. **PRD 작성(PRD Creation)** (선택사항) - 제품 요구사항 문서화
1. **계획(Planning)** - 요구사항 분석 및 작업 분해
2. **설계(Design)** - 아키텍처 및 API 사양
3. **구현(Implementation)** - AI 에이전트를 활용한 기능 개발
4. **검토(Review)** - 코드 품질 및 보안 분석
5. **테스트(Testing)** - 포괄적인 테스트 실행
6. **배포(Deployment)** - 프로덕션 릴리스 관리
7. **문서화(Documentation)** - 완전한 지식 관리

자세한 안내는 [SDLC 파이프라인 가이드](docs/guides/SDLC_GUIDE.ko.md) ([English](docs/guides/SDLC_GUIDE.md))를 참조하세요.

## 🏗️ 아키텍처

### 시스템 설계
- **아키텍처 패턴**: [마이크로서비스/모놀리스/서버리스]
- **통신**: [REST API/GraphQL/이벤트 기반]
- **데이터 저장소**: [데이터베이스 기술 및 패턴]
- **캐싱**: [캐싱 전략 및 기술]

### 기술 스택
- **백엔드**: Express.js를 사용한 Node.js/TypeScript
- **프론트엔드**: TypeScript와 최신 도구를 사용한 React
- **데이터베이스**: 캐싱용 Redis를 사용한 PostgreSQL
- **인프라**: Docker, Kubernetes, 클라우드 네이티브 배포

### 메모리 통합
프로젝트는 계층적 메모리 관리를 활용합니다:
- **프로젝트 컨텍스트**: `@import .claude/memory/project-context.md`
- **팀 표준**: `@import .claude/memory/team-preferences.md`
- **도메인 지식**: `@import .claude/memory/domain-knowledge.md`

## 🛠️ 개발

### 명령어 사용법
이 프로젝트를 위한 필수 Context Engineering 명령어:

```bash
# 분석 명령어
/analyze:project-context .        # 프로젝트 이해 및 컨텍스트
/analyze:architecture .           # 아키텍처 검증 및 인사이트
/analyze:security .              # 보안 태세 평가
/analyze:performance .           # 성능 프로파일링 및 최적화
/analyze:code-quality .          # 코드 품질 메트릭 및 개선사항

# 구현 명령어  
/implement:feature [component]   # 새로운 기능 개발
/implement:enhancement [module]  # 기존 코드 개선
/implement:cleanup [codebase]    # 기술 부채 감소

# 관리 명령어
/manage:test [test-suite]        # 자동화된 테스트 실행
/manage:build [deployment]       # 빌드 및 배포 프로세스  
/manage:git [version-control]    # 의미론적 커밋을 통한 버전 관리
/manage:workflow [automation]    # 워크플로우 자동화 및 최적화

# 지원 명령어
/support:document [component]    # 문서 생성
/support:estimate [task]         # 개발 노력 추정
/support:diagnose [issue]        # 문제 진단 및 해결
/support:explain [concept]       # 기술 설명 및 지식 전달

# 오케스트레이션
/orchestrate "[complex-task-description]"  # 다중 에이전트 조정
```

### 에이전트 전문화
이 프로젝트는 전문 AI 에이전트를 활용합니다:

- **feature-implementer**: 전문가 페르소나를 통한 새로운 기능 개발
- **code-enhancement-specialist**: 코드 품질 및 성능 개선
- **security-analyzer**: 보안 평가 및 취약점 관리
- **performance-analyzer**: 성능 최적화 및 확장성 분석
- **system-architect**: 아키텍처 설계 및 패턴 검증

### 테스팅 전략
```bash
# Context Engineering 명령어를 통한 포괄적인 테스팅
/manage:test unit-tests          # 단위 테스트 실행
/manage:test integration-tests   # 통합 테스트 검증
/manage:test e2e-tests          # End-to-end 사용자 여정 테스트
/manage:test performance-tests   # 성능 및 부하 테스트
```

## 🔐 보안

security-analyzer 에이전트를 통한 보안 구현:
- **인증**: [인증 방법 및 구현]
- **권한 부여**: [접근 제어 및 권한 모델]
- **데이터 보호**: [암호화 및 데이터 처리 방식]
- **규정 준수**: [규제 요구사항 및 표준]

```bash
# 보안 검증 워크플로우
/analyze:security .                    # 포괄적인 보안 평가
/implement:enhancement security-controls # 보안 개선 구현
/manage:test security-test-suite       # 보안 테스트 및 검증
```

## ⚡ 성능

performance-analyzer 에이전트를 통한 성능 최적화:
- **응답 시간**: 95번째 백분위수에서 200ms 미만 목표
- **처리량**: [예상 초당 요청 수]
- **확장성**: [확장 전략 및 용량 계획]
- **모니터링**: [성능 모니터링 및 경고]

```bash
# 성능 최적화 워크플로우
/analyze:performance .                 # 성능 기준선 및 분석
/implement:enhancement performance     # 성능 최적화 구현
/manage:test performance-benchmarks    # 성능 회귀 테스트
```

## 📚 문서화

### 문서 생성
Context Engineering 명령어를 사용하여 자동으로 문서를 생성하고 유지관리합니다:

```bash
/support:document api-specification    # OpenAPI 문서 생성
/support:document architecture-guide   # 아키텍처 문서
/support:document deployment-guide     # 배포 및 운영 가이드
/support:document troubleshooting      # 문제 해결 문서
```

### 프로젝트 문서 구조
- **API 문서**: 자동 생성된 OpenAPI 사양
- **아키텍처 가이드**: 시스템 설계 및 통합 패턴
- **개발 가이드**: 설정, 워크플로우 및 기여 지침
- **배포 가이드**: 인프라 및 배포 절차
- **문제 해결**: 일반적인 문제 및 해결 절차

## 🚀 배포

### 배포 오케스트레이션
```bash
# Context Engineering 시스템을 통한 프로덕션 배포
/manage:build production-deployment    # 프로덕션 준비 빌드
/analyze:security deployment-security  # 보안 검증
/manage:workflow ci-cd-pipeline       # 자동화된 배포 파이프라인
```

### 환경 구성
- **개발**: Docker Compose를 통한 로컬 개발
- **스테이징**: 통합 테스트를 위한 스테이징 환경
- **프로덕션**: 모니터링 및 경고를 통한 프로덕션 배포

### Infrastructure as Code
- **컨테이너화**: Docker 멀티 스테이지 빌드
- **오케스트레이션**: Kubernetes 배포 매니페스트
- **인프라**: Terraform 또는 CloudFormation 템플릿
- **모니터링**: 메트릭 및 추적을 통한 관찰성 스택

## 🤝 기여하기

### 개발 워크플로우
1. **프로젝트 분석**: `/analyze:project-context .`
2. **기능 계획**: `/support:estimate [feature-implementation]`
3. **개발**: `/implement:feature [feature-name]`
4. **품질 보증**: `/analyze:code-quality [changes]`
5. **테스팅**: `/manage:test [comprehensive-suite]`
6. **문서화**: `/support:document [changes]`
7. **통합**: `/manage:git [semantic-commit]`

### 코드 표준
- `.claude/memory/team-preferences.md`에 정의된 팀 선호사항 따르기
- 코드 커버리지 85% 이상 유지
- 보안 우선 개발 방식 적용
- 모든 아키텍처 결정 문서화 (ADR)

### Pull Request 프로세스
1. 설명적인 이름으로 기능 브랜치 생성
2. 품질 보증을 위해 Context Engineering 명령어를 사용하여 변경사항 구현
3. 포괄적인 테스트 스위트 실행: `/manage:test all-tests`
4. 문서 업데이트: `/support:document [changes]`
5. 자세한 설명과 검증 결과를 포함한 Pull Request 제출

## 📊 모니터링 및 관찰성

### 메트릭 및 경고
- **애플리케이션 메트릭**: 비즈니스 및 기술 KPI
- **성능 모니터링**: 응답 시간 및 처리량
- **오류 추적**: 중앙화된 오류 모니터링 및 경고
- **보안 모니터링**: 보안 이벤트 추적 및 분석

### 헬스 체크
```bash
# 시스템 상태 검증
/analyze:architecture health-check     # 아키텍처 상태 평가
/analyze:performance system-metrics    # 성능 메트릭 분석
/support:diagnose system-issues        # 시스템 문제 진단
```

## 🔄 지속적 개선

### 품질 향상
```bash
# 지속적 개선 워크플로우
/analyze:code-quality technical-debt   # 기술 부채 평가
/implement:cleanup systematic-refactor # 코드 품질 개선
/analyze:performance optimization      # 성능 최적화 기회
/support:document improvements         # 개선사항 및 교훈 문서화
```

## 📞 지원

### 문제 해결
```bash
# 문제 진단 및 해결
/support:diagnose [issue-description]  # 체계적인 문제 진단
/analyze:architecture [problem-area]   # 아키텍처 영향 평가
/implement:enhancement [fix-solution]  # 솔루션 구현
/manage:test [validation-suite]        # 수정 검증 및 테스트
```

### 연락처 및 리소스
- **기술 문제**: 진단 정보와 함께 GitHub 이슈 사용
- **아키텍처 질문**: 아키텍처 문서 참조
- **성능 문제**: 성능 분석 결과 포함
- **보안 우려사항**: 보안 사고 대응 절차 따르기

## ☕ 이 프로젝트 지원하기

이 Context Engineering 템플릿이 개발 워크플로우를 향상시켰다면, 지속적인 혁신을 지원하는 것을 고려해 주세요:

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-☕-yellow.svg)](https://buymeacoffee.com/a1rtisan)

여러분의 지원은 고급 AI 지원 개발 도구와 엔터프라이즈급 템플릿 개발을 추진합니다. 🚀

## 📄 라이선스

[라이선스 정보]

---

*이 프로젝트는 체계적인 개발, 포괄적인 품질 보증 및 엔터프라이즈급 소프트웨어 제공을 위해 SDLC 파이프라인 시스템을 갖춘 Context Engineering 템플릿을 활용합니다. 모든 개발, 테스트 및 유지보수 활동에 Context Engineering 명령어를 사용하세요.*