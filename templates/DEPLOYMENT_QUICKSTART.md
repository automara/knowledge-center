# Deployment System Quick Start

## TL;DR

Every project created with `keithstart` now includes:
- ✅ Railway configuration (automatic)
- ✅ Staging & production environment templates
- ✅ URL display in Claude Code responses
- ✅ GitHub → Railway auto-deployment

## For New Projects

When you run `keithstart project-name`, you get:

```
project-name/
├── railway.json              # Railway config
├── .env.staging              # Staging template
├── .env.production           # Production template
├── .project.json             # URLs configured
├── .claude/
│   ├── helpers/
│   │   └── show-urls.sh      # Display URLs
│   └── DEPLOYMENT_INSTRUCTIONS.md
└── docs/
    └── DEPLOYMENT.md         # Full guide
```

## Setup (One Time Per Project)

### 1. Install Railway CLI

```bash
npm i -g @railway/cli
railway login
```

### 2. Initialize Railway

```bash
cd your-project
railway init
railway link
```

### 3. Create Environments

Railway Dashboard:
1. Create "staging" environment
2. Set branch to `staging`
3. Enable auto-deploy

Production is created automatically (deploys from `main`).

### 4. Set Environment Variables

Railway Dashboard → Variables:
- Copy from `.env.staging` for staging
- Copy from `.env.production` for production
- Replace placeholders with real values

## Daily Workflow

### Develop Locally

```bash
# In Conductor workspace
npm run dev
# → http://localhost:3000
```

### Deploy to Staging

```bash
git add .
git commit -m "feat: new feature"
git push origin HEAD:staging --force
# → https://project-staging.up.railway.app
```

### Deploy to Production

```bash
gh pr create --base main
# After review & merge:
# → https://project.up.railway.app
```

## Claude Code Integration

Claude Code automatically shows URLs after relevant changes:

```
✅ Changes complete!

🔗 Project URLs
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   Localhost:   http://localhost:3000
   Staging:     https://project-staging.up.railway.app
   Production:  https://project.up.railway.app

Click any URL to open in browser →
```

**Manually show URLs:**
```bash
./.claude/helpers/show-urls.sh
```

## Environment Files

| File | Purpose | Committed? |
|------|---------|------------|
| `.env` | Local dev (workspace-specific) | ❌ No |
| `.env.staging` | Template for Railway staging | ✅ Yes (no secrets) |
| `.env.production` | Template for Railway prod | ✅ Yes (no secrets) |

**Important:** `.env.staging` and `.env.production` are templates only. Set real secrets in Railway UI.

## Branch Strategy

```
feature-branch
     ↓
   staging  → Railway Staging
     ↓ (via PR)
    main   → Railway Production
```

## URLs Structure

Railway provides:
- **Staging:** `https://[project]-staging.up.railway.app`
- **Production:** `https://[project].up.railway.app`

Or set custom domain in Railway dashboard.

## Common Commands

```bash
# View all URLs
./.claude/helpers/show-urls.sh

# View staging logs
railway logs --environment staging

# View production logs
railway logs --environment production

# Open Railway dashboard
railway open

# Run migration on staging
railway run --environment staging npm run migrate
```

## Quick Reference

| Action | Command |
|--------|---------|
| Show URLs | `./.claude/helpers/show-urls.sh` |
| Deploy staging | `git push origin HEAD:staging --force` |
| Deploy prod | Merge PR to `main` |
| View logs | `railway logs --environment staging` |
| Open dashboard | `railway open` |

## For Existing Projects

To add deployment system to existing projects:

```bash
# Copy templates from knowledge-center
cp ~/code/knowledge-center/.conductor/[workspace]/project-init/mandatory/railway.json .
cp ~/code/knowledge-center/.conductor/[workspace]/project-init/mandatory/.env.staging .
cp ~/code/knowledge-center/.conductor/[workspace]/project-init/mandatory/.env.production .
cp -r ~/code/knowledge-center/.conductor/[workspace]/project-init/mandatory/.claude/helpers .claude/

# Update .project.json with deployment config
# See: ~/code/knowledge-center/.conductor/[workspace]/project-init/mandatory/.project.json

# Follow setup steps above
```

## Troubleshooting

### URLs not showing in Claude Code?

```bash
# Check if helper script exists
ls .claude/helpers/show-urls.sh

# Check if .project.json has deployment config
cat .project.json | jq '.deployment'
```

### Deployment failed?

```bash
railway logs --environment staging
# Check for:
# - Missing env vars
# - Build errors
# - Port issues
```

### Want different port locally?

```bash
# Set in your workspace .env
PORT=3001

# Or use Conductor's port
# Automatically uses $CONDUCTOR_PORT
```

## Documentation

- **Full Guide:** `docs/DEPLOYMENT.md` (in your project)
- **System Design:** `docs/DEPLOYMENT_SYSTEM.md` (in knowledge-center)
- **Claude Instructions:** `.claude/DEPLOYMENT_INSTRUCTIONS.md`

## Security Checklist

- [ ] Never commit real secrets to Git
- [ ] Use different secrets for staging/prod
- [ ] Set secrets in Railway UI only
- [ ] Protect `main` branch (require PR reviews)
- [ ] Test on staging before production
- [ ] Rotate secrets when team members leave

---

**Generated by keithstart deployment system**
**Last Updated:** 2025-11-16
