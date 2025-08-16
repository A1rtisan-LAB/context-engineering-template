# 마이그레이션 가이드

## v3.0.1로 마이그레이션 - 디렉토리 구조 수정

### 개요

버전 3.0.1은 생성된 프로젝트에서 원하지 않는 `src/` 하위 디렉토리가 있는 잘못된 `.claude/` 디렉토리 구조 문제를 수정합니다.

### 변경 사항

**이전 (v3.0.0 - 잘못됨):**
```
my-project/.claude/
├── agents/
│   └── src/ -> 모노레포로의 심링크
├── commands/
│   └── src/ -> 모노레포로의 심링크
└── workflows/
    └── src/ -> 모노레포로의 심링크
```

**이후 (v3.0.1 - 올바름):**
```
my-project/.claude/
├── agents/
│   ├── agent-prompt-reviewer.md
│   ├── architecture-analyzer.md
│   └── ... (파일이 여기에 직접)
├── commands/
│   ├── orchestrate.md
│   ├── analyze/
│   └── ... (파일이 여기에 직접)
└── workflows/
    ├── development-lifecycle.md
    └── ... (파일이 여기에 직접)
```

### 기존 프로젝트 수정 방법

v3.0.0으로 프로젝트를 생성하여 잘못된 구조를 가지고 있다면:

1. **이전 .claude 디렉토리 제거:**
```bash
rm -rf .claude
```

2. **프로젝트 구조 재생성:**
```bash
# 템플릿 저장소에서
node cli/claude-init.js temp-project basic /tmp
cp -r /tmp/temp-project/.claude .
rm -rf /tmp/temp-project
```

3. **또는 수동으로 파일 복사:**
```bash
# 에이전트 파일 복사
cp path/to/template/packages/@claude-code/agents/src/*.md .claude/agents/
# 명령 파일 복사 (구조 유지)
cp -r path/to/template/packages/@claude-code/commands/src/* .claude/commands/
# 워크플로우 파일 복사
cp path/to/template/packages/@claude-code/workflows/src/*.md .claude/workflows/
```

## v2.x에서 v3.0 (모노레포)로 마이그레이션

### 개요

버전 3.0은 이중 컨텍스트 아키텍처에서 현대적인 모노레포 구조로의 주요 재구성을 도입합니다. 이 가이드는 기존 프로젝트를 마이그레이션하는 데 도움을 줍니다.

## 주요 변경사항

### 1. 디렉토리 구조

**이전 (v2.x):**
```
context-engineering-template/
├── templates/
│   └── .claude/
├── .claude/
├── lib/
└── setup-claude-code.sh
```

**이후 (v3.0):**
```
context-engineering-template/
├── packages/
│   └── @claude-code/
│       ├── agents/
│       ├── commands/
│       ├── workflows/
│       └── core/
├── starters/
├── cli/
└── package.json
```

### 2. CLI 변경사항

**이전:**
```bash
./setup-claude-code.sh project-name project-type path
```

**이후:**
```bash
node cli/claude-init.js project-name project-type path
```

### 3. 성능 개선

- async/await로 **40-50% 더 빠른** 프로젝트 생성
- 파일 복사 및 처리를 위한 **병렬 작업**
- 동기 작업 대신 프로미스를 사용한 **최적화된 I/O**

## 마이그레이션 단계

### 1단계: 프로젝트 백업

```bash
cp -r your-project your-project-backup
```

### 2단계: 새 버전 설치

```bash
git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
cd context-engineering-template
npm install
```

### 3단계: 설정 마이그레이션

#### 3.1 .claude 디렉토리 업데이트

기존 `.claude` 디렉토리 구조는 대부분 동일하게 유지되지만 다음을 업데이트할 수 있습니다:

1. **에이전트 정의**: `packages/@claude-code/agents/`에서 새 에이전트 확인
2. **명령어**: `packages/@claude-code/commands/`에서 새 명령어 검토
3. **워크플로우**: `packages/@claude-code/workflows/`에서 워크플로우 업데이트

#### 3.2 package.json 업데이트

모노레포 기능을 사용하는 경우 워크스페이스 구성 추가:

```json
{
  "workspaces": [
    "packages/@claude-code/*"
  ]
}
```

### 4단계: 스크립트 업데이트

이전 셸 스크립트를 새 npm 스크립트로 교체:

**이전:**
```bash
./sync-templates.sh validate
```

**이후:**
```bash
npm run validate
```

### 5단계: 테스트

모든 것이 작동하는지 확인하기 위해 테스트 스위트 실행:

```bash
npm test
npm run benchmark
```

## 호환성을 깨는 변경사항

### 1. 템플릿 동기화 도구 제거

`sync-templates.sh` 도구가 npm 워크스페이스 명령으로 대체되었습니다.

**마이그레이션:**
- `./sync-templates.sh validate` 대신 `npm run validate` 사용
- 패키지 업데이트에는 `npm run update` 사용

### 2. 이중 컨텍스트 아키텍처 제거

개발 컨텍스트와 출력 템플릿 간의 분리가 제거되었습니다.

**마이그레이션:**
- 모든 템플릿은 이제 `starters/` 디렉토리에 있음
- 개발은 모노레포 패키지에서 직접 진행

### 3. 생성기 스크립트 변경

`generator.sh` 스크립트가 단순화되고 이동되었습니다.

**마이그레이션:**
- 생성기에 의존하는 사용자 정의 스크립트 업데이트
- 새 위치: `packages/@claude-code/core/src/generator.sh`

## v3.0의 새로운 기능

### 1. Jest 테스팅 프레임워크

```bash
npm test              # 테스트 실행
npm run test:coverage # 커버리지와 함께
npm run test:watch    # 감시 모드
```

### 2. 성능 벤치마킹

```bash
npm run benchmark     # 성능 테스트 실행
```

### 3. Async/Await CLI

더 나은 성능을 위해 모든 파일 작업이 이제 비동기입니다.

### 4. 이중 언어 문서

모든 문서에 이제 한국어 번역(`.ko.md` 파일)이 포함됩니다.

## 일반적인 마이그레이션 문제

### 문제: "Command not found" 오류

**해결책:** PATH를 업데이트하거나 셸 스크립트 대신 npm 스크립트 사용.

### 문제: templates 디렉토리 누락

**해결책:** 템플릿은 이제 `starters/` 디렉토리에 있습니다.

### 문제: 동기화 명령이 작동하지 않음

**해결책:** 대신 npm 워크스페이스 명령 사용:
```bash
npm run validate --workspaces
npm run build --workspaces
```

### 문제: 이전 프로젝트 구조 호환되지 않음

**해결책:** v3.0으로 새 프로젝트를 생성하고 코드를 마이그레이션:
```bash
node cli/claude-init.js new-project
cp -r old-project/src new-project/
```

## 롤백 계획

v2.x로 롤백해야 하는 경우:

```bash
git checkout v2.0.0
./setup-claude-code.sh your-project
```

## 도움 받기

- [GitHub 이슈](https://github.com/A1rtisan-LAB/context-engineering-template/issues)
- [Discord 커뮤니티](#)
- [문서](https://docs.anthropic.com/claude-code)

## 버전 호환성

| 버전 | Node.js | npm | 상태 |
|------|---------|-----|------|
| v3.0+ | ≥16.0.0 | ≥8.0.0 | 현재 |
| v2.x | ≥14.0.0 | ≥6.0.0 | 유지보수 |
| v1.x | ≥12.0.0 | ≥6.0.0 | 지원 중단 |

## 지원 중단 일정

- **v2.x**: 2025-01-01까지 유지보수 모드
- **v1.x**: 더 이상 지원되지 않음

## 다음 단계

마이그레이션 후:

1. [QUICKSTART](QUICKSTART.ko.md) 가이드 검토
2. 새로운 [API 기능](API.ko.md) 탐색
3. [개선 계획](IMPROVEMENT_PLAN.ko.md) 확인
4. 프로젝트에 기여하기!

---

v3.0으로 업그레이드해 주셔서 감사합니다! 🚀