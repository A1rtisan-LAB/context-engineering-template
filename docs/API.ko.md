# API 문서

## CLI API

### `claude-init`

새 Claude Code 프로젝트를 생성하는 주요 CLI 진입점입니다.

#### 개요

```bash
node cli/claude-init.js [project-name] [starter-type] [target-path]
```

#### 매개변수

| 매개변수 | 타입 | 기본값 | 설명 |
|---------|------|--------|------|
| `project-name` | string | `my-claude-project` | 프로젝트 이름 |
| `starter-type` | string | `basic` | 스타터 템플릿 유형 (`basic`, `api`, `frontend`, `fullstack`) |
| `target-path` | string | `./<project-name>` | 프로젝트 생성 위치 |

#### 옵션

| 옵션 | 별칭 | 설명 |
|------|------|------|
| `--help` | `-h` | 도움말 메시지 표시 |
| `--version` | `-v` | 버전 정보 표시 |

#### 예제

```bash
# 기본 프로젝트 생성
node cli/claude-init.js my-project

# API 프로젝트 생성
node cli/claude-init.js my-api api

# 특정 디렉토리에 프론트엔드 프로젝트 생성
node cli/claude-init.js my-app frontend ~/projects
```

## 프로그래밍 API

### 모듈로 사용하기

```javascript
const { createProject } = require('./cli/claude-init');

// 프로그래밍 방식으로 프로젝트 생성
await createProject('my-project', 'basic', '/path/to/projects');
```

### 핵심 함수

#### `createProject(projectName, starterType, targetPath)`

새 Claude Code 프로젝트를 생성합니다.

**매개변수:**
- `projectName` (string): 프로젝트 이름
- `starterType` (string): 스타터 템플릿 유형
- `targetPath` (string): 대상 디렉토리 경로

**반환값:** Promise<void>

**예외:** 디렉토리가 존재하거나 스타터를 찾을 수 없는 경우 Error

#### `pathExists(path)`

경로가 존재하는지 비동기적으로 확인합니다.

**매개변수:**
- `path` (string): 확인할 경로

**반환값:** Promise<boolean>

#### `copyRecursive(src, dest)`

파일과 디렉토리를 재귀적으로 복사합니다.

**매개변수:**
- `src` (string): 소스 경로
- `dest` (string): 대상 경로

**반환값:** Promise<void>

#### `replacePlaceholders(targetPath, projectName)`

파일에서 PROJECT_NAME 플레이스홀더를 교체합니다.

**매개변수:**
- `targetPath` (string): 프로젝트 디렉토리 경로
- `projectName` (string): 교체할 이름

**반환값:** Promise<void>

#### `copyPackageContents(targetPath)`

모노레포에서 생성된 프로젝트로 패키지 콘텐츠를 동적으로 복사합니다.

**매개변수:**
- `targetPath` (string): 대상 프로젝트 디렉토리 경로

**반환값:** Promise<void>

**설명:**
이 함수는 `@claude-code/` 아래의 모든 패키지를 동적으로 발견하고 생성된 프로젝트의 `.claude/` 디렉토리로 콘텐츠를 복사합니다. 다음을 처리합니다:
- 모든 패키지 디렉토리를 자동으로 발견
- `src/` 디렉토리가 있는 패키지의 경우, 콘텐츠를 `.claude/[package-name]/`으로 직접 복사 (src/ 없이)
- 프로젝트에 필요하지 않은 'core'와 같은 내부 패키지 건너뛰기
- 불필요한 파일 제외 (package.json, 테스트, node_modules 등)
- 미래 대비: 모노레포에 추가된 새 패키지를 자동으로 처리

**결과 예시:**
```
.claude/
├── agents/          # packages/@claude-code/agents/src/의 콘텐츠
│   ├── *.md        # 에이전트 파일이 여기에 직접, src/ 하위디렉토리 없음
├── commands/        # packages/@claude-code/commands/src/의 콘텐츠  
│   ├── *.md        # 명령 파일이 여기에 직접
│   └── analyze/    # 하위디렉토리 유지
└── workflows/       # packages/@claude-code/workflows/src/의 콘텐츠
    └── *.md        # 워크플로우 파일이 여기에 직접
```

## 벤치마크 API

### `Benchmark` 클래스

성능 벤치마킹 유틸리티입니다.

```javascript
const Benchmark = require('./scripts/benchmark');
const benchmark = new Benchmark();
```

#### 메서드

##### `measure(name, fn)`

함수의 실행 시간을 측정합니다.

**매개변수:**
- `name` (string): 작업 이름
- `fn` (Function): 측정할 함수

**반환값:** Promise<number> - 밀리초 단위 시간

##### `benchmarkFileOperations()`

파일 I/O 작업을 벤치마킹합니다.

**반환값:** Promise<void>

##### `benchmarkCLIInit()`

모든 스타터 유형에 대한 CLI 초기화를 벤치마킹합니다.

**반환값:** Promise<void>

##### `generateReport()`

성능 보고서를 생성하고 저장합니다.

**반환값:** void

##### `generateMarkdownReport()`

마크다운 형식의 보고서를 생성합니다.

**반환값:** string

##### `cleanup()`

임시 파일을 정리합니다.

**반환값:** void

##### `run()`

모든 벤치마크를 실행합니다.

**반환값:** Promise<void>

### 사용 예제

```javascript
const Benchmark = require('./scripts/benchmark');

async function runBenchmarks() {
  const benchmark = new Benchmark();
  
  // 사용자 정의 작업 측정
  const duration = await benchmark.measure('Custom Operation', async () => {
    // 여기에 코드 작성
    await someAsyncOperation();
  });
  
  console.log(`작업 소요 시간: ${duration}ms`);
  
  // 모든 벤치마크 실행
  await benchmark.run();
}
```

## 테스팅 API

### 테스트 유틸리티

`test/setup.js`에 위치:

#### `testUtils.createTempDir()`

테스트용 임시 디렉토리를 생성합니다.

**반환값:** string - 임시 디렉토리 경로

#### `testUtils.cleanupDir(dir)`

디렉토리를 정리합니다.

**매개변수:**
- `dir` (string): 정리할 디렉토리

**반환값:** void

#### `testUtils.mockConsole()`

테스트를 위해 콘솔 메서드를 모킹합니다.

**반환값:** Function - 복원 함수

### 테스트 실행

```javascript
// 모든 테스트 실행
npm test

// 커버리지와 함께 실행
npm run test:coverage

// 특정 테스트 파일 실행
npx jest path/to/test.js

// 감시 모드로 실행
npm run test:watch
```

## 패키지 스크립트

사용 가능한 npm 스크립트:

| 스크립트 | 설명 |
|---------|------|
| `npm run init` | CLI 초기화 프로그램 실행 |
| `npm run test` | Jest 테스트 실행 |
| `npm run test:watch` | 감시 모드로 테스트 실행 |
| `npm run test:coverage` | 커버리지와 함께 테스트 실행 |
| `npm run test:ci` | CI 환경용 테스트 실행 |
| `npm run benchmark` | 성능 벤치마크 실행 |
| `npm run validate` | 워크스페이스 패키지 검증 |
| `npm run build` | 워크스페이스 패키지 빌드 |
| `npm run clean` | node_modules 및 coverage 정리 |
| `npm run setup` | 모든 것 설치 및 빌드 |

## 환경 변수

| 변수 | 설명 | 기본값 |
|------|------|--------|
| `NODE_ENV` | 환경 모드 | `development` |
| `CI` | CI 환경 플래그 | `false` |

## 오류 코드

| 코드 | 설명 |
|------|------|
| 1 | 일반 오류 |
| 2 | 디렉토리가 이미 존재 |
| 3 | 잘못된 스타터 유형 |
| 4 | 스타터 템플릿을 찾을 수 없음 |

## 성능 메트릭

예상 성능 벤치마크:

| 작업 | 목표 시간 | 실제 (비동기) |
|------|----------|---------------|
| 프로젝트 생성 | < 100ms | ~5-10ms |
| 파일 복사 (소규모) | < 5ms | ~1-2ms |
| 플레이스홀더 교체 | < 10ms | ~2-5ms |
| 전체 CLI 작업 | < 150ms | ~10-20ms |

## 모노레포 구조

### 워크스페이스 패키지

```
packages/
├── @claude-code/agents     # AI 에이전트 정의
├── @claude-code/commands   # 명령어 구현
├── @claude-code/workflows  # 워크플로우 정의
└── @claude-code/core       # 코어 엔진
```

### 패키지 규칙

각 패키지는 다음 구조를 따릅니다:

```
package-name/
├── package.json
├── README.md
├── README.ko.md
├── src/
│   └── index.js
└── __tests__/
    └── index.test.js
```

## 기여하기

개발 가이드라인은 [CONTRIBUTING.ko.md](../CONTRIBUTING.ko.md)를 참조하세요.

## 라이선스

MIT - 자세한 내용은 [LICENSE](../LICENSE)를 참조하세요.