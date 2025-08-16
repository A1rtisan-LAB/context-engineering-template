# SDLC 파이프라인 예제: 전자상거래 체크아웃 기능

## 🎯 기능 사양
SDLC 파이프라인을 사용한 완전한 체크아웃 시스템 구현

### 비즈니스 요구사항
- 장바구니 관리
- 결제 처리 (다중 결제 방법)
- 주문 확인 및 알림
- 재고 관리 시스템 통합

## 📊 SDLC 파이프라인 초기화

### 1단계: 파이프라인 초기화
```bash
/sdlc "checkout-feature" --init --template=standard
```

### 2단계: 계획 단계 (1-2일차)
```bash
/sdlc "checkout-feature" --phase=planning

# 활동:
- 요구사항 수집
- 사용자 스토리 생성
- 작업 분해
- /support:estimate를 통한 시간 추정
```

### 3단계: 설계 단계 (3-5일차)
```bash
/sdlc "checkout-feature" --phase=design

# 산출물:
- 시스템 아키텍처
- API 사양
- 데이터베이스 스키마
- UI/UX 목업
```

### 4단계: 구현 단계 (6-10일차)
```bash
/sdlc "checkout-feature" --phase=implementation

# 전문 에이전트 사용:
/implement:feature checkout-cart
/implement:feature payment-gateway
/implement:feature order-processing
```

### 5단계: 리뷰 단계 (11일차)
```bash
/sdlc "checkout-feature" --phase=review

# 품질 검사:
/analyze:code-quality .
/analyze:security .
/analyze:architecture .
```

### 6단계: 테스트 단계 (12-13일차)
```bash
/sdlc "checkout-feature" --phase=testing

# 테스트 실행:
/manage:test unit-tests
/manage:test integration-tests
/manage:test e2e-tests
```

### 7단계: 배포 단계 (14일차)
```bash
/sdlc "checkout-feature" --phase=deployment

# 배포 단계:
/manage:build production
/manage:workflow deployment-pipeline
```

### 8단계: 문서화 단계 (15일차)
```bash
/sdlc "checkout-feature" --phase=documentation

# 문서 생성:
/support:document api-reference
/support:document user-guide
```

## 📈 파이프라인 모니터링

### 상태 확인
```bash
/sdlc "checkout-feature" --status
```

### 보고서 생성
```bash
/support:sdlc-report "checkout-feature"
```

## 🎨 대체 템플릿

### 애자일 스프린트
```bash
/sdlc "mobile-app" --init --template=agile
```

### 긴급 핫픽스
```bash
/sdlc "critical-bug-fix" --init --template=hotfix
```

## 📚 추가 자료
- [SDLC 파이프라인 가이드](docs/SDLC_GUIDE.ko.md)
- [명령어 레퍼런스](.claude/commands/)
- [에이전트 문서](.claude/agents/)