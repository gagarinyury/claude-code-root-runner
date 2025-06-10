#!/bin/bash
# Claude Root Runner - Installation Script
# https://github.com/gagarinyury/claude-code-root-runner

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_URL="https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main"
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="claude-root"

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_dependencies() {
    log_info "Checking dependencies..."
    
    # Check if running as root
    if [[ $EUID -ne 0 ]]; then
        log_error "This installer must be run as root"
        log_error "Try: sudo $0"
        exit 1
    fi
    
    # Check for required commands
    local missing_deps=()
    
    for cmd in curl wget chmod; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing required dependencies: ${missing_deps[*]}"
        log_error "Please install them and try again"
        exit 1
    fi
    
    log_success "All dependencies found"
}

download_script() {
    log_info "Downloading Claude Root Runner..."
    
    local temp_file
    temp_file=$(mktemp)
    
    # Try curl first, then wget
    if command -v curl &> /dev/null; then
        if curl -sSL "$REPO_URL/claude-root.sh" -o "$temp_file" >/dev/null 2>&1; then
            log_success "Downloaded using curl"
        else
            log_error "Failed to download with curl"
            rm -f "$temp_file"
            exit 1
        fi
    elif command -v wget &> /dev/null; then
        if wget -q "$REPO_URL/claude-root.sh" -O "$temp_file" >/dev/null 2>&1; then
            log_success "Downloaded using wget"
        else
            log_error "Failed to download with wget"
            rm -f "$temp_file"
            exit 1
        fi
    else
        log_error "Neither curl nor wget available"
        exit 1
    fi
    
    # Verify file was downloaded
    if [ ! -f "$temp_file" ] || [ ! -s "$temp_file" ]; then
        log_error "Downloaded file is empty or missing"
        rm -f "$temp_file"
        exit 1
    fi
    
    # Return only the file path, no other output
    printf "%s" "$temp_file"
}

install_script() {
    local temp_file="$1"
    local install_path="$INSTALL_DIR/$SCRIPT_NAME"
    
    log_info "Installing to $install_path..."
    
    # Create install directory if it doesn't exist
    mkdir -p "$INSTALL_DIR"
    
    # Copy script to install location
    cp "$temp_file" "$install_path"
    
    # Make executable
    chmod +x "$install_path"
    
    # Verify installation
    if [ -x "$install_path" ]; then
        log_success "Claude Root Runner installed successfully!"
    else
        log_error "Installation failed - script not executable"
        exit 1
    fi
    
    # Clean up temp file
    rm -f "$temp_file"
}

check_claude_cli() {
    log_info "Checking for Claude CLI..."
    
    if command -v claude &> /dev/null; then
        local claude_version
        claude_version=$(claude --version 2>/dev/null || echo "unknown")
        log_success "Claude CLI found (version: $claude_version)"
    else
        log_warning "Claude CLI not found"
        log_warning "Install it with: npm install -g @anthropic-ai/claude-code"
        echo
    fi
}

show_usage() {
    cat << EOF

${GREEN}✅ Installation complete!${NC}

${YELLOW}Usage:${NC}
  $SCRIPT_NAME "write a hello world script"
  $SCRIPT_NAME --help
  $SCRIPT_NAME -c "generate tests for this project"

${YELLOW}Examples:${NC}
  # Basic usage
  sudo $SCRIPT_NAME "fix all linting errors"
  
  # With cleanup (removes temporary user after execution)
  sudo $SCRIPT_NAME -c "create a deployment script"
  
  # Custom temporary username
  sudo $SCRIPT_NAME -u my-user "write documentation"

${YELLOW}Next steps:${NC}
  1. Make sure Claude CLI is installed: npm install -g @anthropic-ai/claude-code
  2. Configure your Claude API key
  3. Run: sudo $SCRIPT_NAME --help

${BLUE}Repository:${NC} https://github.com/gagarinyury/claude-code-root-runner
${BLUE}Documentation:${NC} See README.md for detailed usage instructions

EOF
}

main() {
    echo -e "${BLUE}Claude Root Runner Installer${NC}"
    echo "=============================="
    echo
    
    check_dependencies
    
    local temp_file
    temp_file=$(download_script 2>&1 | grep -v "$(printf '\033')" | tail -1)
    
    # If temp_file is empty or contains color codes, try alternative approach
    if [ -z "$temp_file" ] || [[ "$temp_file" == *"$(printf '\033')"* ]]; then
        log_warning "Fallback: downloading directly..."
        temp_file=$(mktemp)
        if command -v curl &> /dev/null; then
            curl -sSL "$REPO_URL/claude-root.sh" -o "$temp_file" || {
                log_error "Direct download failed"
                exit 1
            }
        else
            wget -q "$REPO_URL/claude-root.sh" -O "$temp_file" || {
                log_error "Direct download failed" 
                exit 1
            }
        fi
        log_success "Direct download completed"
    fi
    
    install_script "$temp_file"
    check_claude_cli
    show_usage
}

main "$@"