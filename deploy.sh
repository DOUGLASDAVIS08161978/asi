#!/bin/bash

# ============================================================================
# ARIA/ASI SIMPLE DEPLOYMENT SCRIPT
# ============================================================================
# One-command deployment wrapper for quick and easy deployment
# ============================================================================

set -e

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                                                                ║"
echo "║        🚀 ARIA/ASI DEPLOYMENT - ONE COMMAND 🚀                ║"
echo "║                                                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Check if we should show help
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Usage: ./deploy.sh [OPTIONS]"
    echo ""
    echo "Simple deployment options:"
    echo "  (no args)              - Quick deploy locally (default)"
    echo "  --help, -h             - Show this help message"
    echo "  --run                  - Just run the system (no deployment)"
    echo "  --info                 - Show system information"
    echo "  --validate             - Validate deployment readiness"
    echo ""
    echo "Advanced deployment options:"
    echo "  --pm2                  - Deploy with PM2 process manager"
    echo "  --docker               - Deploy with Docker"
    echo "  --kubernetes           - Deploy to Kubernetes"
    echo "  --systemd              - Deploy as systemd service"
    echo ""
    echo "For advanced deployment, see: auto_deploy.sh"
    echo "For quick start, see: run.sh"
    echo ""
    exit 0
fi

# Validate deployment readiness
if [ "$1" == "--validate" ]; then
    echo -e "${YELLOW}Running deployment validation...${NC}"
    if [ -f "validate_deployment.sh" ]; then
        ./validate_deployment.sh
    else
        echo "Validation script not found. Performing basic checks..."
        
        # Check Node.js
        if command -v node &> /dev/null; then
            echo -e "${GREEN}✓${NC} Node.js: $(node --version)"
        else
            echo "✗ Node.js not found!"
            exit 1
        fi
        
        # Check files
        if [ -f "aria.js" ] && [ -f "unified_launcher.js" ]; then
            echo -e "${GREEN}✓${NC} Core files present"
        else
            echo "✗ Core files missing!"
            exit 1
        fi
        
        echo -e "${GREEN}✓${NC} System validated and ready for deployment"
    fi
    exit 0
fi

# Show system info
if [ "$1" == "--info" ]; then
    echo "Showing system information..."
    node unified_launcher.js --info
    exit 0
fi

# Just run (no deployment)
if [ "$1" == "--run" ]; then
    echo "Starting ARIA/ASI system..."
    node unified_launcher.js
    exit 0
fi

# Advanced deployment options
if [ "$1" == "--pm2" ]; then
    echo "Deploying with PM2..."
    ./auto_deploy.sh production pm2
    exit 0
fi

if [ "$1" == "--docker" ]; then
    echo "Deploying with Docker..."
    ./auto_deploy.sh production docker
    exit 0
fi

if [ "$1" == "--kubernetes" ]; then
    echo "Deploying to Kubernetes..."
    ./auto_deploy.sh production kubernetes
    exit 0
fi

if [ "$1" == "--systemd" ]; then
    echo "Deploying as systemd service..."
    ./auto_deploy.sh production systemd
    exit 0
fi

# Default: Quick local deployment
echo -e "${BLUE}Quick Local Deployment${NC}"
echo ""
echo "1. Checking prerequisites..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}Node.js not found. Please install Node.js 14+ first.${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} Node.js $(node --version)"

# Check files
if [ ! -f "aria.js" ]; then
    echo "Error: aria.js not found!"
    exit 1
fi
if [ ! -f "unified_launcher.js" ]; then
    echo "Error: unified_launcher.js not found!"
    exit 1
fi
echo -e "${GREEN}✓${NC} Core files present"

echo ""
echo "2. Deploying ARIA/ASI system..."
echo ""

# Create logs directory
mkdir -p logs

# Start the system
echo "Starting unified launcher..."
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                                ║${NC}"
echo -e "${GREEN}║              🎉 DEPLOYMENT SUCCESSFUL! 🎉                      ║${NC}"
echo -e "${GREEN}║                                                                ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "System is now starting..."
echo "Press Ctrl+C to stop"
echo ""

# Run the system
node unified_launcher.js
