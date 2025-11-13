#!/bin/bash

# Quick Start Script for ASI/ARIA Unified System
# Makes it easy to run the system

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                                                                ║"
echo "║        🌟 ASI/ARIA UNIFIED SYSTEM - QUICK START 🌟            ║"
echo "║                                                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "Select run mode:"
echo "1) Unified System (ARIA + Documentation)"
echo "2) ARIA Only"
echo "3) Show Info"
echo "4) Python ASI"
echo "5) Python AEON"
echo ""
read -p "Enter choice [1-5]: " choice

case $choice in
    1)
        echo "Starting Unified System..."
        node unified_launcher.js
        ;;
    2)
        echo "Starting ARIA Only..."
        node aria.js
        ;;
    3)
        echo "Showing System Info..."
        node unified_launcher.js --info
        ;;
    4)
        echo "Starting Python ASI..."
        python3 asi.py
        ;;
    5)
        echo "Starting Python AEON..."
        python3 aeon.py
        ;;
    *)
        echo "Invalid choice. Defaulting to Unified System..."
        node unified_launcher.js
        ;;
esac
