# Project Memory System

This file serves as the comprehensive memory system for [Project Name]. It tracks decisions, patterns, issues, and lessons learned to enable seamless project reconstruction and continuous improvement.

**Last Updated:** YYYY-MM-DD
**Project:** [Project Name]
**Status:** Active Development

---

## Table of Contents

1. [Project Genesis](#project-genesis)
2. [Key Decisions](#key-decisions)
3. [Successful Patterns](#successful-patterns)
4. [Issues & Resolutions](#issues--resolutions)
5. [Architecture Evolution](#architecture-evolution)
6. [Dependencies & Integrations](#dependencies--integrations)
7. [Lessons Learned](#lessons-learned)
8. [Quick Restart Guide](#quick-restart-guide)

---

## Project Genesis

### Initial Vision
[Describe what this project aims to accomplish and why it was created]

### Core Objectives
- [Objective 1]
- [Objective 2]
- [Objective 3]

### Starting Point
- Date: YYYY-MM-DD
- Initial branch: main
- Repository: [repo-url]
- Created with: keithstart

---

## Key Decisions

### Decision Log

Track significant decisions here using this format:

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

---

### Decision Criteria
When making decisions, prioritize:
1. **Clarity over cleverness** - Simple, understandable solutions
2. **Maintainability** - Easy to update and extend
3. **Performance** - Efficient and scalable
4. **Security** - Safe and protected

---

## Successful Patterns

Document patterns that work well for this project:

### Pattern: [Pattern Name]
**Context:** [When to use this pattern]
**Solution:** [How it works]
**Why It Works:**
- [Reason 1]
- [Reason 2]

**Usage:** [How to apply this pattern]

**Example:**
```
[Code or configuration example]
```

---

## Issues & Resolutions

### Issue Tracking Format

#### Issue: [Short Title]
**Date:** YYYY-MM-DD
**Severity:** Critical | High | Medium | Low
**Status:** Open | Investigating | Resolved | Won't Fix
**Tags:** [tag1, tag2]

**Symptom:** [What you observed]
**Root Cause:** [What actually caused it]
**Solution:** [How it was resolved]
**Prevention:** [How to avoid in future]
**Related:** [Links to notes, commits, or issues]

---

### Resolved Issues

[Document resolved issues here]

---

### Open Issues

[Track ongoing issues here]

---

## Architecture Evolution

### Phase 1: Initial Setup (YYYY-MM-DD)
**Structure:**
```
[Project Name]/
├── src/
├── tests/
└── README.md
```
**Focus:** [What this phase accomplished]

**Key Additions:**
- [File or feature 1]
- [File or feature 2]

---

### Future Phases (Planned)

#### Phase 2: [Phase Name]
- [Planned addition 1]
- [Planned addition 2]

---

## Dependencies & Integrations

### Core Dependencies
- **[Dependency 1]** - [Purpose and version]
- **[Dependency 2]** - [Purpose and version]

### Integration Points
- **[Service/Tool 1]** - [How it integrates]
- **[Service/Tool 2]** - [How it integrates]

### Rationale for Key Dependencies
**[Dependency Name]:**
- Chosen because: [reason]
- Alternatives considered: [alternatives]
- Trade-offs: [what we gained/lost]

---

## Lessons Learned

### Lesson: [Lesson Title]
**Context:** [Situation where this was learned]
**Learning:** [What was discovered]
**Application:** [How to apply this lesson]
**Evidence:** [Data or examples supporting this]

---

## Quick Restart Guide

This section provides everything needed to recreate this project from scratch.

### Prerequisites
```bash
# Required tools
- [Tool 1 + version]
- [Tool 2 + version]
- [Tool 3 + version]
```

### Step-by-Step Restart

#### 1. Clone or Create Repository
```bash
# If restarting with existing repo
git clone [repo-url]
cd [project-name]

# If creating fresh
mkdir [project-name]
cd [project-name]
git init
```

#### 2. Install Dependencies
```bash
# [Your project's installation commands]
npm install
# or: pip install -r requirements.txt
# or: go mod download
```

#### 3. Set Up Environment
```bash
cp .env.example .env
# Edit .env with your configuration
```

#### 4. Verify Setup
```bash
# Run tests
npm test

# Start development server
npm run dev
```

### Critical Files for Restart

1. **MEMORY.md** (this file) - Complete project context
2. **CHANGELOG.md** - Development history
3. **README.md** - Project overview
4. **.claude/CLAUDE.md** - Development workflow
5. **[Other critical files]**

### Validation Checklist

After restart, verify:
- [ ] Dependencies installed successfully
- [ ] Environment variables configured
- [ ] Tests passing
- [ ] Development server runs
- [ ] [Other validations specific to your project]

### Recovery from Partial Data

If you only have:

**Only MEMORY.md:**
- Use Quick Restart Guide above
- Reference Architecture Evolution for structure
- Follow Successful Patterns for implementation details

**Only CHANGELOG.md:**
- Review chronological history
- Recreate files based on commit descriptions
- Use dates to understand project evolution

---

## Maintenance Guidelines

### Updating This File

**When to Update:**
- After making significant architectural decisions
- When discovering new successful patterns
- After resolving notable issues
- When project structure changes
- After learning valuable lessons

**What to Update:**
- Add new decisions to Key Decisions
- Document successful patterns as they emerge
- Log and resolve issues in Issues & Resolutions
- Update Architecture Evolution when structure changes
- Add lessons learned after notable experiences
- Keep Quick Restart Guide current

**How Often:**
- Review weekly during active development
- Update immediately after major milestones
- Batch small updates, commit significant ones

---

## Related Files

- **CHANGELOG.md** - Chronological development log
- **README.md** - Project overview
- **.claude/CLAUDE.md** - Development workflow instructions
- **docs/** - Detailed documentation

---

**Memory System Version:** 1.0
**Created with:** keithstart
**Last Major Revision:** YYYY-MM-DD
