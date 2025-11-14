# CI/CD Pipeline Documentation

## Overview

This repository includes a complete CI/CD (Continuous Integration/Continuous Deployment) pipeline using GitHub Actions.

---

## 🔄 CI Pipeline (`ci.yml`)

The CI pipeline runs automatically on:
- Every push to `main`, `develop`, or `copilot/**` branches
- Every pull request to `main` or `develop` branches

### Jobs Included

#### 1. **Test Node.js Components**
- Tests on Node.js 18.x and 20.x
- Validates JavaScript files (aria.js, unified_launcher.js)
- Runs syntax checks
- Tests ARIA system execution

#### 2. **Test Python Components**
- Tests on Python 3.10, 3.11, and 3.12
- Validates Python files (asi.py, aeon.py, etc.)
- Runs syntax checks
- Tests module execution

#### 3. **Lint and Format Check**
- Checks JavaScript syntax
- Validates documentation files

#### 4. **Integration Test**
- Runs full system integration test
- Tests unified_launcher.js
- Generates test reports
- Uploads artifacts

#### 5. **Security Scan**
- Runs Trivy vulnerability scanner
- Uploads results to GitHub Security
- Continuous security monitoring

#### 6. **Build Summary**
- Generates comprehensive build summary
- Shows test results across all components

---

## 🚀 CD Pipeline (`cd.yml`)

The CD pipeline runs on:
- Pushes to `main` branch
- Version tags (`v*.*.*`)
- Manual workflow dispatch

### Jobs Included

#### 1. **Create Release**
- Triggers on version tags
- Creates GitHub releases
- Attaches deployment artifacts
- Generates release notes

#### 2. **Build Artifacts**
- Creates deployment packages
- Generates tarballs
- Includes all necessary files
- Uploads artifacts (retained 90 days)

#### 3. **Docker Build**
- Builds Docker image
- Tests Docker container
- Saves image as artifact
- Supports multi-architecture

#### 4. **Deploy to Staging**
- Deploys to staging environment
- Runs on main branch pushes
- Can be triggered manually
- Generates deployment summary

#### 5. **Deploy to Production**
- Deploys to production environment
- Triggers on version tags
- Requires manual approval
- Generates deployment summary

#### 6. **Notifications**
- Sends deployment notifications
- Reports success/failure status

---

## 📋 How to Use

### Triggering CI

CI runs automatically. No action needed.

```bash
# Push to trigger CI
git push origin your-branch

# Create PR to trigger CI
gh pr create
```

### Triggering CD

#### Option 1: Push to Main
```bash
git checkout main
git merge your-branch
git push origin main
```

#### Option 2: Create Release Tag
```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

#### Option 3: Manual Dispatch
1. Go to Actions tab in GitHub
2. Select "CD - Continuous Deployment"
3. Click "Run workflow"
4. Choose environment (staging/production)
5. Click "Run workflow" button

---

## 🎯 Status Badges

Add these to your README.md:

```markdown
![CI](https://github.com/DOUGLASDAVIS08161978/asi/workflows/CI%20-%20Continuous%20Integration/badge.svg)
![CD](https://github.com/DOUGLASDAVIS08161978/asi/workflows/CD%20-%20Continuous%20Deployment/badge.svg)
```

---

## 📦 Artifacts

### CI Artifacts
- **test-report**: Test execution summary (retained 30 days)

### CD Artifacts
- **aria-deployment-package**: Complete deployment package (retained 90 days)
- **aria-docker-image**: Docker container image (retained 30 days)

### Downloading Artifacts

1. Go to Actions tab
2. Click on a workflow run
3. Scroll to "Artifacts" section
4. Download desired artifacts

---

## 🔒 Security

### Automated Security Scanning
- Trivy vulnerability scanner runs on every CI build
- Results uploaded to GitHub Security tab
- Alerts created for vulnerabilities

### Secret Management
- Use GitHub Secrets for sensitive data
- Never commit credentials to repository
- Rotate secrets regularly

### Adding Secrets

```bash
# Via GitHub UI
Settings → Secrets and variables → Actions → New repository secret

# Via GitHub CLI
gh secret set SECRET_NAME
```

---

## 🐳 Docker Deployment

The CD pipeline automatically builds Docker images:

### Building Locally
```bash
docker build -t aria-system:latest .
docker run -it aria-system:latest
```

### Using Pre-built Image
```bash
# Download artifact from GitHub Actions
tar -xzf aria-docker-image.tar.gz
docker load < aria-system-latest.tar

# Run container
docker run -d --name aria aria-system:latest
```

---

## 🌍 Environments

### Staging Environment
- **URL**: `https://staging.example.com`
- **Triggers**: Push to main branch
- **Purpose**: Pre-production testing

### Production Environment
- **URL**: `https://production.example.com`
- **Triggers**: Version tags (v*.*.*)
- **Purpose**: Live production deployment

### Configuring Environments

1. Go to Settings → Environments
2. Create environment (staging/production)
3. Add protection rules
4. Configure environment secrets
5. Set deployment URL

---

## 📊 Monitoring

### Build Status
- View in Actions tab
- Check status badges
- Review workflow logs

### Deployment Status
- Check environment status
- View deployment history
- Monitor deployment logs

### Notifications
Configure notifications in:
- Settings → Notifications
- Watch repository for Actions

---

## 🔧 Customization

### Modifying CI Workflow

Edit `.github/workflows/ci.yml`:

```yaml
# Add new test job
new-test-job:
  name: New Test
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - name: Run test
      run: echo "Custom test"
```

### Modifying CD Workflow

Edit `.github/workflows/cd.yml`:

```yaml
# Add deployment step
- name: Custom deploy
  run: |
    echo "Custom deployment"
```

---

## 🐛 Troubleshooting

### CI Failures

**Problem**: Tests timing out
**Solution**: Adjust timeout values in workflow

**Problem**: Python dependency issues
**Solution**: Add requirements.txt with dependencies

**Problem**: Node.js version conflicts
**Solution**: Update matrix versions in workflow

### CD Failures

**Problem**: Artifact upload fails
**Solution**: Check artifact size limits (2GB max)

**Problem**: Docker build fails
**Solution**: Verify Dockerfile syntax, check logs

**Problem**: Deployment fails
**Solution**: Check environment variables, secrets

---

## 📚 Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [Docker Documentation](https://docs.docker.com/)

---

## ✅ Workflow Status

After setup, you should see:

```
✅ CI - Continuous Integration: Passing
✅ CD - Continuous Deployment: Passing
✅ Security Scan: No vulnerabilities
✅ All tests: Passing
```

---

## 🎉 Benefits

- ✅ **Automated Testing**: Every commit tested automatically
- ✅ **Multiple Environments**: Test in Python 3.10-3.12, Node 18-20
- ✅ **Security Scanning**: Continuous vulnerability monitoring
- ✅ **Artifact Management**: Deployment packages retained
- ✅ **Docker Support**: Containerized deployments
- ✅ **Release Automation**: Automatic GitHub releases
- ✅ **Deployment Pipeline**: Staging → Production flow
- ✅ **Status Monitoring**: Real-time build status

---

**Your CI/CD pipeline is now fully configured and ready to use! 🚀**
