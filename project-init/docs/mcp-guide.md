# MCP (Model Context Protocol) Guide

Complete guide for using MCPs with Claude Code in your development workflow.

## Table of Contents

1. [What are MCPs?](#what-are-mcps)
2. [Installed MCPs](#installed-mcps)
3. [Getting Credentials](#getting-credentials)
4. [Usage Examples](#usage-examples)
5. [Troubleshooting](#troubleshooting)

---

## What are MCPs?

Model Context Protocol (MCP) is a standard for connecting AI assistants like Claude to external tools and data sources. MCPs extend Claude's capabilities by providing:

- **Tools**: Actions Claude can perform (create files, run tests, deploy code)
- **Resources**: Data Claude can access (documentation, database schemas, API specs)
- **Prompts**: Reusable templates for common tasks

**Benefits:**
- Up-to-date library documentation
- Direct integration with your tech stack
- Automated workflows (testing, deployment, database operations)
- Persistent memory across sessions

---

## Installed MCPs

### Essential Core MCPs

#### Filesystem MCP
**Package:** `@modelcontextprotocol/server-filesystem`

**Capabilities:**
- Read, write, and edit files
- Directory operations
- Secure file access with configured paths

**Configuration:**
```json
"filesystem": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/keitharmstrong/code"]
}
```

**Usage:**
- "Read the contents of src/app.ts"
- "Create a new component in components/Button.tsx"
- "List all TypeScript files in the src directory"

---

#### Git MCP
**Package:** `@modelcontextprotocol/server-git`

**Capabilities:**
- View git status, diff, log
- Search through git history
- Read repository information
- Manage branches

**Configuration:**
```json
"git": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-git"]
}
```

**Usage:**
- "Show me the git diff for the last commit"
- "What branches exist in this repository?"
- "Search git history for changes to the auth system"

---

#### GitHub MCP
**Package:** `@modelcontextprotocol/server-github`

**Capabilities:**
- Create and manage issues
- Create and manage pull requests
- Search repositories and code
- View and comment on PRs
- Manage branches remotely

**Configuration:**
```json
"github": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

**Required Environment Variable:**
- `GITHUB_TOKEN`: Personal access token with `repo` and `read:org` scopes

**Usage:**
- "Create a GitHub issue for this bug"
- "Open a PR with my changes"
- "Search for all TODOs in the codebase"
- "List open issues tagged with 'bug'"

---

#### Memory MCP
**Package:** `@modelcontextprotocol/server-memory`

**Capabilities:**
- Persistent knowledge graph across sessions
- Remember project context, decisions, patterns
- Store and retrieve important information

**Configuration:**
```json
"memory": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-memory"]
}
```

**Usage:**
- "Remember that we use Railway for deployment"
- "What was our decision about state management?"
- "Recall the authentication flow we designed"

---

### Tech Stack MCPs

#### Supabase MCP
**Package:** `supabase-mcp`

**Capabilities:**
- Database CRUD operations
- Table schema queries
- User authentication management
- Edge Functions invocation
- Storage operations
- Row Level Security (RLS) management

**Configuration:**
```json
"supabase": {
  "command": "npx",
  "args": ["-y", "supabase-mcp"],
  "env": {
    "SUPABASE_URL": "${SUPABASE_URL}",
    "SUPABASE_KEY": "${SUPABASE_KEY}"
  }
}
```

**Required Environment Variables:**
- `SUPABASE_URL`: Your project URL (https://your-project.supabase.co)
- `SUPABASE_KEY`: Anon/service role key

**Usage:**
- "Show me the schema for the users table"
- "Query all posts from the database"
- "Create a new RLS policy for the profiles table"
- "List all Edge Functions in this project"

---

#### ShadCN UI MCP
**Package:** `shadcn-mcp`

**Capabilities:**
- Access all shadcn/ui component documentation
- Generate components with TypeScript/JavaScript
- Tailwind CSS integration
- Direct registry access

**Configuration:**
```json
"shadcn": {
  "command": "npx",
  "args": ["-y", "shadcn-mcp"]
}
```

**Usage:**
- "Add a Button component using shadcn"
- "Show me the Dialog component documentation"
- "Generate a form with shadcn form components"
- "What shadcn components are available?"

---

#### Railway MCP
**Package:** Railway CLI (`railway mcp`)
**Status:** ⚠️ Experimental

**Capabilities:**
- Verify Railway CLI installation
- Project management
- Environment creation and selection
- Deploy templates and projects
- Retrieve build and deployment logs
- Service configuration

**Prerequisites:**
- Railway CLI installed (`brew install railway` or from https://railway.com)
- Logged in (`railway login`)

**Configuration:**
```json
"railway": {
  "command": "railway",
  "args": ["mcp"]
}
```

**Usage:**
- "Deploy this project to Railway"
- "Show me the deployment logs"
- "Create a new Railway environment"
- "List all Railway projects"

**Note:** Destructive operations (delete services/environments) are excluded by design for safety.

---

#### Figma MCP
**Package:** `@figma/dev-mode-mcp`
**Status:** Beta

**Capabilities:**
- Pull design variables, components, layout data
- Access FigJam diagrams
- Code Connect integration
- Design system workflows

**Configuration:**
```json
"figma": {
  "command": "npx",
  "args": ["-y", "@figma/dev-mode-mcp"],
  "env": {
    "FIGMA_ACCESS_TOKEN": "${FIGMA_ACCESS_TOKEN}"
  }
}
```

**Required Environment Variable:**
- `FIGMA_ACCESS_TOKEN`: Personal access token from Figma

**Usage:**
- "Get design tokens from the Figma file"
- "Show me the component specifications"
- "What are the spacing values in the design system?"
- "Pull the latest design updates"

---

#### Playwright MCP
**Package:** `@playwright/mcp`

**Capabilities:**
- Browser automation (Chromium, Firefox, WebKit)
- Screenshot capture
- E2E test generation
- Web scraping
- Form automation
- JavaScript execution in browser

**Configuration:**
```json
"playwright": {
  "command": "npx",
  "args": ["-y", "@playwright/mcp@latest"]
}
```

**Usage:**
- "Open the app in a browser and take a screenshot"
- "Test the login flow with Playwright"
- "Generate an E2E test for the checkout process"
- "Automate filling out the contact form"

**Technical Features:**
- Accessibility tree-based (not pixel-based)
- Fast and deterministic
- No vision models needed

---

#### Context7 MCP
**Package:** `@upstash/context7-mcp`

**Capabilities:**
- Up-to-date, version-specific library documentation
- Code examples from official sources
- Token-configurable context (default: 5000)

**Configuration:**
```json
"context7": {
  "command": "npx",
  "args": ["-y", "@upstash/context7-mcp"]
}
```

**Usage:**
- "Get the latest Next.js 15 documentation"
- "Show me React 19 hooks documentation"
- "How do I use Supabase authentication?"
- "Context7: fetch Prisma v6 query documentation"

---

### Development Tools

#### ESLint MCP
**Package:** `@eslint/mcp`

**Capabilities:**
- Run ESLint on files
- Get linting errors and warnings
- Auto-fix suggestions
- Enforce code quality

**Configuration:**
```json
"eslint": {
  "command": "npx",
  "args": ["-y", "@eslint/mcp@latest"]
}
```

**Usage:**
- "Lint all TypeScript files"
- "Fix ESLint errors in src/app.ts"
- "What are the linting issues in this file?"

---

#### Prisma MCP
**Package:** `prisma`

**Capabilities:**
- Database schema management
- Type-safe ORM operations
- Migration management
- Database introspection

**Configuration:**
```json
"prisma": {
  "command": "npx",
  "args": ["-y", "prisma", "mcp"]
}
```

**Usage:**
- "Generate Prisma schema from the database"
- "Create a migration for the new users table"
- "Show me the Prisma types for the Post model"

**Perfect pairing with Supabase (PostgreSQL)!**

---

#### Next.js DevTools MCP
**Package:** `next-devtools-mcp`

**Capabilities:**
- Error detection (build, runtime, type errors)
- Live state queries
- Real-time application state
- Automatic dev server discovery

**Configuration:**
```json
"nextjs": {
  "command": "npx",
  "args": ["-y", "next-devtools-mcp"]
}
```

**Usage:**
- "What errors are in the Next.js app?"
- "Show me the current app state"
- "Query the Next.js dev server"

**Note:** Built into Next.js 16+ automatically

---

#### Sequential Thinking MCP
**Package:** `@modelcontextprotocol/server-sequential-thinking`

**Capabilities:**
- Break complex tasks into logical steps
- Architectural design assistance
- System decomposition
- Multi-phase planning

**Configuration:**
```json
"sequential-thinking": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
}
```

**Usage:**
- "Help me plan the architecture for this feature"
- "Break down this refactoring into steps"
- "Design a system for real-time notifications"

---

#### Fetch MCP
**Package:** `@modelcontextprotocol/server-fetch`

**Capabilities:**
- Fetch web content
- Convert HTML to markdown
- Research documentation
- API exploration

**Configuration:**
```json
"fetch": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-fetch"]
}
```

**Usage:**
- "Fetch the React documentation page"
- "Get the content from this API endpoint"
- "Research this Stack Overflow thread"

---

## Getting Credentials

### GitHub Token

1. Go to https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Give it a name: "Claude Code MCP"
4. Select scopes:
   - `repo` (Full control of private repositories)
   - `read:org` (Read org and team membership)
5. Click "Generate token"
6. Copy the token immediately (you won't see it again!)
7. Add to your environment:
   ```bash
   export GITHUB_TOKEN="your_token_here"
   ```

### Supabase Credentials

1. Go to https://app.supabase.com
2. Select your project
3. Go to Settings → API
4. Copy:
   - **Project URL** (e.g., `https://abcdefgh.supabase.co`)
   - **Anon/public key** (for client operations) OR
   - **Service role key** (for admin operations - keep secret!)
5. Add to your environment:
   ```bash
   export SUPABASE_URL="https://your-project.supabase.co"
   export SUPABASE_KEY="your_key_here"
   ```

### Figma Access Token

1. Go to https://www.figma.com/developers/api#access-tokens
2. Or: Figma → Settings → Account → Personal access tokens
3. Click "Create new token"
4. Give it a name: "Claude Code MCP"
5. Copy the token
6. Add to your environment:
   ```bash
   export FIGMA_ACCESS_TOKEN="your_token_here"
   ```

### Setting Up Environment Variables

**Option 1: Add to shell profile** (recommended for global use)

Edit `~/.zshrc` (or `~/.bashrc`):
```bash
export GITHUB_TOKEN="your_token_here"
export SUPABASE_URL="https://your-project.supabase.co"
export SUPABASE_KEY="your_key_here"
export FIGMA_ACCESS_TOKEN="your_token_here"
```

Then reload:
```bash
source ~/.zshrc
```

**Option 2: Use direnv** (recommended for project-specific)

1. Install direnv: `brew install direnv`
2. Add to shell: `eval "$(direnv hook zsh)"` in `~/.zshrc`
3. Create `.envrc` in project:
   ```bash
   export GITHUB_TOKEN="your_token_here"
   export SUPABASE_URL="https://your-project.supabase.co"
   export SUPABASE_KEY="your_key_here"
   ```
4. Allow: `direnv allow`

**⚠️ SECURITY WARNING:**
- NEVER commit `.env` files with real credentials
- Add `.env` to `.gitignore`
- Use different keys for development/production
- Rotate tokens periodically

---

## Usage Examples

### Complete Workflow: Feature Development

```
You: I need to add a user profile feature with Supabase

Claude (using MCPs):
1. [Memory MCP] Recalls project structure and patterns
2. [Supabase MCP] Checks existing database schema
3. [ShadCN MCP] Generates form components
4. [Filesystem MCP] Creates new files
5. [Prisma MCP] Generates type-safe database client
6. [ESLint MCP] Ensures code quality
7. [Git MCP] Stages changes
8. [GitHub MCP] Creates a PR

You: Deploy this to Railway

Claude:
1. [Railway MCP] Creates deployment
2. [Railway MCP] Shows deployment logs
3. [Memory MCP] Remembers deployment configuration
```

### Example: Database Query with Type Safety

```
You: Show me all users who signed up in the last week

Claude:
1. [Supabase MCP] Queries users table with date filter
2. [Prisma MCP] Uses type-safe query
3. [Filesystem MCP] Generates a TypeScript file with results
```

### Example: UI Component with Design System

```
You: Create a modal dialog using our design system

Claude:
1. [Figma MCP] Fetches design tokens
2. [ShadCN MCP] Generates Dialog component
3. [Filesystem MCP] Creates component file
4. [ESLint MCP] Validates code quality
```

### Example: Browser Testing

```
You: Test the checkout flow and take screenshots

Claude:
1. [Playwright MCP] Opens browser
2. [Playwright MCP] Navigates through checkout
3. [Playwright MCP] Captures screenshots at each step
4. [Filesystem MCP] Saves screenshots to /screenshots
```

---

## Troubleshooting

### MCP Not Loading

**Problem:** MCP server doesn't appear in Claude Code

**Solutions:**
1. Verify configuration:
   ```bash
   cat ~/.claude/mcp.json
   ```
2. Check for JSON syntax errors
3. Restart Claude Code completely
4. Check logs for errors

---

### Environment Variables Not Found

**Problem:** Error like "GITHUB_TOKEN is not set"

**Solutions:**
1. Verify variables are exported:
   ```bash
   echo $GITHUB_TOKEN
   ```
2. Source your shell profile:
   ```bash
   source ~/.zshrc
   ```
3. Restart terminal/IDE
4. Check variable name matches exactly (case-sensitive)

---

### Railway MCP Not Working

**Problem:** Railway MCP fails or not found

**Solutions:**
1. Verify Railway CLI is installed:
   ```bash
   railway --version
   ```
2. Install if needed:
   ```bash
   brew install railway
   ```
3. Login:
   ```bash
   railway login
   ```
4. Restart Claude Code

---

### npm Package Installation Fails

**Problem:** `npm install -g` fails with permissions error

**Solutions:**

**Option 1: Use npx** (no installation needed)
- Configuration already uses `npx -y` which downloads on demand

**Option 2: Fix npm permissions**
```bash
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

**Option 3: Use nvm**
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node
```

---

### Supabase Connection Errors

**Problem:** "Invalid API key" or connection refused

**Solutions:**
1. Verify URL format:
   - Should be: `https://abcdefgh.supabase.co`
   - NOT: `https://app.supabase.com/project/...`
2. Check you're using the correct key:
   - **Anon key** for client-side operations
   - **Service role key** for admin operations
3. Verify project is not paused
4. Check network connectivity

---

### Figma MCP Authorization Issues

**Problem:** "Unauthorized" or "Invalid token"

**Solutions:**
1. Regenerate token in Figma
2. Ensure token has correct permissions
3. Check token isn't expired
4. Verify environment variable is set correctly

---

### Performance Issues

**Problem:** MCP responses are slow

**Solutions:**
1. Reduce Context7 token limit:
   ```json
   "context7": {
     "command": "npx",
     "args": ["-y", "@upstash/context7-mcp"],
     "env": {
       "CONTEXT7_MAX_TOKENS": "2000"
     }
   }
   ```
2. Limit filesystem MCP scope to specific directories
3. Use caching when available
4. Close unused MCP servers

---

### Debugging MCP Issues

**General debugging steps:**

1. **Check MCP configuration:**
   ```bash
   cat ~/.claude/mcp.json | jq
   ```

2. **Verify package installation:**
   ```bash
   npm list -g --depth=0 | grep mcp
   ```

3. **Test MCP manually:**
   ```bash
   npx @modelcontextprotocol/server-github
   ```

4. **Check environment:**
   ```bash
   env | grep -E "(GITHUB|SUPABASE|FIGMA)"
   ```

5. **Review logs:**
   - Claude Code logs (check application settings)
   - Terminal output when running commands

---

## Additional Resources

### Official Documentation
- MCP Specification: https://github.com/modelcontextprotocol/modelcontextprotocol
- MCP Registry: https://registry.modelcontextprotocol.io
- Official Servers: https://github.com/modelcontextprotocol/servers

### Tech-Specific Docs
- Supabase MCP: https://supabase.com/docs/guides/self-hosting/enable-mcp
- Railway MCP: https://docs.railway.com/reference/mcp-server
- Figma MCP: https://help.figma.com/hc/en-us/articles/32132100833559
- Playwright MCP: https://github.com/microsoft/playwright-mcp
- ESLint MCP: https://eslint.org/docs/latest/use/mcp

### Community
- MCP Servers Directory: https://mcpservers.org
- GitHub MCP Registry: https://github.blog/ai-and-ml/generative-ai/how-to-find-install-and-manage-mcp-servers-with-the-github-mcp-registry/
- LobeHub MCP: https://lobehub.com/mcp

---

## Best Practices

### Security
1. ✅ Never commit credentials to version control
2. ✅ Use fine-grained tokens with minimal permissions
3. ✅ Rotate tokens periodically
4. ✅ Use different credentials for dev/staging/production
5. ✅ Add `.env`, `.env.local` to `.gitignore`

### Performance
1. ✅ Only install MCPs you actively use
2. ✅ Limit filesystem MCP to specific directories
3. ✅ Set reasonable token limits for documentation MCPs
4. ✅ Close unused MCP servers when not needed

### Workflow
1. ✅ Use Memory MCP to maintain project context
2. ✅ Combine MCPs for complete workflows
3. ✅ Let Claude orchestrate multiple MCPs together
4. ✅ Provide clear, specific instructions

### Maintenance
1. ✅ Keep MCP packages updated: `npm update -g`
2. ✅ Review and clean unused MCPs periodically
3. ✅ Backup your MCP configuration
4. ✅ Document custom workflows in project README

---

## Getting Help

**If you encounter issues:**

1. Check this troubleshooting guide first
2. Review the official MCP documentation
3. Check the specific MCP's GitHub repository for issues
4. Ask Claude to help debug (it can read logs and configs!)

**For keithstart-specific issues:**
- Check `.conductor/` documentation
- Review `.project-meta.json` for installation status
- Re-run `install-mcps.sh` if needed

---

**Last Updated:** 2025-11-16
