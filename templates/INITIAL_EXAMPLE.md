## FEATURE:
비동기 이메일 알림 시스템 구현
- Gmail API를 사용한 이메일 발송
- Brave Search API를 사용한 수신자 정보 검색
- Pydantic을 사용한 데이터 검증
- 재시도 로직과 에러 핸들링 포함
- CLI 인터페이스 제공

## EXAMPLES:
examples/ 폴더의 파일들:
- `examples/api/client.py` - API 클라이언트 구현 패턴 참고
- `examples/architecture/agent/` - 에이전트 아키텍처 패턴 참고
- `examples/tests/` - 테스트 작성 패턴 참고
- `examples/_patterns/error-handling.md` - 에러 처리 패턴 참고

이 예시들을 직접 복사하지 말고, 베스트 프랙티스를 위한 영감으로 사용하세요.

## DOCUMENTATION:
- Gmail API: https://developers.google.com/gmail/api
- Brave Search API: https://brave.com/search/api/
- Pydantic 문서: https://docs.pydantic.dev/
- Python asyncio: https://docs.python.org/3/library/asyncio.html

## OTHER CONSIDERATIONS:
- .env.example 파일 포함
- 설정 방법을 포함한 README 작성
- 프로젝트 구조를 README에 포함
- 환경 변수는 python-dotenv 사용
- 비동기 처리를 위해 asyncio 사용
- API 키는 절대 하드코딩하지 않음
- 속도 제한 고려 (Gmail API는 분당 250 요청)