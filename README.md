# Claude Code Root Runner 🚀

A utility that allows running [Claude Code CLI](https://claude.ai/code) with root privileges by creating a temporary non-root user and bypassing permission restrictions.

## ✨ Features

- **🔒 Safe Root Bypass** - Creates temporary user instead of running as root
- **📁 Two Operating Modes** - Current directory or interactive workspace selection  
- **⚡ Full System Access** - Sudo privileges for system administration tasks
- **🔧 Easy Installation** - One-line installer script
- **🛡️ Security Focused** - Temporary user with controlled permissions

## 🎯 Use Cases

- **Docker Containers** running as root
- **Server Administration** scenarios
- **CI/CD Pipelines** requiring elevated permissions
- **Development Environments** in sandboxed systems

## 📦 Installation

### Quick Install (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main/install.sh | sudo bash
```

### Manual Installation
```bash
# Download scripts
sudo curl -fsSL https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main/claude-plus.sh -o /usr/local/bin/claude+
sudo curl -fsSL https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main/claude-workspace.sh -o /usr/local/bin/claudew

# Make executable
sudo chmod +x /usr/local/bin/claude+ /usr/local/bin/claudew
```

## 🚀 Usage

### Mode 1: Current Directory (`claude+`)
Works in your current directory - perfect for quick tasks and server administration.

```bash
# Basic usage
claude+ "check system status and running services"

# File operations in current directory
claude+ "create a backup script for important configs"

# System administration
claude+ "analyze nginx logs and suggest optimizations"
```

### Mode 2: Workspace Selection (`claudew`)
Prompts you to choose or create a working directory - ideal for projects.

```bash
# Interactive workspace selection
claudew "create a new web application"
# Will prompt: Enter workspace directory path: /home/projects/myapp

# Project development
claudew "build a REST API with authentication"
# Will prompt: Enter workspace directory path: /var/www/api
```

## 📋 Examples

<details>
<summary>🔧 System Administration</summary>

```bash
# Check what's using port 80
claude+ "find what process is using port 80 and show its configuration"

# Service management
claude+ "restart nginx and check if it started successfully"

# Log analysis
claude+ "analyze the last 50 lines of system logs for errors"

# Disk cleanup
claude+ "find large files over 100MB and suggest cleanup options"
```
</details>

<details>
<summary>💻 Development Projects</summary>

```bash
# Create new project
claudew "create a Python Flask API with user authentication"
# Choose: /home/projects/flask-api

# Full-stack development
claudew "build a React + Node.js todo application"
# Choose: /var/www/todo-app

# Infrastructure as code
claudew "create Docker setup for a microservices architecture"
# Choose: /home/docker-projects/microservices
```
</details>

<details>
<summary>🛠️ Configuration Management</summary>

```bash
# Nginx configuration
claude+ "create an optimized nginx config for a high-traffic website"

# SSL setup
claude+ "configure Let's Encrypt SSL certificate for my domain"

# Database administration
claude+ "optimize PostgreSQL configuration for better performance"
```
</details>

## ⚙️ How It Works

1. **Creates temporary user** `claude-temp` with sudo privileges
2. **Copies Claude configuration** from root to temporary user
3. **Transfers ownership** of working directory to temporary user
4. **Runs Claude CLI** with `--dangerously-skip-permissions` flag
5. **Restores ownership** back to root after completion

## ⚠️ Security Considerations

- **Trusted Environments Only** - Use only in sandboxed or trusted environments
- **Temporary User** - `claude-temp` user persists between runs for performance
- **Sudo Access** - Temporary user has full sudo privileges for system tasks
- **File Permissions** - Directory ownership is temporarily modified during execution

## 🔧 Requirements

- **Root/sudo access** for installation and execution
- **Claude Code CLI** installed (`npm install -g @anthropic-ai/claude-code`)
- **Linux/Unix system** with `useradd`, `sudo`, and `su` commands

## 🗑️ Uninstallation

```bash
# Remove scripts
sudo rm /usr/local/bin/claude+ /usr/local/bin/claudew

# Remove temporary user (optional)
sudo userdel -r claude-temp
sudo rm /etc/sudoers.d/claude-temp
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## ⭐ Support

If this tool helps you, please consider giving it a star on GitHub!

---

**Disclaimer**: This tool bypasses Claude Code CLI security restrictions. Use responsibly and only in environments where you understand the security implications.