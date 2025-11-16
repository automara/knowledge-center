# Getting Started with Your Knowledge Center

Welcome! This guide will help you get your knowledge center up and running.

## Initial Setup

### 1. Clone This Repository on All Devices

```bash
git clone https://github.com/yourusername/knowledge-center.git
cd knowledge-center
```

### 2. Configure Git (First Time Only)

```bash
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### 3. Create an Alias (Optional but Recommended)

Add this to your shell profile (`.bashrc`, `.zshrc`, etc.):

```bash
alias kb='cd ~/path/to/knowledge-center'
```

Then reload: `source ~/.bashrc` or restart your terminal.

---

## Your First Note

Let's create your first knowledge center note:

### Step 1: Copy the Template

```bash
cp templates/issue-note.md notes/2025-11-16-my-first-note.md
```

### Step 2: Edit the Note

Open the file and fill in:
```yaml
---
title: My First Claude Code Insight
date: 2025-11-16
tags: [claude-code, workflow]
category: workflow
status: raw
source: my-project
---

# Issue/Insight: [Your title]

## Problem/Observation
What issue did you encounter or what did you learn?

## Solution/Insight
What did you do or learn about it?

## Key Takeaway
One sentence summarizing the key insight.
```

### Step 3: Commit Your Note

```bash
cd knowledge-center
git add notes/2025-11-16-my-first-note.md
git commit -m "chore: add first knowledge center note"
git push origin main
```

---

## Daily Workflow

### Morning: Planning
1. Check any notes from yesterday
2. Review templates you might need
3. Plan your work

### During Development
As you work on projects:
1. When you hit an interesting issue or solution, capture it
2. Use the issue-note template in `/notes`
3. Don't worry about formatting - just capture the insight
4. Name file: `YYYY-MM-DD-short-topic.md`

### Evening: Review
1. Review notes from today
2. Expand any that need more detail
3. Identify patterns or related insights
4. Commit and push your notes

```bash
cd knowledge-center
git add .
git commit -m "chore: add today's notes"
git push origin main
```

### Weekly: Organization
1. Process raw notes into structured format
2. Move completed notes to `/archive/[category]/`
3. Extract useful patterns into guides or templates
4. Update INDEX.md with new content
5. Push organized content

```bash
git add .
git commit -m "chore: organize weekly notes"
git push origin main
```

---

## Adding Different Types of Content

### Adding a Solution Guide

When you solve a problem that others might encounter:

```bash
cp templates/solution.md guides/how-to-solve-my-problem.md
```

Then fill in the template with:
- Problem statement
- Implementation steps
- Key insights
- When to use this approach

### Creating a Custom Claude.md

When starting a new project that uses Claude Code:

```bash
cp templates/claude-md.md ~/my-project/claude.md
```

Then customize:
- Project structure
- Key technologies
- Development setup
- Common patterns
- Important files

### Documenting a Reusable Skill

When you create a skill worth sharing:

```bash
cp templates/skill-template.md templates/my-custom-skill.md
```

Fill in the template and consider:
- Publishing to your skills folder
- Adding it to an archive guide
- Documenting use cases

---

## Organization Over Time

As your knowledge center grows, organize it:

```
archive/
├── workflow/
│   ├── claude-code-tips.md
│   └── productivity-hacks.md
├── debugging/
│   ├── common-errors.md
│   └── testing-strategies.md
├── architecture/
│   └── design-patterns.md
└── automation/
    └── useful-scripts.md
```

Move notes from `/notes` to `archive/[category]/` once they're:
- Refined and well-documented
- Potentially useful for future reference
- Status updated to "archived" in frontmatter

---

## Tips for Success

### 1. Capture Early, Organize Later
Don't worry about perfection when capturing notes. Raw, messy notes are fine - you can refine them later.

### 2. Use Tags Consistently
Keep using the approved tags so content is easy to find later:
- `claude-code` - Claude Code specific
- `workflow` - Process improvements
- `debugging` - Troubleshooting
- `architecture` - Design/structure
- `tools` - Tool integration
- `automation` - Scripts/automation
- `best-practices` - Standards

### 3. Link Related Content
In your notes, reference related content:
```markdown
See also: [Related Guide](link)
```

### 4. Review Periodically
Every month or quarter:
1. Review notes you've captured
2. Look for patterns and common themes
3. Extract insights into guides
4. Create new templates based on what you've learned
5. Update your projects with new best practices

### 5. Sync Across Devices
On each device, regularly:
```bash
cd knowledge-center
git pull origin main  # Get latest
# ... work on notes ...
git push origin main  # Share your updates
```

---

## Integrating with Your Projects

### Option 1: Copy Templates
```bash
# When starting a new project
cp ~/knowledge-center/templates/claude-md.md my-project/

# Copy solution templates
cp ~/knowledge-center/templates/prd-template.md my-project/docs/
```

### Option 2: Symlink (Advanced)
```bash
# Link to knowledge center templates
ln -s ~/knowledge-center/templates/claude-md.md my-project/claude.md
```

### Option 3: Reference
Document in your project: "See ~/knowledge-center for templates and guides"

---

## Common Tasks

### Find All Notes About a Topic
```bash
# Search for notes with a specific tag
grep -r "tags:.*workflow" notes/

# Or use your editor's search
cd knowledge-center
# Then use Cmd+F or Ctrl+F to find in editor
```

### See Recent Changes
```bash
git log --oneline -20
```

### See What's Changed Since Last Sync
```bash
git status
git diff
```

### Undo an Accidental Commit
```bash
# Before pushing
git reset --soft HEAD~1

# If already pushed, ask in your CLAUDE.md what to do
```

---

## Next Steps

1. **Complete initial setup** - Clone on all devices
2. **Create your first note** - Document something you learned today
3. **Explore templates** - Familiarize yourself with what's available
4. **Read the INDEX** - Check out what's in the knowledge center
5. **Start capturing** - Begin documenting insights from your projects
6. **Organize weekly** - Process raw notes into organized content

---

## Need Help?

- **Index & Navigation:** See `INDEX.md`
- **Repository Structure:** See `README.md`
- **Templates:** Check `/templates` folder
- **Examples:** See `/notes` for examples

---

## Customization

Feel free to:
- Add new categories
- Create custom templates
- Rename sections
- Adapt to your workflow
- Add new tools or tags

Just remember to:
- Keep content organized
- Use consistent structure
- Document your changes
- Sync across devices

---

**Happy learning! Your knowledge center awaits.**
