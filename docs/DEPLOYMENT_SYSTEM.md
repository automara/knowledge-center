# Deployment System: Localhost → Staging → Production

## Overview

Simple deployment pipeline integrated with keithstart:
- **Localhost**: Conductor workspaces (`.env`)
- **Staging**: Railway deployment from `staging` branch
- **Production**: Railway deployment from `main` branch

## Architecture

```
┌─────────────┐
│  localhost  │ → Your Conductor workspace
│   (port)    │   .env with local settings
└─────────────┘

┌─────────────┐
│   staging   │ → Railway auto-deploy from `staging` branch
│ (staging.*) │   Railway environment variables
└─────────────┘

┌─────────────┐
│ production  │ → Railway auto-deploy from `main` branch
│ (custom URL)│   Railway environment variables
└─────────────┘
```

## Railway Setup (Per Project)

### 1. GitHub → Railway Connection

Railway watches your repository branches:
- **staging branch** → Auto-deploys to staging environment
- **main branch** → Auto-deploys to production environment

### 2. Environment Configuration

Each Railway environment has its own variables set in the UI:
- Staging uses `.env.staging` as a reference (never committed with secrets)
- Production uses `.env.production` as a reference (never committed with secrets)

### 3. URL Structure

Railway provides:
- **Staging**: `https://[project]-staging.up.railway.app`
- **Production**: `https://[project].up.railway.app` or custom domain

## Workflow

### Development
```bash
# In your Conductor workspace
cd .conductor/[workspace-name]

# Environment is already set up
cat .env  # Local configuration

# Develop & test
npm run dev
# → http://localhost:3000 (or $CONDUCTOR_PORT)
```

### Deploy to Staging
```bash
# Commit your work
git add .
git commit -m "feat: new feature"

# Push to staging branch
git push origin your-branch:staging --force

# Railway auto-deploys
# → https://[project]-staging.up.railway.app
```

### Deploy to Production
```bash
# Merge to main via PR
gh pr create --base main

# After PR approval and merge
# Railway auto-deploys to production
# → https://[project].up.railway.app
```

## Claude Code Integration

Claude Code automatically displays relevant URLs after updates:

```
✅ Changes complete!

🔗 URLs:
   Localhost:   http://localhost:3000
   Staging:     https://myapp-staging.up.railway.app
   Production:  https://myapp.up.railway.app

Click to open →
```

## Project Configuration

### `.project.json` (Added by keithstart)

```json
{
  "deployment": {
    "provider": "railway",
    "environments": {
      "development": {
        "url": "http://localhost:${PORT}",
        "branch": "current"
      },
      "staging": {
        "url": "https://[project-name]-staging.up.railway.app",
        "branch": "staging"
      },
      "production": {
        "url": "https://[project-name].up.railway.app",
        "branch": "main"
      }
    }
  }
}
```

### `railway.json` (Added by keithstart)

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "numReplicas": 1,
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

## Environment Files

### Localhost: `.env`
```bash
NODE_ENV=development
PORT=3000
DATABASE_URL=postgresql://localhost:5432/myapp_dev
API_URL=http://localhost:3000
```

### Staging: `.env.staging` (Template)
```bash
NODE_ENV=staging
# Railway provides PORT automatically
DATABASE_URL=${{Railway.POSTGRES_URL}}  # Set in Railway UI
API_URL=https://myapp-staging.up.railway.app
```

### Production: `.env.production` (Template)
```bash
NODE_ENV=production
# Railway provides PORT automatically
DATABASE_URL=${{Railway.POSTGRES_URL}}  # Set in Railway UI
API_URL=https://myapp.up.railway.app
```

## Railway CLI Setup (Optional)

```bash
# Install Railway CLI
npm i -g @railway/cli

# Login
railway login

# Link project
railway link

# View logs
railway logs

# Open dashboard
railway open
```

## Safety & Best Practices

### Branch Protection
- Protect `main` branch (require PR reviews)
- Protect `staging` branch (force pushes allowed for testing)

### Environment Variables
- ❌ Never commit real secrets to Git
- ✅ Use Railway UI to set production secrets
- ✅ Use `.env.staging` and `.env.production` as templates only
- ✅ Rotate secrets regularly

### Deployment Checklist
- [ ] Test locally first
- [ ] Deploy to staging
- [ ] Test on staging URL
- [ ] Create PR to main
- [ ] Get review approval
- [ ] Merge (auto-deploys to production)
- [ ] Verify production URL

## Troubleshooting

### Deployment Failed
```bash
# Check Railway logs
railway logs --environment staging

# Or via dashboard
railway open
```

### Environment Variable Issues
- Verify in Railway UI: Variables tab
- Check Railway logs for missing vars
- Compare with `.env.staging` or `.env.production` templates

### URL Not Working
- Check Railway deployment status
- Verify build completed successfully
- Check service is running (Railway dashboard)

## Quick Reference

| Action | Command | Result |
|--------|---------|--------|
| Start local | `npm run dev` | localhost:3000 |
| Deploy staging | `git push origin HEAD:staging --force` | staging.railway.app |
| Deploy prod | Merge PR to main | production.railway.app |
| View logs | `railway logs` | Stream deployment logs |
| Open dashboard | `railway open` | Open Railway UI |

---

**Generated by keithstart deployment system**
**Last Updated:** 2025-11-16
