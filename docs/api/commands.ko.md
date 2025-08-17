---
title: Commands API 참조
author: Claude Code Team  
date: 2025-08-17
version: 1.0.0
category: api
tags: [commands, api, reference, documentation]
language: ko
---

# Commands API 참조

## 개요

Context Engineering Template에는 다양한 개발 작업을 위한 26개의 전문 명령이 포함되어 있습니다. 명령은 analyze, implement, manage, support의 네 가지 카테고리로 구성됩니다.

## 목차

- [분석 명령](#분석-명령)
- [구현 명령](#구현-명령)
- [관리 명령](#관리-명령)
- [지원 명령](#지원-명령)
- [명령 사용법](#명령-사용법)
- [명령 사용자 정의](#명령-사용자-정의)

## 분석 명령

### /analyze:code-quality
가독성, 유지보수성, 표준 준수를 포함한 코드 품질 메트릭을 분석합니다.

**구문**: `/analyze:code-quality [path]`  
**매개변수**: 
- `path` - 분석할 디렉토리 또는 파일 (기본값: 현재 디렉토리)

**예제**:
```bash
/analyze:code-quality src/
```

### /analyze:performance
성능 병목 현상과 최적화 기회를 식별합니다.

**구문**: `/analyze:performance [path]`  
**매개변수**:
- `path` - 분석할 코드 경로

**예제**:
```bash
/analyze:performance src/api/handlers
```

### /analyze:project-context
포괄적인 프로젝트 개요와 컨텍스트 분석을 제공합니다.

**구문**: `/analyze:project-context [path]`  
**매개변수**:
- `path` - 프로젝트 루트 디렉토리

**예제**:
```bash
/analyze:project-context .
```

### /analyze:sdlc-readiness
프로젝트가 SDLC 파이프라인 통합 준비가 되었는지 확인합니다.

**구문**: `/analyze:sdlc-readiness`  
**옵션**:
- `--verbose` - 상세 출력
- `--fix` - 문제 자동 수정

**예제**:
```bash
/analyze:sdlc-readiness --verbose
```

### /analyze:security
보안 취약점 분석을 수행합니다.

**구문**: `/analyze:security [path]`  
**매개변수**:
- `path` - 분석할 코드 경로

**예제**:
```bash
/analyze:security src/auth
```

## 구현 명령

### /implement:enhancement
기존 코드에 개선 사항을 구현합니다.

**구문**: `/implement:enhancement [component] [description]`  
**매개변수**:
- `component` - 개선할 컴포넌트
- `description` - 개선 사항 세부정보

**예제**:
```bash
/implement:enhancement auth-module "속도 제한 추가"
```

### /implement:feature
지능형 에이전트 지원으로 새로운 기능을 구현합니다.

**구문**: `/implement:feature [feature-name]`  
**매개변수**:
- `feature-name` - 구현할 기능 이름

**예제**:
```bash
/implement:feature user-authentication
```

### /implement:fix
코드베이스의 버그와 문제를 수정합니다.

**구문**: `/implement:fix [issue-description]`  
**매개변수**:
- `issue-description` - 문제 설명

**예제**:
```bash
/implement:fix "로그인 리다이렉트 루프"
```

### /implement:refactor
더 나은 구조와 유지보수성을 위해 코드를 리팩토링합니다.

**구문**: `/implement:refactor [component]`  
**매개변수**:
- `component` - 리팩토링할 컴포넌트

**예제**:
```bash
/implement:refactor database-layer
```

### /implement:sdlc-phase
특정 SDLC 파이프라인 단계를 실행합니다.

**구문**: `/implement:sdlc-phase [feature] --phase=[phase-name]`  
**매개변수**:
- `feature` - 기능 이름
- `phase-name` - 실행할 단계 (planning, design, implementation 등)

**예제**:
```bash
/implement:sdlc-phase payment-integration --phase=design
```

## 관리 명령

### /manage:docs
검증과 동기화로 프로젝트 문서를 관리합니다.

**구문**: `/manage:docs [action]`  
**작업**:
- `validate` - 문서 상태 확인
- `sync` - 번역 동기화
- `update` - 오래된 문서 업데이트

**예제**:
```bash
/manage:docs validate
```

### /manage:git
지능형 커밋 메시지로 Git 워크플로우를 관리합니다.

**구문**: `/manage:git [action]`  
**작업**:
- `commit` - 지능형 커밋 생성
- `pr` - 풀 리퀘스트 생성
- `branch` - 브랜치 관리

**예제**:
```bash
/manage:git commit
```

### /manage:prd
제품 요구사항 문서를 관리합니다.

**구문**: `/manage:prd [action] [prd-name] [options]`  
**작업**:
- `create` - 새 PRD 생성
- `status` - PRD 상태 확인
- `approve` - PRD 승인
- `list` - PRD 목록
- `move` - PRD 상태 변경
- `archive` - 완료된 PRD 보관

**옵션**:
- `--template=[type]` - 템플릿 유형 (standard, api, frontend, fullstack)
- `--to=[state]` - 이동할 대상 상태
- `--all` - 모든 PRD 나열

**예제**:
```bash
/manage:prd create "user-auth" --template=api
/manage:prd approve "user-auth"
/manage:prd list --all
```

### /manage:sdlc-pipeline
SDLC 파이프라인 인스턴스를 관리합니다.

**구문**: `/manage:sdlc-pipeline [action] [pipeline-name]`  
**작업**:
- `reset` - 파이프라인 상태 재설정
- `rebuild` - 히스토리에서 재구축
- `archive` - 완료된 파이프라인 보관
- `restore` - 백업에서 복원

**예제**:
```bash
/manage:sdlc-pipeline reset "feature-x" --to-phase=design
```

### /manage:test
테스트 실행 및 관리.

**구문**: `/manage:test [scope]`  
**범위**:
- `all` - 모든 테스트 실행
- `unit` - 단위 테스트 실행
- `integration` - 통합 테스트 실행
- `e2e` - E2E 테스트 실행

**예제**:
```bash
/manage:test all
```

## 지원 명령

### /support:agent-review
에이전트 프롬프트 품질을 검토하고 점수를 매깁니다.

**구문**: `/support:agent-review [agent-name]`  
**매개변수**:
- `agent-name` - 검토할 에이전트 이름

**예제**:
```bash
/support:agent-review feature-implementer
```

### /support:claude-structure-audit
Claude Code 프로젝트 구조를 모범 사례와 비교하여 감사합니다.

**구문**: `/support:claude-structure-audit`  
**옵션**:
- `--fix` - 문제 자동 수정
- `--verbose` - 상세 출력

**예제**:
```bash
/support:claude-structure-audit --fix
```

### /support:concept-explain
코드 개념과 기능을 설명합니다.

**구문**: `/support:concept-explain [concept]`  
**매개변수**:
- `concept` - 설명할 개념 또는 코드

**예제**:
```bash
/support:concept-explain "async/await 패턴"
```

### /support:issue-diagnose
문제를 진단하고 해결합니다.

**구문**: `/support:issue-diagnose [error-description]`  
**매개변수**:
- `error-description` - 문제 설명

**예제**:
```bash
/support:issue-diagnose "TypeScript 빌드 오류 TS2304"
```

### /support:prd-review
PRD 품질과 완성도를 검토합니다.

**구문**: `/support:prd-review [prd-name] [options]`  
**매개변수**:
- `prd-name` - 검토할 PRD 이름

**옵션**:
- `--quick` - 빠른 검증만
- `--auto-fix` - 서식 문제 수정

**예제**:
```bash
/support:prd-review "user-auth" --auto-fix
```

### /support:sdlc-report
SDLC 파이프라인 보고서를 생성합니다.

**구문**: `/support:sdlc-report [pipeline-name] [options]`  
**매개변수**:
- `pipeline-name` - 보고할 파이프라인

**옵션**:
- `--format=[type]` - 출력 형식 (markdown, json, html)
- `--verbose` - 상세 보고서

**예제**:
```bash
/support:sdlc-report "feature-x" --format=markdown
```

## 명령 사용법

### 명령 구조
모든 명령은 일관된 구조를 따릅니다:
```
/category:action [required-params] [--optional-flags]
```

### 명령 카테고리
- **analyze**: 분석 및 검사 명령
- **implement**: 코드 구현 및 수정
- **manage**: 프로젝트 및 워크플로우 관리
- **support**: 도움말 및 지원 유틸리티

### 명령 탐색
프로젝트에서 사용 가능한 명령을 확인하려면:
```bash
ls .claude/commands/
```

### 명령 도움말
대부분의 명령은 도움말 플래그를 지원합니다:
```bash
/command --help
```

## 명령 사용자 정의

### 사용자 정의 명령 생성
1. `.claude/commands/`에 새 마크다운 파일 생성
2. 명령 구조와 동작 정의
3. 필요한 도구와 에이전트 지정
4. 명령 테스트

### 명령 템플릿
```markdown
# Command: /category:action

## 설명
명령이 수행하는 작업에 대한 간단한 설명.

## 사용법
/category:action [parameters] [options]

## 매개변수
- parameter1: 설명
- parameter2: 설명

## 옵션
- --option1: 설명
- --option2: 설명

## 예제
/category:action example-param --option1

## 구현
AI 에이전트를 위한 상세한 구현 지침.
```

### 명령 모범 사례
1. **명명**: 설명적이고 행동 지향적인 이름 사용
2. **카테고리**: 적절한 카테고리에 배치
3. **문서화**: 명확한 사용 예제 포함
4. **오류 처리**: 오류 케이스 정의
5. **검증**: 매개변수 검증 포함

## 고급 기능

### 명령 구성
복잡한 작업을 위해 명령을 구성할 수 있습니다:
```bash
/analyze:project-context . && /implement:feature authentication
```

### 명령 별칭
자주 사용하는 명령에 대한 별칭 생성:
```bash
# .claude/settings.json에서
{
  "aliases": {
    "quick-fix": "/implement:fix",
    "full-analysis": "/orchestrate complete-analysis"
  }
}
```

### 명령 파이프라인
자동화된 워크플로우를 위한 명령 체이닝:
```bash
/manage:prd create "feature" --template=api && \
/manage:prd approve "feature" && \
/sdlc "feature" --full
```

## API 통합

### 프로그래밍 방식 명령 실행
명령을 프로그래밍 방식으로 실행할 수 있습니다:
```javascript
// 예제: API를 통한 명령 실행
const result = await claude.executeCommand('/analyze:code-quality', {
  path: 'src/',
  options: { verbose: true }
});
```

### 명령 이벤트
명령은 모니터링 가능한 이벤트를 발생시킵니다:
- `command:start` - 명령 실행 시작
- `command:progress` - 진행 상황 업데이트
- `command:complete` - 명령 완료
- `command:error` - 명령 실패

## 오류 처리

### 일반적인 오류 코드
| 코드 | 설명 | 해결 방법 |
|------|------|----------|
| CMD001 | 명령을 찾을 수 없음 | 명령 이름과 철자 확인 |
| CMD002 | 필수 매개변수 누락 | 모든 필수 매개변수 제공 |
| CMD003 | 잘못된 매개변수 형식 | 매개변수 구문 확인 |
| CMD004 | 권한 거부 | 파일 권한 확인 |
| CMD005 | 에이전트 사용 불가 | 에이전트 구성 확인 |

### 명령 디버깅
상세 출력을 위한 디버그 모드 활성화:
```bash
CLAUDE_DEBUG=true /command:action
```

## 성능 고려사항

### 명령 최적화
- 와일드카드 대신 특정 경로 사용
- 가능한 경우 배치 작업
- 반복 작업에 대한 결과 캐싱
- 적절한 분석 깊이 사용

### 리소스 사용량
명령은 다음을 위해 최적화됩니다:
- 메모리 효율성
- 빠른 실행
- 최소 디스크 I/O
- 해당되는 경우 병렬 처리

## 참조

- [AI Agents API](agents.ko.md) - 에이전트 기능 및 사용법
- [Workflows API](workflows.ko.md) - 워크플로우 오케스트레이션
- [SDLC 가이드](../guides/SDLC_GUIDE.ko.md) - SDLC 파이프라인 문서
- [PRD 가이드](../guides/PRD_GUIDE.ko.md) - PRD 시스템 문서