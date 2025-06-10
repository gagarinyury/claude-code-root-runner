#!/bin/bash
# Claude Code Root Runner - Current Directory Mode
# Allows running Claude Code CLI as root in current directory
# Repository: https://github.com/gagarinyury/claude-code-root-runner

set -euo pipefail

TEMP_USER="claude-temp"

# Create temporary user if it doesn't exist
if ! id "$TEMP_USER" &>/dev/null; then
    useradd -m -s /bin/bash "$TEMP_USER"
fi

# Ensure user has sudo privileges
if ! groups "$TEMP_USER" | grep -q sudo; then
    usermod -aG sudo "$TEMP_USER"
fi

# Allow passwordless sudo
if [ ! -f "/etc/sudoers.d/$TEMP_USER" ]; then
    echo "$TEMP_USER ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$TEMP_USER"
    chmod 440 "/etc/sudoers.d/$TEMP_USER"
fi

# Copy Claude configuration if it exists
if [ -d "$HOME/.config/claude" ]; then
    mkdir -p "/home/$TEMP_USER/.config"
    cp -r "$HOME/.config/claude" "/home/$TEMP_USER/.config/"
    chown -R "$TEMP_USER:$TEMP_USER" "/home/$TEMP_USER/.config"
fi

# Find Claude CLI path
CLAUDE_PATH=$(which claude 2>/dev/null)
if [ -z "$CLAUDE_PATH" ]; then
    CLAUDE_PATH="/root/.npm-global/bin/claude"
fi

# Verify Claude CLI exists
if [ ! -x "$CLAUDE_PATH" ]; then
    echo "Error: Claude Code CLI not found at $CLAUDE_PATH"
    echo "Please install it with: npm install -g @anthropic-ai/claude-code"
    exit 1
fi

# For /root directory, work in a safe subdirectory
if [ "$PWD" = "/root" ]; then
    WORK_DIR="/root/claude-workspace"
    mkdir -p "$WORK_DIR"
    chown "$TEMP_USER:$TEMP_USER" "$WORK_DIR"
    TARGET_DIR="$WORK_DIR"
    echo "Working in safe directory: $WORK_DIR"
else
    # For other directories, use as-is
    chown -R "$TEMP_USER:$TEMP_USER" "$PWD" 2>/dev/null || true
    TARGET_DIR="$PWD"
fi

# Run Claude as non-root user in target directory
su "$TEMP_USER" -c "cd '$TARGET_DIR' && PATH=/root/.npm-global/bin:$PATH '$CLAUDE_PATH' --dangerously-skip-permissions $*"

# Restore ownership (but not for /root itself)
if [ "$PWD" != "/root" ]; then
    chown -R root:root "$PWD" 2>/dev/null || true
fi