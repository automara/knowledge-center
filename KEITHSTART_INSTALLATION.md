# keithstart Installation Fix

## Problem
`keithstart` was installed with symlinks pointing to temporary workspace directories (`.conductor/riyadh`), which caused the command to break when workspaces were cleaned up or changed.

## Solution
Moved `keithstart` and related files to the main knowledge-center repository so they persist independently of any workspace.

## What Changed

### Files Moved to Main Repo
- `/Users/keitharmstrong/code/knowledge-center/project-init/` - Full project initialization system
  - `mandatory/` - Template files required for all projects
  - `optional/` - Language-specific templates (node, python, go)
  - `scripts/` - Installation and utility scripts
    - `keithstart.sh` - Main project creation script
    - `keithsync.sh` - Project sync utility
    - `install.sh` - Installation script
- `/Users/keitharmstrong/code/knowledge-center/scripts/install-mcps.sh` - MCP installer

### Path Updates in keithstart.sh
Updated all hardcoded workspace paths to point to main repo:
- `MANDATORY_DIR`: `.conductor/riyadh/project-init/mandatory` → `project-init/mandatory`
- `OPTIONAL_DIR`: `.conductor/riyadh/project-init/optional` → `project-init/optional`
- Templates path: `.conductor/riyadh/templates` → `templates`
- MCP installer: `.conductor/tianjin-v1/install-mcps.sh` → `scripts/install-mcps.sh`
- Project log: `.conductor/riyadh/project-init/.projects-log` → `project-init/.projects-log`

### New Helper Function
Added `prompt_yes_no()` function to keithstart.sh for interactive prompts.

## Installation Steps

The files have already been copied to the main repository. To complete the installation:

1. **Create the symlinks** (requires your password):
   ```bash
   bash /Users/keitharmstrong/code/knowledge-center/.conductor/troy/create-symlinks.sh
   ```

2. **Verify installation**:
   ```bash
   keithstart --help
   which keithstart
   readlink $(which keithstart)
   ```

   Should show:
   - `keithstart` is available
   - Points to `/Users/keitharmstrong/code/knowledge-center/project-init/scripts/keithstart.sh`

3. **Commit to main repo** (to preserve changes):
   ```bash
   cd /Users/keitharmstrong/code/knowledge-center
   git add project-init/ scripts/
   git status
   # Review the changes
   git commit -m "feat: add persistent keithstart installation

   - Move keithstart from temporary workspace to main repo
   - Update all paths to use main repo location
   - Add prompt_yes_no helper function
   - Install MCP scripts in scripts/ directory

   This fixes the issue where keithstart breaks when workspaces change.

   🤖 Generated with Claude Code

   Co-Authored-By: Claude <noreply@anthropic.com>"
   ```

## Why This Fixes the Problem

**Before:**
- Symlink: `/usr/local/bin/keithstart` → `.conductor/riyadh/project-init/scripts/keithstart.sh`
- When workspace `riyadh` is deleted or changed → symlink breaks
- Result: `zsh: command not found: keithstart`

**After:**
- Symlink: `/usr/local/bin/keithstart` → `~/code/knowledge-center/project-init/scripts/keithstart.sh`
- Main repo location is permanent and independent of workspaces
- Result: `keithstart` works reliably across all sessions

## Testing

After installation, test with:
```bash
# Show help
keithstart --help

# Verify symlink location
ls -la $(which keithstart)

# Create a test project
cd /tmp
keithstart test-project --type=node
cd test-project
git log
rm -rf /tmp/test-project
```

## Future Workspace Setup

When setting up new Conductor workspaces, you don't need to reinstall keithstart. The command is now globally available and persistent.

If you need the project-init files in a workspace for development:
```bash
# In your workspace
cp -r ~/code/knowledge-center/project-init .
```

But remember: the installed `keithstart` command always uses the version in the main repo.

## Uninstalling

To remove keithstart:
```bash
sudo rm /usr/local/bin/keithstart
sudo rm /usr/local/bin/keithsync
```

To reinstall later:
```bash
cd ~/code/knowledge-center/project-init/scripts
./install.sh
```
