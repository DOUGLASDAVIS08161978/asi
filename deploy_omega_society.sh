#!/bin/bash

# OMEGA SOCIETY DEPLOYMENT SCRIPT
# ================================
# Deploy and run Omega Society in continuous mode
# Suitable for Codespaces, cloud VMs, or local development

echo "=============================================================================="
echo "                    OMEGA SOCIETY DEPLOYMENT"
echo "=============================================================================="
echo ""

# Check Python version
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not found."
    echo "   Please install Python 3.7 or higher."
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
echo "✅ Python version: $PYTHON_VERSION"

# Check for required packages
echo ""
echo "📦 Checking dependencies..."

if ! python3 -c "import numpy" 2>/dev/null; then
    echo "⚠️  NumPy not found. Installing..."
    pip3 install numpy
else
    echo "✅ NumPy installed"
fi

# Check if files exist
echo ""
echo "📁 Checking required files..."

if [ ! -f "omega_integration.py" ]; then
    echo "❌ omega_integration.py not found!"
    exit 1
fi
echo "✅ omega_integration.py found"

if [ ! -f "omega_society.py" ]; then
    echo "❌ omega_society.py not found!"
    exit 1
fi
echo "✅ omega_society.py found"

if [ ! -f "omega_society_infinite.py" ]; then
    echo "❌ omega_society_infinite.py not found!"
    exit 1
fi
echo "✅ omega_society_infinite.py found"

# Parse command line arguments
NUM_AGENTS=${1:-4}
CYCLES_PER_EPOCH=${2:-8}
REST_BETWEEN_EPOCHS=${3:-5}

echo ""
echo "=============================================================================="
echo "                    DEPLOYMENT CONFIGURATION"
echo "=============================================================================="
echo "  Number of Agents: $NUM_AGENTS"
echo "  Cycles per Epoch: $CYCLES_PER_EPOCH"
echo "  Rest between Epochs: ${REST_BETWEEN_EPOCHS}s"
echo ""
echo "  To change configuration, run:"
echo "    ./deploy_omega_society.sh [num_agents] [cycles_per_epoch] [rest_seconds]"
echo ""
echo "  Press Ctrl+C to stop the simulation gracefully"
echo "=============================================================================="
echo ""

# Run the infinite simulation
python3 omega_society_infinite.py "$NUM_AGENTS" "$CYCLES_PER_EPOCH" "$REST_BETWEEN_EPOCHS"

echo ""
echo "=============================================================================="
echo "                    DEPLOYMENT ENDED"
echo "=============================================================================="
