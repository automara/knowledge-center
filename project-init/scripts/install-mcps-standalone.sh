#!/bin/bash
# Standalone MCP installer wrapper
# Can be run independently from keithstart

# Find the knowledge center
KNOWLEDGE_CENTER="$HOME/code/knowledge-center"

if [ ! -d "$KNOWLEDGE_CENTER" ]; then
    echo "Error: Knowledge center not found at $KNOWLEDGE_CENTER"
    exit 1
fi

# Find the MCP installer - try scripts directory first (after installation), then conductor workspaces
MCP_INSTALLER=""

if [ -f "$KNOWLEDGE_CENTER/scripts/install-mcps.sh" ]; then
    MCP_INSTALLER="$KNOWLEDGE_CENTER/scripts/install-mcps.sh"
else
    # Fall back to searching conductor workspaces
    for workspace in "$KNOWLEDGE_CENTER"/.conductor/*/install-mcps.sh; do
        if [ -f "$workspace" ]; then
            MCP_INSTALLER="$workspace"
            break
        fi
    done
fi

if [ -z "$MCP_INSTALLER" ] || [ ! -f "$MCP_INSTALLER" ]; then
    echo "Error: MCP installer not found"
    echo "Searched:"
    echo "  - $KNOWLEDGE_CENTER/scripts/install-mcps.sh"
    echo "  - $KNOWLEDGE_CENTER/.conductor/*/install-mcps.sh"
    exit 1
fi

echo "Running MCP installer from: $MCP_INSTALLER"
echo ""

bash "$MCP_INSTALLER"

exit $?
