# keithstart - Project Initialization System

A comprehensive project initialization system that creates new projects with standardized configurations, templates, and best practices built-in.

## Quick Start

### Installation

```bash
# Navigate to knowledge center
cd ~/code/knowledge-center/.conductor/tianjin/project-init/scripts

# Install keithstart globally (creates symlink)
./install.sh

# Verify installation
keithstart --help
```

### Create a New Project

```bash
# Basic usage (defaults to Node.js)
keithstart my-project

# Python project
keithstart ml-model --type=python

# Go project
keithstart microservice --type=go

# With Conductor workspace
keithstart api-service --type=node --conductor

# Create GitHub repository automatically
keithstart full-stack-app --type=node --remote
```

## Features

### Mandatory Templates (Applied to All Projects)

Every project gets:
- `.gitignore` - Comprehensive ignore patterns for all project types
- `.claude/CLAUDE.md` - Claude Code project instructions
- `.project.json` - Project metadata and configuration
- `README.md` - Project documentation template
- `.env.example` - Environment variables template
- `MEMORY.md` - Project memory system for decisions, patterns, and lessons (new!)
- `CHANGELOG.md` - Development history and change tracking (new!)
- `docs/README.md` - Documentation folder structure
- `docs/MEMORY_SYSTEM.md` - Memory system usage guide (new!)
- `.github/PULL_REQUEST_TEMPLATE.md` - PR template following workflow
- `.github/ISSUE_TEMPLATE.md` - Issue template with by-claude tag

### Optional Templates (Project Type Specific)

#### Node.js (`--type=node`)
- `package.json` - npm configuration with common scripts
- `tsconfig.json` - TypeScript configuration
- `.eslintrc.js` - ESLint configuration
- `src/index.js` - Main entry point

#### Python (`--type=python`)
- `requirements.txt` - Python dependencies
- `pyproject.toml` - Python project configuration
- `main.py` - Main entry point
- Virtual environment setup (`venv/`)

#### Go (`--type=go`)
- `go.mod` - Go module configuration
- `main.go` - Main entry point

### Template Customization

Templates automatically replace placeholders:
- `[Project Name]` → Actual project name
- `[project-name]` → Actual project name (lowercase/hyphenated)
- `YYYY-MM-DD` → Current date

### Project Metadata (.project.json)

Each project includes a `.project.json` file with structured metadata:

```json
{
  "name": "project-name",
  "version": "0.1.0",
  "type": "node|python|go",
  "created": "2025-11-16",
  "generator": {
    "tool": "keithstart",
    "version": "1.0.0"
  },
  "metadata": {
    "description": "Brief description",
    "tags": [],
    "repository": {
      "type": "git",
      "url": "https://github.com/keitharm/project-name"
    },
    "author": {
      "name": "Keith Armstrong",
      "github": "keitharm"
    }
  },
  "dependencies": {
    "packageManager": "npm|pip|go",
    "lockfile": "package-lock.json|requirements.txt|go.sum"
  },
  "development": {
    "conductor": true|false,
    "environmentFile": ".env"
  }
}
```

This file is automatically customized based on:
- Project type (`--type`)
- Conductor flag (`--conductor`)
- Package manager for the selected type

You can use this file for:
- Project discovery and indexing
- Automated tooling and scripts
- Documentation generation
- IDE integrations

### Memory System

Every project includes a comprehensive memory system for knowledge retention:

**MEMORY.md** - Strategic knowledge base containing:
- Project genesis and vision
- Key architectural decisions with rationale
- Successful patterns and best practices
- Issue resolutions with root causes
- Architecture evolution timeline
- Lessons learned
- Quick restart guide for complete project reconstruction

**CHANGELOG.md** - Chronological development history containing:
- Date-ordered change entries with branch/commit info
- Type, scope, and impact of each change
- Rationale for changes
- Related issues and PRs
- Detailed development log
- Project statistics

**docs/MEMORY_SYSTEM.md** - Complete usage guide with:
- Daily workflow integration
- Update templates for decisions, patterns, issues
- Project restart scenarios
- Best practices and troubleshooting
- Git workflow integration

**Benefits:**
- Complete project restart capability from memory files alone
- Decision rationale preserved for future reference
- Pattern library building automatically over time
- Context retention across workspace changes and context resets
- Seamless onboarding for new team members
- Continuous improvement through lessons learned

**Usage:**
```bash
# Morning: Read recent changes
tail -50 CHANGELOG.md

# During work: Document as you go
# Reference MEMORY.md for patterns

# Evening: Update with today's work
# Add entries to CHANGELOG.md
# Update MEMORY.md if significant decisions made

# Commit and push
git add MEMORY.md CHANGELOG.md
git commit -m "docs: update memory system"
```

See `docs/MEMORY_SYSTEM.md` in any keithstart project for complete usage guide.

## Commands

### keithstart

Initialize a new project with standardized configuration.

**Usage:**
```bash
keithstart project-name [OPTIONS]
```

**Options:**
- `--type=TYPE` - Project type: `node` (default), `python`, or `go`
- `--conductor` - Create Conductor workspace
- `--remote` - Create GitHub repository (requires `gh` CLI)

**Examples:**
```bash
# Basic Node.js project
keithstart my-app

# Python project with Conductor workspace
keithstart data-pipeline --type=python --conductor

# Go project with GitHub repo
keithstart api-gateway --type=go --remote

# Full setup
keithstart full-stack --type=node --conductor --remote
```

**What It Does:**
1. Creates project directory in `/Users/keitharmstrong/code/`
2. Initializes git repository (on `main` branch)
3. Copies mandatory templates
4. Copies project-type specific templates
5. Customizes templates with project name and date
6. Sets up `.env` from `.env.example`
7. Installs dependencies (npm/pip/go)
8. Creates Conductor workspace (if `--conductor`)
9. Creates GitHub repository (if `--remote`)
10. Creates initial git commit
11. Logs project to `.projects-log`

### keithsync

Update existing project with latest templates from knowledge center.

**Usage:**
```bash
keithsync [OPTIONS]
```

**Options:**
- `--dry-run` - Show what would be updated without applying changes
- `--template=NAME` - Only sync specific template
- `--force` - Apply all updates without prompting

**Examples:**
```bash
# See what would be updated
keithsync --dry-run

# Interactively sync all templates
keithsync

# Only update .gitignore
keithsync --template=.gitignore

# Force update all templates
keithsync --force
```

**What It Does:**
1. Checks if current directory is a keithstart project
2. Compares local files with knowledge center templates
3. Shows differences and prompts for updates
4. Backs up files before updating (in `.backup/`)
5. Updates `.keithstart-version` file

## File Structure

```
project-init/
├── README.md                 # This file
├── versions.json             # Template version tracking
├── .projects-log             # Log of initialized projects
│
├── mandatory/                # Files for ALL projects
│   ├── .gitignore
│   ├── .env.example
│   ├── README.md
│   ├── .claude/
│   │   └── CLAUDE.md
│   ├── .github/
│   │   ├── PULL_REQUEST_TEMPLATE.md
│   │   └── ISSUE_TEMPLATE.md
│   └── docs/
│       └── README.md
│
├── optional/                 # Project-type specific files
│   ├── node/
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   ├── .eslintrc.js
│   │   └── src-index.js
│   ├── python/
│   │   ├── requirements.txt
│   │   ├── pyproject.toml
│   │   └── main.py
│   └── go/
│       ├── go.mod.template
│       └── main.go
│
└── scripts/                  # Initialization scripts
    ├── keithstart.sh         # Main init script
    ├── keithsync.sh          # Template sync script
    └── install.sh            # Global installation
```

## Template Management

### Adding New Mandatory Templates

1. Add file to `mandatory/` directory
2. Update `versions.json` with new template entry
3. Update `keithstart.sh` to copy the new file
4. Update `keithsync.sh` FILES_TO_SYNC array
5. Test with a new project

### Adding New Project Types

1. Create directory in `optional/` (e.g., `optional/rust/`)
2. Add template files for that project type
3. Update `versions.json` with new project type
4. Update `keithstart.sh` to handle new type:
   - Add to type validation
   - Add copy logic in step 4
   - Add dependency installation in step 7
   - Add run instructions in success message
5. Test with a new project

### Updating Templates

1. Edit template files in `mandatory/` or `optional/`
2. Update version in `versions.json`
3. Add changelog entry to `versions.json`
4. Existing projects can sync with `keithsync`

## Version Tracking

Each project gets a `.keithstart-version` file containing the date it was created/last synced.

Template versions are tracked in `versions.json`:
```json
{
  "version": "1.0.0",
  "templates": {
    "mandatory": {
      ".gitignore": {
        "version": "1.0.0",
        "last_updated": "2025-11-16"
      }
    }
  }
}
```

## Project Log

All initialized projects are logged to `.projects-log`:
```
project-name|type|date|location
my-api|node|2025-11-16|/Users/keitharmstrong/code/my-api
ml-tool|python|2025-11-17|/Users/keitharmstrong/code/ml-tool
```

Use this to:
- Track all projects created with keithstart
- Find projects that need syncing
- Analyze project types and patterns

## Integration with Existing Workflow

### Git Workflow

Projects are initialized with:
- Main branch: `main`
- Initial commit with keithstart attribution
- GitHub templates for PRs and issues
- .gitignore for all common file types

### Claude Code Integration

Every project gets `.claude/CLAUDE.md` with:
- Project-specific instructions
- Git workflow guidelines
- Development setup
- Common tasks and patterns

### Conductor Integration

With `--conductor` flag:
- Creates `.conductor/[project-name]/` workspace
- Copies error templates and workflows
- Sets up environment files

## Troubleshooting

### Command not found: keithstart

Run the installation script:
```bash
cd ~/code/knowledge-center/.conductor/tianjin/project-init/scripts
./install.sh
```

### Permission denied

Make scripts executable:
```bash
chmod +x scripts/*.sh
```

### Templates not copying

Check paths in scripts match your knowledge center location:
```bash
KNOWLEDGE_CENTER="$HOME/code/knowledge-center"
```

### Dependencies not installing

Ensure you have the required tools installed:
- Node.js: `npm` for Node projects
- Python: `python3` and `pip` for Python projects
- Go: `go` for Go projects

## Best Practices

1. **Keep templates updated** - Regularly review and improve templates in knowledge center
2. **Sync existing projects** - Run `keithsync` periodically on active projects
3. **Log improvements** - Update `versions.json` when templates change
4. **Test changes** - Create a test project after updating templates
5. **Version control** - Commit template changes to knowledge center

## Weekly Review Integration

Add to your weekly review process:
1. Check `.projects-log` for new projects
2. Review if any patterns emerged worth adding to templates
3. Run `keithsync --dry-run` on active projects
4. Update templates with improvements
5. Increment versions in `versions.json`

## Future Enhancements

Potential improvements:
- Interactive mode with prompts
- Template marketplace for sharing
- Smart defaults based on project history
- Automatic dependency updates
- Multi-repo/monorepo support
- Cloud deployment integration
- Additional project types (Rust, Ruby, etc.)

## Support

For issues or questions:
- Check this README first
- Review script source code in `scripts/`
- Check knowledge center documentation
- Test with `--dry-run` flags

## Credits

Generated with [keithstart](https://github.com/keitharm/knowledge-center)
Part of the knowledge center system for standardized project initialization.

---

**Version:** 1.0.0
**Last Updated:** 2025-11-16
