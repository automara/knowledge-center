#!/bin/bash
# Standalone MCP installer wrapper
# Can be run independently from keithstart

# Find the knowledge center
KNOWLEDGE_CENTER="$HOME/code/knowledge-center"

if [ ! -d "$KNOWLEDGE_CENTER" ]; then
    echo "Error: Knowledge center not found at $KNOWLEDGE_CENTER"
    exit 1
fi

# Find and run the MCP installer
MCP_INSTALLER="$KNOWLEDGE_CENTER/.conductor/tianjin-v1/install-mcps.sh"

if [ ! -f "$MCP_INSTALLER" ]; then
    echo "Error: MCP installer not found at $MCP_INSTALLER"
    exit 1
fi

echo "Running MCP installer..."
echo ""

bash "$MCP_INSTALLER"

exit $?
