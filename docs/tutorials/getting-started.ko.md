---
title: 시작하기 튜토리얼
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: tutorials
tags: [tutorial, getting-started, quickstart, basics]
language: ko
---

# Context Engineering Template 시작하기

## 첫 프로젝트를 5분 안에 시작하기

Context Engineering Template을 사용하여 AI 지원 개발 환경을 빠르게 설정하고 첫 번째 프로젝트를 시작하는 방법을 배웁니다.

## 목차

1. [빠른 시작](#빠른-시작)
2. [프로젝트 생성](#프로젝트-생성)
3. [프로젝트 구조 이해](#프로젝트-구조-이해)
4. [첫 기능 구현](#첫-기능-구현)
5. [AI 에이전트 사용](#ai-에이전트-사용)
6. [명령 실행](#명령-실행)
7. [워크플로우 실행](#워크플로우-실행)
8. [다음 단계](#다음-단계)

## 빠른 시작

### 사전 요구사항
```bash
# 필수 도구 확인
node --version  # v18.0.0 이상
npm --version   # v9.0.0 이상
git --version   # v2.0.0 이상
```

### 1분 설정
```bash
# 템플릿 복제
git clone https://github.com/A1rtisan-LAB/context-engineering-template
cd context-engineering-template

# 의존성 설치
npm install

# 새 프로젝트 생성
node cli/claude-init.js my-awesome-app
cd my-awesome-app

# 완료! 🎉
```

## 프로젝트 생성

### 옵션 1: 기본 프로젝트
```bash
# 가장 간단한 방법
node cli/claude-init.js my-project

# 생성 내용:
✅ 26개 AI 에이전트
✅ 26개 명령
✅ 4개 워크플로우
✅ PRD 시스템
✅ SDLC 파이프라인
✅ 문서 관리
```

### 옵션 2: 특정 스타터 선택
```bash
# API 프로젝트
node cli/claude-init.js my-api api

# 프론트엔드 프로젝트
node cli/claude-init.js my-frontend frontend

# 풀스택 프로젝트
node cli/claude-init.js my-fullstack fullstack
```

### 옵션 3: 사용자 정의 구성
```bash
# 최소 설정 (에이전트와 명령만)
node cli/claude-init.js my-project basic . --minimal

# 전체 기능 (모든 시스템 포함)
node cli/claude-init.js my-project basic . --full

# 특정 경로에 생성
node cli/claude-init.js my-project basic ~/projects
```

### 대화형 모드
```bash
$ node cli/claude-init.js

📦 Context Engineering Template 프로젝트 생성기
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

? 프로젝트 이름: my-awesome-app
? 스타터 유형 선택: 
  ❯ basic     - 기본 프로젝트
    api       - API 서버
    frontend  - 프론트엔드 앱
    fullstack - 풀스택 애플리케이션
? 대상 경로: ./
? PRD 시스템 포함? (Y/n): Y
? SDLC 파이프라인 포함? (Y/n): Y
? 문서 관리 포함? (Y/n): Y

✨ 프로젝트 생성 중...
✅ 프로젝트가 성공적으로 생성되었습니다!
```

## 프로젝트 구조 이해

### 생성된 구조
```
my-project/
├── .claude/                    # Claude Code 구성
│   ├── agents/                # 26개 AI 에이전트
│   │   ├── feature-implementer.md
│   │   ├── code-quality-analyzer.md
│   │   └── ...
│   ├── commands/              # 26개 명령
│   │   ├── analyze/          # 분석 명령
│   │   ├── implement/        # 구현 명령
│   │   ├── manage/           # 관리 명령
│   │   └── support/          # 지원 명령
│   └── workflows/            # 4개 핵심 워크플로우
│       ├── development-lifecycle.md
│       ├── quality-assurance.md
│       ├── prd-to-implementation.md
│       └── issue-resolution.md
├── docs/                      # 프로젝트 문서
│   ├── prd/                  # PRD 문서
│   │   ├── draft/           # 초안
│   │   ├── review/          # 검토 중
│   │   └── approved/        # 승인됨
│   └── guides/              # 가이드 문서
├── src/                      # 소스 코드
├── CLAUDE.md                 # AI 어시스턴트 지침
└── README.md                 # 프로젝트 문서
```

### 핵심 파일 설명

#### CLAUDE.md
AI 어시스턴트를 위한 프로젝트별 지침:
```markdown
# CLAUDE.md

## 프로젝트 개요
이 프로젝트는 전자상거래 플랫폼입니다...

## 코딩 표준
- TypeScript 사용
- ESLint 규칙 준수
- 100% 테스트 커버리지 목표

## 주요 명령
npm run dev    # 개발 서버 시작
npm test       # 테스트 실행
npm run build  # 프로덕션 빌드
```

#### PRD 시스템
프로젝트는 INITIAL.md 대신 더 강력한 PRD(Product Requirements Document) 시스템을 사용합니다:

```bash
# 새 PRD 생성
/manage:prd create "user-authentication" --template=standard

# PRD 상태 확인
/manage:prd status "user-authentication"

# PRD 승인 (SDLC 파이프라인 자동 시작)
/manage:prd approve "user-authentication"
```

PRD 템플릿은 `docs/prd/templates/` 폴더에 위치하며, 다음과 같은 라이프사이클을 가집니다:
- **draft/** → **review/** → **approved/** → **in-development/** → **archived/**

## 첫 기능 구현

### 단계 1: PRD 작성
```bash
# PRD 생성
/manage:prd create "user-authentication" --template=api

# 파일 편집: docs/prd/draft/user-authentication.md
```

### 단계 2: PRD 승인
```bash
# PRD 검토
/support:prd-review "user-authentication"

# 검토 결과:
✅ 구조 완성도: 95%
✅ 요구사항 명확성: 90%
⚠️  기술 사양: 추가 세부사항 필요

# PRD 승인 (SDLC 자동 시작)
/manage:prd approve "user-authentication"
```

### 단계 3: 구현
```bash
# 자동으로 SDLC 파이프라인 시작됨
Pipeline Started: user-authentication
Phase 1/7: Planning...

# 또는 수동으로 기능 구현
/implement:feature "user-authentication"
```

### 단계 4: 테스트
```bash
# 테스트 실행
/manage:test all

# 결과:
Test Suites: 5 passed
Tests: 42 passed
Coverage: 89%
```

## AI 에이전트 사용

### 코드 분석
```bash
# 코드 품질 분석
/analyze:code-quality src/

# 출력:
코드 품질 점수: B+ (85/100)
- 가독성: A (92)
- 유지보수성: B (83)
- 복잡도: B (80)

개선 제안:
1. 함수 getUserById 복잡도 감소
2. 매직 넘버를 상수로 추출
3. 에러 처리 개선
```

### 보안 스캔
```bash
# 보안 취약점 스캔
/analyze:security

# 발견된 문제:
HIGH: 0
MEDIUM: 2
  - 오래된 의존성 (express@4.17.1)
  - 약한 암호화 알고리즘 (MD5)
LOW: 5
```

### 버그 진단
```bash
# 문제 진단
/support:issue-diagnose "로그인이 실패합니다"

# 진단 중...
✅ 데이터베이스 연결 정상
✅ API 엔드포인트 응답
❌ JWT 시크릿 키 누락

해결 방법:
1. .env 파일에 JWT_SECRET 추가
2. 환경 변수 설정 확인
3. 서버 재시작
```

## 명령 실행

### 분석 명령
```bash
# 프로젝트 컨텍스트 분석
/analyze:project-context

# 성능 분석
/analyze:performance src/api

# SDLC 준비 상태 확인
/analyze:sdlc-readiness
```

### 구현 명령
```bash
# 새 기능 구현
/implement:feature "shopping-cart"

# 코드 개선
/implement:enhancement "optimize-database-queries"

# 버그 수정
/implement:fix "payment-processing-error"

# 리팩토링
/implement:refactor "user-service"
```

### 관리 명령
```bash
# Git 작업
/manage:git commit  # 지능형 커밋 메시지 생성

# 문서 관리
/manage:docs validate  # 문서 검증
/manage:docs sync      # 번역 동기화

# 테스트 실행
/manage:test unit       # 단위 테스트
/manage:test integration # 통합 테스트
/manage:test e2e        # E2E 테스트
```

### 지원 명령
```bash
# 에이전트 품질 검토
/support:agent-review "feature-implementer"

# Claude Code 구조 감사
/support:claude-structure-audit

# 개념 설명
/support:concept-explain "의존성 주입"

# SDLC 보고서 생성
/support:sdlc-report "user-authentication"
```

## 워크플로우 실행

### 개발 라이프사이클 워크플로우
```bash
# 전체 개발 라이프사이클 실행
/orchestrate development-lifecycle "new-feature"

# 실행 단계:
1. Planning (1-2일)
2. Design (2-3일)
3. Implementation (3-5일)
4. Review (1일)
5. Testing (2-3일)
6. Deployment (1일)
7. Documentation (1일)
```

### 품질 보증 워크플로우
```bash
# 품질 검사 실행
/orchestrate quality-assurance

# 검사 항목:
- 코드 분석 (ESLint, Prettier)
- 보안 스캔
- 성능 테스트
- 문서 검증
```

### 문제 해결 워크플로우
```bash
# 긴급 문제 해결
/orchestrate issue-resolution "critical-bug"

# 빠른 대응:
1. 진단 (15-30분)
2. 해결책 설계 (15-30분)
3. 구현 (30-120분)
4. 검증 (15-30분)
5. 배포 (15분)
```

## 실제 예제: TODO 앱 만들기

### 1. 프로젝트 생성
```bash
node cli/claude-init.js todo-app frontend
cd todo-app
```

### 2. 요구사항 정의
```bash
# PRD 생성
/manage:prd create "todo-features" --template=frontend
```

### 3. 기능 구현
```bash
# Todo 리스트 컴포넌트
/implement:feature "todo-list-component"

# Todo 추가 기능
/implement:feature "add-todo"

# Todo 완료 기능
/implement:feature "complete-todo"

# Todo 삭제 기능
/implement:feature "delete-todo"
```

### 4. 스타일링 추가
```bash
# Tailwind CSS 설정
/implement:enhancement "add-tailwind-styling"
```

### 5. 테스트 작성
```bash
# 테스트 생성
/implement:feature "unit-tests"

# 테스트 실행
/manage:test all
```

### 6. 배포 준비
```bash
# 빌드 최적화
/implement:enhancement "production-build"

# 문서 생성
/focused-doc-generator "todo-app"
```

## 팁과 트릭

### 생산성 향상
```bash
# 병렬 작업 실행
/orchestrate parallel-analysis "project" \
  --agents="security-analyzer,performance-analyzer"

# 작업 배치
/implement:feature "feature-1" && \
/implement:feature "feature-2" && \
/manage:test all
```

### 디버깅
```bash
# 상세 로깅 활성화
DEBUG=* /implement:feature "complex-feature"

# 에이전트 추적
AGENT_TRACE=true /orchestrate development-lifecycle
```

### 사용자 정의
```bash
# 사용자 정의 명령 추가
echo "커스텀 명령 정의" > .claude/commands/custom-command.md

# 사용자 정의 에이전트 추가
echo "커스텀 에이전트 정의" > .claude/agents/custom-agent.md
```

## 일반적인 문제 해결

### 문제: 명령을 찾을 수 없음
```bash
오류: Command not found: /custom:command

해결:
1. 명령 파일이 .claude/commands/에 있는지 확인
2. 파일 이름과 명령 이름이 일치하는지 확인
3. Claude Code 재시작
```

### 문제: 에이전트 시간 초과
```bash
오류: Agent timeout after 300s

해결:
1. 작업을 더 작은 단위로 분할
2. 시간 초과 증가: --timeout=600
3. 에이전트 로그 확인
```

### 문제: PRD 승인 실패
```bash
오류: PRD validation failed

해결:
1. /support:prd-review 실행
2. 누락된 섹션 추가
3. 요구사항 명확히 하기
4. 재승인 시도
```

## 다음 단계

### 학습 경로
1. **기초 마스터**
   - 모든 명령 익히기
   - 에이전트 기능 이해
   - 워크플로우 실행

2. **고급 기능**
   - 사용자 정의 워크플로우 생성
   - 파이프라인 최적화
   - CI/CD 통합

3. **팀 협업**
   - Git 워크플로우 설정
   - 코드 리뷰 프로세스
   - 문서 표준화

### 추천 튜토리얼
1. [PRD 개발 튜토리얼](prd-development.ko.md)
2. [SDLC 파이프라인 사용법](sdlc-pipeline-usage.ko.md)
3. [에이전트 오케스트레이션](agent-orchestration.ko.md)

### 커뮤니티 리소스
- [GitHub 저장소](https://github.com/your-org/context-engineering-template)
- [Discord 커뮤니티](https://discord.gg/claude-code)
- [포럼](https://forum.claude.ai)
- [YouTube 튜토리얼](https://youtube.com/@claudecode)

## 요약

이제 다음을 할 수 있습니다:
- ✅ 새 프로젝트 생성
- ✅ AI 에이전트 사용
- ✅ 명령 실행
- ✅ 워크플로우 오케스트레이션
- ✅ PRD 작성 및 승인
- ✅ SDLC 파이프라인 실행

Context Engineering Template과 함께 생산적인 개발을 시작하세요! 🚀