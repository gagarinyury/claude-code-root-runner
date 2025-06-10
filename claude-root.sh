#!/bin/bash
# Claude Code Root Runner - Simple version that works

TEMP_USER="claude-temp"

# Create temporary user if doesn't exist
if ! id "$TEMP_USER" &>/dev/null; then
    useradd -m -s /bin/bash "$TEMP_USER"
fi

# Copy Claude configuration if exists
if [ -d "$HOME/.config/claude" ]; then
    mkdir -p "/home/$TEMP_USER/.config"
    cp -r "$HOME/.config/claude" "/home/$TEMP_USER/.config/"
    chown -R "$TEMP_USER:$TEMP_USER" "/home/$TEMP_USER/.config"
fi

# Find claude path
CLAUDE_PATH=$(which claude)
if [ -z "$CLAUDE_PATH" ]; then
    CLAUDE_PATH="/root/.npm-global/bin/claude"
fi

# Run Claude from current directory as temporary user with full path
su - "$TEMP_USER" -c "PATH=/root/.npm-global/bin:\$PATH cd '$PWD' && '$CLAUDE_PATH' --dangerously-skip-permissions $*"