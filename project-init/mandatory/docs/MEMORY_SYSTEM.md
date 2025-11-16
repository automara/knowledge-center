# Memory System Usage Guide

This project includes a memory system consisting of MEMORY.md and CHANGELOG.md to track decisions, patterns, and development history.

## Overview

### Purpose
Enable complete project reconstruction and knowledge retention across:
- New workspaces or development environments
- Context resets
- New team members joining
- Long breaks from the project
- Complete project rebuilds

### Core Files

1. **MEMORY.md** - Strategic, timeless knowledge
   - Project decisions and rationale
   - Successful patterns
   - Issue resolutions
   - Lessons learned
   - Quick restart guide

2. **CHANGELOG.md** - Chronological development history
   - Date-ordered changes
   - Commit and branch information
   - Impact assessments
   - Development timeline

## Daily Usage

### Morning Routine
```bash
# 1. Pull latest changes
git pull

# 2. Read recent CHANGELOG entries
tail -50 CHANGELOG.md

# 3. Review relevant MEMORY patterns
# (as needed for today's work)
```

### During Development
- Create notes as you work
- Reference MEMORY.md for established patterns
- Document decisions in real-time

### Evening Routine
```bash
# 1. Update CHANGELOG.md
# Add entry for today's work (see template below)

# 2. Update MEMORY.md (if significant decisions were made)
# Add decisions, patterns, or lessons learned

# 3. Commit and push
git add MEMORY.md CHANGELOG.md
git commit -m "docs: update memory system for $(date +%Y-%m-%d)"
git push
```

## Templates

### Adding a Decision to MEMORY.md

```markdown
#### YYYY-MM-DD: [Decision Title]
**Decision:** [Clear statement of what was decided]
**Rationale:**
- [Why this decision was made]
- [What problem it solves]

**Alternatives Considered:**
- [Option A] (rejected because...)
- [Option B] (rejected because...)

**Impact:** High | Medium | Low - [Brief impact description]
**Related:** [Links to commits, issues, or documentation]
```

### Adding a Pattern to MEMORY.md

```markdown
### Pattern: [Pattern Name]
**Context:** [When to use this pattern]
**Solution:** [How it works]
**Why It Works:**
- [Reason 1]
- [Reason 2]

**Usage:** [How to apply this pattern]

**Example:**
```[language]
[Code or configuration example]
```
```

### Adding a Change to CHANGELOG.md

```markdown
### YYYY-MM-DD - [Change Title]

**Branch:** `branch-name`
**Type:** feat | fix | chore | docs | refactor | test
**Scope:** area-of-project

**Added/Changed/Fixed/Removed:**
- [What changed]
- [Specific details]

**Why:**
[Rationale for the change]

**Impact:** High | Medium | Low
- [How this affects the project]

**Commits:**
- [abc1234] commit message

**Issues/PRs:**
- #123 - Issue title

**Notes:**
[Additional context or lessons learned]
```

### Adding an Issue Resolution to MEMORY.md

```markdown
#### Issue: [Short Title]
**Date:** YYYY-MM-DD
**Severity:** Critical | High | Medium | Low
**Status:** Resolved
**Tags:** [tag1, tag2]

**Symptom:** [What you observed]
**Root Cause:** [What actually caused it]
**Solution:** [How it was resolved]
**Prevention:** [How to avoid in future]
**Related:** [Links to notes, commits, or issues]
```

## When to Update

### Update MEMORY.md When:
- Making significant architectural decisions
- Discovering patterns that work well
- Resolving notable issues
- Learning valuable lessons
- After major milestones or releases

### Update CHANGELOG.md When:
- After each development session
- After completing features
- After fixing bugs
- After context resets
- During code reviews

## Project Restart Scenarios

### Scenario 1: New Workspace
```bash
# 1. Clone repository
git clone [repo-url]
cd [project-name]

# 2. Read MEMORY.md completely
# Focus on: Quick Restart Guide, Architecture Evolution

# 3. Read recent CHANGELOG.md entries
tail -100 CHANGELOG.md

# 4. Set up environment
cp .env.example .env
# Edit .env with your configuration

# 5. Install dependencies
[your-install-command]

# 6. Verify setup
[your-test-command]
```

### Scenario 2: After Long Break
```bash
# 1. Update repository
git pull

# 2. Read CHANGELOG.md from your last session date forward
# Find your last entry and read from there

# 3. Review MEMORY.md Lessons Learned
# Refresh on important insights

# 4. Check for structural changes in Architecture Evolution

# 5. Resume work with restored context
```

### Scenario 3: New Team Member Onboarding

**Day 1: Orientation**
1. Read README.md - Project overview
2. Read MEMORY.md sections:
   - Project Genesis
   - Key Decisions
   - Successful Patterns
3. Skim CHANGELOG.md for recent activity

**Day 2: Deep Dive**
4. Read .claude/CLAUDE.md - Development workflow
5. Review Architecture Evolution in MEMORY.md
6. Read recent CHANGELOG.md entries in detail

**Day 3: Hands On**
7. Follow Quick Restart Guide
8. Set up development environment
9. Make first small contribution

## Best Practices

### For MEMORY.md
- ✅ Write for someone with zero context
- ✅ Explain rationale for every decision
- ✅ Document patterns as you discover them
- ✅ Keep Quick Restart Guide current
- ✅ Link to related files and commits
- ❌ Don't assume prior knowledge
- ❌ Don't skip the "why" behind decisions
- ❌ Don't let it get stale

### For CHANGELOG.md
- ✅ Update after every session
- ✅ Include specific dates
- ✅ Reference commits and issues
- ✅ Explain rationale for changes
- ✅ Document impact
- ❌ Don't skip updates (hard to recreate)
- ❌ Don't be vague about changes
- ❌ Don't batch too many changes

### For Both Files
- ✅ Commit with other changes
- ✅ Use consistent formatting
- ✅ Make them searchable (good headers)
- ✅ Cross-reference each other
- ✅ Keep version controlled
- ❌ Don't treat as afterthought
- ❌ Don't forget to push to remote

## Workflow Integration

### With Git Workflow

```bash
# Before starting feature
git checkout main
git pull
# Review MEMORY.md for relevant patterns

git checkout -b feature/new-feature

# During development
# Create notes, document as you work

# After completing feature
# Update CHANGELOG.md with feature details
# Update MEMORY.md if significant decisions made

git add MEMORY.md CHANGELOG.md
git commit -m "feat: add new feature with documentation"
git push
```

### With Context Resets

```bash
# Before context reset
# Update CHANGELOG.md with current session
# Review uncommitted changes
git add .
git commit -m "docs: document session before context reset"
git push

# After context reset
git pull
# Read recent CHANGELOG.md entries
# Continue work with restored context
```

## Troubleshooting

### Can't Find Past Decision
```bash
# Search MEMORY.md
grep -i "keyword" MEMORY.md

# Search CHANGELOG.md for date range
grep "2024-11" CHANGELOG.md

# Search git history
git log --all --grep="keyword"
```

### Missing Context After Restart
1. Read MEMORY.md Quick Restart Guide completely
2. Review Architecture Evolution section
3. Read last 2 weeks of CHANGELOG.md
4. Check Recent Updates section

### Outdated Documentation
1. Update immediately with current state
2. Add entry to CHANGELOG.md explaining what changed
3. Update relevant MEMORY.md sections
4. Document why documentation was out of sync
5. Add lesson learned about keeping docs current

## Success Criteria

The memory system is working if you can:
- ✅ Restart the project from scratch using these files
- ✅ Explain any decision from MEMORY.md
- ✅ Understand what changed and when from CHANGELOG.md
- ✅ Onboard new developers using these files
- ✅ Avoid repeating past mistakes

## Quick Reference

**Update Triggers:**
- MEMORY.md: Major decisions, patterns, issues, lessons
- CHANGELOG.md: Every dev session, context reset, milestone

**Read Priorities:**
1. On restart: MEMORY.md Quick Restart Guide
2. Daily: Recent CHANGELOG.md entries
3. Before decisions: MEMORY.md relevant patterns
4. After long break: CHANGELOG.md Development Log

**File Locations:**
- `/MEMORY.md` - Root of project
- `/CHANGELOG.md` - Root of project
- `/docs/MEMORY_SYSTEM.md` - This guide

---

**For more information:**
- See MEMORY.md for project-specific context
- See CHANGELOG.md for development history
- See .claude/CLAUDE.md for development workflow

**Created with:** keithstart
**Last Updated:** YYYY-MM-DD
