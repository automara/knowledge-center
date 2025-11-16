# Project Context Template

This file provides automatic context for error documentation and other workflows.

Place this file as `.conductor-context.md` in the root of each project to enable automatic context detection.

---

```yaml
---
# Project Information
project_name: my-project-name
repository: https://github.com/org/repo
description: Brief description of what this project does

# Technology Stack
language: Python  # Primary language: Python, JavaScript, TypeScript, Go, Rust, Java, etc.
framework: FastAPI  # Main framework: FastAPI, Django, React, Next.js, Express, etc.

# Tech Stack Details (optional but recommended)
stack:
  - Python 3.11
  - FastAPI 0.104
  - PostgreSQL 15
  - Redis 7.2
  - Docker

# Environment Information
default_environment: development  # development, staging, production
environments:
  development:
    url: http://localhost:8000
    database: postgresql://localhost/myapp_dev
  staging:
    url: https://staging.myapp.com
    database: RDS instance
  production:
    url: https://myapp.com
    database: RDS instance

# Team & Ownership
team: backend-team  # Team responsible for this project
owner: engineering  # Department or primary owner
contacts:
  - tech-lead: Alice Smith
  - on-call: backend-oncall@company.com

# Common Error Categories (helps with tagging)
common_categories:
  - api
  - database
  - authentication
  - cache
  - background-jobs

# Related Projects (optional)
related_projects:
  - name: frontend-app
    relationship: API consumer
  - name: auth-service
    relationship: Authentication provider

# Documentation Links (optional)
docs:
  - architecture: https://wiki.company.com/arch/my-project
  - runbook: https://wiki.company.com/runbooks/my-project
  - api_docs: https://api.myapp.com/docs

# Custom Fields (add any project-specific context)
custom:
  deployment_frequency: daily
  monitoring: datadog
  log_aggregation: elasticsearch
---

# Additional Notes

Add any additional context or notes about the project here that might be useful
for error documentation or troubleshooting.

## Common Issues

- Issue 1: Description
- Issue 2: Description

## Quick References

- Deployment process: [link]
- Configuration management: [link]
- Dependency documentation: [link]
```

---

## Usage

1. Copy this template to your project root as `.conductor-context.md`
2. Fill in the YAML frontmatter with your project's information
3. Commit it to version control
4. The error ingestion workflow will automatically read this file to populate context

## Auto-Population

When you use `/error` in a project with this file, the workflow will automatically:

- ✅ Set `project_name` from the context file
- ✅ Set `language` and `framework` tags
- ✅ Include repository link
- ✅ Use `default_environment` if not specified
- ✅ Apply `common_categories` as suggested tags
- ✅ Link to relevant documentation

You'll only need to provide:
- The actual error message
- Stack trace (if available)
- What triggered it
- Any project-specific details

## Example: Minimal Context File

For quick setup, here's a minimal version:

```yaml
---
project_name: my-api
repository: https://github.com/myorg/my-api
language: Python
framework: FastAPI
default_environment: development
team: backend
---
```

Even this minimal file saves you from entering the same information repeatedly!
