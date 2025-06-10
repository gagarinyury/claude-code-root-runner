#!/bin/bash
# Claude Code Root Runner - Installation Script
# https://github.com/gagarinyury/claude-code-root-runner

set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main"
INSTALL_DIR="/usr/local/bin"

echo "🚀 Claude Code Root Runner Installer"
echo "===================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Error: This installer must be run as root"
    echo "   Try: sudo $0"
    exit 1
fi

echo "📥 Downloading claude+ (current directory mode)..."
curl -fsSL "$REPO_URL/claude-plus.sh" -o "$INSTALL_DIR/claude+"
chmod +x "$INSTALL_DIR/claude+"

echo "📥 Downloading claudew (workspace mode)..."
curl -fsSL "$REPO_URL/claude-workspace.sh" -o "$INSTALL_DIR/claudew"
chmod +x "$INSTALL_DIR/claudew"

echo ""
echo "✅ Installation completed successfully!"
echo ""
echo "Usage:"
echo "  claude+   - Run Claude in current directory"
echo "  claudew   - Run Claude with workspace selection"
echo ""
echo "Examples:"
echo "  claude+ \"create a hello world script\""
echo "  claudew \"build a new project\""
echo ""
echo "Repository: https://github.com/gagarinyury/claude-code-root-runner"