#!/bin/bash

# MCP Installation Script
# Interactively installs Model Context Protocol servers for Claude Code

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CLAUDE_DIR="$HOME/.claude"
MCP_CONFIG="$CLAUDE_DIR/mcp.json"
ENV_EXAMPLE="$CLAUDE_DIR/.env.example"

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  MCP Server Installation for Claude   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Ensure .claude directory exists
mkdir -p "$CLAUDE_DIR"

# Backup existing configuration
if [ -f "$MCP_CONFIG" ]; then
    BACKUP_FILE="$MCP_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}⚠️  Backing up existing config to: $BACKUP_FILE${NC}"
    cp "$MCP_CONFIG" "$BACKUP_FILE"
fi

# Function to prompt yes/no
prompt_yes_no() {
    local prompt="$1"
    local default="${2:-n}"

    if [ "$default" = "y" ]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    while true; do
        read -p "$prompt" response
        response=${response:-$default}
        case $response in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
            *) echo "Please answer yes or no." ;;
        esac
    done
}

# Arrays to track selections
declare -a SELECTED_MCPS=()

echo ""
echo -e "${GREEN}═══ Essential Core MCPs ═══${NC}"
echo "These provide fundamental development capabilities."
echo ""

if prompt_yes_no "  Install Filesystem MCP (secure file operations)?"; then
    SELECTED_MCPS+=("filesystem")
fi

if prompt_yes_no "  Install Git MCP (repository operations)?"; then
    SELECTED_MCPS+=("git")
fi

if prompt_yes_no "  Install GitHub MCP (issues, PRs, code search)?"; then
    SELECTED_MCPS+=("github")
fi

if prompt_yes_no "  Install Memory MCP (persistent context across sessions)?"; then
    SELECTED_MCPS+=("memory")
fi

echo ""
echo -e "${GREEN}═══ Your Tech Stack MCPs ═══${NC}"
echo "MCPs for Supabase, ShadCN, Railway, Figma, Playwright, etc."
echo ""

if prompt_yes_no "  Install Supabase MCP (database operations)?"; then
    SELECTED_MCPS+=("supabase")
fi

if prompt_yes_no "  Install ShadCN UI MCP (component documentation & generation)?"; then
    SELECTED_MCPS+=("shadcn")
fi

if prompt_yes_no "  Install Railway MCP (deployment management)?" && echo -e "    ${YELLOW}⚠️  WARNING: Railway MCP is experimental${NC}"; then
    SELECTED_MCPS+=("railway")
fi

if prompt_yes_no "  Install Figma MCP (design context & Code Connect)?"; then
    SELECTED_MCPS+=("figma")
fi

if prompt_yes_no "  Install Playwright MCP (browser testing & automation)?"; then
    SELECTED_MCPS+=("playwright")
fi

if prompt_yes_no "  Install Context7 MCP (up-to-date library docs)?"; then
    SELECTED_MCPS+=("context7")
fi

echo ""
echo -e "${GREEN}═══ Development Tools ═══${NC}"
echo "Quality, database, and productivity enhancements."
echo ""

if prompt_yes_no "  Install ESLint MCP (code quality & linting)?"; then
    SELECTED_MCPS+=("eslint")
fi

if prompt_yes_no "  Install Prisma MCP (type-safe database ORM)?"; then
    SELECTED_MCPS+=("prisma")
fi

if prompt_yes_no "  Install Next.js DevTools MCP (error detection & state)?"; then
    SELECTED_MCPS+=("nextjs")
fi

if prompt_yes_no "  Install Sequential Thinking MCP (complex planning)?"; then
    SELECTED_MCPS+=("sequential-thinking")
fi

if prompt_yes_no "  Install Fetch MCP (web content fetching)?"; then
    SELECTED_MCPS+=("fetch")
fi

echo ""
echo -e "${BLUE}Selected MCPs: ${#SELECTED_MCPS[@]}${NC}"
echo ""

if [ ${#SELECTED_MCPS[@]} -eq 0 ]; then
    echo -e "${YELLOW}No MCPs selected. Exiting.${NC}"
    exit 0
fi

# Verify Railway CLI if Railway MCP selected
if [[ " ${SELECTED_MCPS[@]} " =~ " railway " ]]; then
    if ! command -v railway &> /dev/null; then
        echo -e "${RED}✗ Railway CLI not found${NC}"
        echo "  Install from: https://docs.railway.com/guides/cli"
        echo "  Then run: railway login"
        echo ""
        if ! prompt_yes_no "Continue without Railway MCP?"; then
            exit 1
        fi
        # Remove railway from selection
        SELECTED_MCPS=("${SELECTED_MCPS[@]/railway}")
    else
        echo -e "${GREEN}✓ Railway CLI detected${NC}"
    fi
fi

# Install npm packages
echo ""
echo -e "${BLUE}Installing MCP packages...${NC}"
echo ""

for mcp in "${SELECTED_MCPS[@]}"; do
    case $mcp in
        filesystem)
            echo -e "${YELLOW}Installing Filesystem MCP...${NC}"
            npm install -g @modelcontextprotocol/server-filesystem
            ;;
        git)
            echo -e "${YELLOW}Installing Git MCP...${NC}"
            npm install -g @modelcontextprotocol/server-git
            ;;
        github)
            echo -e "${YELLOW}Installing GitHub MCP...${NC}"
            npm install -g @modelcontextprotocol/server-github
            ;;
        memory)
            echo -e "${YELLOW}Installing Memory MCP...${NC}"
            npm install -g @modelcontextprotocol/server-memory
            ;;
        supabase)
            echo -e "${YELLOW}Installing Supabase MCP...${NC}"
            npm install -g supabase-mcp
            ;;
        shadcn)
            echo -e "${YELLOW}Installing ShadCN UI MCP...${NC}"
            npm install -g shadcn-mcp
            ;;
        railway)
            # Railway MCP uses Railway CLI, no npm install needed
            echo -e "${YELLOW}Railway MCP uses Railway CLI (already installed)${NC}"
            ;;
        figma)
            echo -e "${YELLOW}Installing Figma MCP...${NC}"
            npm install -g @figma/dev-mode-mcp
            ;;
        playwright)
            echo -e "${YELLOW}Installing Playwright MCP...${NC}"
            npm install -g @playwright/mcp
            ;;
        context7)
            echo -e "${YELLOW}Installing Context7 MCP...${NC}"
            npm install -g @upstash/context7-mcp
            ;;
        eslint)
            echo -e "${YELLOW}Installing ESLint MCP...${NC}"
            npm install -g @eslint/mcp
            ;;
        prisma)
            echo -e "${YELLOW}Installing Prisma MCP...${NC}"
            npm install -g prisma
            ;;
        nextjs)
            echo -e "${YELLOW}Installing Next.js DevTools MCP...${NC}"
            npm install -g next-devtools-mcp
            ;;
        sequential-thinking)
            echo -e "${YELLOW}Installing Sequential Thinking MCP...${NC}"
            npm install -g @modelcontextprotocol/server-sequential-thinking
            ;;
        fetch)
            echo -e "${YELLOW}Installing Fetch MCP...${NC}"
            npm install -g @modelcontextprotocol/server-fetch
            ;;
    esac
done

# Generate MCP configuration
echo ""
echo -e "${BLUE}Generating MCP configuration...${NC}"

# Start JSON object
cat > "$MCP_CONFIG" << 'EOF'
{
  "mcpServers": {
EOF

# Add each selected MCP configuration
FIRST=true
for mcp in "${SELECTED_MCPS[@]}"; do
    # Add comma if not first entry
    if [ "$FIRST" = false ]; then
        echo "," >> "$MCP_CONFIG"
    fi
    FIRST=false

    case $mcp in
        filesystem)
            cat >> "$MCP_CONFIG" << 'EOF'
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/keitharmstrong/code"]
    }
EOF
            ;;
        git)
            cat >> "$MCP_CONFIG" << 'EOF'
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git"]
    }
EOF
            ;;
        github)
            cat >> "$MCP_CONFIG" << 'EOF'
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
EOF
            ;;
        memory)
            cat >> "$MCP_CONFIG" << 'EOF'
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
EOF
            ;;
        supabase)
            cat >> "$MCP_CONFIG" << 'EOF'
    "supabase": {
      "command": "npx",
      "args": ["-y", "supabase-mcp"],
      "env": {
        "SUPABASE_URL": "${SUPABASE_URL}",
        "SUPABASE_KEY": "${SUPABASE_KEY}"
      }
    }
EOF
            ;;
        shadcn)
            cat >> "$MCP_CONFIG" << 'EOF'
    "shadcn": {
      "command": "npx",
      "args": ["-y", "shadcn-mcp"]
    }
EOF
            ;;
        railway)
            cat >> "$MCP_CONFIG" << 'EOF'
    "railway": {
      "command": "railway",
      "args": ["mcp"]
    }
EOF
            ;;
        figma)
            cat >> "$MCP_CONFIG" << 'EOF'
    "figma": {
      "command": "npx",
      "args": ["-y", "@figma/dev-mode-mcp"],
      "env": {
        "FIGMA_ACCESS_TOKEN": "${FIGMA_ACCESS_TOKEN}"
      }
    }
EOF
            ;;
        playwright)
            cat >> "$MCP_CONFIG" << 'EOF'
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    }
EOF
            ;;
        context7)
            cat >> "$MCP_CONFIG" << 'EOF'
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
EOF
            ;;
        eslint)
            cat >> "$MCP_CONFIG" << 'EOF'
    "eslint": {
      "command": "npx",
      "args": ["-y", "@eslint/mcp@latest"]
    }
EOF
            ;;
        prisma)
            cat >> "$MCP_CONFIG" << 'EOF'
    "prisma": {
      "command": "npx",
      "args": ["-y", "prisma", "mcp"]
    }
EOF
            ;;
        nextjs)
            cat >> "$MCP_CONFIG" << 'EOF'
    "nextjs": {
      "command": "npx",
      "args": ["-y", "next-devtools-mcp"]
    }
EOF
            ;;
        sequential-thinking)
            cat >> "$MCP_CONFIG" << 'EOF'
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    }
EOF
            ;;
        fetch)
            cat >> "$MCP_CONFIG" << 'EOF'
    "fetch": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    }
EOF
            ;;
    esac
done

# Close JSON object
cat >> "$MCP_CONFIG" << 'EOF'

  }
}
EOF

echo -e "${GREEN}✓ Configuration written to: $MCP_CONFIG${NC}"

# Create .env.example if needed
NEEDS_ENV=false
for mcp in "${SELECTED_MCPS[@]}"; do
    if [[ "$mcp" == "github" || "$mcp" == "supabase" || "$mcp" == "figma" ]]; then
        NEEDS_ENV=true
        break
    fi
done

if [ "$NEEDS_ENV" = true ]; then
    echo ""
    echo -e "${BLUE}Creating environment variable template...${NC}"

    cat > "$ENV_EXAMPLE" << 'EOF'
# MCP Server Environment Variables
# Copy this file and fill in your actual values
# NEVER commit actual credentials to version control

EOF

    for mcp in "${SELECTED_MCPS[@]}"; do
        case $mcp in
            github)
                cat >> "$ENV_EXAMPLE" << 'EOF'
# GitHub Personal Access Token
# Get from: https://github.com/settings/tokens
# Required scopes: repo, read:org
GITHUB_TOKEN=your_github_token_here

EOF
                ;;
            supabase)
                cat >> "$ENV_EXAMPLE" << 'EOF'
# Supabase Project Credentials
# Get from: https://app.supabase.com/project/_/settings/api
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your_supabase_anon_key_here

EOF
                ;;
            figma)
                cat >> "$ENV_EXAMPLE" << 'EOF'
# Figma Access Token
# Get from: https://www.figma.com/developers/api#access-tokens
FIGMA_ACCESS_TOKEN=your_figma_token_here

EOF
                ;;
        esac
    done

    echo -e "${GREEN}✓ Environment template created: $ENV_EXAMPLE${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  IMPORTANT: Set up your environment variables${NC}"
    echo "   1. Copy $ENV_EXAMPLE to .env"
    echo "   2. Fill in your actual credentials"
    echo "   3. Source it before running Claude Code"
    echo "   4. NEVER commit credentials to git"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     MCP Installation Complete! ✓       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo "Installed MCPs:"
for mcp in "${SELECTED_MCPS[@]}"; do
    echo -e "  ${GREEN}✓${NC} $mcp"
done
echo ""
echo "Next steps:"
echo "  1. Set up environment variables (see $ENV_EXAMPLE)"
echo "  2. Restart Claude Code to load new MCPs"
echo "  3. Verify with: cat $MCP_CONFIG"
echo ""
echo -e "${BLUE}Documentation:${NC} .conductor/docs/mcp-guide.md"
echo ""
