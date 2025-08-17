# Claude Code를 위한 컨텍스트 엔지니어링 템플릿

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.ko.md)

> 🚀 25개의 전문 AI 에이전트, 26개의 커맨드, SDLC 파이프라인 시스템, PRD 기반 개발 워크플로우를 포함한 Claude Code 프로젝트용 고급 모노레포(monorepo) 템플릿 시스템

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

# SDLC 파이프라인 시스템 포함:
node cli/claude-init.js my-project basic . --with-sdlc
node cli/claude-init.js my-api api . --with-sdlc --sdlc-template=agile

# PRD 시스템 포함 (기본적으로 포함됨):
node cli/claude-init.js my-project basic              # PRD 포함
node cli/claude-init.js my-api api --no-prd          # PRD 제외
node cli/claude-init.js my-app frontend --prd-template=frontend  # 커스텀 PRD 템플릿
```

## 📁 프로젝트 구조

### 세 가지 구조 이해하기

이 저장소는 함께 작동하는 세 가지 구조를 포함합니다:

#### 1️⃣ **템플릿 저장소 구조** (이 저장소)
```
context-engineering-template/        # 개발 및 유지보수용
├── packages/@claude-code/          # 소스 코드 (개발용)
│   ├── agents/src/*.md            # 에이전트 소스 파일들
│   ├── commands/src/*.md          # 커맨드 소스 파일들
│   └── workflows/src/*.md         # 워크플로우 소스 파일들
├── starters/                       # 프로젝트 템플릿
│   ├── basic/                     # 기본 템플릿
│   ├── api/                       # API 템플릿
│   ├── frontend/                  # 프론트엔드 템플릿
│   └── fullstack/                 # 풀스택 템플릿
├── cli/claude-init.js            # 프로젝트 생성 도구
└── docs/                          # 템플릿 시스템 문서
```
**목적**: 템플릿 개발 및 유지보수

#### 2️⃣ **스타터 템플릿 구조** (설계도)
```
starters/basic/                     # 복사될 파일들
├── CLAUDE.md                      # AI 지침 (복사됨)
├── README.md                      # 프로젝트 문서 (복사됨)
└── docs/                          # 프로젝트 가이드 (복사됨)
    ├── QUICKSTART.md
    ├── PRD_GUIDE.md
    └── SDLC_GUIDE.md
```
**목적**: 새 프로젝트의 설계도

#### 3️⃣ **생성된 프로젝트 구조** (사용자가 받는 것)
```
my-project/                        # 사용자의 새 프로젝트
├── .claude/                       # Claude Code 설정 ⭐
│   ├── agents/                   # AI 에이전트 (src/ 디렉토리 없음!)
│   │   ├── feature-implementer.md
│   │   └── code-analyzer.md
│   ├── commands/                 # 커맨드 (src/ 디렉토리 없음!)
│   │   ├── analyze/*.md
│   │   └── implement/*.md
│   └── workflows/                # 워크플로우 (src/ 디렉토리 없음!)
├── docs/                         # 프로젝트 문서
│   ├── QUICKSTART.md
│   └── guides/
├── CLAUDE.md                     # AI 지침
└── README.md                     # 프로젝트 설명
```
**목적**: 바로 사용 가능한 Claude Code 프로젝트

### 🔄 핵심 변환 과정

```
템플릿 저장소                    →    생성된 프로젝트
─────────────                   →    ─────────────
packages/@claude-code/          →    .claude/
  └── agents/src/*.md          →      └── agents/*.md (src/ 제거!)
  └── commands/src/*.md        →      └── commands/*.md (src/ 제거!)
  
starters/[type]/*              →    [프로젝트 루트 파일들]
```

### 💡 간단한 비유
다음과 같이 생각하세요:
- **이 저장소** = 공장 (부품 + 설계도 + 조립 도구)
- **생성된 프로젝트** = 제품 (깨끗하고 바로 사용 가능한 Claude Code 프로젝트)

사용자는 공장의 복잡한 구조를 이해할 필요 없이 깨끗하고 잘 정리된 제품만 받으면 됩니다.

### 생성된 프로젝트 구조 상세
새 프로젝트를 생성하면 다음과 같은 구조를 갖게 됩니다:

```
my-project/
├── .claude/                  # Claude Code 설정
│   ├── agents/              # AI 에이전트 (*.md 파일이 바로 여기에)
│   ├── commands/            # 카테고리별로 구성된 커맨드
│   │   ├── analyze/         # 분석 커맨드
│   │   ├── implement/       # 구현 커맨드
│   │   ├── manage/          # 관리 커맨드 (PRD 포함)
│   │   └── support/         # 지원 커맨드 (PRD 리뷰 포함)
│   ├── workflows/           # 워크플로우 정의
│   └── sdlc/                # SDLC 및 PRD 설정
├── docs/
│   ├── prd/                 # PRD 문서 (PRD 시스템 활성화 시)
│   │   ├── draft/           # 작성 중인 PRD
│   │   ├── approved/        # 승인된 PRD
│   │   └── archived/        # 완료된 PRD
│   └── guides/              # 사용자 및 개발자 가이드
├── CLAUDE.md                # AI 어시스턴트 지침
├── INITIAL.md               # 기능 요청 템플릿
└── README.md                # 프로젝트 문서
```

### 모노레포 구조 (개발용)
이 템플릿 저장소는 모노레포 구조를 사용합니다:

```
context-engineering-template/
├── packages/@claude-code/    # 모듈형 패키지
│   ├── agents/src/          # 에이전트 정의
│   ├── commands/src/        # 커맨드 구현
│   ├── workflows/src/       # 워크플로우 정의
│   └── core/src/            # 핵심 엔진 (내부용)
├── starters/                # 스타터 템플릿
├── cli/                     # CLI 도구
└── docs/                    # 문서
```

**참고:** CLI는 `packages/@claude-code/*/src/`의 내용을 생성된 프로젝트의 `.claude/*/` 디렉토리로 `src/` 하위 디렉토리 없이 복사합니다.

## 🛠️ Claude Code 커맨드

생성된 프로젝트에서 사용 가능한 전문가 수준 커맨드:

### 🔍 **분석 커맨드**
| 커맨드 | 설명 |
|--------|---------|
| `/analyze:architecture [target]` | 소프트웨어 아키텍처, 디자인 패턴, 구조적 품질 분석 |
| `/analyze:code-quality [target]` | 코드 품질, 가독성, 유지보수성, 표준 준수 분석 |
| `/analyze:performance [target]` | 성능 병목 현상, 메모리 사용량, 확장성 문제 분석 |
| `/analyze:project-context [target]` | 프로젝트 구조, 의존성, 설정 분석 |
| `/analyze:security [target]` | 보안 취약점, 인증 결함, 데이터 보호 문제 분석 |

### 🚀 **구현 커맨드**  
| 커맨드 | 설명 |
|--------|---------|
| `/implement:feature [feature-name]` | 전문가 페르소나로 새로운 기능과 컴포넌트 구현 |
| `/implement:enhancement [target]` | 기존 코드 성능, 유지보수성, 가독성 개선 |
| `/implement:cleanup [target]` | 코드베이스 정리, 사용하지 않는 코드 제거, 구조 최적화 |

### 🔧 **관리 커맨드**
| 커맨드 | 설명 |
|--------|---------|
| `/manage:git [task]` | 지능적인 Git 작업, 자동 커밋 메시지, 전략적 브랜치 관리 |
| `/manage:build [project]` | 다양한 언어와 빌드 시스템에서 빌드, 컴파일, 패키징 |
| `/manage:test [scope]` | 테스트 실행, 결과 분석, 종합 테스트 보고서 생성 |
| `/manage:workflow [task]` | 복잡한 다단계 작업을 위한 지능적인 워크플로우 관리 |
| `/manage:prd create [name]` | 템플릿 기반 PRD 생성 |
| `/manage:prd status [name]` | PRD 상태 확인 |
| `/manage:prd approve [name]` | PRD 승인 및 SDLC 시작 |
| `/manage:prd list` | 모든 PRD 목록 조회 |

### 🛠️ **지원 커맨드**
| 커맨드 | 설명 |
|--------|---------|
| `/support:diagnose [issue]` | 버그, 빌드 실패, 배포 문제, 예상치 못한 시스템 동작 진단 |
| `/support:document [target]` | 코드 컴포넌트, 함수, 기능에 대한 정확한 문서 생성 |
| `/support:estimate [task]` | 작업, 기능, 전체 프로젝트의 개발 시간 추정 |
| `/support:explain [concept]` | 코드 기능과 프로그래밍 개념에 대한 명확한 설명 제공 |
| `/support:sdlc-report [feature]` | 메트릭과 인사이트를 포함한 종합 SDLC 파이프라인 보고서 생성 |
| `/support:prd-review [name]` | PRD 품질 검토 및 개선 제안 |

### 🎯 **SDLC 파이프라인 커맨드**
| 커맨드 | 설명 |
|--------|---------|
| `/sdlc [feature] [options]` | 종합적인 소프트웨어 개발 생명주기 파이프라인 실행 |
| `/analyze:sdlc-readiness` | SDLC 파이프라인 실행을 위한 프로젝트 준비 상태 분석 |
| `/implement:sdlc-phase [phase]` | 특정 SDLC 파이프라인 단계 실행 |
| `/manage:sdlc-pipeline [action]` | SDLC 파이프라인 생명주기 및 상태 관리 |

### 🎭 **오케스트레이션 커맨드**
| 커맨드 | 설명 |
|--------|---------|
| `/orchestrate [complex-task]` | 복잡한 단일 세션 요청을 다중 에이전트 워크플로우로 분해 및 조정 |
| `/review-agents [agent]` | 에이전트 프롬프트 품질, 일관성, 효과성 검토 및 분석 |

## 📝 워크플로우

### 🎯 **기본 개발 워크플로우**
1. **프로젝트 이해**: `/analyze:project-context .`를 사용하여 프로젝트 구조 이해
2. **기능 구현**: `/implement:feature [feature-name]`를 사용하여 새 기능 개발
3. **품질 검증**: `/analyze:code-quality .`를 사용하여 코드 품질 확인
4. **테스트 실행**: `/manage:test all`을 사용하여 모든 테스트 실행
5. **버전 관리**: `/manage:git commit`을 사용하여 지능적인 커밋과 브랜치 관리

### 🔧 **고급 워크플로우 패턴**
- **종합 분석**: `/orchestrate "complete project architecture, performance, and security analysis"`
- **리팩토링**: `/implement:enhancement [module]` + `/implement:cleanup [module]`
- **문제 해결**: `/support:diagnose [issue]` + `/support:explain [solution]`
- **프로젝트 추정**: `/support:estimate [entire project]`

### 📝 **PRD 기반 개발 워크플로우**
구조화된 개발을 위해 제품 요구사항 문서(PRD)로 시작하세요:

```bash
# 템플릿으로 PRD 생성
/manage:prd create "user-authentication" --template=api

# PRD 품질 검토 및 검증
/support:prd-review "user-authentication"

# PRD 승인 및 개발 시작
/manage:prd approve "user-authentication"
```

### 🚀 **SDLC 파이프라인 워크플로우**
7단계로 구성된 체계적인 개발 생명주기 실행 (선택적으로 PRD에서 시작):

```bash
# 새 기능을 위한 SDLC 파이프라인 초기화
/sdlc "user-authentication" --init

# 승인된 PRD에서 초기화
/sdlc "user-authentication" --init --from-prd

# 전체 파이프라인 실행 (계획 → 설계 → 구현 → 리뷰 → 테스트 → 배포 → 문서화)
/sdlc "user-authentication" --full

# 특정 단계 실행
/sdlc "user-authentication" --phase=design

# 파이프라인 상태 확인
/sdlc "user-authentication" --status

# 파이프라인 보고서 생성
/support:sdlc-report "user-authentication"
```

**사용 가능한 SDLC 템플릿**: `standard` (폭포수), `agile` (스프린트 기반), `hotfix` (긴급)

## 🤝 기여하기

이 프로젝트는 커뮤니티 기여를 환영합니다!

### 기여 방법

1. 저장소 포크
2. 기능 브랜치 생성 (`git checkout -b feature/amazing-pattern`)
3. 변경 사항 커밋 (`git commit -m 'Add amazing pattern'`)
4. 브랜치에 푸시 (`git push origin feature/amazing-pattern`)
5. Pull Request 생성

자세한 내용은 [CONTRIBUTING.ko.md](CONTRIBUTING.ko.md)를 참조하세요.

## 🔧 문제 해결

일반적인 문제와 해결책은 `docs/TROUBLESHOOTING.md`를 참조하세요.

### 자주 묻는 질문

**Q: Claude Code가 커맨드를 인식하지 못합니다**
- A: `.claude/settings.json` 파일이 올바른 위치에 있는지 확인하세요 (`.local`이 아님!)

**Q: 템플릿 수정사항이 반영되지 않습니다**
- A: `node cli/claude-init.js`를 다시 실행하거나 starters 디렉토리에서 업데이트된 파일을 수동으로 복사하세요

## 📚 리소스

- [Claude Code 문서](https://docs.anthropic.com/claude-code)
- [PRD 가이드](docs/guides/PRD_GUIDE.ko.md) - 제품 요구사항 문서 가이드
- [SDLC 파이프라인 가이드](docs/guides/SDLC_GUIDE.ko.md) - SDLC 파이프라인 시스템 종합 가이드
- [아키텍처 개요](docs/architecture/ARCHITECTURE.ko.md)

## 📄 라이선스

이 프로젝트는 MIT 라이선스로 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 🙏 감사의 글

이 프로젝트는 Claude Code 커뮤니티의 피드백과 기여를 통해 발전하고 있습니다.

## ☕ 이 프로젝트 지원하기

이 템플릿이 개발 워크플로우를 개선했다면, 커피 한 잔으로 지원을 고려해 주세요!

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-☕-yellow.svg)](https://buymeacoffee.com/a1rtisan)

여러분의 지원은 더 나은 Context Engineering 도구와 템플릿 개발에 큰 동기부여가 됩니다. 🚀

---

더 나은 AI 협업을 위해 ❤️로 제작되었습니다