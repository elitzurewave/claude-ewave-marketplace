# Ewave Marketplace Setup Guide

Step-by-step guide to set up the Ewave organization marketplace for Claude Code.

## Prerequisites

- Git installed
- GitHub account (or internal Git server access)
- Organization admin access
- Claude Code installed on your machine

## Step 1: Prepare the Marketplace Repository

### A. Create Marketplace Repository Structure

```bash
cd C:\elitzur\Ewave.ai\claude-plugins\marketplace

# Initialize Git
git init
git add .
git commit -m "Initial commit: Ewave marketplace v1.0.0"
```

### B. Create GitHub Repository

**Via GitHub Web UI:**
1. Go to https://github.com/organizations/ewave/repositories/new
2. Repository name: `claude-plugins-marketplace`
3. Description: "Internal Claude Code plugins for Ewave development teams"
4. Visibility: **Private** (for internal use) or **Public**
5. Click "Create repository"

**Via GitHub CLI:**
```bash
gh repo create ewave/claude-plugins-marketplace --private --description "Internal Claude Code plugins for Ewave"
```

### C. Push to GitHub

```bash
git remote add origin https://github.com/ewave/claude-plugins-marketplace.git
git branch -M main
git push -u origin main
```

## Step 2: Publish the Plugin

### A. Create Plugin Repository

```bash
cd C:\elitzur\Ewave.ai\claude-plugins\ewave-development-suite-beta

# Initialize Git
git init
git add .
git commit -m "Initial commit: Ewave Development Suite v0.1.0-beta"
```

### B. Create GitHub Repository for Plugin

**Via GitHub Web UI:**
1. Go to https://github.com/organizations/ewave/repositories/new
2. Repository name: `ewave-development-suite-beta`
3. Description: "Enterprise .NET development workflow for Claude Code"
4. Visibility: **Private** or **Public**
5. Click "Create repository"

**Via GitHub CLI:**
```bash
gh repo create ewave/ewave-development-suite-beta --private --description "Enterprise .NET development workflow"
```

### C. Push Plugin to GitHub

```bash
git remote add origin https://github.com/ewave/ewave-development-suite-beta.git
git branch -M main
git push -u origin main
```

### D. Create Release (Optional but Recommended)

```bash
# Tag the release
git tag -a v0.1.0-beta -m "Release v0.1.0-beta"
git push origin v0.1.0-beta

# Or via GitHub CLI
gh release create v0.1.0-beta --title "v0.1.0-beta" --notes "Initial beta release"
```

## Step 3: Update Marketplace URLs

Edit `marketplace.json` with your actual GitHub URLs:

```json
{
  "url": "https://github.com/ewave/claude-plugins-marketplace",
  "plugins": [
    {
      "name": "ewave-development-suite-beta",
      "homepage": "https://github.com/ewave/ewave-development-suite-beta",
      "repository": {
        "type": "git",
        "url": "https://github.com/ewave/ewave-development-suite-beta.git"
      },
      "downloadUrl": "https://github.com/ewave/ewave-development-suite-beta/archive/refs/heads/main.zip"
    }
  ]
}
```

Commit and push:
```bash
cd C:\elitzur\Ewave.ai\claude-plugins\marketplace
git add marketplace.json
git commit -m "Update marketplace URLs with actual GitHub repositories"
git push
```

## Step 4: Test Installation (Your Machine)

```bash
# Add marketplace to Claude Code
claude marketplace add ewave https://github.com/ewave/claude-plugins-marketplace

# Verify marketplace is added
claude marketplace list

# Expected output:
# Available Marketplaces:
# ✓ ewave (https://github.com/ewave/claude-plugins-marketplace)

# Browse available plugins
claude marketplace search

# Install the plugin
claude plugins install ewave-development-suite-beta

# Enable the plugin
claude plugins enable ewave-development-suite-beta

# Verify it's working
claude plugins list
```

## Step 5: Team Rollout

### A. Create Installation Documentation

Create a document for your team (e.g., Confluence, internal wiki):

```markdown
# Installing Ewave Claude Code Plugins

## One-Time Setup

1. Open your terminal
2. Add Ewave marketplace:
   ```
   claude marketplace add ewave https://github.com/ewave/claude-plugins-marketplace
   ```

3. Install development suite:
   ```
   claude plugins install ewave-development-suite-beta
   claude plugins enable ewave-development-suite-beta
   ```

4. Verify installation:
   ```
   claude plugins list
   ```

5. Restart Claude Code

## Usage

- Planning: `/plan` or "Use planner agent"
- Code review: `/code-review`
- TDD workflow: `/tdd`
- Build fixes: `/build-fix`

Full documentation: https://github.com/ewave/ewave-development-suite-beta
```

### B. Send Team Announcement

**Email Template:**

```
Subject: New Claude Code Plugin Available - Ewave Development Suite

Hi Team,

We've created an internal Claude Code plugin that enforces our development standards
and provides helpful automation for .NET projects.

Features:
✓ 10 specialized agents (code review, security, TDD, etc.)
✓ 15 slash commands for common tasks
✓ Automatic code formatting and linting
✓ .NET Core best practices enforcement

Installation:
1. Run: claude marketplace add ewave https://github.com/ewave/claude-plugins-marketplace
2. Run: claude plugins install ewave-development-suite-beta
3. Run: claude plugins enable ewave-development-suite-beta

Documentation: https://github.com/ewave/ewave-development-suite-beta

Questions? Contact DevOps team.

Thanks,
[Your Name]
```

### C. Provide Support

Set up support channel:
- Slack channel: `#claude-code-plugins`
- Teams channel or email alias
- Internal documentation page

## Step 6: Maintenance

### Updating the Plugin

```bash
# Make changes to plugin
cd C:\elitzur\Ewave.ai\claude-plugins\ewave-development-suite-beta

# Update version in .claude-plugin/plugin.json
# Example: 0.1.0-beta -> 0.2.0-beta

# Commit changes
git add .
git commit -m "feat: add new features for v0.2.0-beta"
git push

# Create new release
git tag -a v0.2.0-beta -m "Release v0.2.0-beta"
git push origin v0.2.0-beta
```

### Update Marketplace

```bash
cd C:\elitzur\Ewave.ai\claude-plugins\marketplace

# Edit marketplace.json
# Update version and changelog

git add marketplace.json
git commit -m "Update ewave-development-suite-beta to v0.2.0-beta"
git push
```

### Team Updates Plugin

```bash
claude marketplace refresh
claude plugins update ewave-development-suite-beta
```

## Alternative: GitLab / Internal Git

If using internal Git server:

```bash
# GitLab (example)
git remote add origin https://gitlab.example.com/devops/claude-marketplace.git
git remote add origin https://gitlab.example.com/devops/ewave-development-suite-beta.git

# Team adds marketplace
claude marketplace add ewave https://gitlab.example.com/devops/claude-marketplace
```

Update `marketplace.json` URLs accordingly.

## Security Considerations

### For Private Repositories

1. **SSH Keys** (Recommended):
```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your_email@ewave.co.il"

# Add to GitHub
cat ~/.ssh/id_ed25519.pub
# Add to https://github.com/settings/keys

# Use SSH URLs in marketplace.json
"url": "git@github.com:ewave/ewave-development-suite-beta.git"
```

2. **Personal Access Tokens**:
```bash
# Create token at https://github.com/settings/tokens
# Scopes: repo (all)

# Configure Git
git config --global credential.helper store
# First git command will prompt for token
```

3. **Organization Access**:
- Add team members to GitHub organization
- Set repository permissions (read access minimum)

## Troubleshooting

### "Marketplace not found"
- Verify repository is public or you have access
- Check URL is correct
- Try: `claude marketplace add ewave <URL> --force`

### "Plugin installation failed"
- Verify plugin repository URL
- Check network connectivity
- Try manual installation: `git clone <URL> ~/.claude/plugins/`

### "Hooks not working"
- Verify Node.js is installed: `node --version`
- Check hook scripts are executable
- Review Claude Code logs: `~/.claude/debug/`

## Next Steps

1. ✅ Set up marketplace repository
2. ✅ Publish plugin repository
3. ✅ Test installation
4. ✅ Roll out to team
5. ⏳ Gather feedback
6. ⏳ Iterate and improve
7. ⏳ Add more plugins as needed

## Support

For help with setup:
- Email: devops@ewave.co.il
- Slack: #claude-code-plugins
- Documentation: https://github.com/ewave/claude-plugins-marketplace
