# Environment Setup Guide

Complete guide for managing environment variables across Conductor workspaces and Railway deployments.

## Table of Contents

1. [Quick Start](#quick-start)
2. [How It Works](#how-it-works)
3. [Creating a New Workspace](#creating-a-new-workspace)
4. [Updating Environment Variables](#updating-environment-variables)
5. [Railway Deployment](#railway-deployment)
6. [Testing Setup](#testing-setup)
7. [Troubleshooting](#troubleshooting)

---

## Quick Start

### For a Brand New Workspace

When you create a new workspace in Conductor, the environment will be set up automatically:

1. **Create workspace** in Conductor (it will run the setup script)
2. **Review `.env`** file in your workspace
3. **Fill in your API keys** and secrets
4. **Start coding!**

### For Existing Workspaces

If you have existing workspaces that need the new environment setup:

```bash
# From repository root
./scripts/sync-env.sh development
```

This will copy `.env.development` to all workspace `.env` files.

---

## How It Works

### Directory Structure

```
/knowledge-center/                    # Repository root (CONDUCTOR_ROOT_PATH)
├── .env.development                  # Development template (NOT in Git)
├── .env.staging                      # Staging template (NOT in Git)
├── .env.production                   # Production template (NOT in Git)
├── conductor.json                    # Auto-setup configuration (IN Git)
├── scripts/
│   └── sync-env.sh                   # Sync tool (IN Git)
├── templates/
│   └── env-template.md               # Documentation (IN Git)
├── docs/
│   └── environment-setup.md          # This file (IN Git)
└── .conductor/
    ├── cancun/                       # Workspace 1
    │   └── .env                      # Workspace-specific (NOT in Git)
    ├── tokyo/                        # Workspace 2
    │   └── .env                      # Workspace-specific (NOT in Git)
    └── ...
```

### What Gets Committed to Git

✅ **DO commit:**
- `conductor.json` - Setup automation
- `scripts/sync-env.sh` - Sync tool
- `templates/env-template.md` - Documentation
- `docs/environment-setup.md` - This guide

❌ **DON'T commit:**
- `.env.development` - Local dev secrets
- `.env.staging` - Staging secrets
- `.env.production` - Production secrets (use Railway UI)
- `.conductor/*/\.env` - Workspace .env files

### Automatic Setup Flow

1. You create a new Conductor workspace
2. Conductor runs the `setup` script from `conductor.json`
3. Script copies `.env.development` from repo root → workspace `.env`
4. You fill in workspace-specific values
5. Ready to code! 🚀

---

## Creating a New Workspace

### Step 1: Ensure Templates Exist at Repo Root

Before creating workspaces, make sure you have environment templates:

```bash
# Navigate to repository root
cd /Users/keitharmstrong/code/knowledge-center

# Check if templates exist
ls -la .env.*

# If they don't exist, copy from an existing workspace
cp .conductor/cancun/.env.development .env.development
cp .conductor/cancun/.env.staging .env.staging
cp .conductor/cancun/.env.production .env.production
```

### Step 2: Create Workspace in Conductor

1. Open Conductor
2. Click "New Workspace" or equivalent
3. Name your workspace (e.g., `feature-auth`, `bugfix-login`)
4. Conductor automatically runs the setup script
5. Check the output - should see: "✅ Copied .env.development to workspace .env"

### Step 3: Configure Workspace Environment

```bash
# Navigate to your new workspace
cd .conductor/your-workspace-name

# Edit the .env file
code .env  # or vim, nano, etc.

# Fill in your values:
# - API keys (OpenAI, Anthropic, etc.)
# - Database URLs (if different from default)
# - Service credentials
# - Workspace-specific settings
```

### Step 4: Verify Setup

```bash
# Check environment is loaded
cat .env | grep -v "^#" | grep -v "^$"

# If you have a Node.js app, you can test:
node -e "require('dotenv').config(); console.log(process.env.OPENAI_API_KEY ? '✅ Loaded' : '❌ Not loaded')"
```

---

## Updating Environment Variables

### Scenario 1: Adding a New Variable

When you add a new tool or service:

1. **Update the template**:
   ```bash
   # Edit the environment template documentation
   code templates/env-template.md

   # Add your new variable with description
   ```

2. **Add to environment files**:
   ```bash
   # Edit all environment templates at repo root
   echo "NEW_SERVICE_API_KEY=your_key_here" >> .env.development
   echo "NEW_SERVICE_API_KEY=staging_key" >> .env.staging
   echo "NEW_SERVICE_API_KEY=prod_key" >> .env.production
   ```

3. **Sync to all workspaces**:
   ```bash
   # This will copy .env.development to all workspaces
   # (Creates backups automatically)
   ./scripts/sync-env.sh development
   ```

4. **Update each workspace** (if values differ):
   ```bash
   # For workspaces needing different values
   cd .conductor/specific-workspace
   code .env  # Edit manually
   ```

5. **Update Railway** (for staging/production):
   - Go to Railway dashboard
   - Add the new variable
   - Redeploy

### Scenario 2: Changing an Existing Variable

```bash
# Option A: Manual (for one workspace)
cd .conductor/workspace-name
code .env

# Option B: Sync (for all workspaces)
# 1. Update the template at repo root
code ../.env.development

# 2. Sync to all workspaces
cd ..
./scripts/sync-env.sh development

# 3. Verify
grep "YOUR_VARIABLE" .conductor/*/\.env
```

### Scenario 3: Workspace-Specific Values

Some variables might need different values per workspace:

```bash
# Example: Different database per workspace
cd .conductor/feature-payments
echo "DATABASE_URL=postgresql://localhost:5432/payments_db" >> .env

cd .conductor/feature-auth
echo "DATABASE_URL=postgresql://localhost:5432/auth_db" >> .env
```

**Tip:** Use Conductor's `$CONDUCTOR_PORT` for port-specific configs:

```bash
# In your app's startup script
PORT=${CONDUCTOR_PORT:-3000}
```

---

## Railway Deployment

### Initial Railway Setup

1. **Create Railway Project**:
   - Go to [Railway](https://railway.app)
   - Create new project
   - Connect your GitHub repository
   - Select branch (usually `main`)

2. **Add Environment Variables**:
   - Go to project → Variables tab
   - Copy from `.env.production` template
   - **DO NOT copy directly** - fill in real production values
   - Click "Add Variable" for each one

3. **Configure Deployment**:
   - Set build command
   - Set start command
   - Configure health checks (optional)

### Staging vs Production

#### Create Two Railway Environments

**Option A: Two Projects**
- Create `my-app-staging` project
- Create `my-app-production` project
- Duplicate variables between them

**Option B: Environments (Railway feature)**
- Use Railway's environment feature
- Create `staging` and `production` environments
- Set different variables for each

### Syncing Variables to Railway

When you update environment variables:

1. **Update local template**:
   ```bash
   code .env.staging  # or .env.production
   ```

2. **Manually update Railway**:
   - Go to Railway dashboard
   - Variables tab
   - Update or add variables
   - Railway will auto-redeploy

3. **Verify deployment**:
   ```bash
   # Check Railway logs
   railway logs --project your-project --environment production

   # Or use Railway CLI
   railway variables --project your-project
   ```

### Railway-Specific Variables

Railway auto-provides these:

```bash
RAILWAY_STATIC_URL          # Your app URL
RAILWAY_PROJECT_ID          # Project identifier
RAILWAY_ENVIRONMENT_NAME    # staging or production
```

Use them in your app:

```javascript
const isDev = !process.env.RAILWAY_ENVIRONMENT_NAME;
const baseUrl = process.env.RAILWAY_STATIC_URL || 'http://localhost:3000';
```

### Railway + Database Example

```bash
# Railway PostgreSQL plugin automatically provides:
DATABASE_URL=postgresql://user:pass@host:port/db

# You can use this directly in your app
# No need to set it manually!
```

---

## Testing Setup

### Testing Environment Configuration

Create a test-specific environment for running tests:

1. **Create `.env.test`** at repo root:
   ```bash
   # Copy from development
   cp .env.development .env.test

   # Modify for testing
   cat > .env.test << 'EOF'
   NODE_ENV=test
   DATABASE_URL=postgresql://localhost:5432/test_db

   # Use mock services
   MOCK_OPENAI=true
   MOCK_EMAIL=true
   MOCK_SMS=true

   # Disable external services
   SENTRY_DSN=
   ANALYTICS_ENABLED=false

   # Fast timeouts for tests
   REQUEST_TIMEOUT=1000
   EOF
   ```

2. **Load in tests**:
   ```javascript
   // test-setup.js
   require('dotenv').config({ path: '.env.test' });
   ```

3. **Run tests**:
   ```bash
   # With npm
   npm test

   # With specific env
   NODE_ENV=test npm test
   ```

### Testing Different Configurations

```bash
# Test with development env
cp .env.development .env
npm run dev

# Test with staging env (simulate production)
cp .env.staging .env
npm run build && npm start

# Switch back to development
cp .env.development .env
```

---

## Troubleshooting

### Problem: `.env` file not found in workspace

**Solution:**
```bash
# Check if template exists at repo root
ls -la ~/.../knowledge-center/.env.development

# If not, copy from existing workspace
cp .conductor/cancun/.env.development ../.env.development

# Then sync to all workspaces
./scripts/sync-env.sh development
```

### Problem: Environment variables not loading in app

**Diagnostic:**
```bash
# Check if .env exists
ls -la .env

# Check contents (be careful - contains secrets!)
cat .env | grep -v "^#" | head -5

# Verify your app loads dotenv
# For Node.js:
node -e "require('dotenv').config(); console.log(Object.keys(process.env).filter(k => !k.startsWith('CONDUCTOR')).slice(0,5))"
```

**Common causes:**
- `.env` file not in the right directory
- App not using `dotenv` or equivalent
- Variables not exported in shell scripts

**Fix:**
```javascript
// At the very top of your entry file
require('dotenv').config();

// Or use import
import 'dotenv/config';
```

### Problem: Different workspaces need different values

This is expected and desired! Options:

1. **Manual per-workspace config** (recommended):
   ```bash
   cd .conductor/specific-workspace
   code .env  # Edit manually
   ```

2. **Workspace-specific templates**:
   ```bash
   # Create workspace-specific template
   cp .env.development .env.workspace-specific

   # Document it
   echo "# Use for workspace: feature-payments" >> .env.workspace-specific
   ```

3. **Use Conductor variables**:
   ```bash
   # In .env
   DATABASE_URL=postgresql://localhost:5432/${CONDUCTOR_WORKSPACE_NAME}_db
   ```

### Problem: Sync script overwrites manual changes

**Prevention:**
The script creates automatic backups:
```bash
# Your changes are saved as:
.env.backup.20251116_143022

# Restore if needed:
cp .env.backup.20251116_143022 .env
```

**Better approach:**
```bash
# Don't sync to specific workspace
# Instead, manually copy and merge:
cp ../.env.development .env.new
diff .env .env.new  # See differences
# Manually merge changes
```

### Problem: Railway deployment fails with "Missing environment variable"

**Solution:**
```bash
# Check what variables your app needs
grep -r "process.env" . --include="*.js" | grep -v node_modules

# Compare with Railway
railway variables --project your-project

# Add missing variables via Railway UI or CLI:
railway variables set VARIABLE_NAME=value --project your-project
```

### Problem: Too many environment files to manage

**Consolidation:**
```bash
# Use a .env manager like direnv or dotenv-vault
# Or consolidate to fewer templates:

# Keep only:
# - .env.development (for all local dev)
# - .env.production (reference only, real values in Railway)
```

---

## Advanced Patterns

### Using Multiple Environment Files

```javascript
// Load multiple .env files
require('dotenv').config({ path: '.env' });
require('dotenv').config({ path: '.env.local' }); // overrides
```

### Validating Environment Variables

```javascript
// env-validator.js
const required = [
  'DATABASE_URL',
  'JWT_SECRET',
  'OPENAI_API_KEY'
];

required.forEach(key => {
  if (!process.env[key]) {
    throw new Error(`Missing required environment variable: ${key}`);
  }
});
```

### Environment Variable Versioning

```bash
# Tag your env templates with versions
cp .env.development .env.development.v1
echo "# Version 2 - Added OpenAI" >> .env.development
```

---

## Quick Reference

### Commands

```bash
# Sync env to all workspaces
./scripts/sync-env.sh development

# Create backup
cp .env .env.backup.$(date +%Y%m%d)

# List all env files
ls -la | grep "\.env"

# Search for a variable
grep "OPENAI_API_KEY" .conductor/*/.env

# Update Railway
railway variables set KEY=value --project my-app
```

### File Locations

```bash
# Templates (repo root)
$CONDUCTOR_ROOT_PATH/.env.development
$CONDUCTOR_ROOT_PATH/.env.staging
$CONDUCTOR_ROOT_PATH/.env.production

# Workspace env (auto-created)
$CONDUCTOR_WORKSPACE_PATH/.env

# Documentation
templates/env-template.md
docs/environment-setup.md

# Scripts
scripts/sync-env.sh
```

---

## Need Help?

1. **Check the template**: `templates/env-template.md`
2. **Review this guide**: `docs/environment-setup.md`
3. **Conductor docs**: https://docs.conductor.build/tips/conductor-env
4. **Railway docs**: https://docs.railway.app/develop/variables

---

**Last Updated:** 2025-11-16
**Maintained by:** Keith Armstrong
