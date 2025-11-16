# MCP Integration System

Automated installation and configuration of Model Context Protocol (MCP) servers for Claude Code, integrated into the keithstart project initialization system.

## Overview

This system provides:
- **Interactive MCP installation** during project setup
- **Global MCP configuration** that works across all projects
- **Curated MCP selection** for your tech stack
- **Comprehensive documentation** for all installed MCPs

## Your Tech Stack

The MCP installer is pre-configured for your development stack:

- **Supabase** - Database operations and Edge Functions
- **ShadCN UI** - Component documentation and generation
- **Tailwind CSS** - Design system integration
- **Railway** - Deployment management
- **GitHub** - Issues, PRs, and code search
- **Claude Code** - AI-powered development
- **Figma** - Design context and Code Connect
- **Playwright** - Browser testing and automation

## Quick Start

### Option 1: Install During Project Creation

When running `keithstart`, you'll be prompted to install MCPs:

```bash
keithstart my-new-project

# During setup:
# 🔌 MCP (Model Context Protocol) Setup
# MCPs extend Claude Code with tools for your tech stack.
#
# Would you like to install MCPs for Claude Code? [Y/n]:
```

### Option 2: Install Standalone

Run the MCP installer at any time:

```bash
bash ~/code/knowledge-center/.conductor/tianjin-v1/install-mcps.sh
```

Or use the convenience wrapper:

```bash
bash ~/code/knowledge-center/.conductor/tianjin-v1/project-init/scripts/install-mcps-standalone.sh
```

## Installation Process

The installer will:

1. **Prompt for MCP selection** in organized categories:
   - Essential Core (Filesystem, Git, GitHub, Memory)
   - Tech Stack (Supabase, ShadCN, Railway, Figma, Playwright, Context7)
   - Development Tools (ESLint, Prisma, Next.js DevTools, Sequential Thinking, Fetch)

2. **Install selected packages** via npm (global installation)

3. **Generate configuration** at `~/.claude/mcp.json`

4. **Create environment template** at `~/.claude/.env.example`

5. **Backup existing config** before making changes

## File Structure

```
knowledge-center/.conductor/tianjin-v1/
├── install-mcps.sh                          # Main MCP installer
├── .conductor/
│   └── docs/
│       └── mcp-guide.md                     # Comprehensive MCP documentation
├── project-init/
│   ├── scripts/
│   │   ├── keithstart.sh                    # Updated with MCP integration
│   │   └── install-mcps-standalone.sh       # Standalone installer wrapper
│   └── mandatory/
│       └── .project.json                    # Updated with MCP metadata
└── MCP_INTEGRATION.md                       # This file

~/.claude/
├── mcp.json                                 # Global MCP configuration
└── .env.example                            # Environment variables template
```

## Available MCPs

### Essential Core

- **Filesystem** - Secure file operations
- **Git** - Repository operations and history
- **GitHub** - Issues, PRs, code search
- **Memory** - Persistent context across sessions

### Your Tech Stack

- **Supabase** - Database CRUD, RLS, Edge Functions
- **ShadCN UI** - Component docs and generation
- **Railway** - Deployment (experimental)
- **Figma** - Design tokens and Code Connect (beta)
- **Playwright** - Browser automation and testing
- **Context7** - Up-to-date library documentation

### Development Tools

- **ESLint** - Code quality and linting
- **Prisma** - Type-safe database ORM
- **Next.js DevTools** - Error detection and state
- **Sequential Thinking** - Complex planning
- **Fetch** - Web content fetching

## Configuration

### Global Configuration

MCPs are installed **globally** in `~/.claude/mcp.json`, making them available across all projects.

**Example configuration:**

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "supabase": {
      "command": "npx",
      "args": ["-y", "supabase-mcp"],
      "env": {
        "SUPABASE_URL": "${SUPABASE_URL}",
        "SUPABASE_KEY": "${SUPABASE_KEY}"
      }
    }
  }
}
```

### Environment Variables

Required credentials are documented in `~/.claude/.env.example`.

**Set up your credentials:**

1. Copy the example file:
   ```bash
   cp ~/.claude/.env.example ~/.claude/.env
   ```

2. Fill in your actual credentials:
   ```bash
   export GITHUB_TOKEN="ghp_xxxxx"
   export SUPABASE_URL="https://xxx.supabase.co"
   export SUPABASE_KEY="eyJxxx"
   export FIGMA_ACCESS_TOKEN="figd_xxx"
   ```

3. Add to your shell profile (`~/.zshrc` or `~/.bashrc`):
   ```bash
   # Load MCP environment variables
   if [ -f "$HOME/.claude/.env" ]; then
       export $(cat "$HOME/.claude/.env" | xargs)
   fi
   ```

4. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

**Security Warning:**
- NEVER commit `.env` files with real credentials
- Use fine-grained tokens with minimal permissions
- Rotate tokens periodically

## Getting Credentials

### GitHub Token
1. Go to https://github.com/settings/tokens
2. Generate new token (classic)
3. Select scopes: `repo`, `read:org`
4. Copy token to environment

### Supabase Credentials
1. Go to https://app.supabase.com
2. Select your project → Settings → API
3. Copy Project URL and Anon/Service key
4. Add to environment

### Figma Token
1. Go to https://www.figma.com/developers/api#access-tokens
2. Create new token
3. Copy token to environment

See `.conductor/docs/mcp-guide.md` for detailed credential setup.

## Usage Examples

### During Development

```
You: Show me all users in the Supabase database

Claude (using Supabase MCP):
[Queries users table and displays results]
```

### Component Generation

```
You: Create a dialog component using ShadCN

Claude (using ShadCN MCP):
[Generates Dialog component with Tailwind CSS]
```

### Browser Testing

```
You: Test the login flow with Playwright

Claude (using Playwright MCP):
[Opens browser, tests flow, captures screenshots]
```

### Deployment

```
You: Deploy this to Railway

Claude (using Railway MCP):
[Creates deployment, shows logs]
```

## Features

### Backup System
- Existing `mcp.json` is backed up before modification
- Backup format: `mcp.json.backup.YYYYMMDD_HHMMSS`
- Never lose your existing configuration

### Safety Checks
- Verifies Railway CLI installation before configuring Railway MCP
- Warns about experimental/beta status
- Prompts for confirmation on potentially destructive operations

### Smart Defaults
- Uses `npx -y` for zero-install convenience
- Pre-configured paths for common setups
- Sensible token limits and timeouts

## Project Metadata

Projects initialized with `keithstart` track MCP installation in `.project.json`:

```json
{
  "development": {
    "conductor": false,
    "environmentFile": ".env",
    "mcps": true
  },
  "tools": {
    "stack": [
      "supabase",
      "shadcn-ui",
      "tailwind",
      "railway",
      "github",
      "claude-code",
      "figma"
    ],
    "mcps": {
      "installed": true,
      "location": "~/.claude/mcp.json",
      "documentation": ".conductor/docs/mcp-guide.md"
    }
  }
}
```

## Troubleshooting

### MCPs Not Loading

1. Verify configuration:
   ```bash
   cat ~/.claude/mcp.json | jq
   ```

2. Check environment variables:
   ```bash
   env | grep -E "(GITHUB|SUPABASE|FIGMA)"
   ```

3. Restart Claude Code

### Installation Fails

1. Check npm permissions:
   ```bash
   npm config get prefix
   ```

2. Use `npx` instead (no installation needed):
   - Configuration already uses `npx -y` by default

3. Check network connectivity

### Railway MCP Issues

1. Verify Railway CLI:
   ```bash
   railway --version
   ```

2. Login if needed:
   ```bash
   railway login
   ```

For more troubleshooting, see `.conductor/docs/mcp-guide.md`.

## Documentation

**Primary Documentation:**
- `.conductor/docs/mcp-guide.md` - Comprehensive guide with examples

**Additional Resources:**
- MCP Specification: https://github.com/modelcontextprotocol/modelcontextprotocol
- Official Servers: https://github.com/modelcontextprotocol/servers
- MCP Registry: https://registry.modelcontextprotocol.io

## Maintenance

### Updating MCPs

Update all installed MCPs:

```bash
npm update -g
```

Update specific MCP:

```bash
npm update -g @modelcontextprotocol/server-github
```

### Re-running Installation

You can re-run the installer at any time:

```bash
bash ~/code/knowledge-center/.conductor/tianjin-v1/install-mcps.sh
```

Your existing configuration will be backed up automatically.

### Removing MCPs

1. Remove from `~/.claude/mcp.json`
2. Uninstall package:
   ```bash
   npm uninstall -g package-name
   ```

## Best Practices

### Security
✅ Never commit credentials
✅ Use fine-grained tokens
✅ Rotate tokens periodically
✅ Use different credentials for dev/production

### Performance
✅ Only install MCPs you use
✅ Set reasonable token limits
✅ Close unused MCP servers

### Workflow
✅ Use Memory MCP for project context
✅ Combine MCPs for complete workflows
✅ Let Claude orchestrate multiple MCPs

## Integration with Workflow

This MCP system integrates with your existing workflow from `~/.claude/CLAUDE.md`:

- **Issues & PRs**: GitHub MCP creates issues and PRs
- **Commits**: Git MCP manages repository operations
- **Testing**: Playwright MCP runs browser tests
- **Deployment**: Railway MCP handles deployments
- **Code Quality**: ESLint MCP enforces standards

## Next Steps

1. **Run the installer** during your next `keithstart` project
2. **Configure credentials** in `~/.claude/.env`
3. **Read the guide** at `.conductor/docs/mcp-guide.md`
4. **Start using MCPs** with Claude Code

## Support

For issues with:
- **MCP installer**: Check this document
- **Specific MCPs**: See `.conductor/docs/mcp-guide.md`
- **keithstart**: Check project-init documentation

---

**Version:** 1.0.0
**Last Updated:** 2025-11-16
**Maintained by:** Keith Armstrong
