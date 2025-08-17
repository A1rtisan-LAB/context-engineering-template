---
title: 문서 관리 가이드
author: Claude Code Team
date: 2025-08-17
version: 1.0.0
category: guides
tags: [documentation, management, bilingual, automation]
language: ko
---

# 문서 관리 가이드

## 목차
1. [개요](#개요)
2. [주요 기능](#주요-기능)
3. [문서 구조](#문서-구조)
4. [doc-manager 에이전트 사용](#doc-manager-에이전트-사용)
5. [문서 명령어](#문서-명령어)
6. [검증 기능](#검증-기능)
7. [번역 관리](#번역-관리)
8. [모범 사례](#모범-사례)
9. [문제 해결](#문제-해결)

## 개요

Context Engineering Template은 코드 변경과 동기화된 고품질의 이중 언어 문서를 유지하도록 설계된 포괄적인 문서 관리 시스템을 포함하고 있습니다.

## 주요 기능

### 🌐 이중 언어 지원
- 모든 문서를 영어와 한국어로 유지
- 자동 동기화 확인
- 번역 상태 추적
- 언어 동등성 강제

### 🔍 자동 검증
- 깨진 링크 감지
- 오래된 콘텐츠 식별
- 구조 검증
- 메타데이터 관리

### 🔄 워크플로우 통합
- SDLC Phase 7 강화
- Git hooks 통합
- CI/CD 파이프라인 검증
- PR 문서 체크리스트

## 문서 구조

### 표준 구성
```
docs/
├── README.md                    # 문서 인덱스
├── guides/                      # 사용자 및 개발자 가이드
│   ├── QUICKSTART.md/ko.md
│   ├── PRD_GUIDE.md/ko.md
│   ├── SDLC_GUIDE.md/ko.md
│   └── DOCUMENT_MANAGEMENT.md/ko.md
├── architecture/                # 기술 문서
│   ├── ARCHITECTURE.md/ko.md
│   └── API.md/ko.md
└── reports/                     # 분석 리포트
    └── BENCHMARK_REPORT.md/ko.md
```

### 파일 명명 규칙
- 영어: `{DOCUMENT_NAME}.md`
- 한국어: `{DOCUMENT_NAME}.ko.md`
- 항상 두 버전 모두 생성

## doc-manager 에이전트 사용

`doc-manager` 에이전트는 지능적인 문서 관리를 제공합니다:

### 기능
1. **레거시 감지**: 오래된 참조 및 깨진 링크 찾기
2. **동기화**: 언어 버전 일치 확인
3. **생성**: 템플릿에서 문서 생성
4. **검증**: 구문, 링크, 구조 확인
5. **워크플로우**: 개발 프로세스와 통합

### 활성화
```bash
/Task doc-manager "모든 문서 업데이트 및 동기화"
/Task doc-manager "오래된 참조 확인"
/Task doc-manager "API 문서 생성"
```

## 문서 명령어 (/manage:docs)

### 기본 명령어

#### 상태 확인
```bash
/manage:docs check
```
포괄적인 문서 검증을 수행합니다.

#### 링크 검증
```bash
/manage:docs validate
```
깨진 내부 및 외부 링크를 확인합니다.

#### 버전 동기화
```bash
/manage:docs sync
```
영어와 한국어 버전이 정렬되어 있는지 확인합니다.

#### 문서 생성
```bash
/manage:docs generate [type] --template=[name]
```
템플릿에서 새 문서를 생성합니다.

### 고급 명령어

#### 오래된 콘텐츠 찾기
```bash
/manage:docs outdated
```
오래된 정보가 있는 모든 문서를 나열합니다.

#### 커버리지 확인
```bash
/manage:docs coverage --feature=[name]
```
문서 완성도를 보고합니다.

#### 구조 수정
```bash
/manage:docs structure --fix
```
문서를 표준 구조로 재구성합니다.

#### 리포트 생성
```bash
/manage:docs report --format=markdown
```
포괄적인 상태 리포트를 생성합니다.

## 자동화 도구

### doc-sync.js 스크립트

위치: `packages/@claude-code/packages/@claude-code/core/src/doc-sync.js`

#### 기능
- 모든 마크다운 파일 검증
- 언어 버전 비교
- 오래된 패턴 감지
- 상세 리포트 생성

#### 사용법
```bash
# 검증 실행
node packages/@claude-code/packages/@claude-code/core/src/doc-sync.js

# 출력 예시
🔍 문서 검증 시작...
📎 깨진 참조 확인 중...
  깨진 링크 0개 발견
🔄 언어 버전 비교 중...
  동기화됨: 45/50
  차이 있음: 3
  번역 누락: 2
📅 오래된 콘텐츠 감지 중...
  오래된 참조 1개 발견
```

### GitHub Actions 통합

`.github/workflows/doc-validation.yml` 워크플로우:

1. **트리거 조건**:
   - 문서 변경이 있는 Pull Request
   - main/develop 브랜치로의 Push
   - 수동 실행

2. **검증 항목**:
   - 문서 구조
   - 링크 무결성
   - 언어 동기화
   - 커버리지 요구사항

3. **리포트**:
   - PR 코멘트로 검증 결과
   - GitHub Actions 요약
   - 실행 가능한 체크리스트

## Git Hooks 설정

### Pre-commit Hook
```bash
#!/bin/sh
# .git/hooks/pre-commit
node packages/@claude-code/packages/@claude-code/core/src/doc-sync.js || exit 1
```

### Post-merge Hook
```bash
#!/bin/sh
# .git/hooks/post-merge
/manage:docs sync --post-merge
```

## SDLC 통합

### Phase 7: 문서화

문서화 단계가 다음과 같이 강화되었습니다:

1. **사전 검증**:
   ```bash
   /manage:docs check
   /manage:docs outdated
   ```

2. **업데이트 프로세스**:
   ```bash
   /Task doc-manager "문서 업데이트"
   /manage:docs sync
   ```

3. **품질 게이트**:
   - ✅ 깨진 링크 없음
   - ✅ 언어 버전 동기화됨
   - ✅ 커버리지 > 90%
   - ✅ 메타데이터 최신

4. **최종 검증**:
   ```bash
   /manage:docs validate
   /manage:docs report
   ```

## 문서 메타데이터

### 표준 헤더
```markdown
<!--
meta:
  last_updated: 2025-01-17
  sync_status: synced
  related_features: [기능명]
  version: 3.0.0
-->
```

### 메타데이터 관리
```bash
# 모든 메타데이터 업데이트
/manage:docs update-meta --all

# 특정 파일 업데이트
/manage:docs update-meta --file=docs/guides/QUICKSTART.ko.md
```

## 모범 사례

### 1. 문서 우선
- 코드 전 또는 코드와 함께 문서 작성
- 코드 변경과 같은 커밋에 문서 업데이트
- 두 언어 버전 모두 포함

### 2. 정기 검증
- 주간 `/manage:docs check` 실행
- Pre-commit hooks 사용
- CI/CD 결과 모니터링

### 3. 동기화
- 항상 두 언어 버전 업데이트
- 변경 후 `/manage:docs sync` 사용
- 정기적으로 차이점 확인

### 4. 구조 유지
- 표준 디렉토리 구조 준수
- 일관된 명명 규칙 사용
- 인덱스 파일 유지

### 5. 품질 표준
- 깨진 링크 없음
- 최신 메타데이터
- 완전한 커버리지
- 명확한 예제

## 문제 해결

### 일반적인 문제

#### 깨진 링크
```bash
# 깨진 링크 식별
/manage:docs validate

# 자동 수정
/manage:docs fix-links
```

#### 동기화되지 않은 버전
```bash
# 동기화 확인
/manage:docs sync

# 차이점 보기
/manage:docs report
```

#### 누락된 문서
```bash
# 커버리지 확인
/manage:docs coverage

# 템플릿에서 생성
/manage:docs generate guide --template=standard
```

#### 오래된 콘텐츠
```bash
# 오래된 참조 찾기
/manage:docs outdated

# 메타데이터 업데이트
/manage:docs update-meta --all
```

## 메트릭 및 리포팅

### 주요 메트릭
- **커버리지**: 문서화된 기능의 비율
- **동기화**: 언어 버전 정렬
- **상태**: 유효한 링크 및 참조
- **최신성**: 최근 업데이트 정도

### 리포트 생성
```bash
# 마크다운 리포트
/manage:docs report --format=markdown

# 자동화를 위한 JSON
/manage:docs report --format=json
```

### 리포트 내용
- 전체 문서 수
- 동기화 상태
- 문제 요약
- 권장 사항
- 실행 가능한 항목

## 다른 시스템과의 통합

### PRD 시스템
- PRD 승인이 문서 요구사항 트리거
- PRD 기반 문서용 템플릿
- 자동 체크리스트 생성

### Git 워크플로우
- 코드와 함께 문서 커밋
- 브랜치 기반 문서화
- 자동화된 PR 확인

### CI/CD 파이프라인
- 빌드 프로세스에서 검증
- 문서 배포
- 버전 태깅

## 향후 개선 사항

### 계획된 기능
1. **AI 기반 번역 제안**
2. **자동 오래된 콘텐츠 감지**
3. **문서 커버리지 배지**
4. **대화형 문서 대시보드**
5. **교차 참조 검증**

### 기여
문서 시스템 개선 방법:
1. 새 기능으로 이 가이드 업데이트
2. doc-sync.js에 테스트 케이스 추가
3. GitHub Actions 워크플로우 강화
4. 새 문서 템플릿 생성

## 빠른 참조

### 필수 명령어
```bash
/manage:docs check          # 상태 확인
/manage:docs validate       # 링크 검증
/manage:docs sync          # 버전 동기화
/manage:docs generate      # 새 문서 생성
/manage:docs report        # 상태 리포트
```

### 파일 위치
- 에이전트: `packages/@claude-code/agents/src/doc-manager.md`
- 명령어: `packages/@claude-code/commands/src/manage/docs.md`
- 스크립트: `packages/@claude-code/packages/@claude-code/core/src/doc-sync.js`
- 워크플로우: `.github/workflows/doc-validation.yml`

---

이 포괄적인 문서 관리 시스템은 프로젝트 문서가 정확하고 접근 가능하며 코드베이스와 일치하도록 보장합니다.