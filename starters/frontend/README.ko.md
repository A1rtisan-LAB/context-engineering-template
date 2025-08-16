# 프론트엔드 스타터 템플릿

23+ 전문 AI 에이전트와 SDLC 파이프라인 시스템을 갖춘 프론트엔드 애플리케이션용 Context Engineering 템플릿입니다.

## 🚀 프로젝트 구조

```
frontend-project/
├── src/
│   ├── components/      # React 컴포넌트
│   ├── pages/          # 페이지 컴포넌트
│   ├── styles/         # CSS/SCSS 파일
│   ├── hooks/          # 커스텀 React 훅
│   └── utils/          # 유틸리티 함수
├── public/             # 정적 자산
├── tests/              # 테스트 파일
├── docs/               # SDLC 가이드를 포함한 문서
├── .claude/            # Claude Code 설정
├── package.json        # Node.js 의존성
└── index.html         # 메인 HTML 파일
```

## 📊 SDLC 파이프라인 시스템

### 빠른 시작
```bash
# 프론트엔드 프로젝트용 SDLC 파이프라인 초기화
/sdlc "ui-feature" --init --template=agile

# 파이프라인 상태 확인
/sdlc "ui-feature" --status

# 진행 보고서 생성
/support:sdlc-report "ui-feature"
```

### 프론트엔드 개발 워크플로우
```bash
# 1단계: 계획 (스프린트 1, 1-2일차)
/sdlc "ui-feature" --phase=planning
/support:estimate component-development

# 2단계: 설계 (스프린트 1, 3-5일차)
/sdlc "ui-feature" --phase=design
/implement:feature ui-mockups
/analyze:architecture component-structure

# 3단계: 구현 (스프린트 1-2)
/sdlc "ui-feature" --phase=implementation
/implement:feature react-components
/implement:enhancement accessibility
/implement:feature responsive-design

# 4단계: 검토 (스프린트 2, 11일차)
/sdlc "ui-feature" --phase=review
/analyze:code-quality components
/analyze:performance rendering

# 5단계: 테스트 (스프린트 2, 12-13일차)
/sdlc "ui-feature" --phase=testing
/manage:test component-tests
/manage:test e2e-tests

# 6단계: 배포 (스프린트 2, 14일차)
/sdlc "ui-feature" --phase=deployment
/manage:build production
/analyze:performance bundle-size

# 7단계: 문서화 (스프린트 2, 14일차)
/sdlc "ui-feature" --phase=documentation
/support:document component-library
```

## 🛠️ 기능

- 현대적인 React 애플리케이션
- 컴포넌트 기반 아키텍처
- 상태 관리를 위한 커스텀 훅
- Styled components/CSS 모듈
- 빌드 최적화
- 핫 리로드가 있는 개발 서버
- 반응형 디자인
- 접근성 준수
- 성능 최적화
- 테스팅 프레임워크 통합

## 🚀 시작하기

1. 의존성 설치:
   ```bash
   npm install
   ```

2. SDLC 파이프라인 초기화 (선택사항):
   ```bash
   /sdlc "my-ui" --init --template=agile
   ```

3. 개발 서버 시작:
   ```bash
   npm start
   ```

4. 프로덕션 빌드:
   ```bash
   npm run build
   ```

## 🤖 Claude Code 명령어

### 분석 명령어
- `/analyze:code-quality` - 코드 품질 분석
- `/analyze:performance` - 성능 최적화
- `/analyze:architecture` - 컴포넌트 아키텍처 검토
- `/analyze:security` - 보안 감사

### 구현 명령어
- `/implement:feature` - 새로운 컴포넌트 추가
- `/implement:enhancement` - 기존 코드 개선
- `/implement:cleanup` - 코드 리팩토링

### 관리 명령어
- `/manage:test` - 테스트 스위트 실행
- `/manage:build` - 프로덕션 빌드
- `/manage:git` - 버전 관리
- `/manage:workflow` - CI/CD 파이프라인

### 지원 명령어
- `/support:document` - 문서 생성
- `/support:estimate` - 개발 시간 추정
- `/support:diagnose` - 문제 해결
- `/support:sdlc-report` - SDLC 진행 보고서

## 📚 문서

- [SDLC 파이프라인 가이드](docs/SDLC_GUIDE.ko.md) ([English](docs/SDLC_GUIDE.md))
- [컴포넌트 가이드라인](docs/COMPONENTS.md)
- [성능 최적화](docs/PERFORMANCE.md)
- [테스팅 전략](docs/TESTING.md)

## 🌏 언어

이 문서는 다음 언어로도 제공됩니다:
- [English](README.md)