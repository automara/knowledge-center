# Knowledge Center

A personal knowledge base for improving workflow and mastering Claude Code. This is a living repository that grows with your projects and experiences.

## Purpose

This knowledge center serves as:
- A repository for capturing workflow insights and solutions
- A source of reusable templates and best practices
- A library of Claude Code skills and configurations
- A reference for common patterns and solutions across projects

## Structure

```
knowledge-center/
├── notes/              # Raw notes about issues and solutions
├── workflows/          # Claude Code workflows and best practices
├── templates/          # Reusable templates
│   ├── issue-note.md
│   ├── solution.md
│   ├── skill-template.md
│   ├── claude-md.md
│   └── prd-template.md
├── snippets/           # Code examples and patterns
├── guides/             # Comprehensive guides on specific topics
├── archive/            # Processed and organized notes
└── INDEX.md            # Master index and navigation
```

## Quick Start

### Adding a Note
1. Create a new markdown file in `/notes` with the format: `YYYY-MM-DD-topic.md`
2. Use the YAML frontmatter template (see below)
3. Add your observation, issue, or solution
4. When ready, move processed notes to `/archive` with proper categorization

### YAML Frontmatter Template
```yaml
---
title: Your Note Title
date: YYYY-MM-DD
tags: [tag1, tag2, tag3]
category: category-name
status: raw # raw, processed, or archived
source: project-name # if from a specific project
---
```

### Categories
- `workflow` - Process improvements and efficiency hacks
- `claude-code` - Claude Code features and usage
- `debugging` - Troubleshooting and solutions
- `architecture` - System design and patterns
- `tools` - Tool integration and setup
- `automation` - Scripts and automation
- `best-practices` - Standards and conventions

## Routing to Projects

To use content from this knowledge center in your projects:

1. **Copy templates** - Use files from `/templates` as starting points
2. **Reference guides** - Link to or copy relevant guides from `/guides`
3. **Extract snippets** - Use code patterns from `/snippets`
4. **Use configurations** - Adapt claude.md or skill files to your project

## Development Workflow

As you work on projects:
1. Capture issues and solutions in `/notes`
2. Periodically review and organize notes
3. Extract reusable content to `/templates` or `/guides`
4. Update project-specific configurations
5. Push changes to sync across devices

## Tags Reference

Keep tags consistent for easy filtering:
- `claude-code` - Claude Code tool usage
- `workflow` - Process and efficiency
- `debugging` - Problem solving
- `automation` - Scripts and tooling
- `testing` - QA and testing
- `performance` - Optimization
- `security` - Security practices
- `documentation` - Docs and communication
- `git` - Version control
- `ci-cd` - Continuous integration/deployment

## Syncing Across Devices

This repo is designed to sync across your devices:

```bash
# On a new device
git clone https://github.com/yourusername/knowledge-center.git
cd knowledge-center

# Regular updates
git pull origin main
git push origin main
```

## Contributing to This Repo

- Keep entries focused and concise
- Use consistent formatting (see templates)
- Tag entries properly for discoverability
- Move from `/notes` to `/archive` when processed
- Update INDEX.md when adding major content

---

**Last Updated:** [Auto-update on commits]
**Total Entries:** [Will grow over time]
