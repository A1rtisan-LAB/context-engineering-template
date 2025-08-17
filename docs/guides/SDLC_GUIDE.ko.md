---
title: SDLC 파이프라인 시스템 가이드
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: guides
tags: [sdlc, pipeline, development, automation]
language: ko
---

# SDLC 파이프라인 시스템 가이드

## 목차
1. [개요 및 철학](#개요-및-철학)
2. [빠른 시작](#빠른-시작)
3. [단계별 상세 가이드](#단계별-상세-가이드)
4. [템플릿 심화 가이드](#템플릿-심화-가이드)
5. [품질 게이트 관리](#품질-게이트-관리)
6. [고급 기능](#고급-기능)
7. [베스트 프랙티스](#베스트-프랙티스)
8. [트러블슈팅](#트러블슈팅)
9. [사례 연구](#사례-연구)
10. [레퍼런스](#레퍼런스)

## 개요 및 철학

### SDLC 파이프라인 시스템이란?

SDLC(소프트웨어 개발 생명주기) 파이프라인 시스템은 임시방편적인 개발을 구조화되고 반복 가능한 프로세스로 변환하는 지능적이고 자동화된 프레임워크입니다. 각각 전문 AI 에이전트, 품질 게이트, 진행 추적 기능을 갖춘 7개의 구별된 단계를 통해 개발 워크플로우를 조정합니다.

### 핵심 철학

- **구조화된 자유**: 경직성 없는 구조 제공
- **설계에 의한 품질**: 모든 단계에 내장된 품질 게이트
- **지능적 자동화**: AI 에이전트가 루틴 작업 처리
- **지속적 가시성**: 실시간 진행 상황 및 메트릭
- **유연한 적응**: 다양한 시나리오를 위한 템플릿

### SDLC 파이프라인을 사용해야 하는 이유

전통적인 개발의 문제점:
- 프로젝트 간 일관성 없는 프로세스
- 누락된 문서화
- 건너뛴 테스트 단계
- 불명확한 진행 가시성
- 늦게 발견되는 품질 문제

SDLC 파이프라인의 해결책:
- 일관되고 검증된 프로세스 적용
- 문서 생성 자동화
- 각 단계의 품질 검사 의무화
- 실시간 진행 추적 제공
- 단계 게이트를 통한 조기 문제 발견

## 빠른 시작

### 10분 튜토리얼

#### 1단계: 준비 상태 확인
```bash
/analyze:sdlc-readiness
```
프로젝트가 SDLC 파이프라인 통합 준비가 되었는지 확인합니다.

#### 2단계: 첫 파이프라인 초기화
```bash
# 옵션 A: SDLC로 직접 시작
/sdlc "my-feature" --init

# 옵션 B: 승인된 PRD에서 시작 (권장)
/manage:prd create "my-feature" --template=standard
# ... PRD 작성 및 개선 ...
/manage:prd approve "my-feature"  # SDLC 자동 시작
```

#### 3단계: 계획 단계 실행
```bash
/sdlc "my-feature" --phase=planning
```
시스템이 요구사항 수집을 안내합니다.
참고: PRD에서 시작한 경우 요구사항이 자동으로 가져와집니다.

#### 4단계: 상태 확인
```bash
/sdlc "my-feature" --status
```
현재 단계와 진행 상황을 확인합니다.

#### 5단계: 다음 단계로 진행
```bash
/sdlc "my-feature" --continue
```
자동으로 설계 단계로 진행합니다.

### 필수 명령어

| 명령어 | 목적 | 예시 |
|--------|------|------|
| `/sdlc --init` | 새 파이프라인 시작 | `/sdlc "auth-system" --init` |
| `/sdlc --init --from-prd` | PRD에서 시작 | `/sdlc "auth-system" --init --from-prd` |
| `/sdlc --status` | 진행 상황 확인 | `/sdlc "auth-system" --status` |
| `/sdlc --continue` | 다음 단계 | `/sdlc "auth-system" --continue` |
| `/sdlc --full` | 모든 단계 실행 | `/sdlc "auth-system" --full` |
| `/support:sdlc-report` | 보고서 생성 | `/support:sdlc-report "auth-system"` |

## 단계별 상세 가이드

### 0단계: PRD 작성 (PRD Creation) - 선택사항

**소요 시간**: 1-2일  
**목적**: 개발 전 제품 요구사항 정의

#### 사용 시기
- 명확한 사양이 필요한 새 기능
- 여러 이해관계자가 있는 복잡한 프로젝트
- 개발 전 승인이 필요한 프로젝트
- 문서화 추적이 중요한 경우

#### 주요 활동
1. **요구사항 정의**
   - 템플릿을 사용하여 포괄적인 PRD 작성
   - 성공 지표 및 KPI 정의
   - 기능 및 비기능 요구사항 명시
   
2. **검토 및 개선**
   - 검토를 위해 PRD 제출
   - 피드백 반영 및 반복
   - 완성도와 명확성 보장
   
3. **승인 프로세스**
   - 이해관계자 승인 획득
   - 요구사항 최종 확정
   - 개발 범위 확정

#### 명령어
```bash
# PRD 생성
/manage:prd create "feature-name" --template=api

# PRD 품질 검토
/support:prd-review "feature-name"

# 승인 및 SDLC 시작
/manage:prd approve "feature-name"
```

#### 품질 게이트
- [ ] PRD 완성도 점수 ≥ 80
- [ ] 모든 요구사항 명확하게 정의
- [ ] 성공 지표 명시
- [ ] 이해관계자 승인 획득

### 1단계: 계획 (Planning)

**소요 시간**: 1-2일  
**목적**: 무엇을 만들지 정의

#### 주요 활동
1. **요구사항 분석**
   - 기능 요구사항 수집
   - 비기능 요구사항 식별
   - 수락 기준 정의
   
2. **작업 분해 구조**
   - 기능을 작업으로 분해
   - 각 작업의 노력 추정
   - 종속성 식별
   
3. **리소스 할당**
   - 팀 구성원 할당
   - 시간 예산 할당
   - 마일스톤 계획

#### 에이전트 지원
- `project-knowledge-curator`: 요구사항 문서화
- `dev-estimator`: 시간 추정 제공
- `task-orchestrator`: 작업 분해 생성

#### 품질 게이트
- [ ] 모든 요구사항 문서화
- [ ] 추정치 검토 및 승인
- [ ] 리소스 할당 완료
- [ ] 위험 식별

#### 예시
```bash
# 계획 단계 시작
/sdlc "payment-integration" --phase=planning

# 시스템이 수행할 작업:
# 1. 요구사항 프롬프트
# 2. WBS 생성
# 3. 타임라인 추정
# 4. 계획 아티팩트 생성
```

### 2단계: 설계 (Design)

**소요 시간**: 2-3일  
**목적**: 어떻게 만들지 정의

#### 주요 활동
1. **아키텍처 설계**
   - 시스템 아키텍처 다이어그램
   - 컴포넌트 상호작용
   - 기술 스택 결정
   
2. **API 인터페이스 정의**
   - 엔드포인트 사양
   - 요청/응답 스키마
   - 인증 메커니즘
   
3. **데이터 모델링**
   - 데이터베이스 스키마 설계
   - 엔티티 관계
   - 데이터 흐름 다이어그램

#### 에이전트 지원
- `system-architect`: 아키텍처 생성
- `architecture-analyzer`: 설계 검토
- `focused-doc-generator`: API 문서화

#### 품질 게이트
- [ ] 아키텍처 검토 완료
- [ ] API 계약 정의
- [ ] 데이터 모델 승인
- [ ] 보안 고려사항 처리

#### 예시
```bash
# 설계 단계 실행
/sdlc "payment-integration" --phase=design

# 출력:
# - architecture.md
# - api-specification.yaml
# - database-schema.sql
# - design-decisions.md
```

### 3단계: 구현 (Implementation)

**소요 시간**: 3-5일  
**목적**: 솔루션 구축

#### 주요 활동
1. **코드 개발**
   - 기능 구현
   - 단위 테스트 생성
   - 코드 문서화
   
2. **증분 통합**
   - 컴포넌트 통합
   - API 구현
   - 데이터베이스 설정
   
3. **코드 리뷰 체크포인트**
   - 동료 리뷰
   - 아키텍처 준수
   - 표준 준수

#### 에이전트 지원
- `feature-implementer`: 기능 구현
- `code-enhancement-specialist`: 코드 최적화
- `code-quality-analyzer`: 표준 보장

#### 품질 게이트
- [ ] 코드 커버리지 >80%
- [ ] 치명적 린팅 오류 없음
- [ ] 모든 테스트 통과
- [ ] 코드 리뷰 완료

#### 예시
```bash
# 자동 에이전트 오케스트레이션으로 구현
/sdlc "payment-integration" --phase=implementation

# 시스템이 수행할 작업:
# 1. 보일러플레이트 코드 생성
# 2. 핵심 로직 구현
# 3. 단위 테스트 생성
# 4. 품질 검사 실행
```

### 4단계: 리뷰 (Review)

**소요 시간**: 1일  
**목적**: 품질 및 준수 보장

#### 주요 활동
1. **코드 리뷰**
   - 로직 검증
   - 성능 분석
   - 베스트 프랙티스 확인
   
2. **아키텍처 리뷰**
   - 설계 준수
   - 확장성 평가
   - 보안 감사
   
3. **문서 리뷰**
   - 완전성 확인
   - 정확성 검증
   - 명확성 평가

#### 에이전트 지원
- `code-quality-analyzer`: 코드 품질 분석
- `security-analyzer`: 보안 감사
- `performance-analyzer`: 성능 리뷰

#### 품질 게이트
- [ ] 모든 리뷰 완료
- [ ] 이슈 해결
- [ ] 승인 획득
- [ ] 메트릭 임계값 내

### 5단계: 테스트 (Testing)

**소요 시간**: 2-3일  
**목적**: 기능 검증

#### 주요 활동
1. **단위 테스트**
   - 컴포넌트 테스트
   - 엣지 케이스 커버리지
   - 모의 종속성
   
2. **통합 테스트**
   - API 테스트
   - 데이터베이스 작업
   - 외부 서비스
   
3. **성능 테스트**
   - 부하 테스트
   - 스트레스 테스트
   - 최적화

#### 에이전트 지원
- `test-execution-manager`: 테스트 스위트 실행
- `issue-diagnostician`: 실패 디버깅
- `performance-analyzer`: 메트릭 분석

#### 품질 게이트
- [ ] 모든 테스트 통과
- [ ] 커버리지 목표 달성
- [ ] 성능 벤치마크 달성
- [ ] 치명적 버그 없음

### 6단계: 배포 (Deployment)

**소요 시간**: 1일  
**목적**: 프로덕션 릴리스

#### 주요 활동
1. **배포 전략**
   - 블루-그린 배포
   - 카나리 릴리스
   - 기능 플래그
   
2. **롤백 계획**
   - 롤백 절차
   - 데이터 마이그레이션 되돌리기
   - 비상 계획
   
3. **모니터링 설정**
   - 헬스 체크
   - 알림 구성
   - 로그 집계

#### 에이전트 지원
- `build-packager`: 배포 준비
- `git-workflow-manager`: 릴리스 관리
- `issue-diagnostician`: 배포 모니터링

#### 품질 게이트
- [ ] 빌드 성공
- [ ] 배포 체크리스트 완료
- [ ] 롤백 테스트 완료
- [ ] 모니터링 활성화

### 7단계: 문서화 (Documentation)

**소요 시간**: 1일  
**목적**: 지식 관리 완료

#### 주요 활동
1. **API 문서화**
   - 엔드포인트 문서
   - 사용 예제
   - 인증 가이드
   
2. **사용자 가이드**
   - 기능 문서
   - 튜토리얼
   - FAQ
   
3. **기술 문서**
   - 아키텍처 업데이트
   - 배포 가이드
   - 유지보수 절차

#### 에이전트 지원
- `project-knowledge-curator`: 문서 조직화
- `focused-doc-generator`: 문서 생성
- `concept-explainer`: 튜토리얼 작성

#### 품질 게이트
- [ ] 모든 문서 완료
- [ ] 예제 제공
- [ ] 리뷰 완료
- [ ] 게시/접근 가능

## 템플릿 심화 가이드

### 표준 템플릿 (폭포수)

**적합한 경우**: 명확한 요구사항이 있는 잘 정의된 프로젝트

```yaml
name: standard
description: 전통적인 폭포수 접근법
total_duration: 10-12일
phases:
  - planning: 2일
  - design: 3일
  - implementation: 5일
  - review: 1일
  - testing: 2일
  - deployment: 1일
  - documentation: 1일
```

**특징**:
- 순차적 실행
- 포괄적 문서화
- 공식 리뷰 게이트
- 예측 가능한 타임라인

**사용 시기**:
- 명확하고 안정적인 요구사항
- 규제된 환경
- 대규모 팀 조정
- 중요 시스템

### 애자일 템플릿 (스프린트 기반)

**적합한 경우**: 변화하는 요구사항의 반복 개발

```yaml
name: agile
description: 스프린트 기반 반복 개발
sprint_duration: 2주
ceremonies:
  - daily_standup: 15분
  - sprint_planning: 2시간
  - sprint_review: 1시간
  - retrospective: 1시간
```

**특징**:
- 반복 주기
- 지속적 피드백
- 유연한 범위
- 정기 릴리스

**사용 시기**:
- 진화하는 요구사항
- 빠른 프로토타이핑
- 사용자 피드백 중심
- 지속적 배포

### 핫픽스 템플릿 (긴급)

**적합한 경우**: 중요한 프로덕션 이슈

```yaml
name: hotfix
description: 긴급 수정 프로세스
sla: 4시간
phases:
  - diagnosis: 30분
  - fix: 2시간
  - testing: 1시간
  - deployment: 30분
```

**특징**:
- 신속한 프로세스
- 최소 문서화
- 즉시 배포
- 사후 분석 필수

**사용 시기**:
- 프로덕션 장애
- 보안 취약점
- 데이터 손상
- 치명적 버그

## 품질 게이트 관리

### 품질 게이트 이해

품질 게이트는 각 단계가 진행 전 최소 표준을 충족하는지 확인하는 체크포인트입니다.

### 게이트 유형

#### 자동화 게이트
- 코드 커버리지 임계값
- 테스트 통과율
- 린팅 준수
- 빌드 성공

#### 수동 게이트
- 설계 승인
- 코드 리뷰 서명
- 배포 권한
- 문서 리뷰

### 게이트 구성

```json
{
  "phase": "implementation",
  "gates": {
    "automated": {
      "code_coverage": 80,
      "tests_passing": 100,
      "linting_errors": 0
    },
    "manual": {
      "code_review": "required",
      "approval_by": ["lead_developer"]
    }
  }
}
```

### 재정의 정책

때로는 게이트를 우회해야 할 때가 있습니다:

```bash
# 정당화와 함께 재정의
/sdlc "hotfix-123" --override-gate=testing --reason="긴급 수정, 프로덕션에서 테스트"
```

**재정의 요구사항**:
- 정당화 필요
- 승인 필요
- 감사를 위한 로깅
- 위험 수용

## 고급 기능

### 파이프라인 커스터마이징

#### 커스텀 단계 구성
```json
{
  "custom_phases": [
    {
      "name": "security_audit",
      "duration": "1일",
      "agents": ["security-analyzer"],
      "gates": {
        "vulnerabilities": 0,
        "compliance": "passed"
      }
    }
  ]
}
```

### 병렬 단계 실행

독립적인 단계를 동시에 실행:

```bash
# 테스트와 문서화를 병렬로 실행
/sdlc "feature" --parallel=testing,documentation
```

### 조건부 단계

조건에 따라 단계를 건너뛰거나 추가:

```json
{
  "conditional_phases": {
    "performance_testing": {
      "condition": "component == 'api'",
      "duration": "1일"
    }
  }
}
```

### 외부 도구 통합

#### CI/CD 통합
```yaml
deployment:
  external_tools:
    - github_actions:
        workflow: ".github/workflows/deploy.yml"
    - jenkins:
        job: "production-deploy"
```

#### 모니터링 통합
```yaml
monitoring:
  tools:
    - datadog:
        dashboard: "production-metrics"
    - sentry:
        project: "backend-api"
```

## 베스트 프랙티스

### 효과적인 파이프라인 설계

1. **단계 크기 적절화**
   - 간단한 기능을 과도하게 설계하지 않기
   - 프로젝트 복잡도에 맞게 단계 조정
   - 철저함과 속도의 균형

2. **반복 작업 자동화**
   - 보일러플레이트에 에이전트 사용
   - 테스트와 배포 자동화
   - 문서 자동 생성

3. **파이프라인 상태 유지**
   - 정기적인 템플릿 리뷰
   - 품질 게이트 업데이트
   - 시간 추정 개선

### 일반적인 안티패턴

#### 안티패턴 1: 단계 건너뛰기
**문제**: 시간 절약을 위해 단계 우회  
**영향**: 기술 부채, 품질 문제  
**해결책**: 적절한 템플릿 사용 (긴급 시 핫픽스)

#### 안티패턴 2: 과도한 문서화
**문제**: 과도한 문서화 요구사항  
**영향**: 속도 저하, 팀 좌절감  
**해결책**: 중요한 것만 문서화, 생성 자동화

#### 안티패턴 3: 경직된 게이트
**문제**: 융통성 없는 품질 게이트  
**영향**: 진행 차단, 컨텍스트 무시  
**해결책**: 컨텍스트 인식 게이트, 재정의 정책

### 성능 최적화

1. **파이프라인 성능**
   - 종속성 캐싱
   - 가능한 경우 병렬화
   - 에이전트 선택 최적화

2. **리소스 최적화**
   - 적절한 에이전트 사용
   - 유사 작업 배치
   - 아티팩트 재사용

### 팀 협업

1. **커뮤니케이션**
   - 일일 상태 업데이트
   - 단계 전환 알림
   - 차단 사항 에스컬레이션

2. **지식 공유**
   - 결정 사항 문서화
   - 학습 내용 공유
   - 템플릿 업데이트

## 트러블슈팅

### 일반적인 문제

#### 문제: 파이프라인이 게이트에서 멈춤
**증상**: 완료에도 불구하고 단계가 진행되지 않음  
**진단**: `--status`로 게이트 기준 확인  
**해결책**: 
```bash
# 상세 게이트 상태 확인
/sdlc "feature" --gate-status

# 필요시 재정의
/sdlc "feature" --override-gate=review --reason="오프라인 승인됨"
```

#### 문제: 에이전트 실패
**증상**: 에이전트 작업이 반복적으로 실패  
**진단**: 에이전트 로그 확인  
**해결책**:
```bash
# 다른 에이전트로 재시도
/sdlc "feature" --retry-phase=implementation --agent=feature-implementer

# 수동 완료
/sdlc "feature" --complete-phase=implementation --manual
```

#### 문제: 상태 손상
**증상**: 일관성 없는 파이프라인 상태  
**진단**: 상태 파일 확인  
**해결책**:
```bash
# 마지막 알려진 양호한 상태로 재설정
/manage:sdlc-pipeline reset "feature" --to-phase=design

# 히스토리에서 재구축
/manage:sdlc-pipeline rebuild "feature"
```

### 파이프라인 디버깅

```bash
# 디버그 모드 활성화
/sdlc "feature" --debug

# 상세 로그 보기
/support:sdlc-report "feature" --verbose

# 상태 검사
cat .claude/sdlc/pipelines/feature/state.json
```

### 상태 복구

1. **상태 백업**
   ```bash
   cp -r .claude/sdlc/pipelines .claude/sdlc/pipelines.backup
   ```

2. **히스토리에서 복원**
   ```bash
   /manage:sdlc-pipeline restore "feature" --from-history
   ```

3. **수동 상태 편집** (고급)
   ```bash
   # 주의해서 편집
   vi .claude/sdlc/pipelines/feature/state.json
   ```

## 사례 연구

### 사례 1: 전자상거래 결제 기능

**프로젝트**: 온라인 스토어 결제 통합  
**템플릿**: 표준  
**소요 시간**: 11일  

**실행된 단계**:
1. 계획 (2일): 5개 결제 방법 요구사항 수집
2. 설계 (3일): API 사양, 보안 아키텍처 생성
3. 구현 (4일): 결제 게이트웨이 통합 구축
4. 리뷰 (0.5일): 보안 및 코드 리뷰
5. 테스트 (1일): 통합 및 보안 테스트
6. 배포 (0.5일): 기능 플래그로 단계적 출시
7. 문서화 (1일): API 문서 및 통합 가이드

**결과**:
- 프로덕션 이슈 제로
- 100% 테스트 커버리지
- 완전한 문서화
- 이전 수동 프로세스보다 30% 빠름

**배운 교훈**:
- 자동화된 테스트로 2일 절약
- 조기 보안 리뷰로 취약점 방지
- 문서화 단계에서 통합 갭 발견

### 사례 2: 긴급 데이터베이스 수정

**프로젝트**: 프로덕션 데이터베이스 교착상태 수정  
**템플릿**: 핫픽스  
**소요 시간**: 3.5시간  

**실행된 단계**:
1. 진단 (45분): 교착상태 패턴 식별
2. 수정 (1.5시간): 쿼리 최적화 구현
3. 테스트 (45분): 스테이징에서 수정 확인
4. 배포 (30분): 프로덕션 적용

**결과**:
- SLA 내 문제 해결
- 데이터 손실 없음
- 최소 다운타임
- 사후 분석 완료

**배운 교훈**:
- 긴급 상황에 핫픽스 템플릿 필수
- 자동 롤백으로 복구 시간 절약
- 사후 분석으로 재발 방지

### 사례 3: 모바일 앱 MVP

**프로젝트**: 모바일 앱 최소 실행 가능 제품  
**템플릿**: 애자일  
**소요 시간**: 3 스프린트 (6주)  

**스프린트 1**: 사용자 인증 및 프로필
**스프린트 2**: 핵심 기능 구현
**스프린트 3**: 마무리 및 배포

**결과**:
- 일정 내 배포
- 사용자 피드백 통합
- 반복적 개선
- 원활한 프로덕션 출시

**배운 교훈**:
- MVP에 완벽한 애자일 템플릿
- 사용자 피드백의 가치
- 지속적 배포로 위험 감소

## 레퍼런스

### 전체 명령어 레퍼런스

#### 주요 명령어

| 명령어 | 설명 | 옵션 |
|--------|------|------|
| `/sdlc` | 메인 파이프라인 명령어 | `--init`, `--status`, `--continue`, `--full` |
| `/analyze:sdlc-readiness` | 준비 상태 확인 | `--verbose`, `--fix` |
| `/implement:sdlc-phase` | 특정 단계 실행 | `--phase=<name>`, `--force` |
| `/manage:sdlc-pipeline` | 파이프라인 관리 | `reset`, `rebuild`, `archive` |
| `/support:sdlc-report` | 보고서 생성 | `--format=<type>`, `--verbose` |

#### 명령어 옵션

**`/sdlc` 옵션**:
- `--init`: 새 파이프라인 초기화
- `--from-prd`: 승인된 PRD에서 초기화
- `--template=<type>`: 템플릿 지정 (standard/agile/hotfix)
- `--phase=<name>`: 특정 단계 실행
- `--continue`: 현재 단계에서 계속
- `--full`: 남은 모든 단계 실행
- `--status`: 현재 상태 표시
- `--parallel=<phases>`: 단계 병렬 실행
- `--override-gate=<gate>`: 품질 게이트 재정의
- `--reason=<text>`: 재정의 정당화
- `--debug`: 디버그 모드 활성화

### 구성 옵션

#### 파이프라인 구성
```json
{
  "pipeline": {
    "name": "feature-name",
    "template": "standard",
    "auto_proceed": false,
    "notifications": true,
    "parallel_execution": false
  }
}
```

#### 단계 구성
```json
{
  "phase": {
    "name": "implementation",
    "duration": "3일",
    "required": true,
    "agents": ["feature-implementer"],
    "gates": {
      "automated": {...},
      "manual": {...}
    }
  }
}
```

### API 레퍼런스

#### 상태 관리 API
```javascript
// 파이프라인 상태 가져오기
GET .claude/sdlc/pipelines/{name}/state.json

// 단계 상태 업데이트
POST .claude/sdlc/pipelines/{name}/phases/{phase}/complete

// 게이트 재정의
POST .claude/sdlc/pipelines/{name}/gates/{gate}/override
```

#### 보고 API
```javascript
// 보고서 생성
GET .claude/sdlc/reports/{name}

// 메트릭 가져오기
GET .claude/sdlc/metrics/{name}

// 히스토리 내보내기
GET .claude/sdlc/history/export
```

### 용어집

| 용어 | 정의 |
|------|------|
| **파이프라인** | 완전한 개발 워크플로우 인스턴스 |
| **단계** | 개발 생명주기의 구별된 스테이지 |
| **게이트** | 단계 간 품질 체크포인트 |
| **템플릿** | 사전 정의된 파이프라인 구성 |
| **에이전트** | 특정 작업에 특화된 AI 어시스턴트 |
| **아티팩트** | 단계에서 생성된 출력 |
| **SLA** | 완료를 위한 서비스 수준 계약 |
| **WBS** | 작업 분해 구조 |
| **재정의** | 정당화와 함께 품질 게이트 우회 |
| **상태** | 파이프라인의 현재 상태와 데이터 |

## 결론

SDLC 파이프라인 시스템은 소프트웨어 개발을 임시방편적인 프로세스에서 구조화되고, 반복 가능하며, 측정 가능한 워크플로우로 변환합니다. 지능적 자동화, 품질 게이트, 포괄적 추적을 활용하여 팀은 더 높은 품질의 소프트웨어를 더 빠르고 자신감 있게 제공할 수 있습니다.

### 핵심 요점

1. **구조가 속도를 가능하게 함**: 잘 정의된 프로세스가 배포를 가속화
2. **품질 게이트가 부채를 방지**: 조기 발견이 시간 절약
3. **자동화가 오류를 줄임**: AI 에이전트가 루틴 작업 처리
4. **가시성이 성공을 주도**: 실시간 추적이 의사결정 개선
5. **유연성이 민첩성 유지**: 템플릿이 필요에 적응

### 시작하기

1. `/analyze:sdlc-readiness`로 프로젝트 확인
2. 시작 지점 선택:
   - **PRD 우선** (권장): `/manage:prd create "your-feature"`
   - **직접 SDLC**: `/sdlc "your-feature" --init`
3. 각 단계를 통한 가이드 프로세스 따르기
4. 진행 상황 추적을 위한 보고서 생성
5. 템플릿 반복 및 개선

### 추가 리소스

- [PRD 가이드](PRD_GUIDE.ko.md) - 제품 요구사항 문서 가이드
- [아키텍처 가이드](../architecture/ARCHITECTURE.ko.md#sdlc-파이프라인-시스템-아키텍처)
- [빠른 시작 가이드](QUICKSTART.ko.md#sdlc-파이프라인-사용)
- [API 문서](../architecture/API.ko.md#sdlc-cli-옵션)
- [에이전트 문서](../api/agents.md#sdlc-coordinator)

---

*개발 프로세스를 변환할 준비가 되셨나요? 오늘 첫 SDLC 파이프라인을 시작하세요!*

## 🌏 언어

이 문서는 다음 언어로도 제공됩니다:
- [English](SDLC_GUIDE.md)