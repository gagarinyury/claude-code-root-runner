#!/bin/bash
# Simple installer for Claude Code Root Runner

SCRIPT_URL="https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main/claude-root.sh"
INSTALL_PATH="/usr/local/bin/claude-root"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This installer must be run as root"
    echo "Try: sudo $0"
    exit 1
fi

echo "Installing Claude Code Root Runner..."

# Download script
if command -v curl &> /dev/null; then
    curl -sSL "$SCRIPT_URL" -o "$INSTALL_PATH"
elif command -v wget &> /dev/null; then
    wget -q "$SCRIPT_URL" -O "$INSTALL_PATH"
else
    echo "Error: Neither curl nor wget available"
    exit 1
fi

# Make executable
chmod +x "$INSTALL_PATH"

echo "Installation complete!"
echo "Usage: sudo claude-root \"your command here\""