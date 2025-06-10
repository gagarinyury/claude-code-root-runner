#!/bin/bash
# Claude Code Root Runner
# Allows running Claude Code CLI with --dangerously-skip-permissions as root
# by creating a temporary non-root user and switching to it
# https://github.com/gagarinyury/claude-code-root-runner

# Create temporary user if it doesn't exist
if ! id claude-temp &>/dev/null; then
    useradd -m -s /bin/bash claude-temp
fi

# Copy Claude configuration if it exists
if [ -d "$HOME/.config/claude" ]; then
    mkdir -p /home/claude-temp/.config
    cp -r "$HOME/.config/claude" /home/claude-temp/.config/
    chown -R claude-temp:claude-temp /home/claude-temp/.config
fi

# Find Claude CLI path
CLAUDE_PATH=$(which claude)
if [ -z "$CLAUDE_PATH" ]; then
    CLAUDE_PATH="/root/.npm-global/bin/claude"
fi

# Run Claude as non-root user with --dangerously-skip-permissions
su - claude-temp -c "PATH=/root/.npm-global/bin:$PATH $CLAUDE_PATH --dangerously-skip-permissions $*"