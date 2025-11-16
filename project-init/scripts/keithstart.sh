#!/bin/bash
# keithstart - Initialize new project with standardized configuration
# Usage: keithstart project-name [--type=node|python|go] [--conductor] [--remote]

set -e  # Exit on error

# Configuration
KNOWLEDGE_CENTER="$HOME/code/knowledge-center"
MANDATORY_DIR="$KNOWLEDGE_CENTER/.conductor/tianjin/project-init/mandatory"
OPTIONAL_DIR="$KNOWLEDGE_CENTER/.conductor/tianjin/project-init/optional"
PROJECT_ROOT="$HOME/code"

# Default values
PROJECT_NAME=""
PROJECT_TYPE="node"
USE_CONDUCTOR=false
CREATE_REMOTE=false

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Parse arguments
if [ $# -eq 0 ]; then
    echo "Usage: keithstart project-name [--type=node|python|go] [--conductor] [--remote]"
    echo ""
    echo "Options:"
    echo "  --type=TYPE      Project type: node (default), python, or go"
    echo "  --conductor      Create Conductor workspace"
    echo "  --remote         Create GitHub repository"
    echo ""
    echo "Examples:"
    echo "  keithstart my-project"
    echo "  keithstart api-service --type=node"
    echo "  keithstart ml-model --type=python --conductor"
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

# 1. Create project directory
echo -e "${GREEN}📁 Creating project directory...${NC}"
mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH"

# 2. Initialize git repository
echo -e "${GREEN}📦 Initializing git repository...${NC}"
git init
git checkout -b main

# 3. Copy mandatory files
echo -e "${GREEN}📋 Copying mandatory files...${NC}"
# Copy regular files
find "$MANDATORY_DIR" -type f ! -path '*/\.*' -exec cp --parents {} "$PROJECT_PATH/" \; 2>/dev/null || true

# Copy hidden files and directories
cp -r "$MANDATORY_DIR/.gitignore" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/.claude" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/.github" "$PROJECT_PATH/" 2>/dev/null || true
cp -r "$MANDATORY_DIR/.env.example" "$PROJECT_PATH/" 2>/dev/null || true
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
        mkdir -p "$PROJECT_PATH/src"
        cp "$OPTIONAL_DIR/node/src-index.js" "$PROJECT_PATH/src/index.js"
    elif [ "$PROJECT_TYPE" = "python" ]; then
        cp "$OPTIONAL_DIR/python/requirements.txt" "$PROJECT_PATH/"
        cp "$OPTIONAL_DIR/python/pyproject.toml" "$PROJECT_PATH/"
        cp "$OPTIONAL_DIR/python/main.py" "$PROJECT_PATH/"
        mkdir -p "$PROJECT_PATH/src" "$PROJECT_PATH/tests"
    elif [ "$PROJECT_TYPE" = "go" ]; then
        cp "$OPTIONAL_DIR/go/go.mod.template" "$PROJECT_PATH/go.mod"
        cp "$OPTIONAL_DIR/go/main.go" "$PROJECT_PATH/"
    fi
fi

# 5. Customize templates
echo -e "${GREEN}✏️  Customizing templates...${NC}"
CURRENT_DATE=$(date +%Y-%m-%d)

# Replace placeholders in all markdown and config files
if command -v gsed >/dev/null 2>&1; then
    SED_CMD="gsed"
else
    SED_CMD="sed"
fi

# Use find with null separator for safety
find "$PROJECT_PATH" -type f \( -name "*.md" -o -name "*.json" -o -name "*.toml" -o -name "*.js" -o -name "*.py" -o -name "*.go" \) -print0 | while IFS= read -r -d '' file; do
    $SED_CMD -i "s/\[Project Name\]/$PROJECT_NAME/g" "$file"
    $SED_CMD -i "s/\[project-name\]/$PROJECT_NAME/g" "$file"
    $SED_CMD -i "s/YYYY-MM-DD/$CURRENT_DATE/g" "$file"
done

# 6. Set up environment file
if [ -f ".env.example" ]; then
    echo -e "${GREEN}⚙️  Creating .env file...${NC}"
    cp .env.example .env
    $SED_CMD -i "s/\[project-name\]/$PROJECT_NAME/g" .env
fi

# 7. Install dependencies
echo -e "${GREEN}📥 Installing dependencies...${NC}"
if [ "$PROJECT_TYPE" = "node" ]; then
    if command -v npm >/dev/null 2>&1; then
        npm install
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

# 8. Optional: Create Conductor workspace
if [ "$USE_CONDUCTOR" = true ]; then
    echo -e "${GREEN}🎯 Creating Conductor workspace...${NC}"
    mkdir -p .conductor/$PROJECT_NAME

    # Copy templates if they exist in knowledge center
    if [ -d "$KNOWLEDGE_CENTER/.conductor/tianjin/templates" ]; then
        cp -r "$KNOWLEDGE_CENTER/.conductor/tianjin/templates" ".conductor/$PROJECT_NAME/"
    fi

    # Copy environment to workspace
    if [ -f ".env" ]; then
        cp .env ".conductor/$PROJECT_NAME/.env"
    fi
fi

# 9. Optional: Create GitHub repository
if [ "$CREATE_REMOTE" = true ]; then
    if command -v gh >/dev/null 2>&1; then
        echo -e "${GREEN}🌐 Creating GitHub repository...${NC}"
        gh repo create "$PROJECT_NAME" --private --source=. --remote=origin
    else
        echo -e "${YELLOW}⚠️  gh CLI not found, skipping GitHub repository creation${NC}"
    fi
fi

# 10. Create version tracking file
echo "$CURRENT_DATE" > .keithstart-version

# 11. Initial commit
echo -e "${GREEN}💾 Creating initial commit...${NC}"
git add .
git commit -m "chore: initialize project with keithstart

🤖 Generated with keithstart
Project type: $PROJECT_TYPE
Created: $CURRENT_DATE

Co-Authored-By: keithstart <noreply@keithstart.local>"

# 12. Track initialization in knowledge center
echo "$PROJECT_NAME|$PROJECT_TYPE|$CURRENT_DATE|$PROJECT_PATH" >> "$KNOWLEDGE_CENTER/.conductor/tianjin/project-init/.projects-log"

# 13. Success message
echo ""
echo -e "${GREEN}✅ Project initialized successfully!${NC}"
echo ""
echo -e "${BLUE}📁 Location:${NC} $PROJECT_PATH"
echo -e "${BLUE}🏷️  Type:${NC} $PROJECT_TYPE"
echo -e "${BLUE}🎨 Templates:${NC} Applied"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  cd $PROJECT_PATH"

if [ -f ".env" ]; then
    echo "  # Edit .env with your configuration"
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
