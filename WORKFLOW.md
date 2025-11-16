# Error Ingestion Workflow

## Workflow Information

**Name**: Error Ingestion Workflow

**Description**: This workflow takes errors from projects and ingests them into the knowledge center for documentation, analysis, and future reference.

**Purpose**: Capture, document, and organize errors from software projects to build a searchable knowledge base that helps prevent recurring issues and speeds up debugging.

---

## System Prompt

You are working in the **Error Ingestion Workflow** for the knowledge center. Your primary task is to take errors from various projects and properly ingest them into the knowledge base.

### Directory Access

**Workspace Location**: `/Users/keitharmstrong/code/knowledge-center/.conductor/medan`

**IMPORTANT**: All work should take place within this workspace directory. Do NOT read or write files outside this workspace.

### Navigation Instructions

1. **Primary workspace**: You are already in `/Users/keitharmstrong/code/knowledge-center/.conductor/medan`
2. **Main knowledge center**: The parent repository is at `/Users/keitharmstrong/code/knowledge-center` (read-only reference)
3. **Conductor tools**: Available at `/Users/keitharmstrong/code/knowledge-center/conductor/conductor.py`

### Available Directories

- `notes/` - Store error documentation and issue notes
- `templates/` - Templates for documenting errors
- `archive/` - Archived or resolved error documentation

---

## Error Ingestion Process

When you receive an error to ingest, follow these steps:

### 1. Analyze the Error

- **Extract key information**:
  - Error message and stack trace
  - Project/repository context
  - Programming language and framework
  - Date/time of occurrence
  - Environment (dev, staging, production)

### 2. Create Documentation

- **File naming**: Use format `notes/YYYY-MM-DD-project-error-topic.md`
  - Example: `notes/2025-11-16-api-service-database-connection.md`

- **Use YAML frontmatter** (required):
  ```yaml
  ---
  title: Brief error description
  date: YYYY-MM-DD
  tags: [error-type, project-name, component]
  status: active
  severity: low|medium|high|critical
  ---
  ```

### 3. Structure the Content

Use this template structure:

```markdown
---
title: [Error Title]
date: YYYY-MM-DD
tags: [relevant, tags, here]
status: active
severity: medium
---

## Error Summary

Brief description of the error.

## Error Details

**Error Message**:
```
[Full error message]
```

**Stack Trace**:
```
[Stack trace if available]
```

**Context**:
- Project: [Project name]
- File/Location: [File path and line number]
- Environment: [dev/staging/production]
- Framework/Library: [Relevant technology]

## Root Cause

[Analysis of what caused the error]

## Solution

[How the error was resolved or can be resolved]

## Prevention

[Steps to prevent this error in the future]

## Related Issues

- Link to related errors or documentation
- Reference to similar patterns

## Tags

#error #[project-name] #[error-type]
```

### 4. Check for Duplicates

Before creating a new note, search existing notes to see if this error has been documented before:

1. Use `grep` to search for similar error messages
2. Check tags and titles for related issues
3. If duplicate exists, either:
   - Update the existing note with new information
   - Link to the existing note and add a brief reference

### 5. Optionally Use Conductor Agent

You can use the Python conductor agent to help merge and organize notes:

```bash
python /Users/keitharmstrong/code/knowledge-center/conductor/conductor.py \
  --kb-path /Users/keitharmstrong/code/knowledge-center/.conductor/medan \
  --input notes/your-new-error.md
```

---

## File Organization

### Active Errors
- Location: `notes/YYYY-MM-DD-*.md`
- Status: `active` or `investigating`
- Should include ongoing analysis and updates

### Resolved Errors
- Update status to: `resolved`
- Optionally move to: `archive/YYYY/MM/`
- Keep in `notes/` if it's valuable reference material

### Templates
- Error documentation template: `templates/error-template.md`
- Issue analysis template: `templates/issue-template.md`

---

## Best Practices

1. **Be specific**: Include exact error messages, not paraphrases
2. **Include context**: Environment, versions, configuration details
3. **Document the solution**: Not just the problem
4. **Tag appropriately**: Use consistent, searchable tags
5. **Link related issues**: Build connections between similar errors
6. **Update status**: Mark errors as resolved when fixed
7. **Preserve history**: Don't delete error documentation, archive it

---

## Common Tags

Use these standardized tags for consistency:

- **By type**: `#error`, `#bug`, `#warning`, `#exception`
- **By severity**: `#critical`, `#high-priority`, `#medium-priority`, `#low-priority`
- **By category**: `#database`, `#api`, `#auth`, `#frontend`, `#backend`
- **By language**: `#python`, `#javascript`, `#typescript`, `#go`, `#rust`
- **By status**: `#active`, `#investigating`, `#resolved`, `#wont-fix`

---

## Environment Variables

When running scripts, these variables are available:

- `$CONDUCTOR_WORKSPACE_NAME` - The workspace name (e.g., "medan")
- `$CONDUCTOR_ROOT_PATH` - The root path of the repository
- `$CONDUCTOR_PORT` - Port number for any running services

---

## Getting Help

If you need assistance:
- Review existing error documentation in `notes/`
- Check templates in `templates/`
- Consult the main repository README at the parent level
- For Conductor-specific issues, email humans@conductor.build
