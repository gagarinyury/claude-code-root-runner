#!/bin/bash
# claude-root.sh - Claude Code CLI Root Runner
# Allows running Claude Code CLI with --dangerously-skip-permissions as root
# Version: 1.0.0
# Author: Your GitHub Username
# Repository: https://github.com/gagarinyury/claude-code-root-runner

set -euo pipefail

SCRIPT_NAME="Claude Code Root Runner"
VERSION="1.0.2"
TEMP_USER="claude-temp"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root"
        log_error "Try: sudo $0 $*"
        exit 1
    fi
}

create_temp_user() {
    if ! id "$TEMP_USER" &>/dev/null; then
        log_info "Creating temporary user: $TEMP_USER"
        useradd -m -s /bin/bash "$TEMP_USER" 2>/dev/null || {
            log_warning "User creation failed, trying with different options..."
            useradd -m "$TEMP_USER" 2>/dev/null || {
                log_error "Failed to create user $TEMP_USER"
                exit 1
            }
        }
        log_success "User $TEMP_USER created"
    else
        log_info "User $TEMP_USER already exists"
    fi
}

copy_claude_config() {
    local config_copied=false
    
    # Copy Claude Code configuration
    if [ -d "$HOME/.config/claude" ]; then
        log_info "Copying Claude Code configuration..."
        mkdir -p "/home/$TEMP_USER/.config"
        cp -r "$HOME/.config/claude" "/home/$TEMP_USER/.config/"
        chown -R "$TEMP_USER:$TEMP_USER" "/home/$TEMP_USER/.config"
        config_copied=true
    fi
    
    # Copy API keys from environment or other locations
    if [ -f "$HOME/.claude_api_key" ]; then
        cp "$HOME/.claude_api_key" "/home/$TEMP_USER/"
        chown "$TEMP_USER:$TEMP_USER" "/home/$TEMP_USER/.claude_api_key"
        config_copied=true
    fi
    
    # Copy .bashrc and .profile for environment variables
    for file in ".bashrc" ".profile" ".bash_profile"; do
        if [ -f "$HOME/$file" ]; then
            cp "$HOME/$file" "/home/$TEMP_USER/"
            chown "$TEMP_USER:$TEMP_USER" "/home/$TEMP_USER/$file"
        fi
    done
    
    if [ "$config_copied" = true ]; then
        log_success "Configuration copied"
    else
        log_warning "No Claude Code configuration found to copy"
    fi
}

find_claude_path() {
    local claude_path
    claude_path=$(which claude 2>/dev/null) || claude_path=""
    
    if [ -z "$claude_path" ]; then
        # Try common locations
        local common_paths=(
            "/root/.npm-global/bin/claude"
            "/usr/local/bin/claude"
            "/usr/bin/claude"
            "$HOME/.npm-global/bin/claude"
            "$(npm config get prefix 2>/dev/null)/bin/claude"
        )
        
        for path in "${common_paths[@]}"; do
            if [ -x "$path" ]; then
                claude_path="$path"
                break
            fi
        done
    fi
    
    if [ -z "$claude_path" ]; then
        log_error "Claude Code CLI not found. Please install it first:"
        log_error "  npm install -g @anthropic-ai/claude-code"
        log_error ""
        log_error "Or check if it's installed in a different location:"
        log_error "  which claude"
        exit 1
    fi
    
    if [ ! -x "$claude_path" ]; then
        log_error "Claude Code CLI found at $claude_path but is not executable"
        exit 1
    fi
    
    echo "$claude_path"
}

run_claude() {
    local claude_path="$1"
    shift
    
    log_info "Running Claude Code CLI as user: $TEMP_USER"
    log_info "Command: claude --dangerously-skip-permissions $*"
    
    # Build comprehensive PATH
    local npm_global_root
    npm_global_root=$(npm config get prefix 2>/dev/null || echo "/usr/local")
    
    local full_path="/root/.npm-global/bin:$npm_global_root/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
    
    # Copy current environment variables that might be needed
    local env_vars=""
    for var in ANTHROPIC_API_KEY CLAUDE_API_KEY NODE_PATH; do
        if [ -n "${!var:-}" ]; then
            env_vars="$env_vars $var='${!var}'"
        fi
    done
    
    # Create a working directory that the user can access
    local work_dir="/home/$TEMP_USER/work"
    mkdir -p "$work_dir"
    chown "$TEMP_USER:$TEMP_USER" "$work_dir"
    
    # Copy current directory contents if it's accessible
    if [ -r "$PWD" ] && [ "$PWD" != "/root" ]; then
        log_info "Copying current directory to working space..."
        cp -r "$PWD"/* "$work_dir/" 2>/dev/null || true
        chown -R "$TEMP_USER:$TEMP_USER" "$work_dir"
    fi
    
    # Run Claude with environment preservation
    su - "$TEMP_USER" -c "
        export PATH='$full_path'
        $env_vars
        cd '$work_dir'
        '$claude_path' --dangerously-skip-permissions $*
    "
    
    # Copy results back if working in /root
    if [ "$PWD" = "/root" ] && [ -d "$work_dir" ]; then
        log_info "Copying results back to original directory..."
        cp -r "$work_dir"/* "$PWD/" 2>/dev/null || true
    fi
}

cleanup() {
    if [ "${CLEANUP_ON_EXIT:-}" = "true" ] && id "$TEMP_USER" &>/dev/null; then
        log_info "Cleaning up temporary user..."
        userdel -r "$TEMP_USER" 2>/dev/null || true
        log_success "Cleanup completed"
    fi
}

show_help() {
    cat << EOF
$SCRIPT_NAME v$VERSION

DESCRIPTION:
    Runs Claude Code CLI with --dangerously-skip-permissions flag as root
    by creating a temporary user and switching to it.

USAGE:
    $0 [OPTIONS] [claude-arguments...]

OPTIONS:
    -h, --help              Show this help message
    -v, --version           Show version information
    -c, --cleanup           Remove temporary user after execution
    -u, --user USER         Use custom username (default: $TEMP_USER)

EXAMPLES:
    $0 "write a hello world script"
    $0 --help
    $0 "fix all linting errors in this project"
    $0 -c "generate a README for this project"

NOTES:
    - This script must be run as root or with sudo
    - Creates temporary user '$TEMP_USER' if it doesn't exist
    - Copies Claude Code configuration from root to temporary user
    - Automatically adds --dangerously-skip-permissions flag
    - Working directory is preserved

SECURITY WARNING:
    This tool bypasses Claude Code CLI security restrictions.
    Use only in trusted environments where you understand the risks.

REPOSITORY:
    https://github.com/gagarinyury/claude-code-root-runner

EOF
}

show_version() {
    echo "$SCRIPT_NAME v$VERSION"
}

main() {
    # Parse options
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -v|--version)
                show_version
                exit 0
                ;;
            -c|--cleanup)
                CLEANUP_ON_EXIT="true"
                shift
                ;;
            -u|--user)
                TEMP_USER="$2"
                shift 2
                ;;
            --)
                shift
                break
                ;;
            -*)
                log_error "Unknown option: $1"
                log_error "Use --help for usage information"
                exit 1
                ;;
            *)
                break
                ;;
        esac
    done
    
    # Set up cleanup trap
    trap cleanup EXIT
    
    log_info "Starting $SCRIPT_NAME v$VERSION"
    
    check_root
    create_temp_user
    copy_claude_config
    
    local claude_path
    claude_path=$(find_claude_path)
    log_success "Found Claude Code CLI at: $claude_path"
    
    run_claude "$claude_path" "$@"
}

# Only run main if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi