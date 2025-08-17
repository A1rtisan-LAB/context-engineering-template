---
title: 문서 인덱스
author: Claude Code Team
date: 2025-08-17
version: 3.2.1
category: index
tags: [documentation, index, navigation, overview]
language: ko
---

# 문서 인덱스

Context Engineering Template 문서에 오신 것을 환영합니다. 이 디렉토리에는 프로젝트를 위한 종합 가이드, 기술 문서 및 보고서가 포함되어 있습니다.

## 📚 문서 카테고리

### 📖 가이드
시스템을 효과적으로 시작하고 사용하기 위한 사용자 및 개발자 가이드.

- **[빠른 시작 가이드](guides/QUICKSTART.ko.md)** ([English](guides/QUICKSTART.md)) - 5분 안에 시작하기
- **[PRD 가이드](guides/PRD_GUIDE.ko.md)** ([English](guides/PRD_GUIDE.md)) - 제품 요구사항 문서 시스템 가이드
- **[SDLC 파이프라인 가이드](guides/SDLC_GUIDE.ko.md)** ([English](guides/SDLC_GUIDE.md)) - 종합 SDLC 파이프라인 문서
- **[문서 관리 가이드](guides/DOCUMENT_MANAGEMENT.ko.md)** ([English](guides/DOCUMENT_MANAGEMENT.md)) - 문서 관리 시스템 가이드

### 🏗️ 아키텍처
시스템 설계 및 구현에 대한 기술 문서.

- **[아키텍처 개요](architecture/ARCHITECTURE.ko.md)** ([English](architecture/ARCHITECTURE.md)) - 시스템 아키텍처 및 디자인 패턴
- **[API 문서](architecture/API.ko.md)** ([English](architecture/API.md)) - API 참조 및 사용 가이드

### 📊 보고서
분석 보고서 및 벤치마크.

- **[벤치마크 보고서](reports/BENCHMARK_REPORT.ko.md)** ([English](reports/BENCHMARK_REPORT.md)) - 성능 벤치마크 결과

### 🎓 튜토리얼
단계별 학습 가이드.

- **[시작하기](tutorials/getting-started.ko.md)** ([English](tutorials/getting-started.md)) - 첫 프로젝트를 5분 안에 시작하기
- **[PRD 개발 튜토리얼](tutorials/prd-development.ko.md)** ([English](tutorials/prd-development.md)) - 효과적인 PRD 작성법
- **[SDLC 파이프라인 사용법](tutorials/sdlc-pipeline-usage.ko.md)** ([English](tutorials/sdlc-pipeline-usage.md)) - 파이프라인 마스터하기
- **[에이전트 오케스트레이션](tutorials/agent-orchestration.ko.md)** ([English](tutorials/agent-orchestration.md)) - AI 에이전트 조정 모범 사례

### 📚 API 레퍼런스
에이전트 및 명령어 상세 문서.

- **[API 인덱스](api/index.ko.md)** ([English](api/index.md)) - 전체 API 참조 인덱스
- **[에이전트 API](api/agents.ko.md)** ([English](api/agents.md)) - 26개 AI 에이전트 상세 문서
- **[명령 API](api/commands.ko.md)** ([English](api/commands.md)) - 26개 명령 참조
- **[워크플로우 API](api/workflows.ko.md)** ([English](api/workflows.md)) - 워크플로우 오케스트레이션

## 🔍 빠른 탐색

### 주제별
- **시작하기**: [빠른 시작](guides/QUICKSTART.ko.md) → [아키텍처](architecture/ARCHITECTURE.ko.md)
- **개발 워크플로우**: [PRD 가이드](guides/PRD_GUIDE.ko.md) → [SDLC 파이프라인](guides/SDLC_GUIDE.ko.md)
- **기술 참조**: [API 문서](architecture/API.ko.md) → [아키텍처](architecture/ARCHITECTURE.ko.md)
- **문서 관리**: [문서 관리 가이드](guides/DOCUMENT_MANAGEMENT.ko.md)

### 언어별
- **한국어**: `.ko.md` 확장자가 있는 모든 문서
- **English**: `.ko.md` 확장자가 없는 모든 문서

## 📝 문서 표준

### 파일 명명 규칙
- 영어 (기본): `{DOCUMENT_NAME}.md`
- 한국어 버전: `{DOCUMENT_NAME}.ko.md`

### 문서 구조
```
docs/
├── README.ko.md                 # 이 인덱스 파일
├── guides/                      # 사용자 및 개발자 가이드
│   ├── QUICKSTART.md/ko.md
│   ├── PRD_GUIDE.md/ko.md
│   ├── SDLC_GUIDE.md/ko.md
│   └── DOCUMENT_MANAGEMENT.md/ko.md
├── architecture/                # 기술 문서
│   ├── ARCHITECTURE.md/ko.md
│   └── API.md/ko.md
├── reports/                     # 분석 및 벤치마크 보고서
│   └── BENCHMARK_REPORT.md/ko.md
├── api/                        # API 레퍼런스
│   ├── index.md/ko.md         # API 인덱스
│   ├── agents.md/ko.md        # 에이전트 API
│   ├── commands.md/ko.md      # 명령 API
│   └── workflows.md/ko.md     # 워크플로우 API
├── tutorials/                  # 튜토리얼
│   ├── getting-started.md/ko.md
│   ├── prd-development.md/ko.md
│   ├── sdlc-pipeline-usage.md/ko.md
│   └── agent-orchestration.md/ko.md
├── examples/                   # 코드 예제
└── changelog/                  # 버전 변경사항
```

### 버전 동기화
모든 문서는 영어와 한국어 버전으로 유지되어야 합니다. 문서를 업데이트할 때 두 언어 버전이 동기화되었는지 확인하세요.

## 🔄 최근 업데이트

- **2025-08-17**: API 레퍼런스 문서 완성 (agents, commands, workflows, index)
- **2025-08-17**: 튜토리얼 4개 추가 (getting-started, prd-development, sdlc-pipeline-usage, agent-orchestration)
- **2025-08-17**: 모든 API 문서 및 튜토리얼 한국어 번역 완료
- **2025-08-17**: 문서 구조 개선 및 새 디렉토리 추가
- **2025-08-17**: 문서 관리 가이드 추가
- **2025-08-17**: 한국어 문서 인덱스 생성

## 📮 문서 기여하기

문서에 기여할 때:
1. 영어와 한국어 버전 모두 업데이트
2. 확립된 구조 준수
3. 해당하는 경우 예제 포함
4. 새 문서를 추가하는 경우 이 인덱스 업데이트
5. 모든 링크가 작동하는지 확인

기여에 대한 자세한 정보는 [CONTRIBUTING.ko.md](../CONTRIBUTING.ko.md)를 참조하세요.