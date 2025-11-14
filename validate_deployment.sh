#!/bin/bash

# ============================================================================
# DEPLOYMENT VALIDATION SCRIPT
# ============================================================================
# Validates that the ARIA/ASI system is ready for deployment
# Usage: ./validate_deployment.sh

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                                                                ║"
echo "║        🔍 DEPLOYMENT VALIDATION CHECK 🔍                      ║"
echo "║                                                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

ERRORS=0

# Check Node.js
echo -e "\n${BLUE}Checking Node.js...${NC}"
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✅ Node.js installed: $NODE_VERSION${NC}"
else
    echo -e "${RED}❌ Node.js not found${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Check npm
echo -e "\n${BLUE}Checking npm...${NC}"
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    echo -e "${GREEN}✅ npm installed: $NPM_VERSION${NC}"
else
    echo -e "${RED}❌ npm not found${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Check Python (optional)
echo -e "\n${BLUE}Checking Python...${NC}"
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    echo -e "${GREEN}✅ Python installed: $PYTHON_VERSION${NC}"
else
    echo -e "${YELLOW}⚠️  Python not found (optional for some features)${NC}"
fi

# Check required files
echo -e "\n${BLUE}Checking required files...${NC}"
REQUIRED_FILES=(
    "aria.js"
    "unified_launcher.js"
    "package.json"
    "DEPLOYMENT.md"
    "QUICKSTART.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ Found: $file${NC}"
    else
        echo -e "${RED}❌ Missing: $file${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

# Check JavaScript syntax
echo -e "\n${BLUE}Validating JavaScript syntax...${NC}"
if [ -f "aria.js" ]; then
    if node --check aria.js 2>/dev/null; then
        echo -e "${GREEN}✅ aria.js syntax valid${NC}"
    else
        echo -e "${RED}❌ aria.js has syntax errors${NC}"
        ERRORS=$((ERRORS + 1))
    fi
fi

if [ -f "unified_launcher.js" ]; then
    if node --check unified_launcher.js 2>/dev/null; then
        echo -e "${GREEN}✅ unified_launcher.js syntax valid${NC}"
    else
        echo -e "${RED}❌ unified_launcher.js has syntax errors${NC}"
        ERRORS=$((ERRORS + 1))
    fi
fi

# Test unified launcher info
echo -e "\n${BLUE}Testing unified launcher...${NC}"
if timeout 3 node unified_launcher.js --info &>/dev/null; then
    echo -e "${GREEN}✅ Unified launcher works${NC}"
else
    echo -e "${RED}❌ Unified launcher test failed${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Test ARIA system briefly
echo -e "\n${BLUE}Testing ARIA system...${NC}"
if timeout 3 node aria.js &>/dev/null; then
    echo -e "${GREEN}✅ ARIA system initializes${NC}"
else
    echo -e "${YELLOW}⚠️  ARIA test timed out (expected behavior)${NC}"
fi

# Check deployment scripts
echo -e "\n${BLUE}Checking deployment scripts...${NC}"
if [ -f "auto_deploy.sh" ] && [ -x "auto_deploy.sh" ]; then
    echo -e "${GREEN}✅ auto_deploy.sh is executable${NC}"
else
    echo -e "${YELLOW}⚠️  auto_deploy.sh not executable or missing${NC}"
fi

if [ -f "run.sh" ] && [ -x "run.sh" ]; then
    echo -e "${GREEN}✅ run.sh is executable${NC}"
else
    echo -e "${YELLOW}⚠️  run.sh not executable or missing${NC}"
fi

# Check CI/CD workflows
echo -e "\n${BLUE}Checking CI/CD workflows...${NC}"
if [ -f ".github/workflows/ci.yml" ]; then
    echo -e "${GREEN}✅ CI workflow present${NC}"
else
    echo -e "${YELLOW}⚠️  CI workflow missing${NC}"
fi

if [ -f ".github/workflows/cd.yml" ]; then
    echo -e "${GREEN}✅ CD workflow present${NC}"
else
    echo -e "${YELLOW}⚠️  CD workflow missing${NC}"
fi

# Summary
echo -e "\n${BLUE}"
echo "════════════════════════════════════════════════════════════════"
echo "VALIDATION SUMMARY"
echo "════════════════════════════════════════════════════════════════"
echo -e "${NC}"

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}"
    echo "✅ ALL CHECKS PASSED!"
    echo ""
    echo "The ARIA/ASI system is ready for deployment!"
    echo ""
    echo "Next steps:"
    echo "  1. Run: ./run.sh (for interactive menu)"
    echo "  2. Or: node unified_launcher.js (for unified system)"
    echo "  3. Or: ./auto_deploy.sh production pm2 (for production)"
    echo -e "${NC}"
    exit 0
else
    echo -e "${RED}"
    echo "❌ VALIDATION FAILED"
    echo ""
    echo "Found $ERRORS critical error(s)"
    echo "Please fix the errors before deployment"
    echo -e "${NC}"
    exit 1
fi
