# Knowledge Center Index

Master index and navigation guide for the knowledge center.

## Quick Navigation

- [Project Initialization](#project-initialization) - keithstart system for new projects
- [Templates](#templates) - Reusable document templates
- [Workflows](#workflows) - Claude Code workflows and practices
- [Guides](#guides) - Comprehensive guides
- [Snippets](#snippets) - Code examples and patterns
- [Notes](#notes) - Raw notes and observations
- [Archive](#archive) - Processed and organized content

---

## Project Initialization

**keithstart** - Automated project initialization system for creating new projects with standardized configurations.

### Quick Start
```bash
# Install globally
cd ~/code/knowledge-center/.conductor/tianjin/project-init/scripts
./install.sh

# Create a new project
keithstart my-project                    # Node.js (default)
keithstart ml-model --type=python        # Python project
keithstart api-service --type=go         # Go project
```

### Features
- **Mandatory templates** - Every project gets .gitignore, .claude/CLAUDE.md, README, .env.example, GitHub templates
- **Type-specific templates** - Node.js, Python, or Go configurations
- **Auto-customization** - Replaces placeholders with project name and date
- **Dependency installation** - Automatically installs npm/pip/go packages
- **Git integration** - Initializes repository and creates initial commit
- **GitHub integration** - Optional automatic repository creation with `--remote`
- **Template syncing** - Update existing projects with `keithsync`

### Documentation
- **[project-init/README.md](project-init/README.md)** - Complete system documentation
- **[versions.json](project-init/versions.json)** - Template version tracking
- **[.projects-log](project-init/.projects-log)** - Log of initialized projects

### Available Commands
- `keithstart project-name [--type=node|python|go] [--conductor] [--remote]` - Initialize new project
- `keithsync [--dry-run] [--template=name] [--force]` - Sync templates to existing project

### File Structure
```
project-init/
├── mandatory/      # Templates for all projects
├── optional/       # Type-specific templates (node, python, go)
├── scripts/        # keithstart.sh, keithsync.sh, install.sh
└── versions.json   # Version tracking
```

---

## Templates

Reusable templates for common documentation and files. Copy these to your projects and customize as needed.

### Document Templates
- **[claude-md.md](templates/claude-md.md)** - Project-specific Claude Code instructions
- **[prd-template.md](templates/prd-template.md)** - Product Requirements Document template
- **[skill-template.md](templates/skill-template.md)** - Claude Code skill template

### Note Templates
- **[issue-note.md](templates/issue-note.md)** - Structured format for capturing issues
- **[solution.md](templates/solution.md)** - Template for documenting solutions

---

## Workflows

Best practices and workflows for using Claude Code effectively.

### Getting Started
- Creating a new project
- Setting up Claude.md
- Organizing your code

### Development Patterns
- Feature development workflow
- Bug fixing procedures
- Code review practices

### Advanced Topics
- Multi-agent task orchestration
- Skill development
- Custom tool integration

*Coming soon: Add links as content is created*

---

## Guides

Comprehensive guides on specific topics.

### Claude Code Guides
- Using the Explore agent effectively
- Working with the Task tool
- Debugging with Claude Code
- Tips for better prompts

### Workflow Guides
- Git and branching strategies
- Testing strategies
- Performance optimization
- Security best practices

### Tool-Specific Guides
- Using Bash effectively
- File operations (Read, Write, Edit)
- Pattern matching with Glob and Grep
- Working with notebooks

*Coming soon: Add links as content is created*

---

## Snippets

Code examples and patterns for common tasks.

### JavaScript/TypeScript
- React patterns
- Node.js patterns
- Testing examples

### Python
- Data processing
- Script templates
- Testing examples

### Bash
- Common commands
- Script templates
- Automation examples

*Coming soon: Add links as content is created*

---

## Notes

Raw notes captured from your projects. These are organized by date and topic.

### Active Notes (Processing)
*Notes currently being organized will appear here*

### By Category
- **workflow** - Process improvements
- **claude-code** - Claude Code tips and tricks
- **debugging** - Problem solving
- **architecture** - System design
- **tools** - Tool integration
- **automation** - Scripts and tooling
- **best-practices** - Standards

*Notes will be listed here as they're added to `/notes`*

---

## Archive

Processed, organized notes that have been refined and are ready for reference.

### Archived Topics
*Organized content will appear here as notes are processed*

---

## How to Use This Index

### For Adding Content
1. Start by checking the relevant section above
2. If creating new content, use appropriate templates from `/templates`
3. Use consistent YAML frontmatter with tags and categories
4. Link your new content from the relevant section above
5. Keep this index updated

### For Finding Content
1. Search by category (workflow, debugging, etc.)
2. Browse by tool or feature
3. Search by tag (use Ctrl+F or Cmd+F to search this page)
4. Check the archive for refined, organized content

### For Using Templates
1. Navigate to `/templates`
2. Copy the relevant template
3. Update it with your project-specific information
4. Save to your project
5. Customize as needed

---

## Statistics

**Total Entries:** 0
**Last Updated:** [Will update as content is added]
**Most Recent Addition:** [Will show newest content]

---

## Recent Updates

*This section will track recent additions*

---

## Contributing Guidelines

### Adding a New Note
1. Create a file in `/notes` with format: `YYYY-MM-DD-topic.md`
2. Use the issue-note.md template
3. Follow the YAML frontmatter format
4. Use consistent tags and categories

### Processing a Note
1. Review the raw note
2. Expand and clarify as needed
3. Update frontmatter status to "processed" or "archived"
4. Move to `/archive/[category]/` folder
5. Add link to this index

### Creating a New Guide
1. Create file in `/guides` with descriptive name
2. Use clear structure with headers
3. Include examples and code snippets
4. Add to "Guides" section of this index
5. Use relevant tags in metadata

### Adding Code Snippets
1. Create file in `/snippets` with descriptive name
2. Include language/context in filename
3. Add comments explaining the pattern
4. Link from this index
5. Tag appropriately for discoverability

---

## Keyboard Shortcuts & Tips

- **Find on page:** Cmd+F (Mac) or Ctrl+F (Windows/Linux)
- **Search tags:** Look for tags in [ ] brackets throughout index
- **Cross-reference:** Each section links to primary content locations

---

## Syncing to Other Projects

Content from this knowledge center can be reused in your projects:

```bash
# Initialize a new project with keithstart (recommended)
keithstart my-project --type=node

# Or manually copy templates
cp knowledge-center/templates/claude-md.md my-project/

# Reference a guide
cat knowledge-center/guides/[guide-name].md

# Use a code snippet
cat knowledge-center/snippets/[snippet-name].[ext]

# Sync existing project with latest templates
cd my-project
keithsync
```

---

## Next Steps

As you start using the knowledge center:

1. **Set up your environment** - Clone the repo locally and on all devices
2. **Start capturing notes** - Begin adding observations from your projects
3. **Review periodically** - Process raw notes into organized content
4. **Expand templates** - Add project-specific template variations
5. **Build your library** - Grow guides and snippets over time
6. **Stay in sync** - Regular git pulls and pushes to keep devices synchronized

---

**Knowledge Center Repository:** [Will add GitHub link]
**Personal GitHub:** [Your GitHub profile]
**Last Generated:** [Auto-updates with commits]
