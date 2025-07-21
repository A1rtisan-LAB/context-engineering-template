#!/bin/bash

# 템플릿 동기화 및 검증 도구
# 사용법: ./sync-templates.sh [command]
# Commands: validate, update, diff, list

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/templates"

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# 명령어
COMMAND=${1:-"help"}

show_help() {
    echo -e "${CYAN}Context Engineering Template 동기화 도구${NC}"
    echo ""
    echo "사용법: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  validate    템플릿 파일 검증"
    echo "  update      기존 프로젝트의 템플릿 업데이트"
    echo "  diff        현재 템플릿과 프로젝트 간 차이 확인"
    echo "  list        모든 템플릿 파일 목록"
    echo "  help        이 도움말 표시"
}

validate_templates() {
    echo -e "${BLUE}🔍 템플릿 검증 중...${NC}"
    
    local errors=0
    
    # JSON 파일 검증
    echo -e "${CYAN}JSON 파일 검증...${NC}"
    if command -v jq &> /dev/null; then
        while IFS= read -r -d '' file; do
            if ! jq . "$file" > /dev/null 2>&1; then
                echo -e "${RED}❌ JSON 오류: $file${NC}"
                ((errors++))
            else
                echo -e "${GREEN}✓${NC} $(basename "$file")"
            fi
        done < <(find "$TEMPLATE_DIR" -name "*.json" -type f -print0)
    else
        echo -e "${YELLOW}⚠️  jq가 설치되어 있지 않아 JSON 검증을 건너뜁니다${NC}"
    fi
    
    # 필수 파일 확인
    echo -e "${CYAN}필수 파일 확인...${NC}"
    local required_files=(
        ".claude/settings.json"
        ".claude/commands/generate-prp.md"
        ".claude/commands/execute-prp.md"
        "CLAUDE.md"
        "INITIAL.md"
    )
    
    for file in "${required_files[@]}"; do
        if [ -f "$TEMPLATE_DIR/$file" ]; then
            echo -e "${GREEN}✓${NC} $file"
        else
            echo -e "${RED}✗${NC} $file (누락)"
            ((errors++))
        fi
    done
    
    # Markdown 파일 기본 검증
    echo -e "${CYAN}Markdown 파일 확인...${NC}"
    local empty_files=()
    while IFS= read -r -d '' file; do
        if [ ! -s "$file" ]; then
            empty_files+=("$file")
        fi
    done < <(find "$TEMPLATE_DIR" -name "*.md" -type f -print0)
    
    if [ ${#empty_files[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️  빈 Markdown 파일 발견:${NC}"
        printf '  • %s\n' "${empty_files[@]}"
    fi
    
    if [ $errors -eq 0 ]; then
        echo -e "${GREEN}✅ 모든 템플릿 검증 통과${NC}"
        return 0
    else
        echo -e "${RED}❌ $errors개의 오류 발견${NC}"
        return 1
    fi
}

list_templates() {
    echo -e "${BLUE}📋 템플릿 파일 목록${NC}"
    echo ""
    
    # 카테고리별로 정리
    echo -e "${CYAN}Claude Code 설정:${NC}"
    find "$TEMPLATE_DIR/.claude" -type f 2>/dev/null | sort | while read -r file; do
        echo "  • ${file#$TEMPLATE_DIR/}"
    done
    
    echo -e "\n${CYAN}PRP 템플릿:${NC}"
    find "$TEMPLATE_DIR/PRPs" -name "*.md" -type f | sort | while read -r file; do
        echo "  • ${file#$TEMPLATE_DIR/}"
    done
    
    echo -e "\n${CYAN}문서:${NC}"
    find "$TEMPLATE_DIR/docs" -name "*.md" -type f | sort | while read -r file; do
        echo "  • ${file#$TEMPLATE_DIR/}"
    done
    
    echo -e "\n${CYAN}예시 패턴:${NC}"
    find "$TEMPLATE_DIR/examples" -name "*.md" -type f | sort | while read -r file; do
        echo "  • ${file#$TEMPLATE_DIR/}"
    done
    
    echo -e "\n${CYAN}루트 파일:${NC}"
    find "$TEMPLATE_DIR" -maxdepth 1 -name "*" -type f | sort | while read -r file; do
        echo "  • $(basename "$file")"
    done
}

diff_templates() {
    local project_dir=${2:-.}
    
    if [ ! -d "$project_dir/.claude" ]; then
        echo -e "${RED}❌ 오류: '$project_dir'는 Context Engineering 프로젝트가 아닙니다${NC}"
        return 1
    fi
    
    echo -e "${BLUE}📊 템플릿 차이 분석: $project_dir${NC}"
    echo ""
    
    # 변경된 파일 찾기
    local changed_count=0
    local new_count=0
    
    # 템플릿의 모든 파일 확인
    while IFS= read -r -d '' template_file; do
        relative_path="${template_file#$TEMPLATE_DIR/}"
        project_file="$project_dir/$relative_path"
        
        if [ -f "$project_file" ]; then
            if ! diff -q "$template_file" "$project_file" > /dev/null 2>&1; then
                echo -e "${YELLOW}수정됨:${NC} $relative_path"
                ((changed_count++))
            fi
        else
            echo -e "${GREEN}새파일:${NC} $relative_path"
            ((new_count++))
        fi
    done < <(find "$TEMPLATE_DIR" -type f ! -path "*/.git/*" -print0)
    
    echo ""
    echo -e "${CYAN}요약:${NC}"
    echo "  • 수정된 파일: ${changed_count}개"
    echo "  • 새로운 파일: ${new_count}개"
    
    if [ $((changed_count + new_count)) -eq 0 ]; then
        echo -e "${GREEN}✅ 템플릿과 프로젝트가 동기화되어 있습니다${NC}"
    fi
}

update_project() {
    local project_dir=${2:-.}
    
    if [ ! -d "$project_dir/.claude" ]; then
        echo -e "${RED}❌ 오류: '$project_dir'는 Context Engineering 프로젝트가 아닙니다${NC}"
        return 1
    fi
    
    echo -e "${BLUE}🔄 프로젝트 템플릿 업데이트: $project_dir${NC}"
    echo ""
    
    # 백업 생성
    backup_dir="$project_dir/.template-backup-$(date +%Y%m%d-%H%M%S)"
    echo -e "${CYAN}백업 생성: $backup_dir${NC}"
    mkdir -p "$backup_dir"
    
    # 중요 파일 백업
    for file in .claude/settings.json CLAUDE.md; do
        if [ -f "$project_dir/$file" ]; then
            cp -r "$project_dir/$file" "$backup_dir/"
        fi
    done
    
    # 업데이트 확인
    echo -e "${YELLOW}⚠️  주의: 이 작업은 프로젝트의 템플릿 파일을 덮어씁니다.${NC}"
    read -p "계속하시겠습니까? (y/N) " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "취소되었습니다."
        return 1
    fi
    
    # 템플릿 복사 (선택적 업데이트)
    echo -e "${CYAN}템플릿 업데이트 중...${NC}"
    
    # Claude 명령어 업데이트
    cp -r "$TEMPLATE_DIR/.claude/commands" "$project_dir/.claude/"
    echo -e "${GREEN}✓${NC} Claude 명령어 업데이트"
    
    # PRP 템플릿 업데이트
    cp -r "$TEMPLATE_DIR/PRPs/templates" "$project_dir/PRPs/"
    echo -e "${GREEN}✓${NC} PRP 템플릿 업데이트"
    
    # 예시 패턴 업데이트
    cp -r "$TEMPLATE_DIR/examples/_patterns" "$project_dir/examples/"
    echo -e "${GREEN}✓${NC} 예시 패턴 업데이트"
    
    # 문서 템플릿 업데이트 (선택적)
    echo -e "${YELLOW}문서 템플릿을 업데이트하시겠습니까? (기존 내용이 덮어쓰여집니다)${NC}"
    read -p "(y/N) " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp "$TEMPLATE_DIR/docs/TROUBLESHOOTING.md" "$project_dir/docs/"
        echo -e "${GREEN}✓${NC} 문제 해결 가이드 업데이트"
    fi
    
    echo ""
    echo -e "${GREEN}✅ 업데이트 완료!${NC}"
    echo -e "${CYAN}백업 위치: $backup_dir${NC}"
}

# 메인 로직
case $COMMAND in
    validate)
        validate_templates
        ;;
    list)
        list_templates
        ;;
    diff)
        diff_templates "$@"
        ;;
    update)
        update_project "$@"
        ;;
    help|*)
        show_help
        ;;
esac