# [Feature Name] Implementation

## OVERVIEW
Global rules: CLAUDE.md의 모든 규칙을 따를 것

[구현해야 할 내용에 대한 명확하고 구체적인 설명]

## MUST READ
### 포함해야 할 컨텍스트
- url: [공식 API 문서 URL]
  why: [필요한 특정 섹션/메소드]
- file: [path/to/example.py]
  why: [따라야 할 패턴, 피해야 할 실수]
- doc: [라이브러리 문서 URL]
  section: [특정 섹션]
  critical: [핵심 인사이트]
- docfile: [PRPs/ai_docs/file.md]
  why: [프로젝트에 추가된 문서]

## CRITICAL NOTES
[라이브러리별 특별한 설정이나 제한사항]
예시:
- FastAPI는 엔드포인트에 async 함수 필요
- 이 ORM은 1000개 이상의 배치 삽입 미지원
- 특정 라이브러리 버전 요구사항

## IMPLEMENTATION STEPS

### 1. 프로젝트 구조 설정
- 필요한 디렉토리 생성
- 설정 파일 초기화
- 의존성 확인

### 2. 데이터 모델 생성
타입 안전성과 일관성 보장:
- ORM 모델
- Pydantic 스키마
- 검증 로직

### 3. 핵심 비즈니스 로직 구현
- [구체적인 구현 내용]

### 4. API/인터페이스 구현
- [엔드포인트/CLI/GUI 등]

### 5. 테스트 작성
- 단위 테스트
- 통합 테스트
- E2E 테스트 (필요시)

### 6. 문서화
- README 업데이트
- API 문서
- 사용 예시

## VALIDATION GATES
각 단계 후 반드시 검증:
- [ ] 코드가 실행되는가?
- [ ] 테스트가 통과하는가?
- [ ] 린팅이 통과하는가?
- [ ] 타입 체크가 통과하는가?
- [ ] 문서가 업데이트되었는가?

## SUCCESS CRITERIA
- [ ] 모든 기능 요구사항 충족
- [ ] 테스트 커버리지 80% 이상
- [ ] 성능 요구사항 충족
- [ ] 에러 핸들링 완료
- [ ] 문서화 완료
- [ ] 코드 리뷰 체크리스트 통과

## CONFIDENCE SCORE: [1-10]
[점수에 대한 설명과 개선 가능한 부분]