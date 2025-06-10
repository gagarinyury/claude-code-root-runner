# Claude Root Runner - Usage Examples

This document provides comprehensive examples of how to use Claude Root Runner in various scenarios.

## 🚀 Basic Examples

### Simple Code Generation
```bash
sudo claude-root "write a hello world function in Python"
sudo claude-root "create a REST API endpoint for user authentication"
sudo claude-root "generate a Dockerfile for a Node.js application"
```

### Code Analysis and Fixes
```bash
sudo claude-root "analyze this codebase for security vulnerabilities"
sudo claude-root "fix all ESLint errors in this project"
sudo claude-root "optimize this SQL query for better performance"
```

### Documentation Generation
```bash
sudo claude-root "create comprehensive API documentation for this project"
sudo claude-root "write unit tests for all functions in this module"
sudo claude-root "generate a detailed README.md with installation instructions"
```

## 🐳 Docker and Container Scenarios

### Dockerfile Generation
```bash
sudo claude-root "create a multi-stage Dockerfile for this React application"
sudo claude-root "write docker-compose.yml for microservices architecture"
sudo claude-root "optimize Docker image size for production deployment"
```

### Kubernetes Manifests
```bash
sudo claude-root "generate Kubernetes deployment manifests for this app"
sudo claude-root "create Helm charts for this microservice"
sudo claude-root "write service mesh configuration for Istio"
```

## ☁️ Infrastructure as Code

### Terraform
```bash
sudo claude-root "create Terraform configuration for AWS ECS cluster"
sudo claude-root "write Terraform modules for multi-environment setup"
sudo claude-root "generate AWS Lambda infrastructure with API Gateway"
```

### CloudFormation
```bash
sudo claude-root "create CloudFormation template for VPC with subnets"
sudo claude-root "write CloudFormation for RDS with backup policies"
```

### Ansible Playbooks
```bash
sudo claude-root "create Ansible playbook for server hardening"
sudo claude-root "write Ansible roles for LAMP stack deployment"
```

## 🔧 DevOps and CI/CD

### GitHub Actions
```bash
sudo claude-root "create GitHub Actions workflow for automated testing"
sudo claude-root "write CI/CD pipeline with deployment to AWS"
sudo claude-root "generate workflow for Docker image building and pushing"
```

### Jenkins Pipelines
```bash
sudo claude-root "create Jenkinsfile for Maven project deployment"
sudo claude-root "write Jenkins pipeline with parallel testing stages"
```

### GitLab CI
```bash
sudo claude-root "create .gitlab-ci.yml for Node.js application"
sudo claude-root "write GitLab CI with security scanning stages"
```

## 🔐 Security and Monitoring

### Security Scripts
```bash
sudo claude-root "create security audit script for Linux servers"
sudo claude-root "write vulnerability scanning automation"
sudo claude-root "generate SSL certificate renewal script"
```

### Monitoring Configuration
```bash
sudo claude-root "create Prometheus monitoring rules for this application"
sudo claude-root "write Grafana dashboard configuration"
sudo claude-root "generate ELK stack configuration for log analysis"
```

## 🗄️ Database Operations

### Database Scripts
```bash
sudo claude-root "create database migration scripts for this schema"
sudo claude-root "write stored procedures for user management"
sudo claude-root "generate database backup and restore scripts"
```

### Performance Optimization
```bash
sudo claude-root "analyze and optimize these SQL queries"
sudo claude-root "create database indexing strategy"
sudo claude-root "write database performance monitoring script"
```

## 🌐 Web Development

### Frontend Framework Setup
```bash
sudo claude-root "create React application with TypeScript setup"
sudo claude-root "write Vue.js component with state management"
sudo claude-root "generate Angular service with HTTP interceptors"
```

### Backend API Development
```bash
sudo claude-root "create Express.js API with authentication middleware"
sudo claude-root "write FastAPI application with database integration"
sudo claude-root "generate GraphQL schema with resolvers"
```

## 📱 Mobile Development

### React Native
```bash
sudo claude-root "create React Native app with navigation"
sudo claude-root "write mobile API integration with offline support"
```

### Flutter
```bash
sudo claude-root "generate Flutter app with state management"
sudo claude-root "create Flutter widgets for custom UI components"
```

## 🧪 Testing and Quality Assurance

### Test Generation
```bash
sudo claude-root "write comprehensive unit tests for this module"
sudo claude-root "create integration tests for API endpoints"
sudo claude-root "generate end-to-end tests with Cypress"
```

### Code Quality
```bash
sudo claude-root "set up ESLint and Prettier configuration"
sudo claude-root "create pre-commit hooks for code quality"
sudo claude-root "write code coverage reports automation"
```

## 🔄 Advanced Usage with Options

### Cleanup Mode (Temporary User Removal)
```bash
# Remove temporary user after execution
sudo claude-root -c "generate one-time deployment script"
sudo claude-root --cleanup "create temporary analysis report"
```

### Custom Username
```bash
# Use custom temporary username
sudo claude-root -u deploy-user "create deployment scripts"
sudo claude-root --user ci-runner "generate CI configuration"
```

### Combined Options
```bash
# Custom user with cleanup
sudo claude-root -u temp-dev -c "analyze codebase and generate report"
```

## 🐛 Debugging and Troubleshooting

### Debug Mode Examples
```bash
# Enable verbose output for troubleshooting
DEBUG=1 sudo claude-root "help debug this issue"

# Check script version
claude-root --version

# Show detailed help
claude-root --help
```

### Common Issues and Solutions

#### Issue: Claude CLI not found
```bash
# Solution: Install Claude CLI
npm install -g @anthropic-ai/claude-code

# Verify installation
which claude
```

#### Issue: Permission denied
```bash
# Solution: Run with sudo
sudo claude-root "your command here"

# Or make script executable
chmod +x /usr/local/bin/claude-root
```

#### Issue: API key not recognized
```bash
# Solution: Copy API configuration
sudo cp ~/.config/claude/config.json /home/claude-temp/.config/claude/
```

## 📊 Performance and Optimization

### Large Codebase Analysis
```bash
sudo claude-root "analyze this monorepo for architectural improvements"
sudo claude-root "suggest microservices decomposition strategy"
sudo claude-root "identify performance bottlenecks in this application"
```

### Optimization Scripts
```bash
sudo claude-root "create performance monitoring script"
sudo claude-root "write memory usage optimization guide"
sudo claude-root "generate CPU profiling automation"
```

## 🔗 Integration Examples

### API Integration
```bash
sudo claude-root "create webhook handler for GitHub events"
sudo claude-root "write Slack bot integration for deployment notifications"
sudo claude-root "generate payment processing integration"
```

### Third-party Services
```bash
sudo claude-root "create AWS S3 file upload service"
sudo claude-root "write SendGrid email automation"
sudo claude-root "generate Stripe payment processing"
```

## 🎯 Project-Specific Examples

### E-commerce Platform
```bash
sudo claude-root "create shopping cart microservice"
sudo claude-root "write inventory management system"
sudo claude-root "generate payment processing workflow"
```

### Content Management System
```bash
sudo claude-root "create CMS backend with user roles"
sudo claude-root "write content versioning system"
sudo claude-root "generate SEO optimization tools"
```

### Data Analytics Platform
```bash
sudo claude-root "create data pipeline with Apache Kafka"
sudo claude-root "write machine learning model deployment"
sudo claude-root "generate real-time analytics dashboard"
```

---

## 💡 Tips for Better Results

1. **Be Specific**: Provide detailed requirements for better code generation
2. **Context Matters**: Run commands from the project directory for better context
3. **Iterative Approach**: Use Claude for step-by-step project building
4. **Code Review**: Always review generated code before deployment
5. **Documentation**: Ask Claude to generate documentation alongside code

## 🚨 Security Best Practices

- ✅ Use cleanup mode (`-c`) for sensitive operations
- ✅ Review generated scripts before execution
- ✅ Test in development environment first
- ✅ Limit temporary user permissions when possible
- ❌ Don't store sensitive data in generated code
- ❌ Don't run untested scripts in production

For more examples and advanced usage patterns, visit the [GitHub repository](https://github.com/gagarinyury/claude-code-root-runner).