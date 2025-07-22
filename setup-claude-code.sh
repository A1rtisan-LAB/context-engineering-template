#!/bin/bash

# Claude Code용 Context Engineering 프로젝트 구조 초기화 스크립트
# 사용법: ./setup-claude-code.sh [프로젝트명] [프로젝트타입] [프로젝트경로]
# 프로젝트 타입: general(기본값), api, frontend, fullstack
# 프로젝트 경로: 절대경로 또는 상대경로 (기본값: 현재 디렉토리)

set -e  # 에러 발생 시 즉시 종료

# 변수 설정
PROJECT_NAME=${1:-"my-project"}
PROJECT_TYPE=${2:-"general"}
PROJECT_PATH=${3:-"."}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/templates"

# 프로젝트 전체 경로 설정
if [[ "$PROJECT_PATH" = "." ]]; then
    FULL_PROJECT_PATH="$PROJECT_NAME"
else
    # 경로가 /로 끝나면 제거
    PROJECT_PATH=${PROJECT_PATH%/}
    FULL_PROJECT_PATH="$PROJECT_PATH/$PROJECT_NAME"
fi

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 로고 출력
echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════╗"
echo "  ║            C O N T E X T              ║"
echo "  ║       Engineering Template            ║"
echo "  ╚═══════════════════════════════════════╝"
echo "                                        "
echo "     Engineering Template Setup         "
echo -e "${NC}"

echo -e "${BLUE}🚀 Claude Code용 Context Engineering 프로젝트 생성${NC}"
echo -e "   프로젝트명: ${GREEN}$PROJECT_NAME${NC}"
echo -e "   프로젝트 타입: ${GREEN}$PROJECT_TYPE${NC}"
echo -e "   생성 경로: ${GREEN}$FULL_PROJECT_PATH${NC}"
echo ""

# 함수 정의
check_dependencies() {
    local missing_deps=()
    
    # Git 확인
    if ! command -v git &> /dev/null; then
        missing_deps+=("git")
    fi
    
    # jq 확인 (JSON 검증용, 선택사항)
    if ! command -v jq &> /dev/null; then
        echo -e "${YELLOW}ℹ️  jq가 설치되어 있지 않습니다. JSON 검증을 건너뜁니다.${NC}"
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${RED}❌ 다음 의존성이 필요합니다: ${missing_deps[*]}${NC}"
        exit 1
    fi
}

validate_templates() {
    echo -e "${BLUE}🔍 템플릿 검증 중...${NC}"
    
    # 필수 템플릿 파일 확인
    local required_files=(
        ".claude/settings.json"
        ".claude/commands/generate-prp.md"
        ".claude/commands/execute-prp.md"
        "CLAUDE.md"
        "INITIAL.md"
    )
    
    local missing_files=()
    for file in "${required_files[@]}"; do
        if [ ! -f "$TEMPLATE_DIR/$file" ]; then
            missing_files+=("$file")
        fi
    done
    
    if [ ${#missing_files[@]} -ne 0 ]; then
        echo -e "${RED}❌ 다음 필수 템플릿 파일이 누락되었습니다:${NC}"
        printf '%s\n' "${missing_files[@]}"
        exit 1
    fi
    
    # JSON 문법 검사 (jq가 있을 경우)
    if command -v jq &> /dev/null; then
        if ! jq . "$TEMPLATE_DIR/.claude/settings.json" > /dev/null 2>&1; then
            echo -e "${RED}❌ settings.json 문법 오류${NC}"
            exit 1
        fi
    fi
    
    echo -e "${GREEN}✅ 템플릿 검증 완료${NC}"
}

create_project_structure() {
    # 프로젝트 디렉토리 확인
    if [ -d "$FULL_PROJECT_PATH" ]; then
        echo -e "${YELLOW}⚠️  경고: 디렉토리 '$FULL_PROJECT_PATH'이 이미 존재합니다.${NC}"
        # CI 환경에서는 자동으로 덮어쓰기 진행
        if [[ -n "$CI" || -n "$GITHUB_ACTIONS" ]]; then
            echo "CI 환경 감지: 기존 디렉토리 자동 덮어쓰기"
        else
            read -p "계속하시겠습니까? 기존 파일이 덮어쓰여질 수 있습니다. (y/N) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo "취소되었습니다."
                exit 1
            fi
        fi
    fi
    
    echo -e "${BLUE}📁 프로젝트 구조 생성 중...${NC}"
    
    # 상위 디렉토리 생성 (필요한 경우)
    mkdir -p "$(dirname "$FULL_PROJECT_PATH")"
    
    # 프로젝트 디렉토리 생성
    mkdir -p "$FULL_PROJECT_PATH"
    
    # 템플릿 복사
    cp -r "$TEMPLATE_DIR"/* "$FULL_PROJECT_PATH/" 2>/dev/null || true
    # 숨김 파일 복사 (. 및 .. 제외)
    find "$TEMPLATE_DIR" -maxdepth 1 -name ".*" ! -name "." ! -name ".." -exec cp -r {} "$FULL_PROJECT_PATH/" \; 2>/dev/null || true
    
    # 불필요한 파일 제거
    rm -rf "$FULL_PROJECT_PATH/.git" 2>/dev/null || true
    
    cd "$FULL_PROJECT_PATH"
    
    # 빈 디렉토리 생성
    mkdir -p src tests PRPs/{ai_docs,completed}
    mkdir -p examples/{architecture,api,database,tests}
    
    # .gitkeep 파일 추가
    touch src/.gitkeep tests/.gitkeep
    touch PRPs/ai_docs/.gitkeep PRPs/completed/.gitkeep
    touch examples/architecture/.gitkeep examples/api/.gitkeep
    touch examples/database/.gitkeep examples/tests/.gitkeep
    
    echo -e "${GREEN}✅ 디렉토리 구조 생성 완료${NC}"
}

customize_project() {
    echo -e "${BLUE}🎨 프로젝트 커스터마이징 중...${NC}"
    
    # 프로젝트명 치환
    local files_to_customize=(
        "CLAUDE.md"
        "docs/PLANNING.md"
    )
    
    for file in "${files_to_customize[@]}"; do
        if [ -f "$file" ]; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS
                sed -i '' "s/PROJECT_NAME/$PROJECT_NAME/g" "$file"
            else
                # Linux
                sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" "$file"
            fi
        fi
    done
    
    # README 처리
    if [ -f "README.template.md" ]; then
        sed "s/PROJECT_NAME/$PROJECT_NAME/g" README.template.md > README.md
        rm README.template.md
    fi
    
    # 프로젝트 타입별 추가 설정
    case $PROJECT_TYPE in
        api)
            echo -e "${CYAN}🔌 API 프로젝트 설정 적용${NC}"
            # API 특화 설정 추가
            ;;
        frontend)
            echo -e "${CYAN}🎨 Frontend 프로젝트 설정 적용${NC}"
            # Frontend 특화 설정 추가
            ;;
        fullstack)
            echo -e "${CYAN}🚀 Fullstack 프로젝트 설정 적용${NC}"
            # Fullstack 특화 설정 추가
            ;;
    esac
    
    echo -e "${GREEN}✅ 커스터마이징 완료${NC}"
}

initialize_git() {
    if [ ! -d ".git" ]; then
        echo -e "${BLUE}🔧 Git 저장소 초기화 중...${NC}"
        git init
        git add .
        git commit -m "Initial commit: Context Engineering template applied"
        echo -e "${GREEN}✅ Git 저장소 초기화 완료${NC}"
    fi
}

print_next_steps() {
    echo ""
    echo -e "${GREEN}✅ Claude Code용 Context Engineering 프로젝트 구조 생성 완료!${NC}"
    echo ""
    echo -e "${BLUE}📋 다음 단계:${NC}"
    echo "1. cd $FULL_PROJECT_PATH"
    echo "2. CLAUDE.md를 프로젝트에 맞게 편집"
    echo "3. examples/ 폴더에 참고할 코드 패턴 추가"
    echo "4. INITIAL.md에 첫 기능 요청 작성"
    echo "5. Claude Code에서 /generate-prp INITIAL.md 실행"
    echo ""
    echo -e "${YELLOW}📚 주요 개념:${NC}"
    echo "• PRP: Product Requirements Prompt (AI 구현 청사진)"
    echo "• CLAUDE.md: AI 어시스턴트가 따를 전역 규칙"
    echo "• examples/: 코드 패턴과 베스트 프랙티스"
    echo ""
    echo -e "${CYAN}🛠️  사용 가능한 Claude Code 명령어:${NC}"
    echo "• /generate-prp [파일]: PRP 생성"
    echo "• /execute-prp [파일]: 기능 구현"
    echo "• /test-all: 모든 테스트 실행"
    echo "• /check-quality: 코드 품질 검사"
    echo ""
    echo -e "${GREEN}💡 팁: 'cat docs/TROUBLESHOOTING.md'로 문제 해결 가이드를 확인하세요!${NC}"
}

# 메인 실행 흐름
main() {
    # 의존성 확인
    check_dependencies
    
    # 템플릿 디렉토리 확인
    if [ ! -d "$TEMPLATE_DIR" ]; then
        echo -e "${RED}❌ 오류: 템플릿 디렉토리를 찾을 수 없습니다: $TEMPLATE_DIR${NC}"
        echo "setup-claude-code.sh를 올바른 위치에서 실행하고 있는지 확인하세요."
        exit 1
    fi
    
    # 템플릿 검증
    validate_templates
    
    # 프로젝트 구조 생성
    create_project_structure
    
    # 프로젝트 커스터마이징
    customize_project
    
    # Git 초기화 (선택사항)
    # CI 환경에서는 자동으로 Git 초기화를 진행
    if [[ -n "$CI" || -n "$GITHUB_ACTIONS" ]]; then
        echo "CI 환경 감지: Git 저장소 자동 초기화"
        initialize_git
    else
        read -p "Git 저장소를 초기화하시겠습니까? (Y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            initialize_git
        fi
    fi
    
    # 완료 메시지 및 다음 단계 안내
    print_next_steps
}

# 스크립트 실행
main