# Context Engineering Template for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

> 🚀 Claude Code를 위한 Context Engineering 프로젝트 템플릿 - AI와의 효율적인 협업을 위한 구조화된 접근 방식

## 🎯 소개

이 템플릿은 Claude Code와 함께 사용하기 위해 설계된 Context Engineering 프레임워크입니다. AI 어시스턴트가 프로젝트의 전체 맥락을 이해하고 일관된 코드를 생성할 수 있도록 돕습니다.

### 주요 특징

- 📋 **PRP (Product Requirements Prompt)**: AI를 위한 상세한 구현 청사진
- 🤖 **Claude Code 통합**: 커스텀 명령어로 워크플로우 자동화
- 📚 **패턴 라이브러리**: 재사용 가능한 코드 패턴과 베스트 프랙티스
- 🔄 **단일 진실의 원천**: 템플릿 중복 없이 효율적인 관리

## 🚀 빠른 시작

### 1. 저장소 클론
```bash
git clone https://github.com/yourusername/context-engineering-template.git
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
│   ├── settings.json        # 커스텀 명령어 정의
│   └── commands/            # 명령어 구현
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

생성된 프로젝트에서 사용 가능한 명령어:

| 명령어 | 설명 |
|--------|------|
| `/generate-prp [파일]` | INITIAL.md에서 상세한 PRP 생성 |
| `/execute-prp [파일]` | PRP를 기반으로 기능 구현 |
| `/test-all` | 모든 테스트 실행 및 결과 보고 |
| `/check-quality` | 코드 품질 종합 검사 |

## 📝 워크플로우

1. **요구사항 작성**: `INITIAL.md`에 구현하고자 하는 기능 설명
2. **PRP 생성**: Claude Code에서 `/generate-prp INITIAL.md` 실행
3. **검토 및 수정**: 생성된 PRP 검토 후 필요시 수정
4. **구현**: `/execute-prp PRPs/[feature].md` 실행
5. **검증**: `/test-all`과 `/check-quality`로 품질 확인

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

---

Made with ❤️ for better AI collaboration