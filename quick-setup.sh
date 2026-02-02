#!/bin/bash
# Quick Setup Script for Ewave Marketplace
# Bash script to initialize both marketplace and plugin repositories

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${CYAN}$1${NC}"; }
success() { echo -e "${GREEN}$1${NC}"; }
warning() { echo -e "${YELLOW}$1${NC}"; }
error() { echo -e "${RED}$1${NC}"; }

# Default values
ORG_NAME="ewave"
USE_GITHUB=false
GIT_SERVER=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --github)
      USE_GITHUB=true
      shift
      ;;
    --git-server)
      GIT_SERVER="$2"
      shift 2
      ;;
    --org)
      ORG_NAME="$2"
      shift 2
      ;;
    -h|--help)
      echo "Usage: ./quick-setup.sh [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --github              Use GitHub"
      echo "  --git-server URL      Use custom Git server"
      echo "  --org NAME            Organization name (default: ewave)"
      echo "  -h, --help            Show this help"
      echo ""
      echo "Examples:"
      echo "  ./quick-setup.sh --github"
      echo "  ./quick-setup.sh --git-server https://gitlab.ewave.internal/devops"
      exit 0
      ;;
    *)
      error "Unknown option: $1"
      exit 1
      ;;
  esac
done

info "=========================================="
info "Ewave Marketplace - Quick Setup"
info "=========================================="
echo ""

# Determine Git server URL base
if [ "$USE_GITHUB" = true ]; then
  GIT_BASE="https://github.com/$ORG_NAME"
  info "Using GitHub: $GIT_BASE"
elif [ -n "$GIT_SERVER" ]; then
  GIT_BASE="$GIT_SERVER"
  info "Using custom Git server: $GIT_BASE"
else
  warning "No Git server specified."
  echo ""
  info "Options:"
  info "  --github                 Use GitHub"
  info "  --git-server <url>       Use custom Git server"
  echo ""
  info "Example: ./quick-setup.sh --github"
  info "Example: ./quick-setup.sh --git-server https://gitlab.ewave.internal/devops"
  exit 0
fi

MARKETPLACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$MARKETPLACE_DIR")/ewave-development-suite-beta"

# Check if plugin directory exists
if [ ! -d "$PLUGIN_DIR" ]; then
  error "Plugin directory not found: $PLUGIN_DIR"
  error "Expected structure:"
  error "  claude-plugins/"
  error "    ├── marketplace/          (current directory)"
  error "    └── ewave-development-suite-beta/"
  exit 1
fi

echo ""
info "Step 1: Initialize Marketplace Repository"
info "-------------------------------------------"

cd "$MARKETPLACE_DIR"

if [ -d ".git" ]; then
  warning "Git already initialized in marketplace"
else
  git init
  git add .
  git commit -m "Initial commit: Ewave marketplace v1.0.0"
  success "✓ Marketplace repository initialized"
fi

echo ""
info "Step 2: Initialize Plugin Repository"
info "-------------------------------------"

cd "$PLUGIN_DIR"

if [ -d ".git" ]; then
  warning "Git already initialized in plugin"
else
  git init
  git add .
  git commit -m "Initial commit: Ewave Development Suite v0.1.0-beta"
  success "✓ Plugin repository initialized"
fi

echo ""
info "=========================================="
success "Local Setup Complete!"
info "=========================================="
echo ""
info "Next Steps:"
echo ""
info "1. Create repositories on your Git server:"
info "   - $GIT_BASE/claude-plugins-marketplace"
info "   - $GIT_BASE/ewave-development-suite-beta"
echo ""
info "2. Push marketplace:"
info "   cd \"$MARKETPLACE_DIR\""
info "   git remote add origin $GIT_BASE/claude-plugins-marketplace.git"
info "   git push -u origin main"
echo ""
info "3. Push plugin:"
info "   cd \"$PLUGIN_DIR\""
info "   git remote add origin $GIT_BASE/ewave-development-suite-beta.git"
info "   git push -u origin main"
echo ""
info "4. Update marketplace.json URLs with your actual repository URLs"
echo ""
info "5. Team members can then install:"
info "   claude marketplace add ewave $GIT_BASE/claude-plugins-marketplace"
info "   claude plugins install ewave-development-suite-beta"
echo ""
