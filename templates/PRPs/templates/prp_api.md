# [API Name] API Implementation

## OVERVIEW
Global rules: CLAUDE.md의 모든 규칙을 따를 것

[API의 목적과 주요 기능 설명]

## API SPECIFICATIONS
- Base URL: /api/v1/[resource]
- Authentication: [JWT/API Key/OAuth]
- Content-Type: application/json
- Rate Limiting: [요청 제한 정책]

## ENDPOINTS
### 1. GET /[resource]
- Purpose: [목적]
- Query Parameters: [파라미터]
- Response: [응답 형식]

### 2. POST /[resource]
- Purpose: [목적]
- Request Body: [요청 본문]
- Response: [응답 형식]

[추가 엔드포인트...]

## ERROR HANDLING
- 400: Bad Request - 잘못된 요청 형식
- 401: Unauthorized - 인증 실패
- 403: Forbidden - 권한 없음
- 404: Not Found - 리소스 없음
- 429: Too Many Requests - 요청 제한 초과
- 500: Internal Server Error - 서버 오류

## IMPLEMENTATION STEPS
[API 특화 구현 단계]

## TESTING STRATEGY
- 단위 테스트: 각 핸들러 함수
- 통합 테스트: 전체 요청/응답 흐름
- 부하 테스트: 성능 및 동시성
- 보안 테스트: 인증/인가

[나머지 섹션은 base 템플릿과 동일]