---
title: Design system for storing project URLs and metadata
date: 2025-11-16
tags: [design, feature-request, project-init, metadata, urls]
status: active
severity: medium
---

# Project Metadata Storage System Design

## Summary

Need a standardized system for storing project metadata including live URLs, GitHub repository links, API endpoints, and other relevant project information. This should be integrated into the `keithstart` project initialization workflow.

## Problem Statement

Currently, there's no consistent place to store:
- Live/production URLs
- Staging URLs
- GitHub repository URLs
- API endpoints
- Documentation URLs
- Related service URLs
- Project metadata (created date, type, owner, etc.)

This makes it difficult for:
- Claude Code to reference the correct URLs when testing
- Developers to quickly find project resources
- Automated tools to discover project configuration
- Conductor workspaces to access project context

## Proposed Solution

### Option 1: `.project.json` Metadata File

Create a standardized `.project.json` file in the project root with comprehensive metadata:

```json
{
  "name": "project-name",
  "displayName": "Project Display Name",
  "type": "node|python|go",
  "version": "1.0.0",
  "created": "2025-11-16",
  "owner": {
    "name": "Keith Armstrong",
    "github": "https://github.com/automara",
    "email": "keith@example.com"
  },
  "repository": {
    "type": "github",
    "url": "https://github.com/automara/project-name",
    "ssh": "git@github.com:automara/project-name.git"
  },
  "urls": {
    "production": "https://project-name.com",
    "staging": "https://staging.project-name.com",
    "preview": "https://preview.project-name.com",
    "docs": "https://docs.project-name.com",
    "api": "https://api.project-name.com"
  },
  "endpoints": {
    "api": {
      "base": "https://api.project-name.com/v1",
      "graphql": "https://api.project-name.com/graphql",
      "websocket": "wss://api.project-name.com/ws"
    },
    "admin": "https://admin.project-name.com"
  },
  "services": {
    "database": "postgresql",
    "cache": "redis",
    "storage": "s3",
    "monitoring": "https://app.datadoghq.com/...",
    "logs": "https://app.logtail.com/...",
    "errors": "https://sentry.io/..."
  },
  "integrations": {
    "vercel": {
      "projectId": "prj_...",
      "url": "https://vercel.com/automara/project-name"
    },
    "railway": {
      "projectId": "...",
      "url": "https://railway.app/project/..."
    }
  },
  "conductor": {
    "enabled": true,
    "defaultWorkspace": "project-name",
    "contextFile": ".conductor-context.md"
  },
  "metadata": {
    "description": "Brief project description",
    "tags": ["api", "typescript", "postgresql"],
    "status": "active|development|archived",
    "license": "MIT",
    "documentation": "https://github.com/automara/project-name/wiki"
  }
}
```

### Option 2: Extended `.env` with URL Section

Add a dedicated URL section to `.env.example`:

```bash
# Project URLs
PROJECT_URL_PRODUCTION=https://project-name.com
PROJECT_URL_STAGING=https://staging.project-name.com
PROJECT_URL_PREVIEW=https://preview.project-name.com

# Repository
PROJECT_GITHUB_URL=https://github.com/automara/project-name

# API Endpoints
API_BASE_URL=https://api.project-name.com/v1
API_GRAPHQL_URL=https://api.project-name.com/graphql

# Services
MONITORING_URL=https://app.datadoghq.com/...
ERROR_TRACKING_URL=https://sentry.io/...
```

**Pros**: Already in `.env` format, familiar to developers
**Cons**: Not as structured, harder for tools to parse, mixed with secrets

### Option 3: Hybrid Approach (Recommended)

Use **both** systems:

1. **`.project.json`** for static, public metadata:
   - Project info (name, type, created date)
   - Repository URLs
   - Public URLs (production, docs)
   - Project structure/configuration
   - Owner information

2. **`.env`** for environment-specific, potentially sensitive data:
   - Environment-specific URLs (staging, preview)
   - API endpoints with auth
   - Service URLs with credentials

**Example `.project.json` (minimal version)**:

```json
{
  "name": "[project-name]",
  "type": "node|python|go",
  "created": "YYYY-MM-DD",
  "repository": "https://github.com/automara/[project-name]",
  "owner": "https://github.com/automara",
  "urls": {
    "production": "",
    "docs": "",
    "github": "https://github.com/automara/[project-name]"
  },
  "conductor": {
    "enabled": false
  }
}
```

## Implementation Plan

### 1. Create Template

Create `project-init/mandatory/.project.json`:

```json
{
  "name": "[project-name]",
  "displayName": "[Project Name]",
  "type": "node",
  "version": "0.1.0",
  "created": "YYYY-MM-DD",
  "owner": {
    "github": "https://github.com/automara"
  },
  "repository": {
    "url": "https://github.com/automara/[project-name]"
  },
  "urls": {
    "production": "",
    "staging": "",
    "docs": ""
  },
  "conductor": {
    "enabled": false
  }
}
```

### 2. Update `keithstart.sh`

Add `.project.json` to the customization step:

```bash
# In the sed replacement section
find "$PROJECT_PATH" -type f \( -name "*.md" -o -name "*.json" ... \) -print0 | while IFS= read -r -d '' file; do
    $SED_CMD -i '' "s/\[Project Name\]/$PROJECT_NAME/g" "$file"
    $SED_CMD -i '' "s/\[project-name\]/$PROJECT_NAME/g" "$file"
    $SED_CMD -i '' "s/YYYY-MM-DD/$CURRENT_DATE/g" "$file"
done
```

### 3. Add CLI Commands

Add helper commands to work with project metadata:

```bash
# Get project URL
project-url production
project-url staging

# Set project URL
project-url production https://myapp.com

# Show all metadata
project-info

# Edit metadata
project-edit
```

### 4. Integrate with Conductor

Update Conductor context detection to read from `.project.json`:

```bash
# In conductor context detection
if [ -f ".project.json" ]; then
  PROJECT_NAME=$(jq -r '.name' .project.json)
  PROJECT_TYPE=$(jq -r '.type' .project.json)
  GITHUB_URL=$(jq -r '.repository.url' .project.json)
  # ... auto-populate context
fi
```

### 5. Update Documentation

- Add `.project.json` documentation to project README template
- Update `keithstart` README to explain metadata system
- Add examples to knowledge center

## Benefits

### For Developers

- Quick access to all project URLs in one place
- Consistent location across all projects
- Machine-readable format for tooling

### For Claude Code

- Auto-discover project URLs for testing
- Reference GitHub repo without asking user
- Populate context automatically

### For Conductor

- Enhanced context detection
- Better workspace initialization
- Seamless integration with project metadata

### For CI/CD

- Single source of truth for deployment URLs
- Validate URLs before deployment
- Generate documentation automatically

## Migration Strategy

1. **New Projects**: Include `.project.json` by default via `keithstart`
2. **Existing Projects**: Optional, add manually or via helper command
3. **Backward Compatibility**: System is purely additive, no breaking changes

## Related Files

Files that should reference `.project.json`:

- `README.md` - Link to repository
- `.conductor-context.md` - Import metadata
- `.github/workflows/*` - Use for deployments
- `package.json` or equivalent - Repository URL

## Acceptance Criteria

- [ ] `.project.json` template created
- [ ] `keithstart` updated to include and customize template
- [ ] Template includes all standard fields
- [ ] Placeholders properly replaced during initialization
- [ ] Documentation updated
- [ ] Tested with `keithstart` on macOS and Linux
- [ ] Conductor integration updated to read from `.project.json`
- [ ] README template updated to reference `.project.json`

## Examples

### Node.js Project

```json
{
  "name": "api-service",
  "type": "node",
  "created": "2025-11-16",
  "repository": "https://github.com/automara/api-service",
  "owner": "https://github.com/automara",
  "urls": {
    "production": "https://api.myapp.com",
    "staging": "https://staging-api.myapp.com",
    "docs": "https://docs.myapp.com"
  },
  "endpoints": {
    "graphql": "https://api.myapp.com/graphql",
    "rest": "https://api.myapp.com/v1"
  }
}
```

### Python Project

```json
{
  "name": "ml-pipeline",
  "type": "python",
  "created": "2025-11-16",
  "repository": "https://github.com/automara/ml-pipeline",
  "owner": "https://github.com/automara",
  "urls": {
    "production": "",
    "jupyter": "https://jupyter.mylab.com",
    "docs": ""
  }
}
```

## Timeline

- **2025-11-16** - Design documented
- **Status**: Pending implementation

## Next Steps

1. Create GitHub issue for implementation
2. Design minimal viable `.project.json` schema
3. Create template file
4. Update `keithstart.sh`
5. Test with new project
6. Update documentation

---

## Tags

#design #feature-request #project-init #metadata #urls #medium-priority #active #keithstart
