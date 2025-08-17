---
title: Workflows API 참조
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: api
tags: [workflows, api, reference, orchestration]
language: ko
---

# Workflows API 참조

## 개요

Context Engineering Template의 워크플로우는 복잡한 개발 작업을 수행하기 위해 에이전트와 명령을 조정하는 구조화된 다단계 프로세스를 제공합니다. 시스템에는 사용자 정의 및 확장 가능한 4개의 핵심 워크플로우가 포함되어 있습니다.

## 목차

- [핵심 워크플로우](#핵심-워크플로우)
- [워크플로우 구조](#워크플로우-구조)
- [워크플로우 실행](#워크플로우-실행)
- [사용자 정의 워크플로우](#사용자-정의-워크플로우)
- [워크플로우 오케스트레이션](#워크플로우-오케스트레이션)
- [모범 사례](#모범-사례)

## 핵심 워크플로우

### development-lifecycle
요구사항부터 배포까지 완전한 개발 라이프사이클 워크플로우.

**목적**: 전체 개발 라이프사이클 조정  
**기간**: 10-15일 (일반적)  
**단계**: 7단계 (계획 → 문서화)

**구조**:
```yaml
workflow: development-lifecycle
description: 완전한 개발 라이프사이클 워크플로우
phases:
  - planning:
      duration: 1-2일
      agents: [project-knowledge-curator, dev-estimator]
      outputs: [requirements.md, estimates.json]
  - design:
      duration: 2-3일
      agents: [system-architect, architecture-analyzer]
      outputs: [architecture.md, api-spec.yaml]
  - implementation:
      duration: 3-5일
      agents: [feature-implementer, code-enhancement-specialist]
      outputs: [소스 코드, 단위 테스트]
  - review:
      duration: 1일
      agents: [code-quality-analyzer, security-analyzer]
      outputs: [review-report.md]
  - testing:
      duration: 2-3일
      agents: [test-execution-manager, issue-diagnostician]
      outputs: [test-results.json, coverage.html]
  - deployment:
      duration: 1일
      agents: [build-packager, git-workflow-manager]
      outputs: [빌드 아티팩트, 배포 로그]
  - documentation:
      duration: 1일
      agents: [focused-doc-generator, project-knowledge-curator]
      outputs: [api-docs.md, user-guide.md]
```

**트리거**:
```bash
/orchestrate development-lifecycle "feature-name"
```

### quality-assurance
포괄적인 품질 검사 및 검증 워크플로우.

**목적**: 코드 품질, 보안 및 성능 보장  
**기간**: 4-6시간  
**구성요소**: 정적 분석, 테스팅, 보안 감사

**구조**:
```yaml
workflow: quality-assurance
description: 품질 보증 및 검증 워크플로우
stages:
  - code-analysis:
      tools: [eslint, prettier, tsc]
      agents: [code-quality-analyzer]
      metrics: [복잡도, 커버리지, 중복]
  - security-scan:
      tools: [npm audit, security-analyzer]
      agents: [security-analyzer]
      checks: [취약점, 시크릿, 권한]
  - performance-test:
      tools: [벤치마크 스위트]
      agents: [performance-analyzer]
      metrics: [응답 시간, 메모리 사용량, 처리량]
  - documentation-check:
      agents: [doc-manager]
      validations: [완성도, 정확성, 동기화]
```

**트리거**:
```bash
/orchestrate quality-assurance
```

### prd-to-implementation
PRD를 작동하는 구현으로 변환.

**목적**: 요구사항에서 코드로 자동화  
**기간**: 가변 (PRD 복잡도에 따름)  
**통합**: SDLC 파이프라인, PRD 시스템

**구조**:
```yaml
workflow: prd-to-implementation
description: PRD 기반 구현 워크플로우
steps:
  - prd-analysis:
      agents: [prd-workflow-generator]
      actions:
        - PRD 요구사항 파싱
        - 작업 분해 생성
        - 구현 계획 생성
  - sdlc-initialization:
      agents: [sdlc-coordinator]
      actions:
        - 파이프라인 초기화
        - 단계 구성
        - 품질 게이트 설정
  - automated-implementation:
      agents: [workflow-orchestrator]
      actions:
        - 구현 작업 실행
        - 진행 상황 추적
        - 의존성 처리
  - validation:
      agents: [test-execution-manager]
      actions:
        - PRD 대비 검증
        - 수용 테스트 실행
        - 준수 보고서 생성
```

**트리거**:
```bash
/manage:prd approve "feature-name"  # 워크플로우 자동 트리거
```

### issue-resolution
신속한 문제 진단 및 해결 워크플로우.

**목적**: 프로덕션 문제를 빠르게 식별하고 수정  
**기간**: 30분 - 4시간  
**우선순위**: 긴급 대응

**구조**:
```yaml
workflow: issue-resolution
description: 긴급 문제 해결 워크플로우
phases:
  - diagnosis:
      duration: 15-30분
      agents: [issue-diagnostician]
      outputs: [root-cause.md, impact-analysis.md]
  - solution-design:
      duration: 15-30분
      agents: [system-architect, security-analyzer]
      outputs: [fix-strategy.md, risk-assessment.md]
  - implementation:
      duration: 30-120분
      agents: [feature-implementer, code-cleanup-optimizer]
      outputs: [핫픽스 코드, 테스트]
  - validation:
      duration: 15-30분
      agents: [test-execution-manager]
      outputs: [test-results.json, regression-report.md]
  - deployment:
      duration: 15분
      agents: [build-packager]
      outputs: [배포 로그, 롤백 계획]
```

**트리거**:
```bash
/orchestrate issue-resolution "중요 버그 설명"
```

## 워크플로우 구조

### 워크플로우 정의
워크플로우는 다음 구조로 YAML 또는 JSON 형식으로 정의됩니다:

```yaml
# 워크플로우 메타데이터
name: workflow-name
version: 1.0.0
description: 워크플로우 설명
author: 팀/작성자 이름

# 워크플로우 구성
config:
  parallel_execution: false
  auto_proceed: true
  notifications: true
  rollback_enabled: true

# 워크플로우 단계
phases:
  - phase_name:
      description: 단계 설명
      duration: 예상 기간
      agents: [에이전트 목록]
      commands: [명령 목록]
      gates:
        entry: [진입 조건]
        exit: [종료 조건]
      outputs: [예상 결과물]
      on_error: [오류 처리]
```

### 단계 정의
각 단계는 다음을 포함합니다:

| 요소 | 타입 | 설명 |
|------|------|------|
| `description` | string | 단계 목적과 목표 |
| `duration` | string | 완료 예상 시간 |
| `agents` | array | 사용할 AI 에이전트 |
| `commands` | array | 실행할 명령 |
| `gates` | object | 품질 게이트와 조건 |
| `outputs` | array | 예상 결과물 |
| `on_error` | string | 오류 처리 전략 |

### 게이트 정의
품질 게이트는 단계 전환을 제어합니다:

```yaml
gates:
  entry:
    - condition: "PRD 승인됨"
    - condition: "테스트 통과"
  exit:
    - condition: "코드 커버리지 > 80%"
    - condition: "중요 문제 없음"
    - condition: "문서 완료"
```

## 워크플로우 실행

### 수동 실행
orchestrate 명령을 사용하여 워크플로우 실행:

```bash
# 기본 실행
/orchestrate [workflow-name] [parameters]

# 옵션과 함께
/orchestrate [workflow-name] --phase=specific-phase --debug
```

### 자동 트리거
이벤트에 의해 워크플로우가 트리거될 수 있습니다:

| 이벤트 | 워크플로우 | 트리거 |
|--------|----------|--------|
| PRD 승인 | prd-to-implementation | `/manage:prd approve` |
| 프로덕션 이슈 | issue-resolution | 오류 모니터링 알림 |
| PR 생성 | quality-assurance | Git 훅 |
| 스프린트 시작 | development-lifecycle | 캘린더 이벤트 |

### 실행 모드

#### 순차 모드
단계가 순차적으로 실행됩니다:
```yaml
config:
  parallel_execution: false
```

#### 병렬 모드
독립적인 단계가 동시에 실행됩니다:
```yaml
config:
  parallel_execution: true
  parallel_phases:
    - [design, documentation]
    - [testing, security-scan]
```

#### 조건부 모드
조건에 따라 단계가 실행됩니다:
```yaml
phases:
  - optional_phase:
      condition: "feature_type == 'api'"
      agents: [api-specialist]
```

## 사용자 정의 워크플로우

### 사용자 정의 워크플로우 생성

1. **워크플로우 파일 정의**
`.claude/workflows/custom-workflow.yaml` 생성:

```yaml
name: custom-workflow
version: 1.0.0
description: 특정 요구에 맞는 사용자 정의 워크플로우

phases:
  - initialization:
      description: 설정 및 준비
      agents: [project-context-analyzer]
      duration: 30분
  - execution:
      description: 주요 실행 단계
      agents: [task-orchestrator]
      duration: 2시간
  - validation:
      description: 결과 검증
      agents: [test-execution-manager]
      duration: 1시간
```

2. **워크플로우 등록**
`.claude/settings.json`에 추가:

```json
{
  "workflows": {
    "custom-workflow": {
      "path": ".claude/workflows/custom-workflow.yaml",
      "enabled": true
    }
  }
}
```

3. **워크플로우 테스트**
```bash
/orchestrate custom-workflow --dry-run
```

### 워크플로우 템플릿

#### 기능 개발 템플릿
```yaml
name: feature-development
phases:
  - requirements
  - design
  - implementation
  - testing
  - documentation
```

#### 버그 수정 템플릿
```yaml
name: bug-fix
phases:
  - reproduce
  - diagnose
  - fix
  - test
  - deploy
```

#### 리팩토링 템플릿
```yaml
name: refactoring
phases:
  - analysis
  - planning
  - refactor
  - test
  - optimize
```

## 워크플로우 오케스트레이션

### 오케스트레이션 엔진
워크플로우 오케스트레이션 엔진이 관리하는 항목:
- 단계 실행 순서
- 리소스 할당
- 상태 관리
- 오류 복구
- 진행 상황 추적

### 상태 관리
워크플로우 상태는 다음 위치에 유지됩니다:
```
.claude/workflows/state/
├── workflow-name/
│   ├── current-state.json
│   ├── history.json
│   └── artifacts/
```

### 진행 상황 추적
워크플로우 진행 상황 모니터링:

```bash
# 상태 확인
/orchestrate status [workflow-name]

# 상세 진행 상황 보기
/orchestrate progress [workflow-name] --verbose

# 단계 세부정보 가져오기
/orchestrate phase-status [workflow-name] [phase-name]
```

### 오류 처리

#### 재시도 전략
```yaml
on_error:
  strategy: retry
  max_attempts: 3
  backoff: exponential
```

#### 롤백 전략
```yaml
on_error:
  strategy: rollback
  checkpoint: last_successful_phase
```

#### 수동 개입
```yaml
on_error:
  strategy: pause
  notification: slack
  require_approval: true
```

## 모범 사례

### 워크플로우 설계

1. **단계를 집중적으로 유지**
   - 단계당 단일 책임
   - 명확한 입출력 계약
   - 측정 가능한 성공 기준

2. **적절한 에이전트 사용**
   - 단계 요구사항에 맞는 에이전트 매칭
   - 에이전트 과부하 방지
   - 에이전트 전문성 고려

3. **명확한 게이트 정의**
   - 객관적이고 측정 가능한 기준
   - 가능한 경우 자동 검증
   - 게이트 요구사항 문서화

### 성능 최적화

1. **가능한 경우 병렬화**
   - 독립적인 단계 식별
   - 병렬 실행 모드 사용
   - 리소스 사용량 모니터링

2. **중간 결과 캐싱**
   - 단계 출력 저장
   - 아티팩트 재사용
   - 증분 처리 구현

3. **에이전트 선택 최적화**
   - 전문 에이전트 사용
   - 에이전트 전환 최소화
   - 유사한 작업 배치

### 오류 복구

1. **체크포인트 구현**
   - 각 단계 후 상태 저장
   - 실패에서 재개 가능
   - 감사 추적 유지

2. **롤백 포인트 정의**
   - 안전한 롤백 상태 식별
   - 롤백 절차 테스트
   - 롤백 영향 문서화

3. **모니터링 및 알림**
   - 진행 상황 모니터링 설정
   - 실패 알림 구성
   - 성공 메트릭 추적

## 고급 기능

### 워크플로우 구성
복잡한 시나리오를 위한 워크플로우 결합:

```yaml
name: composite-workflow
workflows:
  - development-lifecycle
  - quality-assurance
  - deployment-pipeline
```

### 동적 워크플로우
컨텍스트 기반 워크플로우 생성:

```javascript
// 동적 워크플로우 생성
const workflow = generateWorkflow({
  projectType: 'api',
  complexity: 'high',
  timeline: '2-weeks'
});
```

### 워크플로우 분석
워크플로우 메트릭 추적:

| 메트릭 | 설명 | 사용 사례 |
|--------|------|----------|
| 완료 시간 | 총 실행 시간 | 성능 최적화 |
| 성공률 | 성공적인 실행 비율 | 품질 추적 |
| 단계 기간 | 단계별 시간 | 병목 현상 식별 |
| 오류 빈도 | 단계별 오류율 | 신뢰성 개선 |

## 통합 포인트

### CI/CD 통합
```yaml
# GitHub Actions 통합
on:
  pull_request:
    types: [opened, synchronize]
jobs:
  quality-workflow:
    runs-on: ubuntu-latest
    steps:
      - uses: claude-code/workflow-action@v1
        with:
          workflow: quality-assurance
```

### 외부 도구
워크플로우는 다음과 통합할 수 있습니다:
- 이슈 추적 (Jira, GitHub Issues)
- 모니터링 (DataDog, New Relic)
- 커뮤니케이션 (Slack, Teams)
- 문서화 (Confluence, Notion)

### API 통합
```javascript
// API를 통한 워크플로우 트리거
const response = await claude.workflows.execute({
  name: 'development-lifecycle',
  parameters: {
    feature: 'user-authentication',
    priority: 'high'
  },
  options: {
    notify: true,
    async: true
  }
});
```

## 문제 해결

### 일반적인 문제

| 문제 | 원인 | 해결책 |
|------|------|--------|
| 워크플로우를 찾을 수 없음 | 정의 누락 | 워크플로우 파일 위치 확인 |
| 단계 시간 초과 | 장시간 실행 작업 | 시간 초과 증가 또는 최적화 |
| 게이트 실패 | 기준 미충족 | 게이트 조건 검토 |
| 상태 손상 | 실행 중단 | 체크포인트에서 복원 |

### 디버그 모드
상세 로깅 활성화:
```bash
CLAUDE_WORKFLOW_DEBUG=true /orchestrate [workflow-name]
```

### 워크플로우 로그
상세 로그 접근:
```bash
# 워크플로우 로그 보기
cat .claude/workflows/logs/[workflow-name].log

# 실시간 로그 스트리밍
tail -f .claude/workflows/logs/[workflow-name].log
```

## 참조

- [Commands API](commands.ko.md) - 사용 가능한 명령 참조
- [AI Agents API](agents.ko.md) - 에이전트 기능
- [SDLC 가이드](../guides/SDLC_GUIDE.ko.md) - 파이프라인 문서
- [오케스트레이션 튜토리얼](../tutorials/workflow-orchestration.ko.md) - 실습 가이드