# PROJECT_NAME

[프로젝트 설명]

## 프로젝트 구조

```
PROJECT_NAME/
├── .claude/              # Claude Code 설정
├── PRPs/                 # Product Requirements Prompts
├── examples/             # 코드 예시 및 패턴
├── docs/                 # 프로젝트 문서
├── src/                  # 소스 코드
├── tests/                # 테스트 코드
└── README.md            # 이 파일
```

## 시작하기

### 필수 요구사항
- [필수 소프트웨어/도구]
- Claude Code 확장 프로그램

### 설치
```bash
# 의존성 설치
[설치 명령어]
```

### 환경 설정
```bash
# .env 파일 생성
cp .env.example .env

# 환경 변수 설정
[설정 방법]
```

## Claude Code 사용법

### Context Engineering 워크플로우
1. `INITIAL.md`에 기능 요청 작성
2. Claude Code에서 `/generate-prp INITIAL.md` 실행
3. 생성된 PRP 검토 (PRPs/[feature-name].md)
4. `/execute-prp PRPs/[feature-name].md` 실행
5. `/test-all`로 테스트 실행
6. `/check-quality`로 품질 검사

### 사용 가능한 명령어
- `/generate-prp [INITIAL 파일]` - PRP 생성
- `/execute-prp [PRP 파일]` - 기능 구현
- `/test-all` - 모든 테스트 실행
- `/check-quality` - 코드 품질 검사

## 개발 가이드

### 코드 스타일
[프로젝트의 코드 스타일 가이드]

### 테스트
```bash
[테스트 실행 명령어]
```

### 문서화
- 모든 함수에 docstring/JSDoc 추가
- 복잡한 로직에 주석 추가
- README 항상 최신화

## 기여하기
[기여 가이드라인]

## 라이선스
[라이선스 정보]