#!/bin/bash
# install.sh - Install keithstart and keithsync globally
# Usage: ./install.sh [--uninstall]

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALL_DIR="/usr/local/bin"
COMMANDS=("keithstart" "keithsync")

# Check for uninstall flag
if [ "$1" = "--uninstall" ]; then
    echo -e "${BLUE}🗑️  Uninstalling keithstart system...${NC}"
    echo ""

    for cmd in "${COMMANDS[@]}"; do
        if [ -L "$INSTALL_DIR/$cmd" ] || [ -f "$INSTALL_DIR/$cmd" ]; then
            echo -e "${YELLOW}Removing $cmd...${NC}"
            sudo rm -f "$INSTALL_DIR/$cmd"
            echo -e "${GREEN}✓ Removed $cmd${NC}"
        else
            echo -e "${BLUE}⊘ $cmd not installed${NC}"
        fi
    done

    echo ""
    echo -e "${GREEN}✅ Uninstall complete${NC}"
    exit 0
fi

echo -e "${BLUE}🚀 Installing keithstart system${NC}"
echo ""

# Check if /usr/local/bin exists
if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}Creating $INSTALL_DIR...${NC}"
    sudo mkdir -p "$INSTALL_DIR"
fi

# Check if scripts exist
for cmd in "${COMMANDS[@]}"; do
    if [ ! -f "$SCRIPT_DIR/$cmd.sh" ]; then
        echo -e "${RED}Error: $cmd.sh not found in $SCRIPT_DIR${NC}"
        exit 1
    fi
done

# Make scripts executable
echo -e "${GREEN}Making scripts executable...${NC}"
chmod +x "$SCRIPT_DIR"/*.sh

# Install each command
echo ""
for cmd in "${COMMANDS[@]}"; do
    SOURCE="$SCRIPT_DIR/$cmd.sh"
    TARGET="$INSTALL_DIR/$cmd"

    # Remove existing installation
    if [ -L "$TARGET" ] || [ -f "$TARGET" ]; then
        echo -e "${YELLOW}Removing existing $cmd...${NC}"
        sudo rm -f "$TARGET"
    fi

    # Create symlink
    echo -e "${GREEN}Installing $cmd...${NC}"
    sudo ln -s "$SOURCE" "$TARGET"

    # Verify installation
    if [ -L "$TARGET" ]; then
        echo -e "${GREEN}✓ $cmd installed at $TARGET${NC}"
    else
        echo -e "${RED}✗ Failed to install $cmd${NC}"
        exit 1
    fi
done

# Verify commands are in PATH
echo ""
echo -e "${BLUE}Verifying installation...${NC}"
for cmd in "${COMMANDS[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ $cmd is in PATH${NC}"
    else
        echo -e "${YELLOW}⚠️  $cmd not found in PATH${NC}"
        echo "   You may need to restart your terminal or add $INSTALL_DIR to your PATH"
    fi
done

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Installation complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Installed commands:"
for cmd in "${COMMANDS[@]}"; do
    echo "  • $cmd"
done
echo ""
echo "Try it out:"
echo "  keithstart --help"
echo "  keithstart my-project"
echo ""
echo "To uninstall:"
echo "  ./install.sh --uninstall"
echo ""
