# Error Ingestion Starter Package

This guide helps you set up automatic error context detection in your projects.

---

## Quick Start

Add this file to any project to enable automatic context detection when using `/error`:

### Step 1: Copy the Template

Copy `.conductor-context.md` to your project root:

```bash
# From your project directory
cp path/to/knowledge-center/.conductor/medan/templates/project-context.md .conductor-context.md
```

Or create it manually using the template below.

### Step 2: Fill in Your Project Details

Edit `.conductor-context.md` with your project's information:

```yaml
---
project_name: my-awesome-api
repository: https://github.com/myorg/my-awesome-api
language: Python
framework: FastAPI
default_environment: development
team: backend-team
---
```

### Step 3: Commit to Version Control

```bash
git add .conductor-context.md
git commit -m "Add Conductor project context for error tracking"
git push
```

### Step 4: Use `/error` Command

Now when you use the `/error` command in this project, it will automatically:
- ✅ Know the project name
- ✅ Know the programming language
- ✅ Know the framework
- ✅ Apply appropriate tags
- ✅ Set default environment

You only need to provide:
- Error message
- Stack trace
- What triggered it

---

## Templates

### Minimal Template (Recommended for Quick Setup)

```yaml
---
project_name: my-project
repository: https://github.com/org/repo
language: Python
framework: FastAPI
default_environment: development
---
```

### Standard Template

```yaml
---
# Project Information
project_name: my-api-service
repository: https://github.com/myorg/my-api-service
description: RESTful API for user management and authentication

# Technology Stack
language: Python
framework: FastAPI

# Tech Stack Details
stack:
  - Python 3.11
  - FastAPI 0.104
  - PostgreSQL 15
  - Redis 7.2

# Environment
default_environment: development

# Team
team: backend-team
owner: engineering

# Common Categories
common_categories:
  - api
  - database
  - authentication
---
```

### Comprehensive Template

```yaml
---
# Project Information
project_name: enterprise-api
repository: https://github.com/myorg/enterprise-api
description: Enterprise-grade API platform with microservices architecture

# Technology Stack
language: Python
framework: FastAPI

# Detailed Stack
stack:
  - Python 3.11
  - FastAPI 0.104
  - PostgreSQL 15
  - Redis 7.2
  - Docker
  - Kubernetes

# Environments
default_environment: development
environments:
  development:
    url: http://localhost:8000
    database: postgresql://localhost/api_dev
  staging:
    url: https://staging-api.company.com
    database: RDS staging instance
  production:
    url: https://api.company.com
    database: RDS production instance

# Team & Ownership
team: platform-backend
owner: engineering
contacts:
  - tech-lead: Alice Smith
  - on-call: backend-oncall@company.com

# Error Categories
common_categories:
  - api
  - database
  - authentication
  - cache
  - background-jobs
  - rate-limiting

# Related Projects
related_projects:
  - name: frontend-dashboard
    relationship: API consumer
  - name: auth-service
    relationship: Authentication provider
  - name: analytics-pipeline
    relationship: Data consumer

# Documentation
docs:
  - architecture: https://wiki.company.com/arch/enterprise-api
  - runbook: https://wiki.company.com/runbooks/enterprise-api
  - api_docs: https://api.company.com/docs
  - monitoring: https://datadog.com/dashboards/enterprise-api

# Custom Metadata
custom:
  deployment_frequency: continuous
  monitoring: datadog
  log_aggregation: elasticsearch
  incident_channel: "#incidents-backend"
---
```

---

## Field Reference

### Required Fields

| Field | Description | Example |
|-------|-------------|---------|
| `project_name` | Name of the project (used in file names) | `my-api-service` |
| `language` | Primary programming language | `Python`, `JavaScript`, `Go` |
| `framework` | Main framework or library | `FastAPI`, `React`, `Express` |

### Recommended Fields

| Field | Description | Example |
|-------|-------------|---------|
| `repository` | GitHub/GitLab URL | `https://github.com/org/repo` |
| `default_environment` | Default deployment environment | `development`, `staging`, `production` |
| `team` | Responsible team | `backend-team`, `frontend-team` |

### Optional Fields

| Field | Description | Example |
|-------|-------------|---------|
| `description` | Brief project description | `RESTful API for user management` |
| `stack` | List of technologies | `[Python 3.11, FastAPI, PostgreSQL]` |
| `common_categories` | Typical error categories | `[api, database, auth]` |
| `owner` | Department or owner | `engineering`, `product` |
| `contacts` | Key people | `tech-lead: Alice` |
| `environments` | Environment-specific config | (see templates above) |
| `related_projects` | Connected projects | (see templates above) |
| `docs` | Documentation links | `architecture: https://...` |
| `custom` | Any custom fields | (anything you need) |

---

## Benefits

### Without `.conductor-context.md`:

```
/error

> What's the error message?
[paste error]

> What project is this from?
my-api-service

> What language?
Python

> What framework?
FastAPI

> What environment?
development

> When did it occur?
just now

> What triggered it?
[explain]
```

**7 questions to answer!**

### With `.conductor-context.md`:

```
/error

> What's the error message?
[paste error]

> What triggered it?
[explain]
```

**2 questions to answer!**

Project name, language, framework, and environment are auto-detected.

---

## Multi-Project Setup

If you work on multiple projects, set up context files for each:

```
~/code/
├── api-service/
│   └── .conductor-context.md   # Python/FastAPI project
├── frontend-app/
│   └── .conductor-context.md   # TypeScript/React project
├── data-pipeline/
│   └── .conductor-context.md   # Go project
└── mobile-app/
    └── .conductor-context.md   # Swift/iOS project
```

The `/error` command will automatically use the correct context based on your current directory.

---

## Language-Specific Examples

### Python/Django

```yaml
---
project_name: django-backend
repository: https://github.com/org/django-backend
language: Python
framework: Django
stack:
  - Python 3.11
  - Django 4.2
  - PostgreSQL 15
  - Celery
  - Redis
default_environment: development
common_categories:
  - orm
  - migrations
  - celery
  - rest-api
---
```

### JavaScript/Node.js/Express

```yaml
---
project_name: express-api
repository: https://github.com/org/express-api
language: JavaScript
framework: Express
stack:
  - Node.js 18
  - Express 4.18
  - MongoDB 6
  - Redis 7
default_environment: development
common_categories:
  - api
  - database
  - middleware
  - authentication
---
```

### TypeScript/React

```yaml
---
project_name: react-dashboard
repository: https://github.com/org/react-dashboard
language: TypeScript
framework: React
stack:
  - TypeScript 5.0
  - React 18
  - Next.js 14
  - TailwindCSS
default_environment: development
common_categories:
  - frontend
  - state-management
  - routing
  - api-client
---
```

### Go

```yaml
---
project_name: go-microservice
repository: https://github.com/org/go-microservice
language: Go
framework: Gin
stack:
  - Go 1.21
  - Gin 1.9
  - PostgreSQL 15
  - gRPC
default_environment: development
common_categories:
  - grpc
  - database
  - concurrency
  - microservices
---
```

### Rust

```yaml
---
project_name: rust-service
repository: https://github.com/org/rust-service
language: Rust
framework: Actix
stack:
  - Rust 1.75
  - Actix Web 4
  - PostgreSQL 15
  - Tokio
default_environment: development
common_categories:
  - async
  - database
  - web-server
  - performance
---
```

---

## FAQ

### Q: Do I need this file in every project?

**A:** No, it's optional. Without it, the `/error` command will ask you for all information manually. But having it saves a lot of time!

### Q: Can I share this file with my team?

**A:** Yes! Commit it to version control so everyone on your team benefits from automatic context detection.

### Q: What if I work on multiple projects in the same repository (monorepo)?

**A:** You can place `.conductor-context.md` files in subdirectories. The workflow will search up the directory tree to find the nearest one.

### Q: Can I customize the fields?

**A:** Yes! Add any custom fields you need in the `custom` section or as top-level YAML fields.

### Q: Does this work outside of Conductor?

**A:** The workflow is designed for Conductor but you can read the context file in any tool that understands YAML frontmatter.

---

## Next Steps

1. **Set up your first project** - Add `.conductor-context.md` to your main project
2. **Test it** - Use `/error` and see the automatic context detection in action
3. **Roll out to other projects** - Add context files to all your active projects
4. **Share with team** - Commit and push so teammates can benefit too

---

## Template Location

The master template is available at:

```
${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}/templates/project-context.md
```

You can also find it in the knowledge center repository at:

```
/Users/keitharmstrong/code/knowledge-center/.conductor/medan/templates/project-context.md
```

---

## Support

For questions or issues:
- Check the [Error Ingestion Workflow](WORKFLOW.md) documentation
- Review the [Path Resolution Guide](PATH_RESOLUTION.md)
- Contact the team via your normal channels

Happy error documenting! 🐛➡️📚
