# Error Slash Command for Claude Code

This file documents the `/error` slash command that should be added to the main repository.

**Target Location**: `/Users/keitharmstrong/code/knowledge-center/.claude/commands/error.md`

---

# Error Submission Command

Submit an error to the knowledge center for documentation and future reference.

## Usage

```
/error [paste error message or describe the error]
```

## What This Does

This command follows the **Error Ingestion Workflow** to:
1. **Analyze** the error you provide
2. **Extract** key information (error message, stack trace, context)
3. **Create** a properly formatted error document in the knowledge center
4. **Check** for duplicate or similar errors
5. **Organize** the error with appropriate tags and metadata
6. **Save** to `/Users/keitharmstrong/code/knowledge-center/.conductor/medan/notes/`

## Workflow Reference

This command implements the workflow defined in:
`/Users/keitharmstrong/code/knowledge-center/.conductor/medan/WORKFLOW.md`

## Instructions for Claude Code

When this command is invoked, you should:

### 1. Gather Error Information

Ask the user for any missing information:
- **Error message** (exact text)
- **Stack trace** (if available)
- **Project/repository** name
- **Programming language** and framework
- **Environment** (dev/staging/production)
- **When it occurred** (date/time)
- **What they were doing** when it happened

### 2. Create Error Documentation

Navigate to: `/Users/keitharmstrong/code/knowledge-center/.conductor/medan/`

Create a new file: `notes/YYYY-MM-DD-[project]-[error-topic].md`

Use the template from: `templates/error-template.md`

### 3. Required YAML Frontmatter

```yaml
---
title: [Brief error description]
date: YYYY-MM-DD
tags: [error-type, project-name, component, language]
status: active
severity: low|medium|high|critical
---
```

### 4. File Naming Convention

Format: `notes/YYYY-MM-DD-project-error-topic.md`

Examples:
- `notes/2025-11-16-api-service-database-connection.md`
- `notes/2025-11-16-frontend-react-state-update.md`
- `notes/2025-11-16-backend-auth-token-validation.md`

### 5. Check for Duplicates

Before creating the file, search existing notes:
- Use `grep` to search for similar error messages
- Check if this error already exists
- If duplicate: update existing note or create a reference

### 6. Structure the Content

Follow this structure:

```markdown
## Error Summary
[Brief description]

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
[Analysis of what caused it]

## Solution
[How to resolve]

## Prevention
[Steps to prevent in future]

## Tags
#error #[project] #[type] #[language]
```

### 7. Determine Severity

- **critical**: System down, data loss, security breach
- **high**: Major functionality broken, many users affected
- **medium**: Feature broken, some users affected
- **low**: Minor issue, edge case, cosmetic

### 8. Use Standard Tags

- **By type**: `#error`, `#bug`, `#warning`, `#exception`
- **By severity**: `#critical`, `#high-priority`, `#medium-priority`, `#low-priority`
- **By category**: `#database`, `#api`, `#auth`, `#frontend`, `#backend`
- **By language**: `#python`, `#javascript`, `#typescript`, `#go`, `#rust`

### 9. Optionally Run Conductor

After creating the error document, you can optionally run:

```bash
python /Users/keitharmstrong/code/knowledge-center/conductor/conductor.py \
  --kb-path /Users/keitharmstrong/code/knowledge-center/.conductor/medan \
  --input notes/YYYY-MM-DD-your-error.md
```

This will check for similar existing errors and suggest merges.

### 10. Confirm Completion

Tell the user:
- ✅ Error documented
- 📁 File location
- 🏷️ Tags applied
- 🔍 Link to any similar errors found

## Examples

### Example 1: Database Connection Error

```
/error PostgreSQL connection timeout in production API
```

**Claude Code will**:
1. Ask for error message and stack trace
2. Ask for project name and context
3. Create: `notes/2025-11-16-api-postgresql-connection-timeout.md`
4. Tag with: `#error`, `#database`, `#postgresql`, `#production`, `#high-priority`
5. Search for similar database errors

### Example 2: Frontend React Error

```
/error React state update on unmounted component
```

**Claude Code will**:
1. Gather component name and code location
2. Ask when/how it occurs
3. Create: `notes/2025-11-16-frontend-react-unmounted-state.md`
4. Tag with: `#error`, `#frontend`, `#react`, `#javascript`
5. Include prevention best practices

### Example 3: Pasting Full Error

```
/error
Traceback (most recent call last):
  File "app.py", line 42, in process_data
    result = data['user']['email']
KeyError: 'email'
```

**Claude Code will**:
1. Parse the stack trace
2. Ask for additional context (project, when it happened)
3. Create formatted error document
4. Suggest validation improvements

## Output Format

After processing, Claude Code should show:

```
✅ Error documented successfully

📁 Location: notes/2025-11-16-api-postgresql-connection-timeout.md
📅 Date: 2025-11-16
🏷️ Tags: #error #database #postgresql #production #high-priority
⚠️ Severity: high
📊 Status: active

🔍 Similar errors found:
   - notes/2025-11-10-api-database-timeout.md (similarity: 8/10)

💡 Next steps:
   1. Review similar errors for patterns
   2. Update status when resolved
   3. Run weekly review to merge insights
```

## Integration with Conductor

After documenting errors, run:
```
/conductor notes/YYYY-MM-DD-your-error.md
```

This will:
- Find related errors
- Suggest which knowledge base files to update
- Help build error pattern documentation

## Best Practices

1. **Be specific** - Include exact error messages
2. **Include context** - Environment, versions, what triggered it
3. **Document solution** - Not just the problem
4. **Update status** - Mark as `resolved` when fixed
5. **Link related issues** - Build connections between errors
6. **Tag consistently** - Use standardized tags

## File Locations

- **Workspace**: `/Users/keitharmstrong/code/knowledge-center/.conductor/medan/`
- **New errors**: `notes/YYYY-MM-DD-*.md`
- **Template**: `templates/error-template.md`
- **Workflow docs**: `WORKFLOW.md`
- **Resolved errors**: Update status or move to `archive/`

## See Also

- [Error Ingestion Workflow](WORKFLOW.md)
- [Error Template](templates/error-template.md)
- [Conductor Command](/conductor)

---

**Quick error documentation at your fingertips - never lose track of bugs again!**
