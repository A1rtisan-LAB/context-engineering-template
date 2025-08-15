# 기여 가이드

Context Engineering Template 프로젝트에 기여해 주셔서 감사합니다! 이 문서는 프로젝트에 기여하는 방법을 안내합니다.

## 📋 목차

- [행동 강령](#행동-강령)
- [기여 방법](#기여-방법)
- [개발 환경 설정](#개발-환경-설정)
- [코딩 표준](#코딩-표준)
- [문서 가이드라인](#문서-가이드라인)
- [풀 리퀘스트 프로세스](#풀-리퀘스트-프로세스)
- [이슈 보고](#이슈-보고)

## 행동 강령

이 프로젝트는 모든 기여자가 존중받고 환영받는 환경을 유지하기 위해 노력합니다. 모든 참여자는 다음을 준수해야 합니다:

- 서로를 존중하고 건설적인 피드백 제공
- 다양성과 포용성 존중
- 전문적이고 협력적인 태도 유지

## 기여 방법

### 1. 새로운 에이전트 추가

```bash
# 새 에이전트 패키지 생성
mkdir -p packages/@claude-code/agents/src
touch packages/@claude-code/agents/src/your-agent.md

# README 업데이트 (영어 + 한국어)
# packages/@claude-code/agents/README.md
# packages/@claude-code/agents/README.ko.md
```

### 2. 새로운 커맨드 추가

```bash
# 적절한 카테고리에 커맨드 추가
mkdir -p packages/@claude-code/commands/src/[category]
touch packages/@claude-code/commands/src/[category]/your-command.md
```

### 3. 문서 개선

모든 문서는 이중 언어(영어/한국어)로 작성되어야 합니다:
- 영어: `filename.md`
- 한국어: `filename.ko.md`

## 개발 환경 설정

### 필요 사항

- Node.js 16.0.0 이상
- npm 8.0.0 이상
- Git

### 설정 단계

```bash
# 1. 저장소 포크 및 클론
git clone https://github.com/your-username/context-engineering-template.git
cd context-engineering-template

# 2. 의존성 설치
npm install

# 3. 개발 브랜치 생성
git checkout -b feature/your-feature-name
```

## 코딩 표준

### 에이전트 작성 가이드

에이전트 파일은 다음 구조를 따라야 합니다:

```markdown
# agent: agent-name

## Role
에이전트의 역할과 목적을 명확히 설명

## Capabilities
- 주요 기능 1
- 주요 기능 2
- 주요 기능 3

## Instructions
상세한 작업 지침
```

### 커맨드 작성 가이드

```markdown
# command: command-name

## Description
커맨드의 목적과 사용 시나리오

## Usage
`/command-name [parameters]`

## Parameters
- parameter1: 설명
- parameter2: 설명

## Examples
실제 사용 예제
```

## 문서 가이드라인

**중요**: 모든 문서는 [CLAUDE.md의 Documentation Guidelines](CLAUDE.md#documentation-guidelines)를 따라야 합니다.

### 이중 언어 문서 작성

1. **파일 명명 규칙**:
   - 영어: `README.md`
   - 한국어: `README.ko.md`

2. **번역 표준**:
   - 기술 용어는 영문 병기: "모노레포(monorepo)"
   - 코드 예제는 주석만 번역
   - 자연스럽고 명확한 번역

3. **동기화 유지**:
   - 영문 버전 수정 시 한국어 버전도 업데이트
   - 커밋 메시지에 언어 버전 명시

## 풀 리퀘스트 프로세스

### 1. PR 전 체크리스트

- [ ] 코드가 프로젝트 스타일 가이드를 따름
- [ ] 모든 테스트 통과 (`npm test --workspaces`)
- [ ] 문서가 이중 언어로 작성됨
- [ ] 커밋 메시지가 명확함

### 2. PR 템플릿

```markdown
## 변경 사항
변경 내용에 대한 간단한 설명

## 변경 유형
- [ ] 버그 수정
- [ ] 새 기능
- [ ] 문서 개선
- [ ] 성능 개선

## 테스트
어떻게 테스트했는지 설명

## 체크리스트
- [ ] 코드 스타일 가이드 준수
- [ ] 테스트 추가/업데이트
- [ ] 문서 업데이트 (영어/한국어)
```

### 3. 커밋 메시지 형식

```
type(scope): 간단한 설명

상세 설명 (선택사항)

Closes #이슈번호
```

타입:
- `feat`: 새 기능
- `fix`: 버그 수정
- `docs`: 문서 변경
- `style`: 코드 스타일 변경
- `refactor`: 리팩토링
- `test`: 테스트 추가/수정
- `chore`: 빌드 프로세스나 도구 변경

## 이슈 보고

### 버그 리포트

버그를 발견하면 다음 정보를 포함하여 이슈를 생성해 주세요:

1. **버그 설명**: 명확하고 간결한 설명
2. **재현 단계**: 버그를 재현하는 단계
3. **예상 동작**: 예상했던 동작
4. **실제 동작**: 실제로 발생한 동작
5. **스크린샷**: 가능한 경우
6. **환경 정보**:
   - OS 및 버전
   - Node.js 버전
   - npm 버전

### 기능 요청

새로운 기능을 제안하려면:

1. **기능 설명**: 제안하는 기능의 명확한 설명
2. **사용 사례**: 이 기능이 필요한 이유와 시나리오
3. **대안**: 고려한 다른 대안들
4. **추가 컨텍스트**: 관련 스크린샷이나 참고 자료

## 질문하기

질문이 있으시면:

1. 먼저 [문서](docs/)를 확인해 주세요
2. [기존 이슈](https://github.com/A1rtisan-LAB/context-engineering-template/issues)를 검색해 보세요
3. 그래도 답을 찾을 수 없다면 새 이슈를 생성하거나 디스커션을 시작하세요

## 라이선스

기여하신 내용은 프로젝트와 동일한 [MIT 라이선스](LICENSE)를 따릅니다.

## 감사의 말

모든 기여자분들께 감사드립니다! 여러분의 기여가 이 프로젝트를 더 나은 도구로 만듭니다.

## 🌏 언어

이 문서는 다음 언어로도 제공됩니다:
- [English](CONTRIBUTING.md)