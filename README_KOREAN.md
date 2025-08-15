# Context Engineering Template for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

> 🚀 Context Engineering project template for Claude Code - A structured approach for efficient AI collaboration

## 🎯 Introduction

This template is a Context Engineering framework designed for use with Claude Code. It helps AI assistants understand the full context of your project and generate consistent code.

### Key Features

- 📋 **PRP (Product Requirements Prompt)**: Detailed implementation blueprint for AI
- 🤖 **Claude Code Integration**: Workflow automation with custom commands
- 📚 **Pattern Library**: Reusable code patterns and best practices
- 🔄 **Single Source of Truth**: Efficient management without template duplication

## 🚀 빠른 시작

### 1. 저장소 클론
```bash
git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
cd context-engineering-template
```

### 2. 새 프로젝트 생성
```bash
# 기본 사용법 (현재 디렉토리에 생성)
./setup-claude-code.sh my-awesome-project
```

### 3. 프로젝트 타입 지정 (선택사항)
```bash
# API 프로젝트
./setup-claude-code.sh my-api api

# Frontend 프로젝트
./setup-claude-code.sh my-frontend frontend

# Fullstack 프로젝트
./setup-claude-code.sh my-fullstack fullstack
```

### 4. 프로젝트 경로 지정 (선택사항)
```bash
# 홈 디렉토리의 Desktop에 생성
./setup-claude-code.sh my-project general ~/Desktop

# 절대 경로 지정
./setup-claude-code.sh my-api api /path/to/projects

# 상대 경로 지정
./setup-claude-code.sh my-frontend frontend ./projects

# 전체 옵션 사용 예시
./setup-claude-code.sh awesome-app fullstack ~/Development
```

## 📁 템플릿 구조

```
templates/
├── .claude/                  # Claude Code 설정
│   ├── commands/            # 커스텀 명령어 구현
│   └── agents/              # 전문 AI 에이전트
├── PRPs/                    # Product Requirements Prompts
│   └── templates/           # PRP 템플릿
├── examples/                # 코드 패턴과 예시
│   └── _patterns/          # 재사용 가능한 패턴
├── docs/                    # 프로젝트 문서
├── CLAUDE.md               # AI 어시스턴트 규칙
├── INITIAL.md              # 기능 요청 템플릿
└── README.template.md      # 프로젝트 README 템플릿
```

## 🛠️ Claude Code 명령어

생성된 프로젝트에서 사용 가능한 전문가 수준의 명령어들:

### 🔍 **분석 명령어** (Analysis)
| 명령어 | 설명 |
|--------|------|
| `/analyze:architecture [대상]` | 소프트웨어 아키텍처, 설계 패턴, 구조적 품질 분석 |
| `/analyze:code-quality [대상]` | 코드 품질, 가독성, 유지보수성, 표준 준수 분석 |
| `/analyze:performance [대상]` | 성능 병목점, 메모리 사용량, 확장성 문제 분석 |
| `/analyze:project-context [대상]` | 프로젝트 구조, 의존성, 설정 분석 |
| `/analyze:security [대상]` | 보안 취약점, 인증 결함, 데이터 보호 문제 분석 |

### 🚀 **구현 명령어** (Implementation)  
| 명령어 | 설명 |
|--------|------|
| `/implement:feature [기능명]` | 전문가 페르소나로 새로운 기능, 컴포넌트 구현 |
| `/implement:enhancement [대상]` | 기존 코드의 성능, 유지보수성, 가독성 개선 |
| `/implement:cleanup [대상]` | 코드베이스 정리, 미사용 코드 제거, 구조 최적화 |

### 🔧 **관리 명령어** (Management)
| 명령어 | 설명 |
|--------|------|
| `/manage:git [작업]` | 지능형 Git 작업, 자동 커밋 메시지, 전략적 브랜치 관리 |
| `/manage:build [프로젝트]` | 다양한 언어와 빌드 시스템에서 빌드, 컴파일, 패키징 |
| `/manage:test [범위]` | 테스트 실행, 결과 분석, 포괄적 테스트 리포트 생성 |
| `/manage:workflow [작업]` | 복잡한 다단계 작업의 지능형 워크플로우 관리 |

### 🛠️ **지원 명령어** (Support)
| 명령어 | 설명 |
|--------|------|
| `/support:diagnose [문제]` | 버그, 빌드 실패, 배포 문제, 예상치 못한 시스템 동작 진단 |
| `/support:document [대상]` | 코드 구성요소, 함수, 기능에 대한 정확한 문서 생성 |
| `/support:estimate [작업]` | 작업, 기능, 프로젝트 전체에 대한 개발 시간 추정 |
| `/support:explain [개념]` | 코드 기능, 프로그래밍 개념에 대한 명확한 설명 |

### 🎭 **오케스트레이션 명령어** (Orchestration)
| 명령어 | 설명 |
|--------|------|
| `/orchestrate [복합작업]` | 복잡한 단일 세션 요청을 다중 에이전트 워크플로우로 분해 및 조정 |
| `/review-agents [에이전트]` | 에이전트 프롬프트의 품질, 일관성, 효과성 검토 및 분석 |

## 📝 워크플로우

### 🎯 **기본 개발 워크플로우**
1. **프로젝트 이해**: `/analyze:project-context .` 으로 프로젝트 구조 파악
2. **기능 구현**: `/implement:feature [기능명]` 으로 새 기능 개발
3. **품질 검증**: `/analyze:code-quality .` 으로 코드 품질 검사
4. **테스트 실행**: `/manage:test all` 으로 전체 테스트 실행
5. **버전 관리**: `/manage:git commit` 으로 지능형 커밋 및 브랜치 관리

### 🔧 **고급 워크플로우 패턴**
- **종합 분석**: `/orchestrate "전체 프로젝트 아키텍처, 성능, 보안 분석"`
- **리팩토링**: `/implement:enhancement [모듈]` + `/implement:cleanup [모듈]`
- **문제 해결**: `/support:diagnose [이슈]` + `/support:explain [해결방법]`
- **프로젝트 추정**: `/support:estimate [전체 프로젝트]`

## 🤝 기여하기

이 프로젝트는 커뮤니티 기여를 환영합니다! 

### 기여 방법

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-pattern`)
3. Commit your changes (`git commit -m 'Add amazing pattern'`)
4. Push to the branch (`git push origin feature/amazing-pattern`)
5. Open a Pull Request

자세한 내용은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참조하세요.

## 📋 템플릿 커스터마이징

### 새로운 패턴 추가
```bash
# 새 패턴 파일 생성
templates/examples/_patterns/your-pattern.md
```

### 프로젝트별 규칙 추가
`templates/CLAUDE.md`의 "프로젝트별 규칙" 섹션에 추가

### 새로운 PRP 템플릿 추가
```bash
templates/PRPs/templates/prp_your_type.md
```

## 🔄 템플릿 관리

### 템플릿 동기화 도구

`sync-templates.sh`를 사용하여 템플릿의 품질 관리와 기존 프로젝트 동기화를 수행할 수 있습니다.

#### 사용 가능한 명령어

```bash
# 템플릿 파일 검증
./sync-templates.sh validate

# 모든 템플릿 파일 목록 확인
./sync-templates.sh list

# 프로젝트와 템플릿 간 차이 분석
./sync-templates.sh diff my-project

# 기존 프로젝트의 템플릿 업데이트
./sync-templates.sh update my-project
```

#### 주요 기능

- **검증 (validate)**: JSON 문법 검사, 필수 파일 확인, 빈 Markdown 파일 감지
- **목록 (list)**: 카테고리별 템플릿 파일 목록 (Claude 설정, PRP 템플릿, 문서, 예시 등)
- **차이 분석 (diff)**: 템플릿과 프로젝트 간 수정/추가된 파일 감지
- **업데이트 (update)**: 안전한 백업 후 선택적 템플릿 업데이트

#### 업데이트 시 주의사항

- 업데이트 전 자동 백업 생성 (`.template-backup-[타임스탬프]`)
- Claude 명령어, PRP 템플릿, 예시 패턴은 자동 업데이트
- 문서 템플릿은 사용자 확인 후 선택적 업데이트
- 기존 프로젝트 파일은 보존

## 🔧 문제 해결

일반적인 문제와 해결 방법은 `docs/TROUBLESHOOTING.md`를 참조하세요.

### 자주 묻는 질문

**Q: Claude Code가 명령어를 인식하지 못해요**
- A: `.claude/settings.json` 파일이 올바른 위치에 있는지 확인하세요 (`.local` 아님!)

**Q: 템플릿을 수정했는데 반영되지 않아요**
- A: `setup-claude-code.sh`를 다시 실행하거나 수동으로 파일을 복사하세요

## 📚 리소스

- [Claude Code 문서](https://docs.anthropic.com/claude-code)
- [Context Engineering 가이드](docs/CONTEXT_ENGINEERING.md)
- [베스트 프랙티스](docs/BEST_PRACTICES.md)

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 🙏 감사의 말

이 프로젝트는 Claude Code 커뮤니티의 피드백과 기여로 발전하고 있습니다.

## ☕ 프로젝트 지원

이 템플릿이 여러분의 개발 워크플로우 개선에 도움이 되었다면, 커피 한 잔으로 응원해 주세요!

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-☕-yellow.svg)](https://buymeacoffee.com/a1rtisan)

여러분의 지원은 더 나은 Context Engineering 도구와 템플릿 개발에 큰 동기가 됩니다. 🚀

---

Made with ❤️ for better AI collaboration