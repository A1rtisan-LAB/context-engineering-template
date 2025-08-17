---
title: AI 에이전트 API 참조
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: api
tags: [agents, api, reference, documentation]
language: ko
---

# AI 에이전트 API 참조

## 개요

Context Engineering Template에는 다양한 개발 작업을 지원하도록 설계된 26개의 전문 AI 에이전트가 포함되어 있습니다. 각 에이전트는 특정 기능, 도구 및 전문 영역을 가지고 있습니다.

## 목차

- [분석 에이전트](#분석-에이전트)
- [구현 에이전트](#구현-에이전트)
- [관리 에이전트](#관리-에이전트)
- [지원 에이전트](#지원-에이전트)
- [PRD 및 문서화 에이전트](#prd-및-문서화-에이전트)

## 분석 에이전트

### architecture-analyzer
소프트웨어 아키텍처, 디자인 패턴 및 시스템 구조를 분석합니다.

**도구**: Read, Glob, Grep, TodoWrite, Bash, BashOutput  
**사용 사례**: 아키텍처 리뷰, 시스템 설계 평가, 기술 부채 분석

### security-analyzer
보안 취약점을 식별하고 보안 권장 사항을 제공합니다.

**도구**: Read, Glob, Grep, TodoWrite, Bash  
**사용 사례**: 보안 감사, 취약점 스캔, 규정 준수 확인

### performance-analyzer
성능 병목 현상과 최적화 기회를 분석합니다.

**도구**: Read, Glob, Grep, TodoWrite, Bash, BashOutput, KillBash  
**사용 사례**: 성능 프로파일링, 병목 현상 식별, 확장성 분석

### code-quality-analyzer
코드 품질 메트릭과 표준 준수를 평가합니다.

**도구**: Read, Glob, Grep, TodoWrite, Bash, BashOutput  
**사용 사례**: 코드 리뷰, 품질 평가, 표준 준수

### project-context-analyzer
프로젝트 구조, 의존성, 설정 파일을 이해합니다.

**도구**: Read, Glob, Grep, TodoWrite, Bash  
**사용 사례**: 프로젝트 설정, 환경 구성, 의존성 분석

### claude-code-structure-auditor
Claude Code 프로젝트 구조를 공식 모범 사례와 비교하여 평가합니다.

**도구**: Read, Glob, Grep, TodoWrite, Bash  
**사용 사례**: Claude Code 프로젝트 감사, 구조 검증, 모범 사례 확인

## 구현 에이전트

### feature-implementer
지능형 전문가 페르소나 활성화로 새로운 기능을 구현합니다.

**도구**: Read, Write, Edit, MultiEdit, Glob, Grep, TodoWrite, Bash, Task  
**사용 사례**: 기능 개발, 컴포넌트 생성, API 구현

### code-enhancement-specialist
기존 코드를 체계적으로 개선하여 성능과 유지보수성을 향상시킵니다.

**도구**: Read, Glob, Grep, TodoWrite, Edit, MultiEdit  
**사용 사례**: 코드 리팩토링, 최적화, 현대화

### code-cleanup-optimizer
죽은 코드를 제거하고 구조를 최적화하여 코드베이스를 정리합니다.

**도구**: Read, Write, Edit, MultiEdit, Glob, Grep, TodoWrite, Bash  
**사용 사례**: 죽은 코드 제거, 임포트 최적화, 프로젝트 구조 정리

### task-orchestrator
복잡한 다단계 작업을 조정합니다.

**도구**: Read, Write, Edit, TodoWrite, Task, Bash  
**사용 사례**: 작업 분해, 병렬 실행, 의존성 관리

### workflow-orchestrator
워크플로우 관리로 복잡한 다단계 작업을 실행합니다.

**도구**: Read, Write, Edit, TodoWrite, Task, Bash, Glob, Grep  
**사용 사례**: 복잡한 워크플로우, 세션 간 지속성, 작업 구성

### prd-workflow-generator
PRD를 상세한 구현 워크플로우로 변환합니다.

**도구**: Read, Write, Edit, TodoWrite, Task  
**사용 사례**: PRD 분석, 작업 생성, 워크플로우 설계

### sdlc-coordinator
SDLC 파이프라인 단계와 품질 게이트를 조정합니다.

**도구**: Read, Write, Edit, TodoWrite, Task, Bash, Glob  
**사용 사례**: 파이프라인 오케스트레이션, 단계 관리, 품질 게이트 시행

### build-packager
다양한 언어의 소프트웨어 프로젝트를 빌드하고 패키징합니다.

**도구**: Bash, Read, Write, Edit, Glob, Grep, TodoWrite  
**사용 사례**: 빌드 자동화, 패키징, CI/CD 설정

## 관리 에이전트

### git-workflow-manager
지능형 자동화로 Git 작업을 관리합니다.

**도구**: Bash, Read, Write, Edit, Glob, Grep, TodoWrite  
**사용 사례**: 커밋 관리, 브랜치 전략, 워크플로우 자동화

### doc-manager
고품질 동기화된 이중 언어 문서를 유지합니다.

**도구**: Read, Write, Edit, MultiEdit, Glob, Grep, TodoWrite  
**사용 사례**: 문서 검증, 번역 동기화, SDLC 통합

### project-knowledge-curator
포괄적인 프로젝트 문서와 지식 베이스를 생성합니다.

**도구**: Read, Write, Edit, Glob, Grep, TodoWrite  
**사용 사례**: 지식 베이스 생성, 문서 구성, 온보딩 자료

### test-execution-manager
테스트 스위트를 실행하고 포괄적인 테스트 보고서를 생성합니다.

**도구**: Bash, Read, Write, Edit, Glob, Grep, TodoWrite  
**사용 사례**: 테스트 실행, 커버리지 분석, 보고서 생성

### dev-estimator
작업, 기능 또는 프로젝트에 대한 개발 시간 추정을 제공합니다.

**도구**: Read, Glob, Grep, TodoWrite  
**사용 사례**: 스프린트 계획, 작업 추정, 타임라인 예측

## 지원 에이전트

### issue-diagnostician
버그, 빌드 실패, 성능 문제를 체계적으로 조사합니다.

**도구**: Read, Glob, Grep, TodoWrite, Bash, BashOutput  
**사용 사례**: 버그 진단, 근본 원인 분석, 문제 해결

### concept-explainer
코드 기능과 프로그래밍 개념에 대한 명확한 설명을 제공합니다.

**도구**: Read, Glob, Grep  
**사용 사례**: 코드 설명, 튜토리얼 생성, 개념 문서화

### agent-prompt-reviewer
Claude Code 하위 에이전트 프롬프트를 평가하고 점수를 매깁니다.

**도구**: Read, Glob, Grep, TodoWrite  
**사용 사례**: 에이전트 품질 평가, 프롬프트 개선, 모범 사례 확인

### focused-doc-generator
특정 코드 컴포넌트에 대한 정확하고 대상화된 문서를 생성합니다.

**도구**: Read, Write, Edit, Glob, Grep  
**사용 사례**: API 문서, 컴포넌트 문서, 기능 가이드

## PRD 및 문서화 에이전트

이러한 에이전트는 위의 카테고리에도 포함되지만 PRD 시스템과의 특별한 통합을 가지고 있습니다:

- **prd-workflow-generator**: PRD를 실행 가능한 워크플로우로 변환
- **doc-manager**: 문서 품질과 동기화 유지
- **project-knowledge-curator**: 포괄적인 프로젝트 문서 생성
- **focused-doc-generator**: 특정 기능에 대한 대상화된 문서 생성

## 에이전트 사용 예제

### 단일 에이전트 사용
```bash
# 보안 분석 실행
/orchestrate security-analyzer "src/"

# 새 기능 구현
/orchestrate feature-implementer "user-authentication"

# 코드 품질 분석
/orchestrate code-quality-analyzer "."
```

### 다중 에이전트 오케스트레이션
```bash
# 병렬로 여러 분석 실행
/orchestrate parallel-analysis "project" \
  --agents="security-analyzer,performance-analyzer,architecture-analyzer"
```

### 워크플로우의 에이전트
```yaml
workflow: development-lifecycle
phases:
  - planning:
      agents: [project-knowledge-curator, dev-estimator]
  - design:
      agents: [architecture-analyzer]
  - implementation:
      agents: [feature-implementer, code-enhancement-specialist]
  - testing:
      agents: [test-execution-manager]
```

## 에이전트 기능 매트릭스

| 에이전트 | 읽기 | 쓰기 | 실행 | 작업 관리 | 오케스트레이션 |
|---------|------|------|------|-----------|---------------|
| 분석 에이전트 | ✅ | ❌ | ✅ | ✅ | ❌ |
| 구현 에이전트 | ✅ | ✅ | ✅ | ✅ | ✅ |
| 관리 에이전트 | ✅ | ✅ | ✅ | ✅ | ✅ |
| 지원 에이전트 | ✅ | ✅ | ✅ | ✅ | ❌ |

## 모범 사례

1. **올바른 에이전트 선택**: 작업에 가장 전문화된 에이전트 사용
2. **병렬 실행**: 독립적인 작업에 여러 에이전트 사용
3. **에이전트 체이닝**: 복잡한 워크플로우를 위해 에이전트를 순차적으로 연결
4. **리소스 관리**: 에이전트 리소스 사용량 모니터링
5. **에이전트 결합**: 복잡한 작업에 여러 에이전트 사용

## 참조

### 관련 API 문서
- **[Commands API](commands.ko.md)** - 명령 참조 및 사용법
- **[Workflows API](workflows.ko.md)** - 워크플로우 오케스트레이션 패턴
- **[API Index](index.ko.md)** - 전체 API 참조

### 가이드 및 튜토리얼
- **[에이전트 오케스트레이션 튜토리얼](../tutorials/agent-orchestration.ko.md)** - 에이전트 조정 모범 사례
- **[SDLC 파이프라인 가이드](../guides/SDLC_GUIDE.ko.md#agent-support)** - 파이프라인에서 에이전트 사용
- **[아키텍처 개요](../architecture/ARCHITECTURE.ko.md#ai-agent-system)** - 시스템 설계

### 명령 통합
- **[analyze 명령](commands.ko.md#analysis-commands)** - 분석 에이전트 명령
- **[implement 명령](commands.ko.md#implementation-commands)** - 구현 에이전트 명령
- **[manage 명령](commands.ko.md#management-commands)** - 관리 에이전트 명령
- **[support 명령](commands.ko.md#support-commands)** - 지원 에이전트 명령

### 워크플로우 통합
- **[development-lifecycle](workflows.ko.md#development-lifecycle)** - 개발 워크플로우의 에이전트
- **[quality-assurance](workflows.ko.md#quality-assurance)** - QA 워크플로우의 에이전트
- **[issue-resolution](workflows.ko.md#issue-resolution)** - 긴급 대응의 에이전트

### 외부 리소스
- [Claude Code 문서](https://docs.anthropic.com/claude-code)
- [패키지 문서](../../packages/@claude-code/agents/)