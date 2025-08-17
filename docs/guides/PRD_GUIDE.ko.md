---
title: PRD (제품 요구사항 문서) 가이드
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: guides
tags: [prd, requirements, documentation, planning]
language: ko
---

# PRD (제품 요구사항 문서) 가이드

## 목차
1. [개요](#개요)
2. [PRD 우선 개발의 필요성](#prd-우선-개발의-필요성)
3. [PRD 라이프사이클](#prd-라이프사이클)
4. [첫 PRD 작성하기](#첫-prd-작성하기)
5. [PRD 템플릿](#prd-템플릿)
6. [PRD 명령어](#prd-명령어)
7. [언어 지원](#언어-지원)
8. [SDLC 통합](#sdlc-통합)
9. [모범 사례](#모범-사례)
10. [문제 해결](#문제-해결)

## 개요

PRD(Product Requirements Document) 시스템은 개발 시작 전에 기능 요구사항을 정의, 검토, 관리하는 체계적인 접근 방식을 제공합니다. 명확한 커뮤니케이션을 보장하고, 개발 재작업을 줄이며, 비즈니스 요구와 기술 구현 간의 정렬을 유지합니다.

### 핵심 이점
- **명확한 요구사항**: 코딩 시작 전에 무엇을 만들어야 하는지 정의
- **품질 게이트**: 검토 및 승인 프로세스로 완성도 보장
- **자동 번역**: 한국어 PRD는 자동으로 영어로 번역
- **SDLC 통합**: 승인된 PRD는 자동으로 개발 파이프라인 시작
- **문서화 추적**: 아이디어에서 구현까지 완전한 이력

## PRD 우선 개발의 필요성

### 기존 접근법의 문제점
- 불명확한 요구사항으로 인한 재작업
- 개발 중 범위 변경
- 이해관계자 간 불일치
- 비기능 요구사항 누락
- 부적절한 성공 지표

### PRD 우선 해결책
- **요구사항 명확성**: 모든 요구사항을 사전에 문서화
- **이해관계자 정렬**: 검토 프로세스로 합의 보장
- **범위 통제**: 명확한 경계 정의
- **성공 지표**: 측정 가능한 결과 명시
- **위험 완화**: 조기에 문제 식별

## PRD 라이프사이클

PRD는 명확한 상태 전환과 함께 구조화된 라이프사이클을 따릅니다:

```mermaid
graph LR
    초안[Draft/초안] --> 검토[Review/검토]
    검토 --> 승인[Approved/승인]
    검토 --> 초안
    승인 --> 개발중[In Development/개발중]
    개발중 --> 완료[Completed/완료]
    완료 --> 보관[Archived/보관]
```

### 상태 설명

| 상태 | 설명 | 다음 작업 |
|------|------|----------|
| **초안(Draft)** | PRD 작성 중 | 검토 제출 |
| **검토(Review)** | 품질 검토 중 | 승인 또는 수정 요청 |
| **승인(Approved)** | 개발 준비 완료 | SDLC 파이프라인 시작 |
| **개발중(In Development)** | 구현 진행 중 | 진행 상황 추적 |
| **완료(Completed)** | 개발 완료 | 보관 및 문서화 |
| **보관(Archived)** | 히스토리 기록 | 참조용 |

## 첫 PRD 작성하기

### 1단계: PRD 초기화
```bash
/manage:prd create "기능-이름" --template=api
```

적절한 템플릿을 사용하여 `docs/prd/draft/`에 새 PRD를 생성합니다.

### 2단계: 템플릿 작성
생성된 PRD 파일을 다음 내용으로 편집:
- 개요
- 문제 설명
- 목표 및 성공 지표
- 요구사항 (기능 및 비기능)
- 기술 사양
- 의존성 및 위험
- 일정 및 마일스톤

### 3단계: 검토 제출
```bash
/manage:prd move "기능-이름" --to=review
```

### 4단계: 검토 프로세스
```bash
/support:prd-review "기능-이름"
```

다음을 포함한 종합적인 검토 보고서 생성:
- 완성도 점수 (0-100)
- 명확성 평가
- 기술적 실현 가능성
- 위험 분석
- 필요한 개선 사항

### 5단계: 승인
```bash
/manage:prd approve "기능-이름"
```

이 작업은:
1. PRD를 `approved/` 디렉토리로 이동
2. 자동으로 SDLC 파이프라인 초기화
3. 요구사항에서 개발 작업 생성
4. 진행 상황 추적 설정

## PRD 템플릿

### 사용 가능한 템플릿

| 템플릿 | 사용 사례 | 주요 섹션 |
|--------|----------|-----------|
| **standard** | 일반 기능 | 모든 기능을 위한 기본 구조 |
| **api** | 백엔드 서비스 | 엔드포인트, 데이터 모델, 인증 |
| **frontend** | UI 기능 | UX 플로우, 컴포넌트, 상호작용 |
| **fullstack** | 전체 스택 기능 | 완전한 스택 사양 |

### 템플릿 선택
```bash
# 기본 기능
/manage:prd create "기능" --template=standard

# API 개발
/manage:prd create "api-기능" --template=api

# 프론트엔드 기능
/manage:prd create "ui-기능" --template=frontend

# 풀스택 기능
/manage:prd create "전체-기능" --template=fullstack
```

### 템플릿 구조
모든 템플릿 포함 내용:
- **개요**: 고수준 개요
- **문제 설명**: 해결하려는 문제
- **목표 및 지표**: 성공 기준
- **요구사항**: 상세 사양
- **기술 설계**: 구현 접근법
- **일정**: 개발 단계
- **위험**: 잠재적 문제와 완화 방안

## PRD 명령어

### 관리 명령어

#### PRD 생성
```bash
/manage:prd create "기능-이름" [옵션]
옵션:
  --template    템플릿 타입 (standard/api/frontend/fullstack)
```

#### 상태 확인
```bash
/manage:prd status "기능-이름"
```
현재 상태, 위치, 메타데이터를 표시합니다.

#### PRD 목록
```bash
/manage:prd list --status=draft      # 초안 PRD 목록
/manage:prd list --status=approved   # 승인된 PRD 목록
/manage:prd list --all               # 모든 PRD 목록
```

#### 상태 간 이동
```bash
/manage:prd move "기능-이름" --to=review
/manage:prd move "기능-이름" --to=approved
```

#### PRD 승인
```bash
/manage:prd approve "기능-이름"
```
PRD를 승인하고 SDLC 파이프라인을 트리거합니다.

#### PRD 보관
```bash
/manage:prd archive "기능-이름"
```
완료된 PRD를 타임스탬프와 함께 보관합니다.

### 검토 명령어

#### 종합 검토
```bash
/support:prd-review "기능-이름"
```
상세한 검토 보고서를 생성합니다.

#### 빠른 검토
```bash
/support:prd-review "기능-이름" --quick
```
중요한 항목만 빠르게 검증합니다.

#### 자동 수정
```bash
/support:prd-review "기능-이름" --auto-fix
```
형식 및 사소한 문제를 자동으로 수정합니다.

## 언어 지원

### 자동 번역
PRD 시스템은 한국어에서 영어로 자동 번역을 지원합니다:

1. **한국어로 작성**: 선호하는 경우 한국어로 PRD 작성
2. **자동 감지**: 시스템이 언어를 감지
3. **번역**: 한국어 내용이 영어로 번역
4. **보존**: 원본 한국어 버전 저장
5. **주 문서**: 영어 버전이 주 문서가 됨

### 작동 방식
```javascript
// PRD 저장 시
if (language === 'korean') {
  translateToEnglish(content);
  save('기능_original_ko.md');  // 한국어 원본
  save('기능.md');               // 영어 번역
}
```

### 번역 품질
- 기술 용어 보존
- 코드 예제 변경 없음
- 형식 유지
- 중요한 PRD는 수동 검토 권장

## SDLC 통합

### 자동 파이프라인 트리거
PRD 승인 시:
```bash
/manage:prd approve "기능-이름"
# 자동 실행:
# /sdlc "기능-이름" --init --from-prd
```

### PRD에서 작업으로 변환
요구사항이 자동으로 개발 작업으로 변환:
- 기능 요구사항 → 구현 작업
- 비기능 요구사항 → 품질 기준
- 성공 지표 → 테스트 시나리오
- 일정 → 스프린트 계획

### 진행 상황 추적
```bash
/manage:prd status "기능-이름"
```
표시 내용:
- 현재 SDLC 단계
- 완료 백분율
- 차단 요소 및 문제
- 예상 완료 시간

### 문서 업데이트
완료 시:
- PRD에서 릴리즈 노트 생성
- 사용자 가이드 업데이트
- API 문서 생성
- 메트릭과 함께 PRD 보관

## 모범 사례

### 효과적인 PRD 작성

#### 해야 할 일:
✅ **구체적으로**: 구체적이고 측정 가능한 요구사항 사용  
✅ **예제 포함**: 사용 사례와 시나리오 제공  
✅ **성공 정의**: 명확하고 측정 가능한 성공 지표  
✅ **엣지 케이스 고려**: 오류 시나리오 문서화  
✅ **NFR 명시**: 성능, 보안, 확장성  

#### 하지 말아야 할 일:
❌ **모호함**: "빠른", "사용자 친화적", "확장 가능한" 피하기  
❌ **섹션 생략**: 모든 섹션에는 목적이 있음  
❌ **구현 혼합**: 무엇과 어떻게를 분리  
❌ **의존성 무시**: 모든 의존성 문서화  
❌ **롤백 잊기**: 롤백 계획 포함  

### 검토 프로세스

#### 검토 체크리스트
- [ ] 모든 섹션 완성
- [ ] 요구사항이 SMART (구체적, 측정가능, 달성가능, 관련성, 시간제한)
- [ ] 성공 지표 정의됨
- [ ] 기술적 실현 가능성 확인
- [ ] 위험 식별 및 완화
- [ ] 의존성 문서화
- [ ] 현실적인 일정
- [ ] 명확한 승인 기준

### 점수 가이드라인

| 점수 범위 | 상태 | 조치 |
|-----------|------|------|
| 90-100 | 우수 | 승인 준비 완료 |
| 80-89 | 양호 | 사소한 개선 필요 |
| 70-79 | 보통 | 상당한 개선 필요 |
| 70 미만 | 미흡 | 주요 수정 필요 |

## 문제 해결

### 일반적인 문제

#### PRD를 찾을 수 없음
```bash
Error: PRD '기능-이름' not found
```
**해결책**: PRD 이름과 현재 디렉토리를 확인. `/manage:prd list --all`로 사용 가능한 PRD 확인.

#### 검토 점수가 너무 낮음
```bash
Review Score: 65/100 - Revision Required
```
**해결책**: 식별된 문제 해결, 특히:
- 누락된 요구사항
- 모호한 성공 지표
- 불완전한 기술 사양

#### 번역 문제
```bash
Warning: Translation quality may need review
```
**해결책**: 번역된 PRD를 수동으로 검토, 특히 기술 용어.

#### SDLC 통합 실패
```bash
Error: Failed to initialize SDLC pipeline
```
**해결책**: PRD가 승인되었는지 확인하고 수동으로 `/sdlc "기능-이름" --init --from-prd` 사용.

### 도움 받기

#### PRD 상태 확인
```bash
/manage:prd status "기능-이름"
```

#### 모든 명령어 목록
```bash
/manage:prd --help
/support:prd-review --help
```

#### PRD 위치 보기
```bash
/manage:prd list --all
```
현재 위치와 상태와 함께 모든 PRD를 표시합니다.

## 고급 주제

### 사용자 정의 템플릿
PRD 템플릿은 스타터 프로젝트의 `starters/*/docs/templates/prd/`에 위치합니다:
- `starters/basic/docs/templates/prd/standard.md`
- `starters/api/docs/templates/prd/standard.md`
- `starters/frontend/docs/templates/prd/standard.md`
- `starters/fullstack/docs/templates/prd/standard.md`

사용자 정의 템플릿 생성 방법:
1. 스타터에서 기존 템플릿 복사
2. 필요에 맞게 수정
3. 프로젝트의 `docs/prd/templates/` 디렉토리에 배치
4. `--template=custom`로 사용

### 일괄 작업
```bash
# 모든 초안 PRD 검토
for prd in $(ls docs/prd/draft/); do
  /support:prd-review "${prd%.md}"
done
```

### CI/CD 통합
PRD는 자동화된 워크플로우를 트리거할 수 있음:
- PRD 승인 시 GitHub Actions
- Jenkins 파이프라인 초기화
- JIRA 티켓 생성
- Slack 알림

### 메트릭 수집
PRD 메트릭 추적:
- 초안에서 승인까지 시간
- 검토 반복 횟수
- 요구사항 변경 빈도
- 승인된 PRD의 성공률

## 예제

### 완전한 PRD 워크플로우
```bash
# 1. 인증 기능을 위한 PRD 생성
/manage:prd create "사용자-인증" --template=api

# 2. PRD 편집 (수동 단계)
# docs/prd/draft/사용자-인증.md의 모든 섹션 작성

# 3. 검토 제출
/manage:prd move "사용자-인증" --to=review

# 4. 검토 실행
/support:prd-review "사용자-인증"

# 5. 점수 >= 80이면 승인
/manage:prd approve "사용자-인증"

# 6. SDLC 자동 시작
# 개발 진행...

# 7. 완료 후 보관
/manage:prd archive "사용자-인증"
```

### API PRD 예제
```markdown
# PRD: 사용자 인증 API

## 개요
**기능**: 사용자 인증을 위한 RESTful API
**우선순위**: P0
**목표 릴리즈**: v2.0.0

## 문제 설명
현재 시스템에 안전한 사용자 인증이 부족...

## 요구사항
### 기능 요구사항
- FR1: JWT 기반 인증
- FR2: OAuth2 소셜 로그인 지원
- FR3: 비밀번호 재설정 플로우

### 비기능 요구사항
- 응답 시간 < 200ms
- 동시 사용자 10,000명 지원
- 99.9% 가용성
```

## 결론

PRD 시스템은 임시 개발을 구조화되고 예측 가능한 프로세스로 변환합니다. 명확한 요구사항으로 시작함으로써 팀은:
- 개발 재작업 감소
- 이해관계자 정렬 개선
- 비즈니스 요구를 충족하는 기능 제공
- 포괄적인 문서 유지
- 성공 지표를 효과적으로 추적

다음 기능을 PRD로 시작하고 요구사항 주도 개발의 이점을 경험하세요!