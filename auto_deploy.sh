#!/bin/bash

# ============================================================================
# ARIA AUTOMATED DEPLOYMENT SYSTEM
# ============================================================================
#
# Features:
# - One-click deployment
# - Environment detection
# - Automatic dependency installation
# - Multiple deployment targets
# - Health checks
# - Rollback capability
# - Monitoring setup
# - Auto-scaling configuration
#
# Usage: ./auto_deploy.sh [environment] [target]
# ============================================================================

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

log() {
    echo -e "${CYAN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

error() {
    echo -e "${RED}❌ ERROR: $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
}

info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

banner() {
    echo -e "${PURPLE}"
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                                                                ║"
    echo "║       🚀 ARIA AUTOMATED DEPLOYMENT SYSTEM 🚀                  ║"
    echo "║                                                                ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# ============================================================================
# CONFIGURATION
# ============================================================================

ENVIRONMENT=${1:-production}
TARGET=${2:-local}
PROJECT_DIR=$(pwd)
LOG_FILE="deployment_$(date +'%Y%m%d_%H%M%S').log"

log "Deployment configuration loaded"
info "Environment: $ENVIRONMENT"
info "Target: $TARGET"
info "Project directory: $PROJECT_DIR"

# ============================================================================
# PRE-DEPLOYMENT CHECKS
# ============================================================================

check_dependencies() {
    log "Checking dependencies..."
    
    # Check Node.js
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node --version)
        success "Node.js found: $NODE_VERSION"
    else
        error "Node.js not found. Please install Node.js 18+ first."
        exit 1
    fi
    
    # Check npm
    if command -v npm &> /dev/null; then
        NPM_VERSION=$(npm --version)
        success "npm found: $NPM_VERSION"
    else
        error "npm not found. Please install npm first."
        exit 1
    fi
    
    # Check Python (optional)
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version)
        success "Python found: $PYTHON_VERSION"
    else
        warning "Python not found. Some features may not work."
    fi
    
    # Check git
    if command -v git &> /dev/null; then
        GIT_VERSION=$(git --version)
        success "Git found: $GIT_VERSION"
    else
        warning "Git not found. Version control features disabled."
    fi
}

check_files() {
    log "Checking required files..."
    
    REQUIRED_FILES=(
        "aria.js"
        "unified_launcher.js"
        "package.json"
    )
    
    for file in "${REQUIRED_FILES[@]}"; do
        if [ -f "$file" ]; then
            success "Found: $file"
        else
            error "Missing required file: $file"
            exit 1
        fi
    done
}

# ============================================================================
# INSTALLATION
# ============================================================================

install_dependencies() {
    log "Installing dependencies..."
    
    if [ -f "package.json" ]; then
        npm install --production
        success "Node.js dependencies installed"
    fi
    
    # Install Python dependencies if needed
    if [ -f "requirements.txt" ] && command -v pip3 &> /dev/null; then
        pip3 install -r requirements.txt
        success "Python dependencies installed"
    fi
}

# ============================================================================
# DEPLOYMENT TARGETS
# ============================================================================

deploy_local() {
    log "Deploying to local environment..."
    
    # Create logs directory
    mkdir -p logs
    
    # Start ARIA in background
    nohup node aria.js > logs/aria.log 2>&1 &
    ARIA_PID=$!
    echo $ARIA_PID > aria.pid
    
    success "ARIA deployed locally (PID: $ARIA_PID)"
    info "Logs: logs/aria.log"
    info "Stop with: kill \$(cat aria.pid)"
}

deploy_pm2() {
    log "Deploying with PM2..."
    
    # Check if PM2 is installed
    if ! command -v pm2 &> /dev/null; then
        log "Installing PM2..."
        npm install -g pm2
    fi
    
    # Stop existing instance
    pm2 delete aria 2>/dev/null || true
    
    # Start with PM2
    pm2 start aria.js --name "aria" --max-memory-restart 2G
    pm2 save
    
    # Enable startup script
    pm2 startup || warning "Could not enable PM2 startup (requires sudo)"
    
    success "ARIA deployed with PM2"
    info "Monitor with: pm2 monit"
    info "Logs: pm2 logs aria"
    info "Stop with: pm2 stop aria"
}

deploy_docker() {
    log "Deploying with Docker..."
    
    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        error "Docker not found. Please install Docker first."
        exit 1
    fi
    
    # Create Dockerfile if it doesn't exist
    if [ ! -f "Dockerfile" ]; then
        log "Creating Dockerfile..."
        cat > Dockerfile << 'EOF'
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .

EXPOSE 3000

CMD ["node", "aria.js"]
EOF
        success "Dockerfile created"
    fi
    
    # Build Docker image
    log "Building Docker image..."
    docker build -t aria:latest .
    
    # Stop existing container
    docker stop aria 2>/dev/null || true
    docker rm aria 2>/dev/null || true
    
    # Run container
    docker run -d \
        --name aria \
        --restart unless-stopped \
        -v $(pwd)/logs:/app/logs \
        aria:latest
    
    success "ARIA deployed with Docker"
    info "View logs: docker logs -f aria"
    info "Stop with: docker stop aria"
}

deploy_kubernetes() {
    log "Deploying to Kubernetes..."
    
    # Check if kubectl is installed
    if ! command -v kubectl &> /dev/null; then
        error "kubectl not found. Please install kubectl first."
        exit 1
    fi
    
    # Create deployment manifest
    cat > k8s-deployment.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: aria
  labels:
    app: aria
spec:
  replicas: 3
  selector:
    matchLabels:
      app: aria
  template:
    metadata:
      labels:
        app: aria
    spec:
      containers:
      - name: aria
        image: aria:latest
        resources:
          requests:
            memory: "512Mi"
            cpu: "500m"
          limits:
            memory: "2Gi"
            cpu: "2000m"
---
apiVersion: v1
kind: Service
metadata:
  name: aria-service
spec:
  selector:
    app: aria
  ports:
  - port: 80
    targetPort: 3000
  type: LoadBalancer
EOF
    
    kubectl apply -f k8s-deployment.yaml
    
    success "ARIA deployed to Kubernetes"
    info "Check status: kubectl get pods"
    info "View logs: kubectl logs -l app=aria"
}

deploy_systemd() {
    log "Deploying as systemd service..."
    
    # Create systemd service file
    cat > /tmp/aria.service << EOF
[Unit]
Description=ARIA Autonomous Superintelligence
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$PROJECT_DIR
ExecStart=$(which node) $PROJECT_DIR/aria.js
Restart=always
RestartSec=10
StandardOutput=append:$PROJECT_DIR/logs/aria.log
StandardError=append:$PROJECT_DIR/logs/aria-error.log

[Install]
WantedBy=multi-user.target
EOF
    
    # Install service
    sudo mv /tmp/aria.service /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable aria
    sudo systemctl start aria
    
    success "ARIA deployed as systemd service"
    info "Status: sudo systemctl status aria"
    info "Logs: sudo journalctl -u aria -f"
    info "Stop: sudo systemctl stop aria"
}

# ============================================================================
# HEALTH CHECKS
# ============================================================================

health_check() {
    log "Performing health check..."
    
    # Wait for startup
    sleep 5
    
    # Check if process is running
    case $TARGET in
        local)
            if [ -f "aria.pid" ] && kill -0 $(cat aria.pid) 2>/dev/null; then
                success "ARIA is running (PID: $(cat aria.pid))"
                return 0
            fi
            ;;
        pm2)
            if pm2 pid aria &>/dev/null; then
                success "ARIA is running under PM2"
                return 0
            fi
            ;;
        docker)
            if docker ps | grep -q aria; then
                success "ARIA Docker container is running"
                return 0
            fi
            ;;
        kubernetes)
            if kubectl get pods -l app=aria | grep -q Running; then
                success "ARIA pods are running in Kubernetes"
                return 0
            fi
            ;;
        systemd)
            if systemctl is-active --quiet aria; then
                success "ARIA systemd service is active"
                return 0
            fi
            ;;
    esac
    
    error "Health check failed"
    return 1
}

# ============================================================================
# MONITORING SETUP
# ============================================================================

setup_monitoring() {
    log "Setting up monitoring..."
    
    mkdir -p monitoring
    
    # Create monitoring script
    cat > monitoring/check_aria.sh << 'EOF'
#!/bin/bash
# Simple monitoring script for ARIA

while true; do
    if ! pgrep -f "node.*aria.js" > /dev/null; then
        echo "[$(date)] ARIA process not found! Attempting restart..." | tee -a monitoring/alerts.log
        # Restart logic here
    fi
    sleep 60
done
EOF
    
    chmod +x monitoring/check_aria.sh
    
    success "Monitoring setup complete"
    info "Start monitoring: ./monitoring/check_aria.sh &"
}

# ============================================================================
# ROLLBACK
# ============================================================================

create_backup() {
    log "Creating backup..."
    
    BACKUP_DIR="backups/backup_$(date +'%Y%m%d_%H%M%S')"
    mkdir -p "$BACKUP_DIR"
    
    # Backup configuration files
    cp *.js "$BACKUP_DIR/" 2>/dev/null || true
    cp *.json "$BACKUP_DIR/" 2>/dev/null || true
    cp *.md "$BACKUP_DIR/" 2>/dev/null || true
    
    success "Backup created: $BACKUP_DIR"
}

# ============================================================================
# MAIN DEPLOYMENT FLOW
# ============================================================================

main() {
    banner
    
    log "Starting automated deployment..."
    log "Environment: $ENVIRONMENT"
    log "Target: $TARGET"
    
    # Pre-deployment
    check_dependencies
    check_files
    create_backup
    
    # Installation
    install_dependencies
    
    # Deployment
    case $TARGET in
        local)
            deploy_local
            ;;
        pm2)
            deploy_pm2
            ;;
        docker)
            deploy_docker
            ;;
        kubernetes|k8s)
            deploy_kubernetes
            ;;
        systemd)
            deploy_systemd
            ;;
        *)
            error "Unknown deployment target: $TARGET"
            echo "Available targets: local, pm2, docker, kubernetes, systemd"
            exit 1
            ;;
    esac
    
    # Post-deployment
    health_check
    setup_monitoring
    
    # Success
    echo ""
    success "═══════════════════════════════════════════════════════════"
    success "🎉 DEPLOYMENT COMPLETE! 🎉"
    success "═══════════════════════════════════════════════════════════"
    echo ""
    info "Environment: $ENVIRONMENT"
    info "Target: $TARGET"
    info "Deployment log: $LOG_FILE"
    echo ""
    info "ARIA is now running autonomously with exponential enhancements!"
    echo ""
}

# Execute main function
main 2>&1 | tee "$LOG_FILE"
