#!/bin/bash

# ASI Application Startup Script
# This script provides easy deployment and management

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "   ASI Application Deployment Script"
echo "=========================================="
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for Docker
if command_exists docker; then
    echo -e "${GREEN}✓${NC} Docker is installed"
else
    echo -e "${RED}✗${NC} Docker is not installed"
    echo "Please install Docker from https://docs.docker.com/get-docker/"
    exit 1
fi

# Check for Docker Compose
if command_exists docker-compose || docker compose version >/dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Docker Compose is available"
else
    echo -e "${YELLOW}!${NC} Docker Compose is not available (optional)"
fi

echo ""
echo "What would you like to do?"
echo "1) Build Docker image"
echo "2) Run with Docker"
echo "3) Run with Docker Compose"
echo "4) Stop containers"
echo "5) View logs"
echo "6) Clean up (remove containers and images)"
echo ""
read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        echo "Building Docker image..."
        docker build -t asi-app:latest .
        echo -e "${GREEN}✓${NC} Docker image built successfully"
        ;;
    2)
        echo "Running with Docker..."
        mkdir -p ./data
        docker run -d \
            --name asi-app \
            -v $(pwd)/data:/app/data \
            asi-app:latest
        echo -e "${GREEN}✓${NC} Container started"
        echo "View logs with: docker logs -f asi-app"
        ;;
    3)
        echo "Running with Docker Compose..."
        mkdir -p ./data
        if command_exists docker-compose; then
            docker-compose up -d
        else
            docker compose up -d
        fi
        echo -e "${GREEN}✓${NC} Services started"
        echo "View logs with: docker-compose logs -f"
        ;;
    4)
        echo "Stopping containers..."
        docker stop asi-app 2>/dev/null || true
        if command_exists docker-compose; then
            docker-compose down 2>/dev/null || true
        else
            docker compose down 2>/dev/null || true
        fi
        echo -e "${GREEN}✓${NC} Containers stopped"
        ;;
    5)
        echo "Viewing logs..."
        if docker ps | grep -q asi-app; then
            docker logs -f asi-app
        elif command_exists docker-compose; then
            docker-compose logs -f
        else
            docker compose logs -f
        fi
        ;;
    6)
        echo "Cleaning up..."
        docker stop asi-app 2>/dev/null || true
        docker rm asi-app 2>/dev/null || true
        if command_exists docker-compose; then
            docker-compose down 2>/dev/null || true
        else
            docker compose down 2>/dev/null || true
        fi
        docker rmi asi-app:latest 2>/dev/null || true
        echo -e "${GREEN}✓${NC} Cleanup complete"
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo "=========================================="
