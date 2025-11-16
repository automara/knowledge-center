---
title: keithstart sed "invalid command code k" error on macOS
date: 2025-11-16
tags: [error, keithstart, bash, sed, macos, project-init]
status: active
severity: high
---

# keithstart sed "invalid command code k" Error

## Error Summary

The `keithstart` command fails during template customization with a sed error on macOS. The script attempts to use GNU sed syntax with BSD sed, causing the initialization process to fail after project directory creation.

## Error Details

### Error Message

```
sed: 1: "/Users/keitharmstrong/c ...": invalid command code k
```

### Stack Trace

```
keithstart agento
🚀 Creating new project: agento
   Type: node
   Location: /Users/keitharmstrong/code/agento

📁 Creating project directory...
📦 Initializing git repository...
Initialized empty Git repository in /Users/keitharmstrong/code/agento/.git/
Switched to a new branch 'main'
📋 Copying mandatory files...
📦 Setting up node project...
✏️  Customizing templates...
sed: 1: "/Users/keitharmstrong/c ...": invalid command code k
```

### Context

- **Project**: knowledge-center
- **Repository**: https://github.com/automara/knowledge-center
- **File/Location**: project-init/scripts/keithstart.sh:151-155
- **Environment**: development (macOS)
- **Date Occurred**: 2025-11-16
- **Framework/Library**: Bash script using sed
- **Language/Version**: Bash, BSD sed (macOS), attempting to use GNU sed syntax

### Steps to Reproduce

1. Run `keithstart agento` (or any project name)
2. Script executes successfully through file copying
3. Fails at "Customizing templates..." step
4. Error occurs when trying to replace placeholders in markdown/config files

### Expected Behavior

The script should replace placeholders like `[Project Name]`, `[project-name]`, and `YYYY-MM-DD` in all template files with actual values (project name, current date).

### Actual Behavior

The `sed` command fails with "invalid command code k" because BSD sed (macOS default) requires a backup extension argument for the `-i` flag, while the script uses GNU sed syntax which doesn't require it.

## Root Cause Analysis

### Investigation

Lines 151-155 in keithstart.sh:150-155:

```bash
find "$PROJECT_PATH" -type f \( -name "*.md" -o -name "*.json" -o -name "*.toml" -o -name "*.js" -o -name "*.py" -o -name "*.go" \) -print0 | while IFS= read -r -d '' file; do
    $SED_CMD -i "s/\[Project Name\]/$PROJECT_NAME/g" "$file"
    $SED_CMD -i "s/\[project-name\]/$PROJECT_NAME/g" "$file"
    $SED_CMD -i "s/YYYY-MM-DD/$CURRENT_DATE/g" "$file"
done
```

### Root Cause

**BSD vs GNU sed incompatibility**: The script checks for `gsed` (GNU sed) but falls back to `sed` (BSD sed on macOS). However, the syntax used is GNU-only:

- **GNU sed**: `sed -i "pattern" file` (no backup extension needed)
- **BSD sed**: `sed -i '' "pattern" file` (requires empty string '' for no backup, or `.bak` for backup)

The error "invalid command code k" occurs because BSD sed interprets the replacement pattern as a filename, and then tries to interpret the actual filename as a sed command.

### Contributing Factors

1. Script assumes `gsed` will be installed on macOS (it's not by default)
2. No fallback syntax adjustment for BSD sed
3. Silent fallback to incompatible sed version

## Solution

### Immediate Fix

Install GNU sed via Homebrew (temporary workaround):

```bash
brew install gnu-sed
```

This installs `gsed` which the script will detect and use.

### Long-term Resolution

Update keithstart.sh:151-155 to use BSD-compatible syntax:

```bash
# Instead of:
$SED_CMD -i "s/\[Project Name\]/$PROJECT_NAME/g" "$file"

# Use:
$SED_CMD -i '' "s/\[Project Name\]/$PROJECT_NAME/g" "$file"
```

Or better, adjust the detection logic to set different syntax:

```bash
if command -v gsed >/dev/null 2>&1; then
    SED_CMD="gsed"
    SED_INPLACE="-i"
else
    SED_CMD="sed"
    SED_INPLACE="-i ''"  # BSD sed requires backup extension
fi

# Then use:
$SED_CMD $SED_INPLACE "s/pattern/replacement/g" "$file"
```

### Verification

After fix:
1. Run `keithstart test-project`
2. Verify template customization completes
3. Check that placeholder replacements worked in README.md and other files
4. Confirm no `.bak` or backup files created (if using empty string syntax)

## Prevention

### Code Changes

- [x] Add proper BSD sed support with empty backup extension `''`
- [ ] Add error handling around sed commands
- [ ] Add validation that templates were actually customized
- [ ] Consider using a more portable solution (perl, awk, or Python)

### Process Improvements

- [ ] Add integration test for macOS environment
- [ ] Add documentation about GNU sed requirement or BSD compatibility
- [ ] Add startup check that warns if `gsed` not found on macOS
- [ ] Test on both macOS and Linux systems

### Best Practices

1. Always account for BSD vs GNU tool differences when writing cross-platform scripts
2. Test scripts on both macOS (BSD) and Linux (GNU) environments
3. Prefer portable solutions or explicitly check OS type
4. Document platform-specific requirements clearly

## Impact

- **Users Affected**: All macOS users without GNU sed installed
- **Systems Affected**: Project initialization system
- **Downtime**: N/A (initialization fails, but no existing systems affected)
- **Data Loss**: No (project directory created but incompletely initialized)

## Related Issues

### Issue #1: Incorrect GitHub Profile Placeholder

The script references a placeholder GitHub profile instead of the actual profile (https://github.com/automara).

**Files affected**:
- Templates that include GitHub URLs
- Potentially in mandatory files

**Action needed**: Search for GitHub placeholder and replace with actual profile.

### Issue #2: No System for Storing Live URLs

Need a standardized way to store:
- Project live URLs
- GitHub repository URLs
- API endpoints
- Relevant project metadata

**Proposed solution**: Create a `.project.json` or similar metadata file template.

## References

- [BSD vs GNU sed differences](https://riptutorial.com/sed/topic/9436/bsd-macos-sed-vs--gnu-sed-vs--the-posix-sed-specification)
- [Portable sed usage](https://stackoverflow.com/questions/5694228/sed-in-place-flag-that-works-both-on-mac-bsd-and-linux)

## Timeline

- **2025-11-16 14:00** - Error first detected during `keithstart agento` execution
- **2025-11-16 14:15** - Investigation started
- **2025-11-16 14:30** - Root cause identified (BSD sed incompatibility)
- **2025-11-16 14:35** - Documented in knowledge center
- **Status**: Active - awaiting fix

## Notes

This is a common portability issue when developing on macOS. The script shows good practice by checking for `gsed` first, but needs the fallback to handle BSD sed correctly.

The error message is cryptic ("invalid command code k") because sed is trying to parse the filename as a command, and "k" from "keitharmstrong" is not a valid sed command.

---

## Tags

#error #keithstart #bash #sed #macos #bsd #gnu #portability #high-priority #active #project-init
