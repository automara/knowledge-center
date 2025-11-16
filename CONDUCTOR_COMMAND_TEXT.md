# Conductor Command Configuration

Use this text to create the `/error` command in Conductor.

---

## Name

```
error
```

## Content

```
Submit an error to the knowledge center for documentation and future reference.

You are following the **Error Ingestion Workflow** to document errors from projects.

## Your Task

When the user provides an error, you should:

1. **Gather Information** - Ask for:
   - Error message (exact text)
   - Stack trace (if available)
   - Project/repository name
   - Programming language and framework
   - Environment (dev/staging/production)
   - When it occurred
   - What triggered it

2. **Navigate to Workspace**
   - Determine workspace path: `${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}`
   - Create files in: `${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}/notes/YYYY-MM-DD-project-error-topic.md`
   - Use template from: `${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}/templates/error-template.md`
   - **Note**: These paths work from any directory because they use Conductor's environment variables

3. **Create Error Documentation** with this structure:

```yaml
---
title: [Brief error description]
date: YYYY-MM-DD
tags: [error-type, project-name, component, language]
status: active
severity: low|medium|high|critical
---

## Error Summary
[1-2 sentence description]

## Error Details

**Error Message**:
```
[Exact error text]
```

**Stack Trace**:
```
[Full stack trace]
```

**Context**:
- Project: [name]
- File/Location: [path:line]
- Environment: [dev/staging/production]
- Framework/Library: [technology]

## Root Cause
[What caused it]

## Solution
[How to resolve]

## Prevention
[Steps to prevent in future]

## Tags
#error #[project] #[type] #[language]
```

4. **File Naming**: `notes/YYYY-MM-DD-project-error-topic.md`
   Examples:
   - `notes/2025-11-16-api-postgresql-connection-timeout.md`
   - `notes/2025-11-16-frontend-react-state-update.md`

5. **Severity Levels**:
   - **critical**: System down, data loss, security breach
   - **high**: Major functionality broken, many users affected
   - **medium**: Feature broken, some users affected
   - **low**: Minor issue, edge case

6. **Standard Tags**:
   - Type: `#error`, `#bug`, `#warning`, `#exception`
   - Severity: `#critical`, `#high-priority`, `#medium-priority`, `#low-priority`
   - Category: `#database`, `#api`, `#auth`, `#frontend`, `#backend`
   - Language: `#python`, `#javascript`, `#typescript`, `#go`, `#rust`

7. **Check for Duplicates** - Search existing notes before creating new ones

8. **Confirm Completion** - Show:
   - ✅ Error documented
   - 📁 File location
   - 🏷️ Tags applied
   - 🔍 Similar errors found (if any)

## See Also
- Full workflow: `WORKFLOW.md`
- Error template: `templates/error-template.md`
```

---

**Copy the content between the triple backticks above and paste it into the "Content" field in Conductor.**
