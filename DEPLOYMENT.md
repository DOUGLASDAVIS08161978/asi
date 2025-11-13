# ASI Application Deployment Guide

This guide provides instructions for deploying the ASI (Artificial Super Intelligence) application.

## Prerequisites

- Docker and Docker Compose installed
- Python 3.11 or higher (for local development)
- Git

## Quick Start with Docker

### 1. Build and Run with Docker Compose

The easiest way to deploy is using Docker Compose:

```bash
# Clone the repository
git clone https://github.com/DOUGLASDAVIS08161978/asi.git
cd asi

# Build and start the application
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the application
docker-compose down
```

### 2. Build and Run with Docker

Alternatively, you can use Docker directly:

```bash
# Build the image
docker build -t asi-app:latest .

# Run the container
docker run -d \
  --name asi-app \
  -v $(pwd)/data:/app/data \
  asi-app:latest

# View logs
docker logs -f asi-app

# Stop the container
docker stop asi-app
docker rm asi-app
```

## Local Development Deployment

### 1. Set up Python environment

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate  # On Linux/Mac
# or
venv\Scripts\activate  # On Windows

# Install dependencies
pip install -r requirements.txt
```

### 2. Run the application

```bash
# Run the main ASI script
python asi.py

# Or run AEON script
python aeon.py
```

## CI/CD Pipeline

The repository includes a GitHub Actions workflow that:

1. **Tests** - Validates Python syntax and imports
2. **Builds** - Creates Docker image
3. **Deploys** - Prepares artifacts for deployment

The workflow runs automatically on:
- Push to main/master branch
- Pull requests to main/master branch
- Manual trigger via workflow_dispatch

## Environment Variables

- `PYTHONUNBUFFERED=1` - Ensures Python output is not buffered
- `GENESIS_MEMORY_PATH=/app/data/genesis_memory.pkl` - Path for persistent memory storage

## Data Persistence

The application stores persistent memory in a pickle file. When using Docker:
- Data is stored in `./data` directory on the host
- This directory is mounted to `/app/data` in the container
- Memory persists across container restarts

## Deployment Options

### Option 1: Local Docker
Use Docker Compose for local deployment (recommended for development and testing).

### Option 2: Cloud Deployment

#### AWS
- Use AWS ECS or EKS to deploy the Docker container
- Store data in EFS or S3

#### Google Cloud
- Use Google Cloud Run or GKE
- Store data in Cloud Storage or Persistent Disks

#### Azure
- Use Azure Container Instances or AKS
- Store data in Azure Blob Storage or Azure Files

#### DigitalOcean
- Use DigitalOcean App Platform or Kubernetes
- Store data in Spaces or Volume storage

### Option 3: VPS Deployment
Deploy to any VPS (DigitalOcean, Linode, etc.):

```bash
# SSH into your server
ssh user@your-server

# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Clone and deploy
git clone https://github.com/DOUGLASDAVIS08161978/asi.git
cd asi
docker-compose up -d
```

## Monitoring

### View Application Logs

```bash
# Docker Compose
docker-compose logs -f

# Docker
docker logs -f asi-app
```

### Check Container Status

```bash
# Docker Compose
docker-compose ps

# Docker
docker ps
```

## Troubleshooting

### Container won't start
- Check logs: `docker-compose logs`
- Verify dependencies: `pip install -r requirements.txt`
- Check disk space: `df -h`

### Memory persistence issues
- Ensure `./data` directory exists and is writable
- Check volume mounts: `docker inspect asi-app`

### Python errors
- Verify Python version: `python --version` (should be 3.11+)
- Reinstall dependencies: `pip install --upgrade -r requirements.txt`

## Security Considerations

1. **Data Protection** - Ensure the data directory has appropriate permissions
2. **Network Security** - Use firewalls to restrict access if deploying publicly
3. **Updates** - Regularly update dependencies and base Docker images

## Scaling

For production deployments:
1. Use orchestration tools like Kubernetes
2. Implement health checks
3. Set up monitoring and alerting
4. Use external data stores (databases, object storage)
5. Implement logging aggregation

## Support

For issues or questions:
- Open an issue on GitHub
- Check existing documentation
- Review logs for error messages
