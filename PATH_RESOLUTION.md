# Path Resolution Guide

This document explains how the Error Ingestion Workflow handles file paths to work seamlessly from any directory.

## Problem

Previously, the workflow used hardcoded paths like `/Users/keitharmstrong/code/knowledge-center/.conductor/medan/`, which:
- Only worked on one specific machine
- Failed when working from different directories
- Wasn't portable across users or systems

## Solution

The workflow now uses **Conductor's environment variables** for dynamic path resolution.

---

## Environment Variables

Conductor provides these environment variables automatically:

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `$CONDUCTOR_ROOT_PATH` | Absolute path to repository root | `/Users/keitharmstrong/code/knowledge-center` |
| `$CONDUCTOR_WORKSPACE_NAME` | Name of the current workspace | `medan` |
| `$CONDUCTOR_PORT` | Port number for services | `3000` |

---

## Path Construction

### Workspace Path

The workspace path is constructed as:

```bash
WORKSPACE_PATH="${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}"
```

**Example**:
- `CONDUCTOR_ROOT_PATH` = `/Users/keitharmstrong/code/knowledge-center`
- `CONDUCTOR_WORKSPACE_NAME` = `medan`
- Result: `/Users/keitharmstrong/code/knowledge-center/.conductor/medan`

### Key Directories

All paths are constructed relative to the workspace:

```bash
# Workspace root
WORKSPACE="${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}"

# Notes directory
NOTES_DIR="${WORKSPACE}/notes"

# Templates directory
TEMPLATES_DIR="${WORKSPACE}/templates"

# Archive directory
ARCHIVE_DIR="${WORKSPACE}/archive"

# Repository root (for conductor.py)
REPO_ROOT="${CONDUCTOR_ROOT_PATH}"

# Conductor agent
CONDUCTOR_PY="${REPO_ROOT}/conductor/conductor.py"
```

---

## Usage in Different Contexts

### 1. In Conductor Workspaces (Recommended)

When running in Conductor, environment variables are automatically available:

```bash
# Access workspace
cd ${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}

# Create error note
touch ${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}/notes/2025-11-16-my-error.md

# Run conductor agent
python ${CONDUCTOR_ROOT_PATH}/conductor/conductor.py \
  --kb-path ${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME} \
  --input notes/2025-11-16-my-error.md
```

### 2. From Any Directory

Because paths use environment variables, commands work from **any directory**:

```bash
# You are in: /some/other/project
pwd
# Output: /some/other/project

# But this still works:
cd ${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}
# Now in: /Users/keitharmstrong/code/knowledge-center/.conductor/medan
```

### 3. In Scripts (conductor.json)

The `conductor.json` scripts use environment variables:

```json
{
  "scripts": {
    "setup": "WORKSPACE_PATH=\"${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}\" && cd \"$WORKSPACE_PATH\" && pwd",
    "run": "cd \"${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}\" && pwd"
  }
}
```

### 4. In Command Instructions

When writing instructions for agents:

```markdown
## Navigate to Workspace

Determine workspace path:
- Path: `${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}`
- Create files in: `${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}/notes/`
- Use template: `${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}/templates/error-template.md`
```

---

## Portability Benefits

### ✅ Works Across Users

```bash
# User: keitharmstrong
CONDUCTOR_ROOT_PATH=/Users/keitharmstrong/code/knowledge-center

# User: sarah
CONDUCTOR_ROOT_PATH=/Users/sarah/code/knowledge-center

# Same command works for both:
cd ${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}
```

### ✅ Works Across Machines

```bash
# Mac
CONDUCTOR_ROOT_PATH=/Users/keitharmstrong/code/knowledge-center

# Linux
CONDUCTOR_ROOT_PATH=/home/keitharmstrong/code/knowledge-center

# Windows (WSL)
CONDUCTOR_ROOT_PATH=/mnt/c/Users/keitharmstrong/code/knowledge-center

# Same command works everywhere
```

### ✅ Works From Any Directory

```bash
# In project directory
cd /Users/keitharmstrong/code/my-app

# Can still access knowledge center
cd ${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}
```

---

## Fallback Strategy

If environment variables are **not set** (e.g., running outside Conductor):

### Option 1: Manual Override

Set them manually:

```bash
export CONDUCTOR_ROOT_PATH="/Users/keitharmstrong/code/knowledge-center"
export CONDUCTOR_WORKSPACE_NAME="medan"
```

### Option 2: Use Absolute Paths

As a last resort, use absolute paths:

```bash
cd /Users/keitharmstrong/code/knowledge-center/.conductor/medan
```

### Option 3: Auto-Detection (Future Enhancement)

A helper function could search up the directory tree:

```bash
find_workspace() {
  local current="$PWD"
  while [[ "$current" != "/" ]]; do
    if [[ -d "$current/.conductor/medan" ]]; then
      echo "$current/.conductor/medan"
      return 0
    fi
    current="$(dirname "$current")"
  done
  return 1
}

WORKSPACE=$(find_workspace)
```

---

## Examples

### Creating an Error Note

```bash
# Determine paths
WORKSPACE="${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}"
DATE=$(date +%Y-%m-%d)
ERROR_FILE="${WORKSPACE}/notes/${DATE}-api-timeout.md"

# Create file
cat > "$ERROR_FILE" <<EOF
---
title: API timeout error
date: ${DATE}
tags: [error, api, timeout]
status: active
severity: high
---

## Error Summary
API request timed out after 30 seconds.
EOF

echo "Created: $ERROR_FILE"
```

### Running Conductor Agent

```bash
# Paths
WORKSPACE="${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}"
CONDUCTOR_PY="${CONDUCTOR_ROOT_PATH}/conductor/conductor.py"

# Run
python "$CONDUCTOR_PY" \
  --kb-path "$WORKSPACE" \
  --input "notes/2025-11-16-api-timeout.md"
```

### Checking for Duplicates

```bash
WORKSPACE="${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}"

# Search for similar errors
grep -r "timeout" "${WORKSPACE}/notes/"
```

---

## Troubleshooting

### Issue: "Environment variable not set"

**Cause**: Running outside Conductor context

**Solution**: Set manually or use absolute paths

```bash
export CONDUCTOR_ROOT_PATH="/Users/keitharmstrong/code/knowledge-center"
export CONDUCTOR_WORKSPACE_NAME="medan"
```

### Issue: "Directory not found"

**Cause**: Incorrect workspace name or repository path

**Solution**: Verify environment variables

```bash
echo "Root: $CONDUCTOR_ROOT_PATH"
echo "Workspace: $CONDUCTOR_WORKSPACE_NAME"
echo "Full path: ${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}"
ls -la "${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}"
```

### Issue: "Working from wrong directory"

**Cause**: Relative paths used when not in workspace

**Solution**: Always use fully constructed paths or navigate first

```bash
# Navigate first
cd "${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}"

# Then use relative paths
ls notes/
cat templates/error-template.md
```

---

## Best Practices

1. **Always use environment variables** in scripts and documentation
2. **Construct full paths** for file operations
3. **Quote paths** in shell commands to handle spaces
4. **Validate paths exist** before using them
5. **Document fallbacks** for non-Conductor contexts

### Good Example

```bash
WORKSPACE="${CONDUCTOR_ROOT_PATH}/.conductor/${CONDUCTOR_WORKSPACE_NAME}"
if [[ -d "$WORKSPACE" ]]; then
  cd "$WORKSPACE" && pwd
else
  echo "Error: Workspace not found at $WORKSPACE"
  exit 1
fi
```

### Bad Example

```bash
# Hardcoded path - won't work for other users
cd /Users/keitharmstrong/code/knowledge-center/.conductor/medan
```

---

## Summary

| Aspect | Old Approach | New Approach |
|--------|-------------|--------------|
| **Paths** | Hardcoded absolute | Environment variables |
| **Portability** | Single user/machine | Any user/machine |
| **Flexibility** | Must be in specific directory | Works from anywhere |
| **Maintenance** | Manual path updates | Automatic resolution |

The environment variable approach makes the workflow **portable**, **flexible**, and **maintainable** across different users, machines, and working directories.
