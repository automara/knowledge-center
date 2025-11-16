#!/bin/bash
# keithsync - Update existing project with latest templates
# Usage: keithsync [--dry-run] [--template=name] [--force]

set -e  # Exit on error

# Configuration
KNOWLEDGE_CENTER="$HOME/code/knowledge-center"
MANDATORY_DIR="$KNOWLEDGE_CENTER/.conductor/tianjin/project-init/mandatory"
VERSIONS_FILE="$KNOWLEDGE_CENTER/.conductor/tianjin/project-init/versions.json"

# Default values
DRY_RUN=false
FORCE=false
SPECIFIC_TEMPLATE=""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Parse arguments
for arg in "$@"; do
    case $arg in
        --dry-run)
            DRY_RUN=true
            ;;
        --force)
            FORCE=true
            ;;
        --template=*)
            SPECIFIC_TEMPLATE="${arg#*=}"
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: keithsync [--dry-run] [--template=name] [--force]"
            exit 1
            ;;
    esac
done

# Check if we're in a project directory
if [ ! -f ".keithstart-version" ]; then
    echo -e "${RED}Error: Not in a keithstart project directory${NC}"
    echo "Run this command from a project root created with keithstart"
    exit 1
fi

# Check if knowledge center exists
if [ ! -d "$KNOWLEDGE_CENTER" ]; then
    echo -e "${RED}Error: Knowledge center not found at $KNOWLEDGE_CENTER${NC}"
    exit 1
fi

PROJECT_VERSION=$(cat .keithstart-version)
CURRENT_DATE=$(date +%Y-%m-%d)

echo -e "${BLUE}🔄 Syncing templates for project$([ "$DRY_RUN" = true ] && echo " (dry run)")${NC}"
echo "   Project initialized: $PROJECT_VERSION"
echo "   Current date: $CURRENT_DATE"
echo ""

# Files to sync
FILES_TO_SYNC=(
    ".gitignore"
    ".claude/CLAUDE.md"
    ".github/PULL_REQUEST_TEMPLATE.md"
    ".github/ISSUE_TEMPLATE.md"
)

# Track updates
UPDATES_AVAILABLE=0
UPDATES_MADE=0

# Function to backup file
backup_file() {
    local file=$1
    local backup_dir=".backup/$(date +%Y%m%d)"

    if [ -f "$file" ]; then
        mkdir -p "$backup_dir/$(dirname "$file")"
        cp "$file" "$backup_dir/$file"
        echo -e "${GREEN}  ✓ Backed up to $backup_dir/$file${NC}"
    fi
}

# Function to sync file
sync_file() {
    local file=$1
    local source="$MANDATORY_DIR/$file"
    local dest="./$file"

    # Skip if specific template requested and this isn't it
    if [ -n "$SPECIFIC_TEMPLATE" ] && [ "$file" != "$SPECIFIC_TEMPLATE" ]; then
        return
    fi

    # Check if source exists
    if [ ! -f "$source" ]; then
        echo -e "${YELLOW}⚠️  Template not found: $file${NC}"
        return
    fi

    # Check if file exists in project
    if [ ! -f "$dest" ]; then
        echo -e "${BLUE}📄 $file: Not present in project, skipping${NC}"
        return
    fi

    # Compare files
    if diff -q "$source" "$dest" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ $file: Up to date${NC}"
        return
    fi

    UPDATES_AVAILABLE=$((UPDATES_AVAILABLE + 1))

    # Show diff
    echo -e "${YELLOW}📝 $file: Updates available${NC}"

    if [ "$DRY_RUN" = false ]; then
        echo "   Show diff? [y/N]"
        read -r show_diff

        if [[ "$show_diff" =~ ^[Yy]$ ]]; then
            diff -u "$dest" "$source" || true
            echo ""
        fi

        if [ "$FORCE" = true ]; then
            apply_update="y"
        else
            echo "   Apply update? [y/N]"
            read -r apply_update
        fi

        if [[ "$apply_update" =~ ^[Yy]$ ]]; then
            backup_file "$dest"
            cp "$source" "$dest"
            UPDATES_MADE=$((UPDATES_MADE + 1))
            echo -e "${GREEN}  ✓ Updated $file${NC}"
        else
            echo -e "${BLUE}  ⊘ Skipped $file${NC}"
        fi
    fi

    echo ""
}

# Sync each file
for file in "${FILES_TO_SYNC[@]}"; do
    sync_file "$file"
done

# Summary
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}Dry run complete${NC}"
    echo "Updates available: $UPDATES_AVAILABLE"
    echo ""
    echo "Run 'keithsync' without --dry-run to apply updates"
else
    echo -e "${GREEN}Sync complete${NC}"
    echo "Updates available: $UPDATES_AVAILABLE"
    echo "Updates applied: $UPDATES_MADE"

    # Update version file if updates were made
    if [ $UPDATES_MADE -gt 0 ]; then
        echo "$CURRENT_DATE" > .keithstart-version
        echo ""
        echo -e "${GREEN}✓ Updated .keithstart-version to $CURRENT_DATE${NC}"
    fi
fi
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
