#!/bin/bash
# keithstart - Initialize new project with standardized configuration
# Usage: keithstart project-name [--type=node|python|go] [--conductor] [--remote]

set -e  # Exit on error

# Configuration
KNOWLEDGE_CENTER="$HOME/code/knowledge-center"
MANDATORY_DIR="$KNOWLEDGE_CENTER/project-init/mandatory"
OPTIONAL_DIR="$KNOWLEDGE_CENTER/project-init/optional"
PROJECT_ROOT="$HOME/code"

# Default values
PROJECT_NAME=""
PROJECT_TYPE="node"
USE_CONDUCTOR=false
CREATE_REMOTE=false
INTERACTIVE=false
PROJECT_DESC=""
PROJECT_AUTHOR=""
PROJECT_LICENSE="MIT"
PROJECT_FRAMEWORK=""
PROJECT_DATABASE=""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper function for yes/no prompts
prompt_yes_no() {
    local prompt="$1"
    local default="${2:-n}"
    local answer

    if [ "$default" = "y" ]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    read -p "$prompt" answer
    answer=${answer:-$default}

    if [[ "$answer" =~ ^[Yy] ]]; then
        return 0
    else
        return 1
    fi
}

# Parse arguments
if [ $# -eq 0 ]; then
    echo "Usage: keithstart project-name [--type=node|python|go] [--conductor] [--remote] [--interactive]"
    echo ""
    echo "Options:"
    echo "  --type=TYPE      Project type: node (default), python, or go"
    echo "  --conductor      Create Conductor workspace"
    echo "  --remote         Create GitHub repository"
    echo "  --interactive    Prompt for project metadata (description, author, etc.)"
    echo ""
    echo "Examples:"
    echo "  keithstart my-project"
    echo "  keithstart api-service --type=node"
    echo "  keithstart ml-model --type=python --conductor"
    echo "  keithstart web-app --interactive --remote"
    exit 1
fi

PROJECT_NAME=$1
shift

# Process flags
for arg in "$@"; do
    case $arg in
        --type=*)
            PROJECT_TYPE="${arg#*=}"
            ;;
        --conductor)
            USE_CONDUCTOR=true
            ;;
        --remote)
            CREATE_REMOTE=true
            ;;
        --interactive)
            INTERACTIVE=true
            ;;
        *)
            echo "Unknown option: $arg"
            exit 1
            ;;
    esac
done

# Validate project type
if [[ ! "$PROJECT_TYPE" =~ ^(node|python|go)$ ]]; then
    echo "Error: Invalid project type '$PROJECT_TYPE'. Must be: node, python, or go"
    exit 1
fi

PROJECT_PATH="$PROJECT_ROOT/$PROJECT_NAME"

# Check if project already exists
if [ -d "$PROJECT_PATH" ]; then
    echo "Error: Project $PROJECT_NAME already exists at $PROJECT_PATH"
    exit 1
fi

# Check if knowledge center exists
if [ ! -d "$KNOWLEDGE_CENTER" ]; then
    echo "Error: Knowledge center not found at $KNOWLEDGE_CENTER"
    exit 1
fi

# Check if mandatory templates exist
if [ ! -d "$MANDATORY_DIR" ]; then
    echo "Error: Mandatory templates not found at $MANDATORY_DIR"
    exit 1
fi

echo -e "${BLUE}🚀 Creating new project: $PROJECT_NAME${NC}"
echo "   Type: $PROJECT_TYPE"
echo "   Location: $PROJECT_PATH"
echo ""

# Interactive prompts for project metadata
if [ "$INTERACTIVE" = true ]; then
    echo -e "${BLUE}📝 Project Metadata${NC}"
    echo "Let's gather some information about your project."
    echo ""

    read -p "Project description: " PROJECT_DESC
    PROJECT_DESC=${PROJECT_DESC:-"A new project built with keithstart"}

    read -p "Author name [Keith Armstrong]: " PROJECT_AUTHOR
    PROJECT_AUTHOR=${PROJECT_AUTHOR:-"Keith Armstrong"}

    read -p "License [MIT]: " PROJECT_LICENSE
    PROJECT_LICENSE=${PROJECT_LICENSE:-"MIT"}

    # Framework suggestion based on project type
    if [ "$PROJECT_TYPE" = "node" ]; then
        read -p "Framework (e.g., Express, Fastify, Next.js) [None]: " PROJECT_FRAMEWORK
    elif [ "$PROJECT_TYPE" = "python" ]; then
        read -p "Framework (e.g., FastAPI, Flask, Django) [None]: " PROJECT_FRAMEWORK
    elif [ "$PROJECT_TYPE" = "go" ]; then
        read -p "Framework (e.g., Echo, Gin, Fiber) [None]: " PROJECT_FRAMEWORK
    fi
    PROJECT_FRAMEWORK=${PROJECT_FRAMEWORK:-"None"}

    read -p "Database (e.g., PostgreSQL, MongoDB, MySQL) [None]: " PROJECT_DATABASE
    PROJECT_DATABASE=${PROJECT_DATABASE:-"None"}

    echo ""
    echo -e "${GREEN}✓ Metadata collected${NC}"
    echo ""
fi

# 1. Optional: Create GitHub repository FIRST (before local setup)
if [ "$CREATE_REMOTE" = true ]; then
    if command -v gh >/dev/null 2>&1; then
        echo -e "${GREEN}🌐 Creating GitHub repository...${NC}"
        # Create the repo on GitHub first
        gh repo create "$PROJECT_NAME" --private --clone=false
        echo -e "${GREEN}✓ GitHub repository created${NC}"
    else
        echo -e "${YELLOW}⚠️  gh CLI not found, skipping GitHub repository creation${NC}"
        echo -e "${YELLOW}⚠️  Project will be created locally only${NC}"
        CREATE_REMOTE=false
    fi
fi

# 2. Create project directory
echo -e "${GREEN}📁 Creating project directory...${NC}"
mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH"

# 3. Initialize git repository and set up remote
echo -e "${GREEN}📦 Initializing git repository...${NC}"
git init
git checkout -b main

# If we created a GitHub repo, set it as the origin remote
if [ "$CREATE_REMOTE" = true ]; then
    echo -e "${GREEN}🔗 Setting up remote origin...${NC}"
    # Get the authenticated user's GitHub username
    GH_USER=$(gh api user -q .login)
    git remote add origin "https://github.com/$GH_USER/$PROJECT_NAME.git"
    echo -e "${GREEN}✓ Remote origin configured${NC}"
fi

# 3. Copy mandatory files
echo -e "${GREEN}📋 Copying mandatory files...${NC}"
# Copy regular files
find "$MANDATORY_DIR" -type f ! -path '*/\.*' -exec cp --parents {} "$PROJECT_PATH/" \; 2>/dev/null || true

# Copy hidden files and directories
cp -r "$MANDATORY_DIR/.gitignore" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/.claude" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/.github" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/.env.example" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/.env.staging" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/.env.production" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/.project.json" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/railway.json" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/README.md" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/docs" "$PROJECT_PATH/" 2>/dev/null || true

# 4. Copy project-type specific files
if [ -d "$OPTIONAL_DIR/$PROJECT_TYPE" ]; then
    echo -e "${GREEN}📦 Setting up $PROJECT_TYPE project...${NC}"

    # Copy type-specific files
    if [ "$PROJECT_TYPE" = "node" ]; then
        cp "$OPTIONAL_DIR/node/package.json" "$PROJECT_PATH/"
        cp "$OPTIONAL_DIR/node/tsconfig.json" "$PROJECT_PATH/"
        cp "$OPTIONAL_DIR/node/.eslintrc.js" "$PROJECT_PATH/"
        mkdir -p "$PROJECT_PATH/src" "$PROJECT_PATH/tests" "$PROJECT_PATH/scripts"
        cp "$OPTIONAL_DIR/node/src-index.js" "$PROJECT_PATH/src/index.js"
    elif [ "$PROJECT_TYPE" = "python" ]; then
        cp "$OPTIONAL_DIR/python/requirements.txt" "$PROJECT_PATH/"
        cp "$OPTIONAL_DIR/python/pyproject.toml" "$PROJECT_PATH/"
        cp "$OPTIONAL_DIR/python/main.py" "$PROJECT_PATH/"
        mkdir -p "$PROJECT_PATH/src" "$PROJECT_PATH/tests" "$PROJECT_PATH/scripts"
    elif [ "$PROJECT_TYPE" = "go" ]; then
        cp "$OPTIONAL_DIR/go/go.mod.template" "$PROJECT_PATH/go.mod"
        cp "$OPTIONAL_DIR/go/main.go" "$PROJECT_PATH/"
        mkdir -p "$PROJECT_PATH/tests" "$PROJECT_PATH/scripts"
    fi
fi

# 5. Customize templates
echo -e "${GREEN}✏️  Customizing templates...${NC}"
CURRENT_DATE=$(date +%Y-%m-%d)

# Replace placeholders in all markdown and config files
# Use perl for in-place editing (cross-platform compatible)
# Exclude .sh files to prevent corruption of shell scripts (e.g., install-mcps.sh with @ symbols in npm packages)
find "$PROJECT_PATH" -type f \( -name "*.md" -o -name "*.json" -o -name "*.toml" -o -name "*.js" -o -name "*.py" -o -name "*.go" \) ! -name "*.sh" -print0 | while IFS= read -r -d '' file; do
    perl -pi -e "s/\[Project Name\]/$PROJECT_NAME/g" "$file"
    perl -pi -e "s/\[project-name\]/$PROJECT_NAME/g" "$file"
    perl -pi -e "s/YYYY-MM-DD/$CURRENT_DATE/g" "$file"

    # Replace metadata if interactive mode was used
    if [ "$INTERACTIVE" = true ]; then
        # Escape special characters for perl regex
        ESCAPED_DESC=$(printf '%s\n' "$PROJECT_DESC" | perl -pe 's/([\/\$@])/\\$1/g')
        ESCAPED_AUTHOR=$(printf '%s\n' "$PROJECT_AUTHOR" | perl -pe 's/([\/\$@])/\\$1/g')
        ESCAPED_FRAMEWORK=$(printf '%s\n' "$PROJECT_FRAMEWORK" | perl -pe 's/([\/\$@])/\\$1/g')
        ESCAPED_DATABASE=$(printf '%s\n' "$PROJECT_DATABASE" | perl -pe 's/([\/\$@])/\\$1/g')

        perl -pi -e "s/\[Project description\]/$ESCAPED_DESC/g" "$file"
        perl -pi -e "s/\[Author Name\]/$ESCAPED_AUTHOR/g" "$file"
        perl -pi -e "s/\[Framework\]/$ESCAPED_FRAMEWORK/g" "$file"
        perl -pi -e "s/\[Database\]/$ESCAPED_DATABASE/g" "$file"
        perl -pi -e "s/\[License\]/$PROJECT_LICENSE/g" "$file"
    fi
done

# 6. Customize .project.json with type-specific values
if [ -f ".project.json" ]; then
    echo -e "${GREEN}📝 Customizing project metadata...${NC}"
    # Update project type
    perl -pi -e "s/\"type\": \"node\"/\"type\": \"$PROJECT_TYPE\"/g" .project.json

    # Update conductor flag
    if [ "$USE_CONDUCTOR" = true ]; then
        perl -pi -e "s/\"conductor\": false/\"conductor\": true/g" .project.json
    fi

    # Update package manager based on type
    if [ "$PROJECT_TYPE" = "python" ]; then
        perl -pi -e "s/\"packageManager\": \"npm\"/\"packageManager\": \"pip\"/g" .project.json
        perl -pi -e "s/\"lockfile\": \"package-lock.json\"/\"lockfile\": \"requirements.txt\"/g" .project.json
    elif [ "$PROJECT_TYPE" = "go" ]; then
        perl -pi -e "s/\"packageManager\": \"npm\"/\"packageManager\": \"go\"/g" .project.json
        perl -pi -e "s/\"lockfile\": \"package-lock.json\"/\"lockfile\": \"go.sum\"/g" .project.json
    fi
fi

# 7. Set up environment file
if [ -f ".env.example" ]; then
    echo -e "${GREEN}⚙️  Creating .env file...${NC}"
    cp .env.example .env
    perl -pi -e "s/\[project-name\]/$PROJECT_NAME/g" .env
fi

# 8. Install dependencies
echo -e "${GREEN}📥 Installing dependencies...${NC}"
if [ "$PROJECT_TYPE" = "node" ]; then
    if command -v npm >/dev/null 2>&1; then
        npm install

        # 8a. Setup Husky for pre-commit hooks
        echo -e "${GREEN}🎣 Setting up Husky pre-commit hooks...${NC}"
        npx husky init

        # Create pre-commit hook with linting and formatting
        cat > .husky/pre-commit << 'EOF'
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

npm run lint
npm run format
EOF
        chmod +x .husky/pre-commit
        echo -e "${GREEN}✓ Husky initialized with pre-commit hooks${NC}"
    else
        echo -e "${YELLOW}⚠️  npm not found, skipping dependency installation${NC}"
    fi
elif [ "$PROJECT_TYPE" = "python" ]; then
    if command -v python3 >/dev/null 2>&1; then
        python3 -m venv venv
        source venv/bin/activate
        pip install -r requirements.txt
    else
        echo -e "${YELLOW}⚠️  python3 not found, skipping dependency installation${NC}"
    fi
elif [ "$PROJECT_TYPE" = "go" ]; then
    if command -v go >/dev/null 2>&1; then
        go mod tidy
    else
        echo -e "${YELLOW}⚠️  go not found, skipping dependency installation${NC}"
    fi
fi

# 9. Optional: Create Conductor workspace
if [ "$USE_CONDUCTOR" = true ]; then
    echo -e "${GREEN}🎯 Creating Conductor workspace...${NC}"
    mkdir -p .conductor/$PROJECT_NAME

    # Copy templates if they exist in knowledge center
    if [ -d "$KNOWLEDGE_CENTER/templates" ]; then
        cp -r "$KNOWLEDGE_CENTER/templates" ".conductor/$PROJECT_NAME/"
    fi

    # Copy environment to workspace
    if [ -f ".env" ]; then
        cp .env ".conductor/$PROJECT_NAME/.env"
    fi
fi

# 10. Create version tracking file
echo "$CURRENT_DATE" > .keithstart-version

# 11. Optional: Install MCPs
echo ""
echo -e "${BLUE}🔌 MCP (Model Context Protocol) Setup${NC}"
echo "MCPs extend Claude Code with tools for your tech stack."
echo ""

if prompt_yes_no "Would you like to install MCPs for Claude Code?" "y"; then
    MCP_INSTALLER="$KNOWLEDGE_CENTER/scripts/install-mcps.sh"

    if [ -f "$MCP_INSTALLER" ]; then
        echo ""
        echo -e "${GREEN}Launching MCP installer...${NC}"
        bash "$MCP_INSTALLER"

        # Track MCP installation in project metadata
        if [ -f ".project.json" ]; then
            perl -pi -e "s/\"mcps\": false/\"mcps\": true/g" .project.json
        fi
    else
        echo -e "${YELLOW}⚠️  MCP installer not found at $MCP_INSTALLER${NC}"
        echo "   You can install MCPs manually later."
    fi
else
    echo -e "${YELLOW}Skipping MCP installation. You can install them later by running:${NC}"
    echo "   bash $KNOWLEDGE_CENTER/scripts/install-mcps.sh"
fi

# 12. Initial commit
echo ""
echo -e "${GREEN}💾 Creating initial commit...${NC}"
git add .
git commit -m "chore: initialize project with keithstart

🤖 Generated with keithstart
Project type: $PROJECT_TYPE
Created: $CURRENT_DATE

Co-Authored-By: keithstart <noreply@keithstart.local>"

# 13. Push to GitHub if remote was created
if [ "$CREATE_REMOTE" = true ]; then
    echo ""
    echo -e "${GREEN}⬆️  Pushing initial commit to GitHub...${NC}"
    git push -u origin main
    echo -e "${GREEN}✓ Pushed to GitHub${NC}"
fi

# 14. Validate project setup
echo ""
echo -e "${GREEN}🔍 Validating project setup...${NC}"

VALIDATION_ERRORS=0

# Check for duplicate files (BSD sed issue)
if ls "$PROJECT_PATH" | grep -q "''$" 2>/dev/null; then
    echo -e "${YELLOW}⚠️  Warning: Duplicate files found (possible sed issue)${NC}"
    VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
fi

# Check for unfilled placeholders
if grep -r "\[Project description\]" "$PROJECT_PATH" 2>/dev/null | grep -v node_modules | grep -q .; then
    echo -e "${YELLOW}⚠️  Warning: Some template placeholders remain unfilled${NC}"
    echo "   Consider using --interactive flag for complete setup"
    VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
fi

# Verify dependencies installed
case "$PROJECT_TYPE" in
    node)
        if [ ! -d "$PROJECT_PATH/node_modules" ]; then
            echo -e "${YELLOW}⚠️  Warning: node_modules not found${NC}"
            VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
        else
            echo -e "${GREEN}✓ Node dependencies installed${NC}"
        fi
        if [ -d "$PROJECT_PATH/.husky" ]; then
            echo -e "${GREEN}✓ Husky pre-commit hooks configured${NC}"
        fi
        ;;
    python)
        if [ ! -d "$PROJECT_PATH/venv" ]; then
            echo -e "${YELLOW}⚠️  Warning: venv not found${NC}"
            VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
        else
            echo -e "${GREEN}✓ Python virtual environment created${NC}"
        fi
        ;;
    go)
        if [ ! -f "$PROJECT_PATH/go.sum" ]; then
            echo -e "${YELLOW}⚠️  Warning: go.sum not found${NC}"
            VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
        else
            echo -e "${GREEN}✓ Go modules initialized${NC}"
        fi
        ;;
esac

# Check essential directories exist
for dir in src tests scripts; do
    if [ -d "$PROJECT_PATH/$dir" ]; then
        echo -e "${GREEN}✓ $dir/ directory created${NC}"
    fi
done

# Check essential files exist
for file in .env .gitignore README.md; do
    if [ -f "$PROJECT_PATH/$file" ]; then
        echo -e "${GREEN}✓ $file created${NC}"
    fi
done

if [ $VALIDATION_ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ All validation checks passed!${NC}"
else
    echo -e "${YELLOW}⚠️  $VALIDATION_ERRORS warning(s) found (project still usable)${NC}"
fi

# 15. Track initialization in knowledge center
echo "$PROJECT_NAME|$PROJECT_TYPE|$CURRENT_DATE|$PROJECT_PATH" >> "$KNOWLEDGE_CENTER/project-init/.projects-log"

# 16. Success message
echo ""
echo -e "${GREEN}✅ Project initialized successfully!${NC}"
echo ""
echo -e "${BLUE}📁 Location:${NC} $PROJECT_PATH"
echo -e "${BLUE}🏷️  Type:${NC} $PROJECT_TYPE"
echo -e "${BLUE}🎨 Templates:${NC} Applied"
if [ -f "$HOME/.claude/mcp.json" ]; then
    echo -e "${BLUE}🔌 MCPs:${NC} Configured globally"
fi
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  cd $PROJECT_PATH"

if [ -f ".env" ]; then
    echo "  # Edit .env with your configuration"
fi

if [ -f "$HOME/.claude/.env.example" ]; then
    echo "  # Configure MCP credentials: ~/.claude/.env.example"
fi

if [ "$PROJECT_TYPE" = "node" ]; then
    echo "  npm run dev"
elif [ "$PROJECT_TYPE" = "python" ]; then
    echo "  source venv/bin/activate"
    echo "  python main.py"
elif [ "$PROJECT_TYPE" = "go" ]; then
    echo "  go run main.go"
fi

echo "  # Start coding!"
echo ""
echo -e "${BLUE}📦 Deployment Setup:${NC}"
echo "  Railway configuration added (railway.json)"
echo "  Environment templates created (.env.staging, .env.production)"
echo "  Run 'railway init' to connect to Railway"
echo "  See docs/DEPLOYMENT.md for deployment workflow"
echo ""
echo -e "${BLUE}💡 Tip: Run this command to navigate to your project:${NC}"
echo -e "   ${GREEN}cd $PROJECT_PATH${NC}"
echo ""
echo -e "${BLUE}📚 Documentation:${NC}"
echo "   MCP Guide: .conductor/docs/mcp-guide.md (if available)"
echo "   Project Docs: docs/"
echo ""
