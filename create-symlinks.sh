#!/bin/bash
# create-symlinks.sh - Create symlinks for keithstart and keithsync
# Run this after the files have been copied to the main repo

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

MAIN_REPO="/Users/keitharmstrong/code/knowledge-center"
INSTALL_DIR="/usr/local/bin"
COMMANDS=("keithstart" "keithsync")

echo -e "${BLUE}Creating symlinks for keithstart system...${NC}"
echo ""

for cmd in "${COMMANDS[@]}"; do
    SOURCE="$MAIN_REPO/project-init/scripts/$cmd.sh"
    TARGET="$INSTALL_DIR/$cmd"

    if [ ! -f "$SOURCE" ]; then
        echo -e "${YELLOW}⚠️  $SOURCE not found, skipping${NC}"
        continue
    fi

    # Make executable
    chmod +x "$SOURCE"

    # Remove existing
    if [ -L "$TARGET" ] || [ -f "$TARGET" ]; then
        echo -e "${YELLOW}Removing existing $cmd...${NC}"
        sudo rm -f "$TARGET"
    fi

    # Create symlink
    echo -e "${GREEN}Creating: $TARGET -> $SOURCE${NC}"
    sudo ln -s "$SOURCE" "$TARGET"

    if [ -L "$TARGET" ]; then
        echo -e "${GREEN}✓ $cmd installed${NC}"
    fi
done

echo ""
echo -e "${GREEN}✅ Done! Verifying...${NC}"
echo ""

for cmd in "${COMMANDS[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ $cmd is available${NC}"
        readlink "$(which $cmd)"
    fi
done

echo ""
echo "Try: keithstart --help"
