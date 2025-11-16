# Environment Management Quick Start

**TL;DR:** This project uses workspace-specific environment files managed through Conductor. New workspaces get `.env` automatically. Railway deployments use their own UI.

---

## For New Workspaces

When you create a new Conductor workspace:

1. ✅ **Automatic setup** - `.env` is copied from repo root automatically
2. 📝 **Fill in values** - Edit `.env` and add your API keys
3. 🚀 **Start coding** - Environment is ready!

```bash
# Your workspace already has:
.env  # ← Add your API keys here
```

---

## Quick Commands

### Check Your Environment

```bash
# See if .env exists
ls -la .env

# View (careful - contains secrets!)
cat .env
```

### Copy Environment Template

```bash
# If .env is missing, copy from repo root:
cp $CONDUCTOR_ROOT_PATH/.env.development .env
```

### Update All Workspaces

When you add new environment variables:

```bash
# From repo root
./scripts/sync-env.sh development
```

This syncs `.env.development` to all workspace `.env` files (with auto-backup).

---

## File Structure

```
/knowledge-center/
├── .env.development      ← Template (at repo root, NOT in Git)
├── .env.staging          ← For Railway staging
├── .env.production       ← For Railway production (template only)
├── scripts/
│   └── sync-env.sh       ← Sync tool
├── templates/
│   └── env-template.md   ← Full variable documentation
├── docs/
│   └── environment-setup.md  ← Complete guide
└── .conductor/
    ├── cancun/
    │   └── .env          ← Your workspace env (NOT in Git)
    └── other-workspace/
        └── .env          ← Different values per workspace
```

---

## What Goes Where

### Local Development (Conductor Workspaces)

- **Template**: `.env.development` at repo root
- **Workspace**: `.env` in each workspace (auto-copied from template)
- **Customize**: Edit workspace `.env` for workspace-specific values

### Railway Deployment

- **Staging**: Set variables in Railway UI (reference: `.env.staging`)
- **Production**: Set variables in Railway UI (reference: `.env.production`)
- **Never** commit production secrets to Git!

---

## Common Tasks

### Adding a New API Key

```bash
# 1. Update the template documentation
code templates/env-template.md

# 2. Add to environment template
echo "NEW_API_KEY=your_value_here" >> .env.development

# 3. Sync to all workspaces
./scripts/sync-env.sh development

# 4. Update Railway (if needed)
# Go to Railway dashboard → Variables → Add variable
```

### Workspace-Specific Values

Some workspaces may need different values:

```bash
# Edit just this workspace
code .env

# Example: Different database per feature
DATABASE_URL=postgresql://localhost:5432/my_feature_db
```

### Setting Up Railway

```bash
# 1. Copy variables from .env.production
cat .env.production

# 2. Go to Railway dashboard
# 3. Variables tab
# 4. Add each variable manually (with real production values)

# Don't copy-paste directly - use production-grade secrets!
```

---

## Environment Variables Provided by Conductor

These are automatically available (don't set them):

- `CONDUCTOR_WORKSPACE_NAME` - Current workspace name
- `CONDUCTOR_WORKSPACE_PATH` - Absolute path to workspace
- `CONDUCTOR_ROOT_PATH` - Repository root path
- `CONDUCTOR_PORT` - Port range for this workspace (avoids conflicts)
- `CONDUCTOR_DEFAULT_BRANCH` - Usually `main`

**Use them in your app:**
```bash
# In package.json or scripts
PORT=${CONDUCTOR_PORT:-3000}
```

---

## Troubleshooting

### `.env` missing in workspace

```bash
# Copy from repo root
cp $CONDUCTOR_ROOT_PATH/.env.development .env
```

### Need to restore old `.env` after sync

```bash
# Sync creates backups automatically
ls -la .env.backup.*

# Restore
cp .env.backup.20251116_143022 .env
```

### Environment variables not loading

```javascript
// Make sure you load dotenv at the top of your entry file
require('dotenv').config();
```

---

## Documentation

- **📘 Full Guide**: `docs/environment-setup.md` (complete reference)
- **📝 Variable Docs**: `templates/env-template.md` (all variables explained)
- **🔧 This File**: Quick reference for common tasks

---

## Security Reminders

- ❌ Never commit `.env` files to Git
- ❌ Never commit real API keys or secrets
- ✅ Use different secrets for dev/staging/production
- ✅ Generate strong random secrets (32+ characters)
- ✅ Rotate secrets when team members leave
- ✅ Set production secrets in Railway UI only

---

**Questions?** Check `docs/environment-setup.md` for detailed explanations.

**Last Updated:** 2025-11-16
