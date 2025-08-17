---
title: 변경 이력
author: Claude Code Team
date: 2025-08-17
version: 3.3.0
category: documentation
tags: [changelog, releases, versions, updates]
language: ko
---

# 변경 이력

이 프로젝트의 모든 주요 변경사항이 이 파일에 문서화됩니다.

형식은 [Keep a Changelog](https://keepachangelog.com/ko/1.0.0/)를 기반으로 하며,
이 프로젝트는 [시맨틱 버저닝](https://semver.org/lang/ko/)을 준수합니다.

## [3.3.0] - 2025-08-17

### 추가됨
- **포괄적인 문서 시스템**
  - 26개 에이전트, 26개 명령, 4개 워크플로우에 대한 API 참조 문서
  - 4개의 상세 튜토리얼 (getting-started, prd-development, sdlc-pipeline-usage, agent-orchestration)
  - 모든 API 문서 및 튜토리얼의 완전한 한국어 번역
  - 기능 매트릭스와 성능 벤치마크를 포함한 API 인덱스
  - 문서 전반에 걸친 대화형 예제와 코드 스니펫

### 변경됨
- **문서 구조 개선**
  - index, agents, commands, workflows 문서가 포함된 체계적인 `docs/api/` 디렉토리 생성
  - 실습 학습 가이드가 포함된 `docs/tutorials/` 디렉토리 생성
  - 새 문서에 대한 완전한 탐색 기능으로 `docs/README.ko.md` 업데이트
  - 포괄적인 문서 섹션으로 루트 README.md 개선
  - 24개 이상의 문서 파일에 메타데이터 헤더 추가

### 수정됨
- 모든 문서의 메타데이터 날짜를 2025-01-17에서 2025-08-17로 수정
- 문서의 깨진 링크 수정 (`.claude/agents/` → `../api/agents.md`)
- 모든 참조에서 에이전트 수를 25개에서 26개로 업데이트
- 한국어와 영어 문서 버전 동기화

## [3.2.1] - 2025-08-16

### 추가됨
- basic 스타터의 한국어 README (README.ko.md)

### 변경됨
- 일관성을 위해 basic/README.template.md를 basic/README.md로 이름 변경
- 모든 스타터 템플릿에서 파일 명명 규칙 표준화

### 수정됨
- CHANGELOG.md의 날짜 수정 (1월 → 8월 2025)
- MIGRATION.md 및 MIGRATION.ko.md의 날짜 수정
- 스타터 템플릿(api, frontend, fullstack)의 한국어 문서 동기화

## [3.2.0] - 2025-08-16

### 추가됨
- **포괄적인 SDLC 스타터 통합**
  - 모든 스타터 템플릿(basic, api, frontend, fullstack)에 SDLC 가이드 배포
  - 모든 스타터 문서의 한국어 버전
  - INITIAL_EXAMPLE.ko.md - 한국어 SDLC 파이프라인 예제
  - INITIAL.ko.md - 한국어 프로젝트 사양
  - 모든 스타터 타입용 README.ko.md
  - `--with-sdlc` 옵션으로 SDLC 가이드 배포 CLI 지원

### 변경됨
- **스타터 템플릿 현대화**
  - INITIAL_EXAMPLE.md를 SDLC 파이프라인 예제(이커머스 체크아웃)로 교체
  - 모든 스타터 파일을 올바른 숫자로 업데이트 (23+ 에이전트, 23+ 명령어)
  - 과도한 "V2 Context Engineering" 참조 제거
  - 모든 README 파일에 SDLC 파이프라인 섹션 추가
  - CLAUDE.md에 이중 언어 문서 요구사항 추가
  - 모든 스타터를 7단계 개발 라이프사이클 문서로 강화

### 수정됨
- 오래된 에이전트/명령어 수 수정 (18/21에서 23+/23+로)
- 스타터 전체에서 레거시 V2 용어 제거
- 모든 스타터에서 문서 구조 표준화

## [3.1.0] - 2025-08-16

### 추가됨
- **SDLC 파이프라인 시스템** - 완전한 소프트웨어 개발 라이프사이클 관리
  - 7단계 개발 파이프라인: 계획 → 설계 → 구현 → 검토 → 테스팅 → 배포 → 문서화
  - 파이프라인 오케스트레이션을 위한 메인 `/sdlc` 명령어
  - 단계별 명령어:
    - `/analyze:sdlc-readiness` - 사전 검사 및 준비 상태 평가
    - `/implement:sdlc-phase` - 특정 개발 단계 실행
    - `/manage:sdlc-pipeline` - 파이프라인 라이프사이클 관리
    - `/support:sdlc-report` - 파이프라인 보고서 및 메트릭 생성
  - 지능형 단계 오케스트레이션을 위한 SDLC 코디네이터 에이전트
  - 세 가지 파이프라인 템플릿:
    - **표준 (워터폴)** - 엄격한 품질 게이트를 가진 순차적 단계 실행
    - **애자일 (스프린트 기반)** - 반복 개발을 위한 2주 스프린트 사이클
    - **핫픽스 (긴급)** - 신속한 단계를 가진 4시간 SLA
  - 오버라이드 기능을 가진 자동화된 품질 게이트
  - 파이프라인 상태 관리 및 이력 추적
  - `--with-sdlc` 및 `--sdlc-template` 옵션으로 CLI 통합
  - `.claude/sdlc/README.md`에 포괄적인 문서

### 변경됨
- 에이전트 수를 22개에서 23개로 업데이트 (SDLC 코디네이터 추가)
- 명령어 수를 18개에서 24개로 업데이트 (6개 SDLC 명령어 추가)
- SDLC 기능을 포함하도록 모든 주요 파일의 문서 강화

### 문서화
- **포괄적인 SDLC 파이프라인 가이드 생성** (docs/SDLC_GUIDE.md 및 docs/SDLC_GUIDE.ko.md)
  - 10분 튜토리얼 및 빠른 시작
  - 7단계 모두에 대한 상세한 단계별 가이드
  - 템플릿 심화 (표준, 애자일, 핫픽스)
  - 품질 게이트 관리
  - 고급 기능 및 커스터마이징
  - 모범 사례 및 안티패턴
  - 문제 해결 및 디버깅
  - 실제 사례 연구
  - 완전한 명령어 및 API 참조
- docs/ARCHITECTURE.md에 SDLC 파이프라인 시스템 아키텍처 섹션 추가
- docs/ARCHITECTURE.ko.md에 SDLC 파이프라인 시스템 아키텍처 섹션 추가
- README.md를 SDLC 기능 및 명령어로 업데이트
- README.ko.md를 SDLC 기능 및 명령어로 업데이트
- CLAUDE.md를 SDLC 명령어 예제로 업데이트
- docs/QUICKSTART.md를 SDLC 파이프라인 사용법으로 업데이트
- docs/QUICKSTART.ko.md를 SDLC 파이프라인 사용법으로 업데이트
- docs/API.md를 SDLC CLI 옵션으로 업데이트
- docs/API.ko.md를 SDLC CLI 옵션으로 업데이트
- 모든 관련 문서에 가이드 참조 추가

## [3.0.0] - 2025-08-15

### 추가됨
- 완전한 V2 Context Engineering 시스템 구현
- 포괄적인 템플릿 검증 및 동기화
- 워크스페이스 패키지를 가진 모듈식 모노레포 아키텍처
- 다양한 개발 작업을 위한 22개의 특화된 AI 에이전트
- 카테고리별로 구성된 18개의 Claude Code 명령어
- 개발 및 품질 보증 워크플로우
- 이중 언어 문서 지원 (영어 및 한국어)

### 변경됨
- 모놀리식 설정 스크립트에서 모듈식 아키텍처로 마이그레이션
- 비동기 작업으로 프로젝트 생성 성능 40-50% 개선
- 포괄적인 입력 검증으로 보안 강화

### 수정됨
- 파일 작업의 경로 탐색 취약점
- 템플릿 동기화 문제
- 프로젝트 생성의 성능 병목 현상

## [2.0.0] - 2025-08-14

### 추가됨
- 초기 Context Engineering Template 시스템
- 기본 프로젝트 생성 기능
- 핵심 에이전트 및 명령어 템플릿
- 스타터 템플릿 (basic, api, frontend, fullstack)

## [1.0.0] - 2025-08-13

### 추가됨
- 초기 프로젝트 설정
- 기본 Claude Code 통합
- README 및 문서 구조