# Claude Code를 위한 컨텍스트 엔지니어링 템플릿

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.ko.md)

> 🚀 22개 이상의 전문 AI 에이전트를 포함한 Claude Code 프로젝트용 고급 모노레포(monorepo) 템플릿 시스템

## 📦 새로운 모노레포 구조 (v3.0)

이 프로젝트는 더 나은 모듈성과 유지보수성을 위해 현대적인 모노레포로 재구성되었습니다:

```
context-engineering-template/
├── packages/                      # 모듈형 패키지
│   ├── @claude-code/agents/      # AI 에이전트 정의
│   ├── @claude-code/commands/    # 커맨드 템플릿
│   ├── @claude-code/workflows/   # 워크플로우 정의
│   └── @claude-code/core/        # 핵심 엔진
├── starters/                      # 프로젝트 스타터 템플릿
│   ├── basic/                    # 기본 프로젝트 템플릿
│   ├── api/                      # API 서버 템플릿
│   ├── frontend/                 # 프론트엔드 앱 템플릿
│   └── fullstack/               # 풀스택 템플릿
├── cli/                          # CLI 도구
│   └── claude-init.js           # 프로젝트 초기화 도구
└── package.json                  # 워크스페이스 설정
```

## 🎯 주요 장점

### 모듈성
- 각 패키지가 독립적으로 버전 관리 및 유지보수됨
- 개별 컴포넌트를 쉽게 업데이트하거나 교체 가능
- 명확한 관심사 분리

### 확장성
- 커뮤니티가 새로운 에이전트/커맨드를 패키지로 기여 가능
- 플러그인 생태계 지원
- 새로운 기능을 쉽게 확장 가능

### 개발자 경험
- 단일 진입점: `node cli/claude-init.js`
- npm/yarn 워크스페이스 지원
- 현대적인 도구와의 호환성

## 🚀 빠른 시작

### 1. 저장소 클론
```bash
git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
cd context-engineering-template
```

### 2. 의존성 설치
```bash
npm install
```

### 3. 새 프로젝트 생성
```bash
# 새로운 CLI 사용
node cli/claude-init.js my-project [starter-type] [target-path]

# 예제:
node cli/claude-init.js                        # ./my-claude-project에 기본 프로젝트 생성
node cli/claude-init.js my-api api             # API 프로젝트 생성
node cli/claude-init.js my-app frontend ~/apps # ~/apps에 프론트엔드 앱 생성
```

## 📦 패키지 구성

### @claude-code/agents
다양한 개발 작업을 위한 22개의 전문 AI 에이전트:
- 아키텍처 분석
- 코드 품질 평가
- 성능 최적화
- 보안 감사
- 그 외 다수...

### @claude-code/commands
카테고리별로 구성된 18개의 Claude Code 커맨드:
- 분석 (5개 커맨드)
- 구현 (3개 커맨드)
- 관리 (4개 커맨드)
- 지원 (4개 커맨드)
- 오케스트레이션 (2개 커맨드)

### @claude-code/workflows
개발 라이프사이클 워크플로우:
- 개발 라이프사이클 관리
- 품질 보증 프로세스

### @claude-code/core
핵심 엔진 컴포넌트:
- 템플릿 생성기
- 검증기
- 동기화 도구
- 공통 유틸리티

## 🛠️ 개발

### 워크스페이스 작업

```bash
# 모든 워크스페이스에서 명령 실행
npm run test --workspaces

# 특정 패키지에서 실행
npm run build -w @claude-code/agents

# 클린 설치
npm run clean
npm install
```

### 새 패키지 추가

1. 새 패키지 디렉토리 생성: `packages/@claude-code/new-package`
2. 적절한 이름으로 package.json 추가
3. 필요한 경우 루트 package.json 업데이트
4. `npm install`을 실행하여 링크

## 🔄 v2에서 마이그레이션

이전 이중 컨텍스트 아키텍처에서 마이그레이션하는 경우:

1. 현재 프로젝트 백업
2. 마이그레이션 가이드 참조 (docs/MIGRATION.ko.md)
3. CI/CD 파이프라인을 새 구조로 업데이트

## 📚 문서

- [아키텍처 개요](docs/ARCHITECTURE.ko.md)
- [기여 가이드](CONTRIBUTING.ko.md)
- [에이전트 문서](packages/@claude-code/agents/README.ko.md)
- [커맨드 레퍼런스](packages/@claude-code/commands/README.ko.md)
- [빠른 시작 가이드](docs/QUICKSTART.ko.md)
- [API 레퍼런스](docs/API.ko.md)
- [마이그레이션 가이드](docs/MIGRATION.ko.md)

## 🤝 기여하기

기여를 환영합니다! 새로운 모노레포 구조로 다음이 더 쉬워졌습니다:
- 패키지로 새 에이전트 추가
- 커맨드와 워크플로우 기여
- 문서 개선
- 특정 모듈의 버그 수정

자세한 내용은 [CONTRIBUTING.ko.md](CONTRIBUTING.ko.md)를 참조하세요.

## 📄 라이선스

MIT 라이선스 - 자세한 내용은 [LICENSE](LICENSE)를 참조하세요.

## 🙏 감사의 글

AI 지원 개발을 가속화하기 위해 Claude Code 커뮤니티를 위해 제작되었습니다.

## 🌏 언어

이 문서는 다음 언어로도 제공됩니다:
- [English](README.md)