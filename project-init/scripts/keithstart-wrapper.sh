# keithstart shell function wrapper
# Add this to your ~/.zshrc to enable auto-cd after project creation
#
# Usage: source this file or copy the function below to your ~/.zshrc

keithstart() {
    local script_path="$HOME/.local/bin/keithstart"

    # If keithstart is installed globally, use that path
    if command -v /usr/local/bin/keithstart >/dev/null 2>&1; then
        script_path="/usr/local/bin/keithstart"
    fi

    # Run the keithstart script and capture output
    local output
    output=$("$script_path" "$@" 2>&1)
    local exit_code=$?

    # Print the output
    echo "$output"

    # If successful, extract the project path and cd to it
    if [ $exit_code -eq 0 ]; then
        # Extract project path from output (looks for "Location: /path/to/project")
        local project_path=$(echo "$output" | grep -o "Location:.*" | sed 's/Location: //' | sed $'s/\033\[[0-9;]*m//g' | tr -d ' ')

        if [ -n "$project_path" ] && [ -d "$project_path" ]; then
            echo ""
            echo "🎯 Navigating to: $project_path"
            cd "$project_path"
        fi
    fi

    return $exit_code
}

# Also create keithsync wrapper for consistency
keithsync() {
    local script_path="$HOME/.local/bin/keithsync"

    # If keithsync is installed globally, use that path
    if command -v /usr/local/bin/keithsync >/dev/null 2>&1; then
        script_path="/usr/local/bin/keithsync"
    fi

    "$script_path" "$@"
}
