# Context Engineering 프로젝트 사양

## 🚀 고급 개발 프레임워크 통합

*23개 이상의 전문 명령어, 23개 이상의 AI 에이전트, 계층적 메모리 관리, 그리고 자동화된 워크플로우 오케스트레이션을 갖춘 완전한 Context Engineering 시스템을 활용하여 엔터프라이즈급 개발 우수성을 달성하세요.*

**프로젝트 메모리**: `@import .claude/memory/project-context.md`
**팀 표준**: `@import .claude/memory/team-preferences.md`  
**도메인 지식**: `@import .claude/memory/domain-knowledge.md`

---

## 🎯 프로젝트 사양 프레임워크

### 기능 식별 및 범위 설정
**기능 이름**: [명확한 비즈니스 정렬을 가진 설명적 기능 이름]
**비즈니스 영향**: [정량화 가능한 가치 제안 및 성공 지표]
**기술적 복잡도**: [아키텍처 통합 지점 및 구현 과제]

### SDLC 파이프라인 초기화
7단계 개발 생명주기로 체계적인 개발 수행:

```bash
# SDLC 파이프라인 시작
/sdlc "[feature-name]" --init --template=standard

# 사용 가능한 템플릿:
# - standard: 전통적인 폭포수 방식 (10-12일)
# - agile: 스프린트 기반 반복 개발 (2주 스프린트)
# - hotfix: 긴급 수정 프로세스 (4시간 SLA)
```

### 분석 프로토콜
전문 에이전트를 사용한 포괄적인 사전 구현 분석 실행:

```bash
# 시스템 컨텍스트 및 아키텍처 분석
/analyze:project-context .     # 현재 시스템 아키텍처 및 통합 지점
/analyze:architecture .        # 설계 패턴 및 아키텍처 품질 평가
/analyze:code-quality .        # 품질 기준선 및 기술 부채 평가

# 보안 및 성능 기반
/analyze:security .           # 보안 태세 및 취약점 평가
/analyze:performance .        # 성능 프로파일 및 확장성 분석
```

---

## 📐 구현 전략

### SDLC 단계별 실행

#### 1️⃣ 계획 (Planning) - 1-2일
```bash
/sdlc "[feature-name]" --phase=planning

# 활동:
- 요구사항 분석 및 문서화
- 작업 분해 구조(WBS) 생성
- 시간 추정: /support:estimate [task]
- 리소스 할당 및 위험 식별
```

#### 2️⃣ 설계 (Design) - 2-3일
```bash
/sdlc "[feature-name]" --phase=design

# 에이전트 조정:
- system-architect: 아키텍처 설계
- architecture-analyzer: 설계 검토
- focused-doc-generator: API 사양
```

#### 3️⃣ 구현 (Implementation) - 3-5일
```bash
/sdlc "[feature-name]" --phase=implementation

# 기능 개발:
/implement:feature [core-functionality]
/implement:enhancement [optimization]
/implement:cleanup [refactoring]
```

#### 4️⃣ 리뷰 (Review) - 1일
```bash
/sdlc "[feature-name]" --phase=review

# 품질 검증:
/analyze:code-quality .
/analyze:security .
/analyze:performance .
```

#### 5️⃣ 테스트 (Testing) - 2-3일
```bash
/sdlc "[feature-name]" --phase=testing

# 테스트 실행:
/manage:test unit-tests
/manage:test integration-tests
/manage:test performance-tests
```

#### 6️⃣ 배포 (Deployment) - 1일
```bash
/sdlc "[feature-name]" --phase=deployment

# 배포 오케스트레이션:
/manage:build production
/manage:workflow deployment
```

#### 7️⃣ 문서화 (Documentation) - 1일
```bash
/sdlc "[feature-name]" --phase=documentation

# 문서 생성:
/support:document api-reference
/support:document user-guide
/project-knowledge-curator "Update documentation"
```

---

## 🔄 품질 게이트 및 워크플로우

### 자동화된 품질 게이트
각 단계는 다음 단계로 진행하기 전에 품질 기준을 충족해야 합니다:

```bash
# 품질 게이트 상태 확인
/sdlc "[feature-name]" --gate-status

# 필요시 게이트 재정의 (정당화 필요)
/sdlc "[feature-name]" --override-gate=testing --reason="긴급 배포"
```

### 지속적 모니터링
```bash
# 파이프라인 상태
/sdlc "[feature-name]" --status

# 진행 보고서
/support:sdlc-report "[feature-name]"

# 메트릭 분석
/manage:sdlc-pipeline metrics "[feature-name]"
```

---

## 🎭 전문 에이전트 오케스트레이션

### 단계별 에이전트 활성화
파이프라인 단계에 따라 자동으로 활성화되는 전문 에이전트:

- **계획**: dev-estimator, task-orchestrator, project-knowledge-curator
- **설계**: system-architect, architecture-analyzer
- **구현**: feature-implementer, code-enhancement-specialist
- **리뷰**: code-quality-analyzer, security-analyzer, performance-analyzer
- **테스트**: test-execution-manager, issue-diagnostician
- **배포**: build-packager, git-workflow-manager
- **문서화**: focused-doc-generator, project-knowledge-curator

---

## 📚 이중 언어 문서화

### 문서화 요구사항
모든 주요 문서는 영어와 한국어 버전을 제공해야 합니다:

- README.md / README.ko.md
- CONTRIBUTING.md / CONTRIBUTING.ko.md
- API 문서: API.md / API.ko.md
- 아키텍처 가이드: ARCHITECTURE.md / ARCHITECTURE.ko.md
- SDLC 가이드: SDLC_GUIDE.md / SDLC_GUIDE.ko.md

---

## 🚀 프로젝트 실행

### 전체 파이프라인 실행
```bash
# 전체 SDLC 파이프라인 자동 실행
/sdlc "[feature-name]" --full

# 병렬 단계 실행 (독립적인 단계)
/sdlc "[feature-name]" --parallel=testing,documentation
```

### 워크플로우 오케스트레이션
```bash
# 복잡한 작업 조정
/orchestrate "SDLC 파이프라인을 통한 완전한 기능 구현"

# 다중 에이전트 협업
/workflow-orchestrator "체크아웃 시스템 end-to-end 구현"
```

---

## 📊 성공 지표

### 개발 속도
- **리드 타임**: 기능 구상에서 프로덕션 배포까지
- **사이클 타임**: 개발 시작에서 완료까지
- **배포 빈도**: 자동화된 배포 성공률

### 품질 메트릭
- **코드 커버리지**: 최소 85%
- **기술 부채**: 자동화된 부채 정량화
- **보안 점수**: 취약점 수 및 심각도
- **성능 메트릭**: 응답 시간, 처리량, 리소스 활용률

---

*Context Engineering Template과 SDLC 파이프라인 시스템을 활용하여 이 사양을 프로덕션 준비 구현으로 변환하세요. 지능적인 에이전트 조정, 메모리 기반 개발, 워크플로우 자동화, 포괄적인 품질 보증을 통해 엔터프라이즈급 소프트웨어를 제공합니다.*