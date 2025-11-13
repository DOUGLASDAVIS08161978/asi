# Quick Start Guide

## Fastest Way to Deploy ASI

### Option 1: Using the Deploy Script (Recommended)
```bash
git clone https://github.com/DOUGLASDAVIS08161978/asi.git
cd asi
./deploy.sh
# Select option 3 (Run with Docker Compose)
```

### Option 2: Docker Compose
```bash
git clone https://github.com/DOUGLASDAVIS08161978/asi.git
cd asi
docker-compose up -d
```

### Option 3: Local Python
```bash
git clone https://github.com/DOUGLASDAVIS08161978/asi.git
cd asi
pip install -r requirements.txt
python asi.py
```

## Common Commands

### Start Application
```bash
docker-compose up -d
```

### Stop Application
```bash
docker-compose down
```

### View Logs
```bash
docker-compose logs -f
```

### Check Status
```bash
docker-compose ps
```

### Rebuild After Changes
```bash
docker-compose up -d --build
```

## Files Overview

- **asi.py** - Main ASI application
- **aeon.py** - AEON AI system
- **requirements.txt** - Python dependencies
- **Dockerfile** - Container definition
- **docker-compose.yml** - Orchestration config
- **deploy.sh** - Interactive deployment script
- **DEPLOYMENT.md** - Complete deployment guide
- **README.md** - Project documentation

## Quick Troubleshooting

**Problem**: Container won't start  
**Solution**: `docker-compose logs` to check errors

**Problem**: Import errors  
**Solution**: `pip install -r requirements.txt`

**Problem**: Permission denied on deploy.sh  
**Solution**: `chmod +x deploy.sh`

## Next Steps

For detailed documentation, see:
- [DEPLOYMENT.md](DEPLOYMENT.md) - Full deployment guide
- [README.md](README.md) - Project documentation
