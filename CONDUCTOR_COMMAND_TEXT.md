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

1. **Auto-Detect Project Context** (if available)
   - Check if `.conductor-context.md` exists in the current directory
   - If found, parse the YAML frontmatter to extract:
     - `project_name` - Use for file naming and context
     - `repository` - Include in error documentation
     - `language` - Add as tag
     - `framework` - Add as tag and context
     - `default_environment` - Use if user doesn't specify
     - `common_categories` - Add as suggested tags
   - If not found, proceed with manual information gathering

2. **Gather Information** - Ask for (skip fields auto-detected from context file):
   - Error message (exact text) - ALWAYS REQUIRED
   - Stack trace (if available) - ALWAYS REQUIRED
   - Project/repository name - AUTO-DETECTED or ask
   - Programming language and framework - AUTO-DETECTED or ask
   - Environment (dev/staging/production) - AUTO-DETECTED from default_environment or ask
   - When it occurred - AUTO: use current date/time
   - What triggered it - ALWAYS REQUIRED

3. **Navigate to Workspace**
   - Determine workspace path: `${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}`
   - Create files in: `${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}/notes/YYYY-MM-DD-project-error-topic.md`
   - Use template from: `${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}/templates/error-template.md`
   - **Note**: These paths work from any directory because they use Conductor's environment variables

4. **Create Error Documentation** with this structure:

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

5. **File Naming**: `notes/YYYY-MM-DD-project-error-topic.md`
   - Use auto-detected `project_name` if available
   Examples:
   - `notes/2025-11-16-api-postgresql-connection-timeout.md`
   - `notes/2025-11-16-frontend-react-state-update.md`

6. **Severity Levels**:
   - **critical**: System down, data loss, security breach
   - **high**: Major functionality broken, many users affected
   - **medium**: Feature broken, some users affected
   - **low**: Minor issue, edge case

7. **Standard Tags**:
   - Type: `#error`, `#bug`, `#warning`, `#exception`
   - Severity: `#critical`, `#high-priority`, `#medium-priority`, `#low-priority`
   - Category: `#database`, `#api`, `#auth`, `#frontend`, `#backend` (use `common_categories` from context if available)
   - Language: `#python`, `#javascript`, `#typescript`, `#go`, `#rust` (use auto-detected `language` if available)

8. **Check for Duplicates** - Search existing notes before creating new ones

9. **Confirm Completion** - Show:
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
