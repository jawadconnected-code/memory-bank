#!/bin/bash
#===============================================================================
# kb-test.sh - Knowledge Base Test Suite
#
# Usage:
#   ./testing/scripts/kb-test.sh           # Verbose mode
#   ./testing/scripts/kb-test.sh --quiet   # Quiet mode (CI)
#   ./testing/scripts/kb-test.sh --help   # Show help
#
# Exit codes:
#   0 - All tests passed
#   1 - One or more tests failed
#===============================================================================

set -o pipefail

#-------------------------------------------------------------------------------
# Configuration
#-------------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
KB_DIR="$ROOT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
passed=0
failed=0
warnings=0
total=0

# Options
quiet=false
verbose=true

#-------------------------------------------------------------------------------
# Utility Functions
#-------------------------------------------------------------------------------

log_info() {
    if [[ "$quiet" == "false" ]]; then
        echo -e "${BLUE}[INFO]${NC} $1"
    fi
}

log_pass() {
    ((passed++))
    ((total++))
    if [[ "$quiet" == "false" ]]; then
        echo -e "${GREEN}[PASS]${NC} $1"
    fi
}

log_fail() {
    ((failed++))
    ((total++))
    if [[ "$quiet" == "false" ]]; then
        echo -e "${RED}[FAIL]${NC} $1"
    fi
}

log_warn() {
    ((warnings++))
    if [[ "$quiet" == "false" ]]; then
        echo -e "${YELLOW}[WARN]${NC} $1"
    fi
}

log_section() {
    if [[ "$quiet" == "false" ]]; then
        echo ""
        echo -e "${BLUE}=== $1 ===${NC}"
    fi
}

show_help() {
    cat << EOF
kb-test.sh - Knowledge Base Test Suite

Usage: $(basename "$0") [OPTIONS]

OPTIONS:
    -q, --quiet     Quiet mode (CI/CD, only shows PASS/FAIL)
    -v, --verbose   Verbose mode (default)
    -h, --help      Show this help message

EXAMPLES:
    $(basename "$0")              # Run all tests with detailed output
    $(basename "$0") --quiet      # Run tests, output only PASS/FAIL
    $(basename "$0") --help       # Show this help message

EXIT CODES:
    0 - All tests passed
    1 - One or more tests failed

For more information, see TESTING.md
EOF
}

#-------------------------------------------------------------------------------
# Test Functions
#-------------------------------------------------------------------------------

test_foundation_files() {
    log_section "Foundation Files"
    
    local files=(
        "SOUL.md"
        "USER.md"
        "TOOLS.md"
        "AGENTS.md"
        "MEMORY.md"
        "HEARTBEAT.md"
        "BOOTSTRAP.md"
        "SEARCH.md"
    )
    
    for file in "${files[@]}"; do
        if [[ -f "$KB_DIR/$file" ]]; then
            log_pass "Foundation file exists: $file"
        else
            log_fail "Foundation file missing: $file"
        fi
    done
}

test_folder_structure() {
    log_section "Folder Structure"
    
    local folders=(
        "clients"
        "ideas"
        "research"
        "projects"
        "contexts"
        "memory"
        "templates"
        "archive/builds"
        "testing/scripts"
    )
    
    for folder in "${folders[@]}"; do
        if [[ -d "$KB_DIR/$folder" ]]; then
            log_pass "Folder exists: $folder"
        else
            log_fail "Folder missing: $folder"
        fi
    done
}

test_templates() {
    log_section "Templates"
    
    local templates=(
        "build.md"
        "client-profile.md"
        "daily-log.md"
        "meeting-notes.md"
        "project-update.md"
        "research-notes.md"
    )
    
    for template in "${templates[@]}"; do
        if [[ -f "$KB_DIR/templates/$template" ]]; then
            log_pass "Template exists: $template"
        else
            log_fail "Template missing: $template"
        fi
    done
}

test_frontmatter_schema() {
    log_section "Frontmatter Schema"
    
    # Files that are exempt from frontmatter requirements
    # These are template/foundation files meant to be filled in
    local exempt_files=("SOUL.md" "USER.md" "TOOLS.md" "BOOTSTRAP.md" "README.md" "SETUP.md")
    
    # Check that content files have valid frontmatter
    local md_files
    md_files=$(cd "$KB_DIR" && find . -maxdepth 1 -name "*.md" -type f 2>/dev/null)
    
    for file in $md_files; do
        # Skip if file doesn't exist or is empty
        if [[ ! -s "$file" ]]; then
            continue
        fi
        
        # Get just the filename for display
        local filename
        filename=$(basename "$file")
        
        # Skip exempt files (foundation/template files)
        local is_exempt=false
        for exempt in "${exempt_files[@]}"; do
            if [[ "$filename" == "$exempt" ]]; then
                is_exempt=true
                break
            fi
        done
        
        if [[ "$is_exempt" == "true" ]]; then
            log_info "Skipping frontmatter check: $filename (foundation file)"
            continue
        fi
        
        # Check for title field
        if grep -q "^title:" "$file" 2>/dev/null; then
            log_pass "Has title: $filename"
        else
            log_fail "Missing title: $filename"
        fi
        
        # Check for created date
        if grep -q "^created:" "$file" 2>/dev/null; then
            log_pass "Has created: $filename"
        else
            log_fail "Missing created: $filename"
        fi
        
        # Check for last_updated date
        if grep -q "^last_updated:" "$file" 2>/dev/null; then
            log_pass "Has last_updated: $filename"
        else
            log_fail "Missing last_updated: $filename"
        fi
        
        # Check for status field
        if grep -q "^status:" "$file" 2>/dev/null; then
            log_pass "Has status: $filename"
        else
            log_fail "Missing status: $filename"
        fi
        
        # Check for tags field
        if grep -q "^tags:" "$file" 2>/dev/null; then
            log_pass "Has tags: $filename"
        else
            log_fail "Missing tags: $filename"
        fi
    done
}

test_git_integration() {
    log_section "Git Integration"
    
    # Check if git repo exists
    if [[ -d "$KB_DIR/.git" ]]; then
        log_pass "Git repository exists"
    else
        log_fail "Git repository not found"
        return
    fi
    
    # Check git status
    cd "$KB_DIR"
    local status
    status=$(git status --porcelain 2>/dev/null)
    
    if [[ -z "$status" ]]; then
        log_pass "Git working tree is clean"
    else
        log_warn "Git has uncommitted changes"
        if [[ "$quiet" == "false" ]]; then
            git status --short
        fi
    fi
    
    # Check for git tags
    local tags
    tags=$(git tag -l "build-*" 2>/dev/null)
    
    if [[ -n "$tags" ]]; then
        log_pass "Build tags found: $(echo "$tags" | wc -l) tags"
    else
        log_warn "No build tags found (expected after first build)"
    fi
}

test_build_tracking() {
    log_section "Build Tracking"
    
    # Check if BUILD.md template exists
    if [[ -f "$KB_DIR/templates/build.md" ]]; then
        log_pass "BUILD.md template exists"
    else
        log_fail "BUILD.md template not found"
        return
    fi
    
    # Check template has required fields
    if grep -q "build_id:" "$KB_DIR/templates/build.md" 2>/dev/null; then
        log_pass "Template has build_id field"
    else
        log_fail "Template missing build_id field"
    fi
    
    if grep -q "status:" "$KB_DIR/templates/build.md" 2>/dev/null; then
        log_pass "Template has status field"
    else
        log_fail "Template missing status field"
    fi
    
    # Check if active BUILD.md exists
    if [[ -f "$KB_DIR/BUILD.md" ]]; then
        log_pass "Active BUILD.md found"
        
        # Check BUILD.md is parseable
        if grep -q "build_id:" "$KB_DIR/BUILD.md" 2>/dev/null; then
            log_pass "BUILD.md is parseable"
        else
            log_fail "BUILD.md missing build_id"
        fi
    else
        log_warn "No active BUILD.md (expected when not in build mode)"
    fi
    
    # Check archive/builds exists
    if [[ -d "$KB_DIR/archive/builds" ]]; then
        log_pass "archive/builds folder exists"
    else
        log_fail "archive/builds folder not found"
    fi
}

test_memory_system() {
    log_section "Memory System"
    
    # Check MEMORY.md exists
    if [[ -f "$KB_DIR/MEMORY.md" ]]; then
        log_pass "MEMORY.md exists"
        
        # Check MEMORY.md has sections
        if grep -q "## Decisions" "$KB_DIR/MEMORY.md" 2>/dev/null; then
            log_pass "MEMORY.md has Decisions section"
        else
            log_warn "MEMORY.md missing Decisions section"
        fi
        
        if grep -q "## Preferences" "$KB_DIR/MEMORY.md" 2>/dev/null; then
            log_pass "MEMORY.md has Preferences section"
        else
            log_warn "MEMORY.md missing Preferences section"
        fi
    else
        log_fail "MEMORY.md not found"
    fi
    
    # Check memory folder
    if [[ -d "$KB_DIR/memory" ]]; then
        log_pass "memory/ folder exists"
    else
        log_fail "memory/ folder not found"
    fi
}

test_self_annealing() {
    log_section "Self-Annealing System"
    
    # Check AGENTS.md has self-annealing section
    if [[ -f "$KB_DIR/AGENTS.md" ]]; then
        if grep -q "Self-Annealing" "$KB_DIR/AGENTS.md" 2>/dev/null; then
            log_pass "AGENTS.md has Self-Annealing section"
        else
            log_fail "AGENTS.md missing Self-Annealing section"
        fi
        
        if grep -q "Friction Detection" "$KB_DIR/AGENTS.md" 2>/dev/null; then
            log_pass "AGENTS.md has Friction Detection checklist"
        else
            log_fail "AGENTS.md missing Friction Detection checklist"
        fi
        
        if grep -q "Health Check" "$KB_DIR/AGENTS.md" 2>/dev/null; then
            log_pass "AGENTS.md has Health Check section"
        else
            log_fail "AGENTS.md missing Health Check section"
        fi
    else
        log_fail "AGENTS.md not found"
    fi
}

test_stale_files() {
    log_section "Stale File Detection"
    
    # Find files older than 30 days
    local stale_count=0
    local threshold_date=$(date -d "30 days ago" +%Y-%m-%d 2>/dev/null || date -v-30d +%Y-%m-%d 2>/dev/null)
    
    if [[ -z "$threshold_date" ]]; then
        log_warn "Could not calculate threshold date (platform issue)"
        return
    fi
    
    # Use cd to avoid traversing parent directories
    while IFS= read -r file; do
        local filename=$(basename "$file")
        if [[ "$filename" != "SOUL.md" ]] && [[ "$filename" != "USER.md" ]] && [[ "$filename" != "TOOLS.md" ]]; then
            ((stale_count++))
        fi
    done < <(cd "$KB_DIR" && find . -maxdepth 1 -name "*.md" -type f -newermt "$threshold_date" 2>/dev/null)
    
    if [[ $stale_count -gt 0 ]]; then
        log_warn "Files older than 30 days: $stale_count files"
    else
        log_pass "No stale files (>30 days)"
    fi
}

test_file_count() {
    log_section "File Count & Scalability"
    
    # Count markdown files - only in KB_DIR root
    local md_count
    md_count=$(cd "$KB_DIR" && find . -maxdepth 1 -name "*.md" -type f | wc -l)
    
    log_info "Total markdown files: $md_count"
    
    # Check scalability threshold
    if [[ $md_count -ge 500 ]]; then
        log_warn "File count ($md_count) exceeds 500 - consider semantic search upgrade"
    elif [[ $md_count -ge 400 ]]; then
        log_warn "File count ($md_count) approaching 500 threshold - plan for upgrade"
    else
        log_pass "File count ($md_count) within scalability limits"
    fi
    
    # Count daily logs
    local log_count
    log_count=$(cd "$KB_DIR/memory" && find . -name "*.md" 2>/dev/null | wc -l)
    log_info "Daily logs in memory/: $log_count"
    
    # Count archive builds
    local build_count
    build_count=$(cd "$KB_DIR/archive/builds" && find . -name "BUILD.md" 2>/dev/null | wc -l)
    log_info "Archived builds: $build_count"
}

test_tags_consistency() {
    log_section "Tag Consistency"
    
    # Collect all tags - only from KB_DIR root
    local tags_file="/tmp/kb-test-tags-$$"
    cd "$KB_DIR" && find . -maxdepth 1 -name "*.md" -type f -exec grep -h "^tags:" {} \; 2>/dev/null | sed 's/tags: \[\(.*\)\]/\1/' | tr ',' '\n' | sed 's/ //g' | sed 's/\]//' | sort | uniq > "$tags_file"
    
    local tag_count
    tag_count=$(wc -l < "$tags_file")
    
    if [[ $tag_count -gt 0 ]]; then
        log_pass "Found $tag_count unique tags"
    else
        log_warn "No tags found"
    fi
    
    rm -f "$tags_file"
}

#-------------------------------------------------------------------------------
# Main
#-------------------------------------------------------------------------------

main() {
    echo ""
    echo -e "${BLUE}=======================================${NC}"
    echo -e "${BLUE}  Knowledge Base Test Suite${NC}"
    echo -e "${BLUE}=======================================${NC}"
    echo ""
    log_info "Test directory: $KB_DIR"
    log_info "Date: $(date)"
    echo ""
    
    # Run all tests
    test_foundation_files
    test_folder_structure
    test_templates
    test_frontmatter_schema
    test_git_integration
    test_build_tracking
    test_memory_system
    test_self_annealing
    test_stale_files
    test_file_count
    test_tags_consistency
    
    # Summary
    echo ""
    echo -e "${BLUE}=======================================${NC}"
    echo -e "${BLUE}  Test Summary${NC}"
    echo -e "${BLUE}=======================================${NC}"
    echo ""
    
    if [[ "$quiet" == "false" ]]; then
        echo -e "  ${GREEN}Passed:${NC}   $passed"
        echo -e "  ${RED}Failed:${NC}   $failed"
        echo -e "  ${YELLOW}Warnings:${NC} $warnings"
        echo -e "  ${BLUE}Total:${NC}   $total"
        echo ""
    fi
    
    if [[ $failed -gt 0 ]]; then
        if [[ "$quiet" == "false" ]]; then
            echo -e "${RED}❌ TESTS FAILED${NC}"
            echo ""
            echo "Review the failures above and fix issues before continuing."
            echo "See TESTING.md for troubleshooting guidance."
        else
            echo "FAIL"
        fi
        exit 1
    else
        if [[ "$quiet" == "false" ]]; then
            echo -e "${GREEN}✅ ALL TESTS PASSED${NC}"
            if [[ $warnings -gt 0 ]]; then
                echo ""
                echo -e "${YELLOW}Note: $warnings warning(s) above. Review for improvements.${NC}"
            fi
        else
            echo "PASS"
        fi
        exit 0
    fi
}

#-------------------------------------------------------------------------------
# Parse Arguments
#-------------------------------------------------------------------------------

while [[ $# -gt 0 ]]; do
    case $1 in
        -q|--quiet)
            quiet=true
            verbose=false
            shift
            ;;
        -v|--verbose)
            quiet=false
            verbose=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

#-------------------------------------------------------------------------------
# Run
#-------------------------------------------------------------------------------

main
