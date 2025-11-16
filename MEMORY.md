# Project Memory System

This file serves as the comprehensive memory system for the Knowledge Center project. It tracks decisions, patterns, issues, and lessons learned to enable seamless project reconstruction and continuous improvement.

**Last Updated:** 2025-11-16
**Project:** Knowledge Center (Petra Workspace)
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
A personal knowledge center to capture workflow insights, solutions, and best practices for working with Claude Code across multiple projects.

### Core Objectives
- Create a centralized repository for workflow knowledge
- Maintain reusable templates and patterns
- Track project-specific solutions and issues
- Enable quick project initialization with standardized configs
- Sync knowledge across devices and projects

### Starting Point
- Date: 2025-11-15
- Initial branch: `claude/example-setup`
- Repository: knowledge-center
- Workspace: Petra (Conductor workspace)

---

## Key Decisions

### Decision Log

#### 2025-11-16: Implemented Memory System
**Decision:** Create MEMORY.md and CHANGELOG.md as dual tracking systems
**Rationale:**
- MEMORY.md captures strategic decisions, patterns, and context
- CHANGELOG.md tracks chronological development activities
- Together they enable complete project reconstruction

**Alternatives Considered:**
- Single combined file (rejected: too large, hard to navigate)
- Multiple small files (rejected: fragmented, hard to maintain)

**Impact:** High - Forms foundation for knowledge retention and project restart capability

#### 2025-11-15: Adopted keithstart System
**Decision:** Create global CLI tool for project initialization
**Rationale:**
- Standardize project setup across all new projects
- Ensure consistent CLAUDE.md, .gitignore, and configurations
- Reduce repetitive manual setup work

**Impact:** High - Accelerates new project creation

### Decision Criteria
When making decisions, we prioritize:
1. **Clarity over cleverness** - Simple, understandable solutions
2. **Reusability** - Patterns that work across multiple projects
3. **Maintenance** - Easy to update and extend
4. **Documentation** - Well-documented for future reference

---

## Successful Patterns

### Pattern: YAML Frontmatter for Notes
**Context:** Need consistent metadata across all notes
**Solution:**
```yaml
---
title: Note Title
date: YYYY-MM-DD
tags: [tag1, tag2]
category: category-name
status: raw | processed | archived
source: project-name
---
```
**Why It Works:**
- Enables programmatic filtering and organization
- Consistent across all documentation
- Easy to parse for automation

**Usage:** Apply to all files in `/notes` and `/archive`

---

### Pattern: Dated Note Files
**Context:** Need chronological tracking of observations
**Solution:** `YYYY-MM-DD-topic-description.md`
**Why It Works:**
- Automatically sorts chronologically
- Prevents filename conflicts
- Easy to find recent notes

**Usage:** All notes in `/notes` directory

---

### Pattern: Template-Based Documentation
**Context:** Repetitive document creation across projects
**Solution:** Centralized templates in `/templates` with placeholder variables
**Why It Works:**
- Ensures consistency
- Reduces cognitive load
- Easy to customize per project

**Usage:** Copy from `/templates` to project-specific locations

---

### Pattern: Separation of Concerns (Templates vs. Project-Init)
**Context:** Need both reusable templates and automated project setup
**Solution:**
- `/templates` - Manual copy templates for flexibility
- `/project-init` - Automated initialization via keithstart
**Why It Works:**
- Templates for customization
- project-init for speed and standardization
- Both approaches complement each other

---

## Issues & Resolutions

### Issue Tracking Format
Each issue follows this structure:

```markdown
#### Issue: [Short Title]
**Date:** YYYY-MM-DD
**Severity:** Critical | High | Medium | Low
**Status:** Open | Investigating | Resolved | Won't Fix
**Tags:** [tag1, tag2]

**Symptom:**
Description of the problem

**Root Cause:**
What actually caused the issue

**Solution:**
How it was resolved

**Prevention:**
How to avoid this in the future

**Related:**
- Links to notes, commits, or issues
```

---

### Resolved Issues

#### Issue: keithstart sed Command Incompatibility
**Date:** 2025-11-16
**Severity:** High
**Status:** Resolved
**Tags:** [keithstart, macOS, compatibility]

**Symptom:**
`sed -i` command failing on macOS with "invalid command code" error

**Root Cause:**
BSD sed (macOS) requires different syntax than GNU sed (Linux) for in-place editing

**Solution:**
- Changed `sed -i "s/.../"` to `sed -i '' "s/.../"`
- Added empty string argument for macOS compatibility

**Prevention:**
- Always test bash scripts on macOS and Linux
- Use portable sed syntax or detect OS and adjust

**Related:**
- notes/2025-11-16-keithstart-sed-invalid-command.md

---

#### Issue: Project Metadata System Design
**Date:** 2025-11-16
**Severity:** Medium
**Status:** Resolved
**Tags:** [project-init, metadata]

**Symptom:**
Need to track which projects were created, when, and with what configurations

**Root Cause:**
No system for tracking project initialization history

**Solution:**
Created `.projects-log` and `versions.json` system for tracking:
- When projects were initialized
- What templates were used
- Version of each template

**Prevention:**
Design metadata tracking into systems from the start

**Related:**
- notes/2025-11-16-project-metadata-system-design.md

---

### Open Issues

None currently tracked.

---

## Architecture Evolution

### Phase 1: Basic Knowledge Repository (2025-11-15)
**Structure:**
```
knowledge-center/
├── notes/
├── templates/
└── README.md
```
**Focus:** Capture raw notes and basic templates

---

### Phase 2: Project Initialization System (2025-11-15)
**Structure:**
```
knowledge-center/
├── notes/
├── templates/
├── project-init/
│   ├── mandatory/
│   ├── optional/
│   └── scripts/
└── README.md
```
**Focus:** Automated project setup with keithstart

**Key Additions:**
- Global CLI tools (keithstart, keithsync)
- Template versioning
- Project tracking logs

---

### Phase 3: Memory & Context System (2025-11-16)
**Structure:**
```
knowledge-center/
├── notes/
├── templates/
├── project-init/
├── docs/
├── MEMORY.md         # ← New
├── CHANGELOG.md      # ← New
└── INDEX.md
```
**Focus:** Enable project restart and knowledge retention

**Key Additions:**
- Comprehensive memory documentation
- Chronological changelog
- Decision tracking
- Pattern documentation

---

### Future Phases (Planned)

#### Phase 4: Automation & Integration
- Automated note processing
- Template sync system
- Integration with project workflows

#### Phase 5: Search & Discovery
- Search across all notes and templates
- Tag-based filtering
- Cross-project pattern matching

---

## Dependencies & Integrations

### Core Dependencies
- **Git** - Version control and syncing
- **Bash** - Script execution (keithstart, keithsync)
- **GitHub CLI (gh)** - Optional for remote repo creation
- **Conductor** - Workspace management (current environment)

### Project Type Dependencies
- **Node.js** - For Node.js projects initialized via keithstart
- **Python** - For Python projects initialized via keithstart
- **Go** - For Go projects initialized via keithstart

### Integration Points
- **Claude Code** - CLAUDE.md instructions per project
- **GitHub** - Issue tracking, PRs, version control
- **MCP Servers** - Context7 for documentation retrieval

---

## Lessons Learned

### Lesson: Start with Memory Systems Early
**Context:** Created memory system several iterations into project
**Learning:** Memory and changelog should be first artifacts in any long-term project
**Application:** Include MEMORY.md and CHANGELOG.md in project-init mandatory templates

---

### Lesson: Cross-Platform Compatibility Matters
**Context:** sed command incompatibility between macOS and Linux
**Learning:** Always test scripts on target platforms; use portable syntax
**Application:** Test bash scripts on both macOS and Linux before committing

---

### Lesson: Version Everything
**Context:** Template versioning system added after initial templates created
**Learning:** Version tracking enables safe updates and rollback
**Application:** versions.json system now tracks all template versions

---

### Lesson: Separation of Manual vs. Automated
**Context:** Templates vs. project-init distinction
**Learning:** Both manual templates (flexibility) and automated init (speed) have their place
**Application:** Maintain both systems for different use cases

---

### Lesson: Documentation is Code
**Context:** Heavy documentation in this knowledge center
**Learning:** Well-structured documentation is as valuable as code itself
**Application:** Treat .md files with same care as source code

---

## Quick Restart Guide

This section provides everything needed to recreate this project from scratch on a new machine, with a new Claude Code instance, or in a new workspace.

### Prerequisites
```bash
# Required tools
- Git
- Bash shell
- Text editor
- GitHub account (optional, for remote repos)

# Optional but recommended
- GitHub CLI (gh)
- Conductor app (for workspace management)
```

### Step-by-Step Restart

#### 1. Clone or Create Repository
```bash
# If restarting with existing repo
git clone https://github.com/yourusername/knowledge-center.git
cd knowledge-center

# If creating fresh
mkdir knowledge-center
cd knowledge-center
git init
```

#### 2. Create Core Structure
```bash
# Create directory structure
mkdir -p notes templates project-init/mandatory project-init/optional/{node,python,go} project-init/scripts docs archive

# Create initial files
touch README.md INDEX.md MEMORY.md CHANGELOG.md .gitignore
```

#### 3. Set Up Core Files
Copy these essential files (in order of priority):
1. `MEMORY.md` (this file) - Provides complete context
2. `CHANGELOG.md` - Shows development history
3. `README.md` - Project overview
4. `INDEX.md` - Navigation guide
5. `.gitignore` - Git exclusions

#### 4. Install keithstart System
```bash
cd project-init/scripts
./install.sh

# Verify installation
which keithstart
keithstart --help
```

#### 5. Set Up Templates
Copy or create templates in `/templates`:
- claude-md.md
- prd-template.md
- issue-note.md
- solution.md
- skill-template.md
- error-template.md
- env-template.md

#### 6. Configure Git
```bash
git add .
git commit -m "feat: initialize knowledge center"

# Optional: Create GitHub repo
gh repo create knowledge-center --private --source=. --remote=origin
git push -u origin main
```

#### 7. Set Up Conductor Workspace (if using Conductor)
```bash
# Create conductor.json
cat > conductor.json << 'EOF'
{
  "scripts": {
    "setup": "...",
    "run": "..."
  },
  "runScriptMode": "nonconcurrent"
}
EOF
```

#### 8. Create Initial Note
```bash
# Test the system
cat > notes/$(date +%Y-%m-%d)-restart-test.md << 'EOF'
---
title: Knowledge Center Restart Test
date: $(date +%Y-%m-%d)
tags: [workflow, testing]
category: workflow
status: raw
source: knowledge-center
---

# Restart Test

Successfully recreated knowledge center from MEMORY.md quick restart guide.
EOF
```

### Critical Files for Restart

These files contain essential context and should be prioritized:

1. **MEMORY.md** (this file)
   - Complete project context
   - Decision history
   - Patterns and lessons

2. **CHANGELOG.md**
   - Chronological development log
   - What changed and when
   - Commit references

3. **project-init/** directory
   - keithstart system
   - All templates
   - Installation scripts

4. **INDEX.md**
   - Navigation structure
   - Content organization

### Validation Checklist

After restart, verify:
- [ ] Directory structure matches expected layout
- [ ] Git repository initialized and configured
- [ ] keithstart command available globally
- [ ] Templates present in `/templates`
- [ ] MEMORY.md and CHANGELOG.md readable
- [ ] Can create new note with proper frontmatter
- [ ] Can use keithstart to create test project

### Recovery from Partial Data

If you only have:

**Only MEMORY.md:**
- Use Quick Restart Guide above
- Recreate structure from Architecture Evolution section
- Reference Successful Patterns for file formats

**Only CHANGELOG.md:**
- Review chronological history
- Recreate files based on commit descriptions
- Use dates to understand project evolution

**Only notes/ directory:**
- Review frontmatter for structure patterns
- Rebuild from templates referenced in notes
- Use issue resolutions to understand system design

**Only project-init/ directory:**
- Can rebuild keithstart system
- Templates show expected file structures
- scripts/ contains installation logic

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
- Keep Quick Restart Guide current with latest setup

**How Often:**
- Review weekly during active development
- Update immediately after major milestones
- Batch small updates, commit significant ones

---

## Related Files

- **CHANGELOG.md** - Chronological development log
- **INDEX.md** - Master navigation index
- **README.md** - Project overview
- **notes/** - Raw observations and issues
- **templates/** - Reusable document templates

---

**Memory System Version:** 1.0
**Template Compatible:** All current templates
**Last Major Revision:** 2025-11-16
