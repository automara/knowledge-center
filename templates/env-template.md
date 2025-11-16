# Environment Variables Template

This document tracks all environment variables used across the project. Update this when adding new tools or services.

## Purpose

- **Source of truth** for all environment variables
- **Documentation** for what each variable does
- **Reference** when setting up new workspaces or Railway environments

## How to Use

1. Copy the appropriate `.env.*` file to your workspace
2. Fill in actual values (never commit real secrets!)
3. Update this template when adding new variables
4. Sync to Railway UI for deployment environments

---

## Core Application Variables

### API Keys & Secrets

```bash
# Application secret key (generate with: openssl rand -hex 32)
APP_SECRET_KEY=your_secret_key_here

# API base URL
API_BASE_URL=http://localhost:3000
```

### Database

```bash
# PostgreSQL connection
DATABASE_URL=postgresql://user:password@localhost:5432/dbname

# Redis (if using)
REDIS_URL=redis://localhost:6379
```

### Authentication

```bash
# JWT Secret (generate with: openssl rand -hex 32)
JWT_SECRET=your_jwt_secret_here
JWT_EXPIRES_IN=7d

# OAuth providers (if applicable)
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=
GITHUB_CLIENT_ID=
GITHUB_CLIENT_SECRET=
```

---

## External Services

### AI/ML Services

```bash
# OpenAI
OPENAI_API_KEY=sk-...

# Anthropic Claude
ANTHROPIC_API_KEY=sk-ant-...

# Other AI services
COHERE_API_KEY=
HUGGINGFACE_TOKEN=
```

### Cloud Services

```bash
# AWS
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_REGION=us-east-1
S3_BUCKET_NAME=

# Vercel (if using)
VERCEL_TOKEN=

# Supabase (if using)
SUPABASE_URL=
SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
```

### Communication Services

```bash
# Email (SendGrid, Postmark, etc.)
SENDGRID_API_KEY=
EMAIL_FROM=noreply@example.com

# Twilio (SMS)
TWILIO_ACCOUNT_SID=
TWILIO_AUTH_TOKEN=
TWILIO_PHONE_NUMBER=

# Slack (notifications)
SLACK_WEBHOOK_URL=
SLACK_BOT_TOKEN=
```

### Analytics & Monitoring

```bash
# Sentry
SENTRY_DSN=

# Analytics
GOOGLE_ANALYTICS_ID=
MIXPANEL_TOKEN=

# Logging
LOG_LEVEL=info
```

---

## Development Tools

```bash
# Node environment
NODE_ENV=development

# Port configuration
PORT=3000
HOST=localhost

# Conductor-specific (auto-provided by Conductor)
# CONDUCTOR_WORKSPACE_NAME (provided by Conductor)
# CONDUCTOR_WORKSPACE_PATH (provided by Conductor)
# CONDUCTOR_ROOT_PATH (provided by Conductor)
# CONDUCTOR_PORT (provided by Conductor)
```

---

## Environment-Specific Notes

### Development (.env.development)
- Use localhost URLs
- Enable verbose logging
- Use development API keys (if available)
- Lower rate limits for faster testing

### Staging (.env.staging)
- Mirror production setup
- Use staging databases
- Enable debug mode
- Use test payment processors

### Production (.env.production)
- Production API keys only
- Strict error handling
- Optimized logging
- Real payment processors
- Set in Railway UI (not in file)

---

## Railway Deployment

For Railway deployments:

1. Go to your Railway project dashboard
2. Navigate to Variables tab
3. Copy variables from `.env.production`
4. Never store production secrets in Git

### Railway-Specific Variables

```bash
# Railway auto-provides these:
# RAILWAY_STATIC_URL
# RAILWAY_PROJECT_ID
# RAILWAY_ENVIRONMENT_NAME

# You need to set these manually:
# (Copy from .env.production)
```

---

## Security Best Practices

1. **Never commit** `.env` files with real secrets
2. **Rotate secrets** when team members leave
3. **Use different keys** for dev/staging/production
4. **Generate strong secrets** (32+ character random strings)
5. **Document** what each variable does (here!)

---

## Adding New Variables

When adding a new tool or service:

1. ✅ Add variable to this template
2. ✅ Add to appropriate `.env.*` files
3. ✅ Update Railway UI if needed for staging/prod
4. ✅ Run `scripts/sync-env.sh` to update existing workspaces
5. ✅ Document what it does and where to get the key

---

## Quick Reference Commands

```bash
# Generate a secret key
openssl rand -hex 32

# Copy development env to current workspace
cp $CONDUCTOR_ROOT_PATH/.env.development .env

# Sync updated template to all workspaces
./scripts/sync-env.sh

# Check what environment variables are set
printenv | grep -v CONDUCTOR | sort
```

---

**Last Updated:** 2025-11-16
**Maintained by:** Keith Armstrong
**Questions?** Update this file when you add variables!
