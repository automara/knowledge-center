# Memory System User Guide

Complete guide to using the Knowledge Center memory and changelog system for project reconstruction, continuous improvement, and knowledge retention.

**Version:** 1.0
**Last Updated:** 2025-11-16
**Audience:** Project maintainers, future developers, AI assistants

---

## Table of Contents

1. [Overview](#overview)
2. [System Components](#system-components)
3. [Daily Usage](#daily-usage)
4. [Making Updates](#making-updates)
5. [Project Restart Scenarios](#project-restart-scenarios)
6. [Best Practices](#best-practices)
7. [Troubleshooting](#troubleshooting)

---

## Overview

### What Is the Memory System?

The memory system is a dual-file approach to capturing and retaining project knowledge:

- **MEMORY.md** - Strategic context, decisions, patterns, and lessons
- **CHANGELOG.md** - Chronological development history and changes

Together, these files enable complete project reconstruction from scratch, even with a new repository, Claude Code instance, or workspace.

### Why Use This System?

**Problems It Solves:**
- Context loss when switching to new workspace/instance
- Forgotten decisions and their rationale
- Inability to recreate project from scratch
- Lost knowledge of what works and what doesn't
- Difficulty understanding project evolution

**Benefits:**
- Complete project restart capability
- Decision rationale preserved
- Pattern recognition across iterations
- Continuous improvement through lessons learned
- Seamless handoff to new developers or AI instances

---

## System Components

### MEMORY.md

**Purpose:** Strategic, timeless knowledge

**Contains:**
- Project genesis and vision
- Key architectural decisions with rationale
- Successful patterns that work well
- Issues and their resolutions
- Architecture evolution over time
- Critical dependencies
- Lessons learned
- Quick restart guide

**When to Read:**
- Starting work on the project
- Before making major decisions
- When encountering similar problems
- During project restart
- When training new team members

**When to Update:**
- After significant architectural decisions
- When discovering successful patterns
- After resolving notable issues
- When learning valuable lessons
- After major project milestones

---

### CHANGELOG.md

**Purpose:** Chronological, detailed history

**Contains:**
- Date-ordered change entries
- Branch and commit information
- Type and scope of changes
- Rationale for each change
- Impact assessment
- Related issues, PRs, and notes
- Detailed development log
- Statistics and patterns

**When to Read:**
- Understanding recent changes
- Tracking project timeline
- Reviewing specific dates
- Finding related commits
- Understanding change frequency

**When to Update:**
- After each development session
- After context resets
- When completing features
- After fixing bugs
- During milestones

---

## Daily Usage

### Starting Your Work Day

```markdown
## Morning Routine

1. **Review Recent Changes**
   - Read latest CHANGELOG.md entries
   - Check Development Log for yesterday's work
   - Review any new lessons learned in MEMORY.md

2. **Plan Today's Work**
   - Check Future Planning in CHANGELOG.md
   - Review related patterns in MEMORY.md
   - Note any decisions that might be needed

3. **Set Up Context**
   - Pull latest changes: `git pull`
   - Review current branch
   - Check for open issues or PRs
```

---

### During Development

```markdown
## While Working

1. **Capture Notes**
   - Create dated note files: `notes/YYYY-MM-DD-topic.md`
   - Use YAML frontmatter for metadata
   - Document issues as they occur
   - Track decisions in real-time

2. **Reference Patterns**
   - Check MEMORY.md for similar situations
   - Apply successful patterns
   - Avoid documented pitfalls

3. **Make Decisions**
   - Consider alternatives
   - Document rationale
   - Note for later MEMORY.md update
```

---

### Ending Your Work Day

```markdown
## Evening Routine

1. **Update CHANGELOG.md**
   - Add entry for today's work
   - Include commits, branches, issues
   - Document why changes were made
   - Note impact and lessons learned

2. **Review for MEMORY.md Updates**
   - Did you make significant decisions?
   - Discover any new patterns?
   - Resolve notable issues?
   - Learn valuable lessons?

3. **Commit Documentation**
   git add CHANGELOG.md MEMORY.md notes/
   git commit -m "docs: update memory system for [date]"
   git push
```

---

## Making Updates

### Updating MEMORY.md

#### Adding a Decision

```markdown
#### [Date]: [Decision Title]
**Decision:** Clear statement of what was decided
**Rationale:**
- Why this decision was made
- What problem it solves
- What alternatives were considered

**Alternatives Considered:**
- Option A (rejected because...)
- Option B (rejected because...)

**Impact:** High | Medium | Low - Brief impact description
```

**Example:**
```markdown
#### 2025-11-16: Implemented Memory System
**Decision:** Create MEMORY.md and CHANGELOG.md as dual tracking systems
**Rationale:**
- MEMORY.md captures strategic decisions, patterns, and context
- CHANGELOG.md tracks chronological development activities
- Together they enable complete project reconstruction

**Alternatives Considered:**
- Single combined file (rejected: too large, hard to navigate)
- Multiple small files (rejected: fragmented, hard to maintain)

**Impact:** High - Forms foundation for knowledge retention
```

---

#### Adding a Pattern

```markdown
### Pattern: [Pattern Name]
**Context:** Situation where this pattern applies
**Solution:** Clear description of the pattern
**Why It Works:**
- Reason 1
- Reason 2

**Usage:** How to apply this pattern

**Example:** (optional)
[Code or configuration example]
```

---

#### Adding an Issue Resolution

```markdown
#### Issue: [Short Title]
**Date:** YYYY-MM-DD
**Severity:** Critical | High | Medium | Low
**Status:** Resolved
**Tags:** [tag1, tag2]

**Symptom:** What you observed
**Root Cause:** What actually caused it
**Solution:** How you fixed it
**Prevention:** How to avoid in future
**Related:** Links to notes, commits, PRs
```

---

#### Adding a Lesson Learned

```markdown
### Lesson: [Lesson Title]
**Context:** Situation where you learned this
**Learning:** What you discovered
**Application:** How to apply this lesson
**Evidence:** (optional) Data or examples supporting this
```

---

### Updating CHANGELOG.md

#### Adding a Change Entry

```markdown
### [Date] - [Change Title]

**Branch:** `branch-name`
**Type:** feat | fix | chore | docs | refactor | test
**Scope:** area-of-project

**Added/Changed/Fixed/Removed:**
- Bullet list of changes
- What specifically changed

**Why:**
Rationale for the change

**Impact:** High | Medium | Low
- Description of impact
- What this enables or improves

**Commits:**
- abc1234 commit message
- def5678 commit message

**Issues/PRs:**
- #123 - Issue title
- #456 - PR title

**Related:**
- notes/YYYY-MM-DD-topic.md
- other relevant files

**Notes:** (optional)
Additional context or lessons learned
```

---

#### Adding to Development Log

```markdown
### [Date]

#### [Time of Day] - [Activity Description]
- Bullet points of what happened
- Decisions made
- Issues encountered
- Progress made

**Context:**
Why this work was being done

**Outcome:**
What resulted from this work
```

---

## Project Restart Scenarios

### Scenario 1: New Workspace in Conductor

**Situation:** Starting fresh workspace, have access to repository

```bash
# 1. Clone repository
git clone [repo-url]
cd knowledge-center

# 2. Read MEMORY.md first
cat MEMORY.md
# Focus on: Quick Restart Guide, Architecture Evolution

# 3. Read recent CHANGELOG.md entries
tail -n 100 CHANGELOG.md
# Understand recent changes and current state

# 4. Set up environment
# Follow Quick Restart Guide in MEMORY.md

# 5. Verify setup
# Use Validation Checklist in MEMORY.md
```

**Key Files to Read:**
1. MEMORY.md (complete)
2. CHANGELOG.md (recent entries)
3. INDEX.md (navigation)
4. README.md (overview)

---

### Scenario 2: Complete Project Reconstruction

**Situation:** Lost everything except MEMORY.md and CHANGELOG.md

```bash
# 1. Create base directory
mkdir knowledge-center
cd knowledge-center

# 2. Follow Quick Restart Guide in MEMORY.md exactly
# Each step is documented with commands

# 3. Recreate structure from Architecture Evolution
# MEMORY.md documents each phase of structure

# 4. Use CHANGELOG.md to understand timeline
# Rebuild in chronological order if needed

# 5. Validate against Validation Checklist
# Ensure nothing is missed
```

**Recovery Priority:**
1. Directory structure
2. Core documentation files
3. Templates
4. Project initialization system
5. Notes and archive

---

### Scenario 3: New Developer Onboarding

**Situation:** New person joining project

```bash
# Day 1: Orientation
1. Read README.md - Understand project purpose
2. Read MEMORY.md sections:
   - Project Genesis
   - Key Decisions
   - Successful Patterns
   - Quick Restart Guide

# Day 2: Deep Dive
3. Read CHANGELOG.md:
   - Recent changes
   - Development patterns
   - Understand timeline

4. Review notes/ directory:
   - See real examples
   - Understand issues encountered

# Day 3: Hands On
5. Follow Quick Restart Guide
6. Set up own workspace
7. Create test note
8. Review templates
```

---

### Scenario 4: After Long Break

**Situation:** Returning to project after weeks/months

```bash
# 1. Git update
git pull origin main

# 2. Read CHANGELOG.md Development Log
# Start from your last session date
# Read forward to present

# 3. Review MEMORY.md Lessons Learned
# Refresh on important insights

# 4. Check notes/ directory
ls -lt notes/ | head -20
# See recent activity

# 5. Review current branch
git status
git log -10 --oneline

# 6. Resume work with fresh context
```

---

## Best Practices

### For MEMORY.md

**Do:**
- Write for someone with zero context
- Explain rationale for every decision
- Document patterns as you discover them
- Update immediately after major events
- Keep Quick Restart Guide current
- Link to related notes and files

**Don't:**
- Assume knowledge of previous decisions
- Leave out "why" behind decisions
- Let it get stale (update regularly)
- Include implementation details (use CHANGELOG.md)
- Mix up timeless knowledge with time-specific events

---

### For CHANGELOG.md

**Do:**
- Update after every development session
- Include specific dates and times
- Reference commits and issues
- Explain "why" for each change
- Document impact of changes
- Note lessons learned immediately

**Don't:**
- Skip updates (they're hard to recreate later)
- Be vague about what changed
- Forget to link commits and issues
- Leave out rationale
- Batch too many changes in one entry

---

### For Both Files

**Do:**
- Commit them with other changes
- Review before context resets
- Use consistent formatting
- Cross-reference each other
- Make them searchable (good headers)
- Keep them version controlled

**Don't:**
- Treat as afterthought
- Skip updates when busy
- Use inconsistent terminology
- Make entries too brief
- Forget to push to remote

---

## Troubleshooting

### Can't Find Past Decision

**Symptom:** You know a decision was made but can't find it

**Solution:**
1. Search MEMORY.md for keywords: `grep -i "keyword" MEMORY.md`
2. Check CHANGELOG.md for date range: Look in Development Log
3. Search notes directory: `grep -r "keyword" notes/`
4. Check git history: `git log --all --grep="keyword"`

---

### Missing Context After Restart

**Symptom:** Restarted project, unclear what's important

**Solution:**
1. Read MEMORY.md Quick Restart Guide completely
2. Review Architecture Evolution to understand current state
3. Read last 2 weeks of CHANGELOG.md Development Log
4. Check Recent Updates section in CHANGELOG.md
5. Review notes/ for recent entries

---

### Conflicting Information

**Symptom:** MEMORY.md and CHANGELOG.md seem contradictory

**Solution:**
1. CHANGELOG.md is chronological - what happened when
2. MEMORY.md is strategic - current understanding
3. If conflict: MEMORY.md represents latest thinking
4. Check Last Updated dates on both files
5. If still unclear, check git blame on both files

---

### Forgotten Pattern

**Symptom:** You're solving a problem you know was solved before

**Solution:**
1. Check MEMORY.md Successful Patterns section
2. Search notes/ for similar issue: `grep -r "similar keywords" notes/`
3. Review CHANGELOG.md for related changes
4. Check Issues & Resolutions in MEMORY.md
5. Create new note linking to rediscovered pattern

---

### Outdated Documentation

**Symptom:** Documentation doesn't match current reality

**Solution:**
1. Update immediately with current state
2. Add entry to CHANGELOG.md explaining what changed
3. Update relevant sections in MEMORY.md
4. Document why documentation was out of sync
5. Add lesson learned about keeping docs current

---

## Integration with Workflow

### Git Workflow Integration

```bash
# Before starting feature
git checkout main
git pull
cat MEMORY.md  # Review relevant patterns
git checkout -b feature/new-feature

# During development
# Create notes as you work
vim notes/$(date +%Y-%m-%d)-feature-notes.md

# After completing feature
# Update CHANGELOG.md
vim CHANGELOG.md
# Add entry for this feature

# If significant decision was made
# Update MEMORY.md
vim MEMORY.md
# Add decision or pattern

# Commit all together
git add MEMORY.md CHANGELOG.md notes/
git commit -m "feat: add new feature with documentation"
```

---

### Context Reset Integration

```bash
# Before context reset
# Make sure everything is documented
vim CHANGELOG.md
# Add Development Log entry for current session

# Review uncommitted changes
git status
git diff

# Commit outstanding documentation
git add .
git commit -m "docs: document session before context reset"
git push

# After context reset
# Read recent changes
git pull
tail -50 CHANGELOG.md
# Catch up on latest work
```

---

### Issue Resolution Integration

```bash
# When encountering issue
# Create note immediately
vim notes/$(date +%Y-%m-%d)-issue-description.md
# Document symptoms and investigation

# After resolving
# Update note with resolution
# Add to MEMORY.md Issues & Resolutions
vim MEMORY.md
# Add complete issue entry

# Update CHANGELOG.md
vim CHANGELOG.md
# Add fix entry with reference to MEMORY.md

# Commit together
git add MEMORY.md CHANGELOG.md notes/
git commit -m "fix: resolve issue with full documentation"
```

---

## Advanced Usage

### Extracting Patterns

Periodically review notes and CHANGELOG.md to extract patterns:

```bash
# Find frequent issues
grep -r "Issue:" notes/ | cut -d: -f3 | sort | uniq -c | sort -rn

# Review successful resolutions
grep -A 10 "Solution:" notes/*.md > successful-solutions.txt

# Add top patterns to MEMORY.md
vim MEMORY.md
# Document in Successful Patterns section
```

---

### Cross-Project Learning

Use memory system across multiple projects:

```bash
# Compare patterns across projects
diff project1/MEMORY.md project2/MEMORY.md

# Extract common patterns
# Create shared pattern library in knowledge-center

# Reference in project-specific MEMORY.md
# "See knowledge-center/patterns/pattern-name.md"
```

---

### Automation Opportunities

Consider automating:

```bash
# Auto-generate statistics
# Count decisions, patterns, issues
wc -l MEMORY.md CHANGELOG.md

# Link checker
# Verify all references in docs
grep -o '\[.*\](.*)' *.md

# Changelog compliance
# Check all commits have CHANGELOG entries

# Template validation
# Ensure frontmatter is complete
```

---

## Quick Reference

### Memory System Files
- `MEMORY.md` - Strategic, timeless knowledge
- `CHANGELOG.md` - Chronological history
- `notes/` - Raw daily observations
- `MEMORY_SYSTEM_GUIDE.md` - This guide

### Update Triggers
- **MEMORY.md:** Major decisions, patterns, issues, lessons
- **CHANGELOG.md:** Every dev session, context reset, milestone
- **notes/:** Real-time during development

### Read Priorities
1. **On restart:** MEMORY.md Quick Restart Guide
2. **Daily:** Recent CHANGELOG.md entries
3. **Before decisions:** MEMORY.md relevant patterns
4. **After long break:** CHANGELOG.md Development Log

---

## Conclusion

The memory system is your project's persistent brain. It captures not just what changed, but why decisions were made, what works well, and what to avoid.

**Success Criteria:**
- You can restart the project from scratch using these files
- New developers can onboard using these files
- You can explain any decision from these files
- You avoid repeating past mistakes using these files

**Maintenance Commitment:**
- Update after significant changes
- Review weekly during active development
- Keep Quick Restart Guide current
- Commit changes regularly

**ROI:**
The time spent maintaining this system pays for itself the first time you need to restart a project or explain a decision.

---

**Document Version:** 1.0
**Last Updated:** 2025-11-16
**Next Review:** After first project restart using this system
