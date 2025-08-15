# Contributing to Context Engineering Template

먼저, 이 프로젝트에 기여하는 것을 고려해 주셔서 감사합니다! 🎉

## 행동 강령

이 프로젝트는 모든 참여자가 존중받고 환영받는 환경을 만들기 위해 노력합니다. 기여자는 다음을 준수해야 합니다:
- 건설적이고 친절한 피드백 제공
- 다양한 관점과 경험 존중
- 우아하게 비판 수용
- 커뮤니티의 최선을 위한 집중

## 기여 방법

### 🐛 버그 리포트

버그를 발견하셨나요? GitHub Issues를 통해 알려주세요:

1. **기존 이슈 확인**: 동일한 문제가 이미 보고되었는지 확인
2. **새 이슈 생성**: 명확한 제목과 상세한 설명 포함
3. **정보 제공**:
   - 운영체제 및 버전
   - 재현 단계
   - 예상 동작 vs 실제 동작
   - 가능하다면 스크린샷이나 로그

### 💡 기능 제안

새로운 아이디어가 있으신가요?

1. **이슈 생성**: `enhancement` 라벨 사용
2. **설명 포함**:
   - 해결하고자 하는 문제
   - 제안하는 해결책
   - 대안 고려사항

### 🔧 Pull Request

#### 준비 사항

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
   cd context-engineering-template
   ```

3. 새 브랜치 생성:
   ```bash
   git checkout -b feature/your-feature-name
   ```

#### 개발 가이드라인

##### 템플릿 수정 시

1. **파일 위치**: 모든 템플릿은 `templates/` 디렉토리에 위치
2. **테스트**: 수정 후 `setup-claude-code.sh` 실행하여 검증
3. **문서화**: 새로운 기능은 적절한 문서 포함

##### 코드 스타일

**Markdown 파일**:
- 제목은 `#`로 시작 (공백 포함)
- 코드 블록은 언어 명시
- 링크는 상대 경로 사용 (가능한 경우)

**Shell Scripts**:
- ShellCheck 통과 필수
- 의미 있는 변수명 사용
- 에러 처리 포함

**JSON 파일**:
- 유효한 JSON 문법
- 2칸 들여쓰기
- 후행 쉼표 없음

#### 커밋 메시지

```
<type>: <subject>

<body>

<footer>
```

**Types**:
- `feat`: 새로운 기능
- `fix`: 버그 수정
- `docs`: 문서 변경
- `style`: 코드 스타일 변경
- `refactor`: 리팩토링
- `test`: 테스트 추가/수정
- `chore`: 기타 변경사항

**예시**:
```
feat: API 프로젝트를 위한 새로운 PRP 템플릿 추가

- prp_api.md 템플릿 생성
- API 특화 섹션 포함
- 예시 엔드포인트 문서화
```

#### PR 체크리스트

- [ ] 코드가 프로젝트 스타일 가이드를 따름
- [ ] 자가 리뷰 완료
- [ ] 문서 업데이트 (필요한 경우)
- [ ] 테스트 추가/업데이트
- [ ] GitHub Actions 모든 체크 통과

### 📚 문서 기여

문서 개선은 언제나 환영합니다:

- 오타 수정
- 명확성 개선
- 예시 추가
- 번역

### 🧪 테스트

새로운 기능 추가 시:

1. **수동 테스트**:
   ```bash
   ./setup-claude-code.sh test-project
   cd test-project
   # 새 기능 검증
   ```

2. **자동화 테스트**:
   - GitHub Actions 워크플로우 확인
   - 필요시 새로운 테스트 케이스 추가

## 릴리스 프로세스

1. **버전 태깅**: Semantic Versioning 사용
   - MAJOR: 호환되지 않는 변경
   - MINOR: 새로운 기능 (하위 호환)
   - PATCH: 버그 수정

2. **변경 로그**: CHANGELOG.md 업데이트

## 도움 받기

- **Discord**: [커뮤니티 서버 링크]
- **GitHub Discussions**: 질문과 아이디어 공유
- **이메일**: maintainer@example.com

## 인정

기여자는 다음에 추가됩니다:
- README.md의 Contributors 섹션
- 릴리스 노트

## 라이선스

기여하신 내용은 프로젝트와 동일한 [MIT 라이선스](LICENSE)로 배포됩니다.

---

감사합니다! 🙏 여러분의 기여가 이 프로젝트를 더 좋게 만듭니다.