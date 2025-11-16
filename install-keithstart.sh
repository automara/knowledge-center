#!/bin/bash
# install-keithstart.sh - Install keithstart system to main knowledge-center repo
# This script copies the project-init system from the workspace to the main repo
# and creates persistent symlinks in /usr/local/bin

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
WORKSPACE_DIR="/Users/keitharmstrong/code/knowledge-center/.conductor/troy"
MAIN_REPO="/Users/keitharmstrong/code/knowledge-center"
INSTALL_DIR="/usr/local/bin"

echo -e "${BLUE}🚀 Installing keithstart system${NC}"
echo ""

# 1. Copy project-init to main repo
echo -e "${GREEN}📦 Copying project-init to main knowledge-center repo...${NC}"

if [ ! -d "$WORKSPACE_DIR/project-init" ]; then
    echo -e "${RED}Error: project-init not found in workspace${NC}"
    exit 1
fi

# Create backup if it exists
if [ -d "$MAIN_REPO/project-init" ]; then
    echo -e "${YELLOW}Backing up existing project-init...${NC}"
    mv "$MAIN_REPO/project-init" "$MAIN_REPO/project-init.backup.$(date +%Y%m%d-%H%M%S)"
fi

# Copy project-init
cp -r "$WORKSPACE_DIR/project-init" "$MAIN_REPO/"
echo -e "${GREEN}✓ Copied project-init to $MAIN_REPO${NC}"

# 2. Copy install-mcps.sh to scripts directory
echo ""
echo -e "${GREEN}📦 Copying MCP installer...${NC}"

mkdir -p "$MAIN_REPO/scripts"

if [ -f "$WORKSPACE_DIR/install-mcps.sh" ]; then
    cp "$WORKSPACE_DIR/install-mcps.sh" "$MAIN_REPO/scripts/"
    chmod +x "$MAIN_REPO/scripts/install-mcps.sh"
    echo -e "${GREEN}✓ Copied install-mcps.sh to $MAIN_REPO/scripts${NC}"
else
    echo -e "${YELLOW}⚠️  install-mcps.sh not found, skipping${NC}"
fi

# 3. Create symlinks in /usr/local/bin
echo ""
echo -e "${GREEN}🔗 Creating symlinks in $INSTALL_DIR...${NC}"

COMMANDS=("keithstart" "keithsync")

for cmd in "${COMMANDS[@]}"; do
    SOURCE="$MAIN_REPO/project-init/scripts/$cmd.sh"
    TARGET="$INSTALL_DIR/$cmd"

    if [ ! -f "$SOURCE" ]; then
        echo -e "${YELLOW}⚠️  $SOURCE not found, skipping${NC}"
        continue
    fi

    # Make script executable
    chmod +x "$SOURCE"

    # Remove existing symlink/file
    if [ -L "$TARGET" ] || [ -f "$TARGET" ]; then
        echo -e "${YELLOW}Removing existing $cmd...${NC}"
        sudo rm -f "$TARGET"
    fi

    # Create symlink
    echo -e "${GREEN}Creating symlink: $TARGET -> $SOURCE${NC}"
    sudo ln -s "$SOURCE" "$TARGET"

    # Verify
    if [ -L "$TARGET" ]; then
        echo -e "${GREEN}✓ $cmd installed${NC}"
    else
        echo -e "${RED}✗ Failed to install $cmd${NC}"
    fi
done

# 4. Verify installation
echo ""
echo -e "${BLUE}🔍 Verifying installation...${NC}"

for cmd in "${COMMANDS[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        INSTALLED_PATH=$(which "$cmd")
        TARGET_PATH=$(readlink "$INSTALLED_PATH")
        echo -e "${GREEN}✓ $cmd is available${NC}"
        echo -e "  Location: $INSTALLED_PATH"
        echo -e "  Points to: $TARGET_PATH"
    else
        echo -e "${RED}✗ $cmd not found in PATH${NC}"
    fi
done

# 5. Success message
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Installation complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Files copied to: $MAIN_REPO"
echo "Symlinks created in: $INSTALL_DIR"
echo ""
echo "Try it out:"
echo "  keithstart --help"
echo ""
echo -e "${BLUE}📝 Next steps:${NC}"
echo "  1. Commit the new files to the main repo:"
echo "     cd $MAIN_REPO"
echo "     git add project-init/ scripts/"
echo "     git commit -m 'feat: add persistent keithstart installation'"
echo ""
echo "  2. The symlinks in $INSTALL_DIR now point to the main repo"
echo "     and will persist across workspace changes."
echo ""
