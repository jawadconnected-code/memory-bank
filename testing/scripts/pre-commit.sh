#!/bin/bash
#===============================================================================
# pre-commit - Git pre-commit hook for knowledge base tests
#
# This hook runs automatically before each git commit.
# It validates the knowledge base state before committing.
#
# Usage:
#   cp testing/scripts/pre-commit.sh .git/hooks/pre-commit
#   chmod +x .git/hooks/pre-commit
#
# To skip (emergency):
#   git commit --no-verify -m "message"
#===============================================================================

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}  Pre-commit Knowledge Base Check${NC}"
echo -e "${BLUE}=======================================${NC}"
echo ""

# Check if test script exists
if [[ ! -f "$SCRIPT_DIR/kb-test.sh" ]]; then
    echo -e "${YELLOW}[WARN]${NC} Test script not found at $SCRIPT_DIR/kb-test.sh"
    echo -e "${YELLOW}[WARN]${NC} Skipping tests."
    exit 0
fi

# Make sure test script is executable
chmod +x "$SCRIPT_DIR/kb-test.sh" 2>/dev/null

# Run the test suite in quiet mode
echo "Running knowledge base tests..."
echo ""

"$SCRIPT_DIR/kb-test.sh" --quiet
exit_code=$?

echo ""

if [[ $exit_code -ne 0 ]]; then
    echo -e "${RED}❌ PRE-COMMIT CHECKS FAILED${NC}"
    echo ""
    echo "Fix the issues above before committing."
    echo ""
    echo "For details, run:"
    echo -e "  ${BLUE}./testing/scripts/kb-test.sh${NC}"
    echo ""
    echo "To skip this check (emergency only):"
    echo -e "  ${BLUE}git commit --no-verify -m \"message\"${NC}"
    echo ""
    exit 1
else
    echo -e "${GREEN}✅ Pre-commit checks passed${NC}"
    echo ""
    echo "Proceeding with commit..."
    echo ""
    exit 0
fi
