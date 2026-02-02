# Ewave Organization Marketplace

Internal Claude Code plugin marketplace for Ewave development teams.

## Available Plugins

### 🚀 Ewave Development Suite (Beta)
**Version:** 0.1.0-beta
**Category:** Development Workflow
**License:** MIT

Enterprise .NET development workflow with:
- 10 specialized agents (planner, code-reviewer, security-reviewer, etc.)
- 15 slash commands (/plan, /code-review, /tdd, etc.)
- 13 reusable skills (dotnet-core-standards, security-review, etc.)
- 9 development rules (coding standards, git workflow, security)
- 12 event hooks (pre-commit, post-edit, session management)

**Perfect for:**
- .NET Core 10 development
- Enterprise applications
- Security-conscious teams
- TDD practitioners
- Multi-language projects (TypeScript, React, PostgreSQL)

**Requirements:**
- Claude Code 2.0.0+
- Node.js 18+ (for hooks)
- .NET 10 SDK (optional, for .NET projects)

**Install:**
```bash
claude marketplace add ewave https://github.com/ewave/claude-plugins-marketplace
claude plugins install ewave-development-suite-beta
```

---

## For Organization Administrators

### Setting Up the Marketplace

#### Option 1: GitHub Repository (Recommended)

1. **Create a new repository:**
```bash
git init
git add .
git commit -m "Initial marketplace setup"
git remote add origin https://github.com/ewave/claude-plugins-marketplace.git
git push -u origin main
```

2. **Add plugins to the marketplace:**
   - Place plugin repositories in the same organization
   - Update `marketplace.json` with plugin metadata
   - Push changes to main branch

3. **Team members connect:**
```bash
# One-time setup
claude marketplace add ewave https://github.com/ewave/claude-plugins-marketplace

# Browse available plugins
claude marketplace list

# Install plugins
claude plugins install ewave-development-suite-beta
```

#### Option 2: Internal Git Server (GitLab, Bitbucket, Azure DevOps)

1. **Create repository on your Git server:**
```bash
git remote add origin https://git.ewave.internal/development/claude-plugins-marketplace.git
git push -u origin main
```

2. **Update marketplace.json URLs** to point to your internal server

3. **Team setup:**
```bash
claude marketplace add ewave https://git.ewave.internal/development/claude-plugins-marketplace
```

#### Option 3: Network File Share (Windows)

1. **Copy marketplace to shared location:**
```bash
xcopy /E /I "C:\elitzur\Ewave.ai\claude-plugins\marketplace" "\\server\share\claude-marketplace"
```

2. **Team setup:**
```bash
claude marketplace add ewave file://server/share/claude-marketplace
```

### Adding New Plugins

1. **Create the plugin** (follow plugin structure)

2. **Add entry to marketplace.json:**
```json
{
  "plugins": [
    {
      "name": "your-new-plugin",
      "version": "1.0.0",
      "description": "Plugin description",
      "repository": {
        "type": "git",
        "url": "https://github.com/ewave/your-new-plugin.git"
      },
      "downloadUrl": "https://github.com/ewave/your-new-plugin/archive/refs/heads/main.zip"
    }
  ]
}
```

3. **Commit and push:**
```bash
git add marketplace.json
git commit -m "Add your-new-plugin to marketplace"
git push
```

4. **Team members update:**
```bash
claude marketplace refresh
claude plugins install your-new-plugin
```

### Plugin Approval Process

1. Developer creates plugin
2. Submit PR to marketplace repository
3. Team lead reviews:
   - Security check
   - Code quality
   - Documentation completeness
4. Merge to main
5. Available to all team members

### Versioning

Update plugin versions in `marketplace.json`:
```json
{
  "version": "1.0.0",
  "changelog": {
    "1.0.0": "Stable release",
    "0.2.0-beta": "Added new features",
    "0.1.0-beta": "Initial beta release"
  }
}
```

### Monitoring Usage

Track plugin installations:
```bash
# On marketplace server
git log --grep="install" --oneline
```

### Security Considerations

- ✅ Review all plugins before adding to marketplace
- ✅ Use private repositories for sensitive plugins
- ✅ Require authentication for Git access
- ✅ Audit hook scripts for security issues
- ✅ Scan for hardcoded secrets
- ✅ Test plugins in sandbox before deployment

## For Team Members

### First-Time Setup

1. **Add Ewave marketplace:**
```bash
claude marketplace add ewave https://github.com/ewave/claude-plugins-marketplace
```

2. **Browse available plugins:**
```bash
claude marketplace list
```

3. **Install plugins:**
```bash
claude plugins install ewave-development-suite-beta
```

4. **Enable installed plugins:**
```bash
claude plugins enable ewave-development-suite-beta
```

### Updating Plugins

```bash
# Refresh marketplace catalog
claude marketplace refresh

# Update specific plugin
claude plugins update ewave-development-suite-beta

# Update all plugins
claude plugins update --all
```

### Troubleshooting

#### Marketplace Not Found
```bash
# Check configured marketplaces
claude marketplace list

# Re-add marketplace
claude marketplace add ewave https://github.com/ewave/claude-plugins-marketplace --force
```

#### Plugin Installation Fails
```bash
# Clear cache
claude cache clear

# Retry installation
claude plugins install ewave-development-suite-beta --verbose
```

#### Authentication Required (Private Repos)
```bash
# Configure Git credentials
git config --global credential.helper store

# Or use SSH
git config --global url."git@github.com:".insteadOf "https://github.com/"
```

## Support

For issues or questions:
- **Internal:** Contact Ewave DevOps team
- **Plugin Issues:** Create issue in plugin repository
- **Marketplace Issues:** Create issue in marketplace repository

## Roadmap

- [ ] Web UI for browsing plugins
- [ ] Plugin usage analytics
- [ ] Automated security scanning
- [ ] Plugin rating system
- [ ] Category filtering
- [ ] Search functionality
- [ ] Version compatibility checking
