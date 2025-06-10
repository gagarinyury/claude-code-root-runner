# Claude Code Root Runner 🔥

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)

A utility script that allows running Claude Code CLI with `--dangerously-skip-permissions` flag when you're logged in as root.

## 🎯 Problem

Claude Code CLI blocks the `--dangerously-skip-permissions` flag when running as root for security reasons. This creates issues in:

- **Docker containers** running as root
- **Server administration** scenarios
- **CI/CD pipelines** with root privileges
- **Automated scripts** requiring elevated permissions

## 💡 Solution

This script creates a temporary non-root user and runs Claude Code CLI from that user context, bypassing the root restriction while maintaining full functionality and security.

## ✨ Features

- ✅ **Automatic temporary user creation** - Creates `claude-temp` user if needed
- ✅ **Configuration preservation** - Copies Claude Code config from root user
- ✅ **Environment variable handling** - Preserves API keys and settings
- ✅ **Working directory maintenance** - Runs commands in current directory
- ✅ **Comprehensive error handling** - Clear logging and error messages
- ✅ **Cleanup options** - Optional temporary user removal
- ✅ **Colorized output** - Easy-to-read status messages

## 🚀 Quick Start

### One-line installation:
```bash
curl -sSL https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main/install.sh | bash
```

### Manual installation:
```bash
wget https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main/claude-root.sh
chmod +x claude-root.sh
sudo mv claude-root.sh /usr/local/bin/claude-root
```

## 📖 Usage

### Basic usage:
```bash
sudo claude-root "write a deployment script"
sudo claude-root "fix all TypeScript errors in this project"
sudo claude-root "create a monitoring dashboard"
```

### With options:
```bash
# Clean up temporary user after execution
sudo claude-root -c "generate a README for this project"

# Use custom username
sudo claude-root -u my-claude-user "write tests for this module"

# Show help
claude-root --help
```

### Advanced examples:
```bash
# Generate Infrastructure as Code
sudo claude-root "create Terraform configuration for AWS ECS cluster"

# Fix security issues
sudo claude-root "scan and fix security vulnerabilities in package.json"

# Automated deployment
sudo claude-root "write a complete CI/CD pipeline for this Node.js app"
```

## 🛠️ Command Line Options

| Option | Description |
|--------|-------------|
| `-h, --help` | Show help message and exit |
| `-v, --version` | Show version information |
| `-c, --cleanup` | Remove temporary user after execution |
| `-u, --user USER` | Use custom username (default: claude-temp) |

## 🔧 How It Works

1. **Root Check** - Verifies script is running with root privileges
2. **User Creation** - Creates temporary user `claude-temp` if it doesn't exist
3. **Config Copy** - Copies Claude configuration and API keys from root
4. **Environment Setup** - Preserves necessary environment variables
5. **Execution** - Runs Claude CLI as temporary user with `--dangerously-skip-permissions`
6. **Cleanup** - Optionally removes temporary user (with `-c` flag)

## 📋 Prerequisites

- **Linux/Unix system** with bash
- **Root privileges** (sudo access)
- **Claude Code CLI installed**: `npm install -g @anthropic-ai/claude-code`
- **Node.js and npm** for Claude Code CLI

## ⚙️ Installation Methods

### Method 1: Automated installer
```bash
curl -sSL https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main/install.sh | bash
```

### Method 2: Manual download
```bash
# Download the script
wget https://raw.githubusercontent.com/gagarinyury/claude-code-root-runner/main/claude-root.sh

# Make executable
chmod +x claude-root.sh

# Install globally (optional)
sudo mv claude-root.sh /usr/local/bin/claude-root
```

### Method 3: Git clone
```bash
git clone https://github.com/gagarinyury/claude-code-root-runner.git
cd claude-code-root-runner
chmod +x claude-root.sh
sudo ln -s $(pwd)/claude-root.sh /usr/local/bin/claude-root
```

## 🐳 Docker Usage

Perfect for Docker containers running as root:

```dockerfile
FROM node:18
RUN npm install -g @anthropic-ai/claude-code
COPY claude-root.sh /usr/local/bin/claude-root
RUN chmod +x /usr/local/bin/claude-root
CMD ["claude-root", "help me with this codebase"]
```

## 🔒 Security Considerations

⚠️ **Important Security Warning**

This tool bypasses Claude Code CLI's built-in root restrictions. While it maintains security by running Claude Code as a non-root user, you should:

- ✅ Use only in **trusted environments**
- ✅ Understand the **risks** of `--dangerously-skip-permissions`
- ✅ Review Claude Code's **file access** in your environment
- ✅ Consider using **cleanup mode** (`-c`) for temporary execution
- ❌ Don't use in **production** without proper security review

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Changelog

### v1.0.0
- Initial release
- Basic temporary user creation and Claude CLI execution
- Configuration copying from root user
- Command-line options support
- Comprehensive error handling

## 🐛 Troubleshooting

### Claude Code CLI not found
```bash
# Install Claude Code CLI
npm install -g @anthropic-ai/claude-code

# Check installation
which claude
```

### Permission denied errors
```bash
# Ensure script is executable
chmod +x claude-root.sh

# Run with sudo
sudo ./claude-root.sh "your command"
```

### Temporary user creation fails
```bash
# Check if user already exists
id claude-temp

# Manual user creation
sudo useradd -m claude-temp
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🌟 Show Your Support

If this project helped you, please consider giving it a ⭐ on GitHub!

## 📞 Support

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/gagarinyury/claude-code-root-runner/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/gagarinyury/claude-code-root-runner/discussions)
- 📧 **Questions**: Open an issue with the `question` label

---

**Made with ❤️ for the Claude Code community**