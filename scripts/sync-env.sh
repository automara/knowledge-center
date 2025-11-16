#!/bin/bash

# sync-env.sh
# Syncs environment variable templates to all Conductor workspaces
# Usage: ./scripts/sync-env.sh [environment]
#   environment: development (default), staging, or production

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_ROOT="${CONDUCTOR_ROOT_PATH:-.}"
CONDUCTOR_DIR="${REPO_ROOT}/.conductor"
DEFAULT_ENV="${1:-development}"

# Validate environment argument
if [[ ! "$DEFAULT_ENV" =~ ^(development|staging|production)$ ]]; then
    echo -e "${RED}Error: Invalid environment '${DEFAULT_ENV}'${NC}"
    echo "Usage: $0 [development|staging|production]"
    exit 1
fi

SOURCE_ENV="${REPO_ROOT}/.env.${DEFAULT_ENV}"

# Check if source environment file exists
if [[ ! -f "$SOURCE_ENV" ]]; then
    echo -e "${RED}Error: Source file not found: ${SOURCE_ENV}${NC}"
    echo "Available environment files:"
    ls -1 "${REPO_ROOT}/.env."* 2>/dev/null || echo "  (none found)"
    exit 1
fi

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Conductor Environment Sync Tool             ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Source:${NC} ${SOURCE_ENV}"
echo -e "${YELLOW}Target:${NC} All workspaces in ${CONDUCTOR_DIR}"
echo ""

# Check if .conductor directory exists
if [[ ! -d "$CONDUCTOR_DIR" ]]; then
    echo -e "${RED}Error: No .conductor directory found at ${CONDUCTOR_DIR}${NC}"
    echo "Are you running this from the repository root?"
    exit 1
fi

# Find all workspace directories
WORKSPACES=($(find "$CONDUCTOR_DIR" -mindepth 1 -maxdepth 1 -type d -not -name ".*"))

if [[ ${#WORKSPACES[@]} -eq 0 ]]; then
    echo -e "${YELLOW}No workspaces found in ${CONDUCTOR_DIR}${NC}"
    echo "Create a workspace first, then run this script."
    exit 0
fi

echo -e "${GREEN}Found ${#WORKSPACES[@]} workspace(s):${NC}"
for workspace in "${WORKSPACES[@]}"; do
    echo "  - $(basename "$workspace")"
done
echo ""

# Ask for confirmation
read -p "Sync .env.${DEFAULT_ENV} to all workspaces? This will OVERWRITE existing .env files. (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Sync cancelled.${NC}"
    exit 0
fi

# Sync to each workspace
SUCCESS_COUNT=0
FAIL_COUNT=0

echo ""
echo -e "${BLUE}Syncing...${NC}"
echo ""

for workspace in "${WORKSPACES[@]}"; do
    WORKSPACE_NAME=$(basename "$workspace")
    TARGET_ENV="${workspace}/.env"

    echo -e "${YELLOW}Processing:${NC} ${WORKSPACE_NAME}"

    # Create backup if .env already exists
    if [[ -f "$TARGET_ENV" ]]; then
        BACKUP="${TARGET_ENV}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$TARGET_ENV" "$BACKUP"
        echo -e "  ${GREEN}✓${NC} Backed up existing .env to $(basename "$BACKUP")"
    fi

    # Copy the environment file
    if cp "$SOURCE_ENV" "$TARGET_ENV"; then
        echo -e "  ${GREEN}✓${NC} Synced .env.${DEFAULT_ENV} -> .env"
        ((SUCCESS_COUNT++))
    else
        echo -e "  ${RED}✗${NC} Failed to sync"
        ((FAIL_COUNT++))
    fi

    echo ""
done

# Summary
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Sync complete!${NC}"
echo ""
echo -e "  ${GREEN}✓${NC} Success: ${SUCCESS_COUNT}"
if [[ $FAIL_COUNT -gt 0 ]]; then
    echo -e "  ${RED}✗${NC} Failed:  ${FAIL_COUNT}"
fi
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review the synced .env files in each workspace"
echo "  2. Fill in any missing values specific to each workspace"
echo "  3. Update templates/env-template.md if you added new variables"
echo ""

# Remind about Railway
if [[ "$DEFAULT_ENV" == "production" ]] || [[ "$DEFAULT_ENV" == "staging" ]]; then
    echo -e "${YELLOW}⚠️  Don't forget to update Railway!${NC}"
    echo "  - Go to Railway dashboard"
    echo "  - Update variables in the ${DEFAULT_ENV} environment"
    echo "  - Verify all secrets are set correctly"
    echo ""
fi

exit 0
