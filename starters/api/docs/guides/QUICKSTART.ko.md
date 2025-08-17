# 빠른 시작 가이드

Claude Code Context Engineering Template를 5분 안에 시작하세요!

## 사전 요구사항

- Node.js 18.0.0 이상
- npm 8.0.0 이상
- Git 설정 완료 (버전 관리 및 GitHub 기능용)
- Claude Code 확장 설치 (https://claude.ai/code)
- GitHub 계정 (선택사항, PR 리뷰 기능용)

## 설치

### 1. 저장소 복제

```bash
git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
cd context-engineering-template
```

### 2. 의존성 설치

```bash
npm install
```

### 3. 첫 프로젝트 생성

```bash
# 기본 프로젝트
node cli/claude-init.js my-project

# API 프로젝트
node cli/claude-init.js my-api api

# 프론트엔드 프로젝트
node cli/claude-init.js my-app frontend

# 풀스택 프로젝트
node cli/claude-init.js my-fullstack fullstack

# SDLC 파이프라인 시스템 포함
node cli/claude-init.js my-project basic . --with-sdlc
node cli/claude-init.js my-api api . --with-sdlc --sdlc-template=agile

# PRD 시스템 포함 (기본적으로 포함됨)
node cli/claude-init.js my-project basic                        # PRD 포함
node cli/claude-init.js my-api api --no-prd                    # PRD 제외
node cli/claude-init.js my-app frontend --prd-template=frontend # 커스텀 PRD 템플릿
```

## 프로젝트 구조

프로젝트 생성 후 다음과 같은 구조를 갖게 됩니다:

```
my-project/
├── .claude/                 # Claude Code 설정
│   ├── agents/             # AI 에이전트 정의
│   ├── commands/           # 커스텀 명령어
│   └── workflows/          # 워크플로우 정의
├── CLAUDE.md               # AI 어시스턴트 지침
├── INITIAL.md              # 기능 요청 템플릿
└── README.md               # 프로젝트 문서
```

## Claude Code 명령어 사용

Claude Code에서 프로젝트를 열고 다음 명령어를 사용하세요:

### 빠른 분석
```
/analyze:project-context .
```

### 기능 구현
```
/implement:feature user-authentication
```

### 테스트 실행
```
/manage:test all
```

### 변경사항 커밋
```
/manage:git commit
```

## PRD 시스템 사용

구조화된 개발을 위해 제품 요구사항 문서(PRD)로 시작하세요:

### 템플릿으로 PRD 생성
```
/manage:prd create "feature-name" --template=api
```

### PRD 품질 검토
```
/support:prd-review "feature-name"
```

### PRD 승인 및 개발 시작
```
/manage:prd approve "feature-name"
```

### 모든 PRD 목록 조회
```
/manage:prd list --all
```

## SDLC 파이프라인 사용

SDLC 파이프라인 시스템은 7단계를 통한 체계적인 개발을 제공합니다:

### SDLC 파이프라인 초기화
```
/sdlc "feature-name" --init

# 또는 승인된 PRD에서 초기화
/sdlc "feature-name" --init --from-prd
```

### 전체 파이프라인 실행
```
/sdlc "feature-name" --full
```

### 특정 단계 실행
```
/sdlc "feature-name" --phase=design
```

### 파이프라인 상태 확인
```
/sdlc "feature-name" --status
```

### 파이프라인 보고서 생성
```
/support:sdlc-report "feature-name"
```

**사용 가능한 템플릿**: `standard` (폭포수), `agile` (스프린트 기반), `hotfix` (긴급)

종합적인 SDLC 파이프라인 가이드는 [SDLC 파이프라인 가이드](SDLC_GUIDE.ko.md)를 참조하세요.

## 성능 팁

1. **비동기 작업 사용**: CLI가 async/await로 최적화되어 40-50% 더 빠른 프로젝트 생성
2. **벤치마크 실행**: `npm run benchmark`로 성능 측정
3. **캐싱 활성화**: Claude Code는 에이전트 응답을 캐시하여 후속 작업을 더 빠르게 수행

## 설정 테스트

모든 것이 작동하는지 확인하기 위해 테스트 스위트를 실행하세요:

```bash
# 모든 테스트 실행
npm test

# 커버리지와 함께 실행
npm run test:coverage

# 벤치마크 실행
npm run benchmark
```

## 일반적인 워크플로우

### 1. 새 기능 시작
```bash
# 기능 브랜치 생성
git checkout -b feature/my-feature

# Claude Code로 구현
/implement:feature my-feature

# 변경사항 테스트
npm test

# 지능형 메시지로 커밋
/manage:git commit
```

### 2. 코드 품질 분석
```bash
# 전체 프로젝트 분석
/orchestrate "complete project analysis"

# 특정 모듈 분석
/analyze:code-quality src/modules/auth
```

### 3. 성능 최적화
```bash
# 성능 분석 실행
/analyze:performance .

# 최적화 적용
/implement:enhancement performance-critical-module
```

## 문제 해결

### 문제: 명령어가 인식되지 않음
**해결책**: 프로젝트 루트에 `.claude/settings.json`이 있는지 확인

### 문제: 프로젝트 생성이 느림
**해결책**: 비동기 CLI는 100ms 이내에 프로젝트를 생성해야 합니다. 더 느리다면 디스크 I/O 확인

### 문제: 테스트 실패
**해결책**: `npm install`을 실행하여 모든 의존성이 설치되었는지 확인

## 다음 단계

1. [전체 문서](../README.md) 읽기
2. `.claude/agents/` 디렉토리에서 사용 가능한 에이전트 탐색
3. API 문서 확인 (프로젝트에 `docs/API.ko.md` 생성)
4. 커뮤니티 토론 참여

## 도움 받기

- [GitHub 이슈](https://github.com/A1rtisan-LAB/context-engineering-template/issues)
- [문서](https://docs.anthropic.com/claude-code)
- 기여 가이드 (프로젝트에 `CONTRIBUTING.ko.md` 생성)

---

Claude Code와 함께 즐거운 코딩하세요! 🚀