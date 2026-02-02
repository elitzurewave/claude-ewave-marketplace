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

In Claude Code chat, type:
```
/plugin marketplace add https://github.com/elitzurewave/claude-ewave-marketplace
```

Then:
```
/plugin
```

Go to **Discover** tab and install **ewave-development-suite-beta**

---

## For Organization Administrators

### Setting Up the Marketplace

#### Deployment (GitHub)

**Already deployed at:**
- Marketplace: https://github.com/elitzurewave/claude-ewave-marketplace
- Plugin: https://github.com/elitzurewave/ewave-development-suite-beta

**Team members connect:**

In Claude Code chat:
```
/plugin marketplace add https://github.com/elitzurewave/claude-ewave-marketplace
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
        "url": "https://github.com/elitzurewave/your-new-plugin.git"
      }
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

In Claude Code chat:
```
/plugin
```

Go to **Discover** tab and install the new plugin

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

## For Team Members

### First-Time Setup

1. **Open Claude Code**

2. **In the chat, type:**
```
/plugin marketplace add https://github.com/elitzurewave/claude-ewave-marketplace
```

3. **Browse and install:**
```
/plugin
```

4. **Go to "Discover" tab** and install **ewave-development-suite-beta**

The plugin is now active!

### Updating Plugins

In Claude Code chat:
```
/plugin
```

Go to **Installed** tab → Click plugin → Click **Update**

### Troubleshooting

#### Marketplace Not Found

In Claude Code chat:
```
/plugin
```

Go to **Manage** tab → Verify marketplace is listed

If not, re-add:
```
/plugin marketplace add https://github.com/elitzurewave/claude-ewave-marketplace
```

#### Plugin Installation Fails

In Claude Code chat:
```
/plugin
```

Go to **Discover** tab → Try reinstalling the plugin

#### Authentication Required (Private Repos)

For private GitHub repositories:
- Personal Access Token configured
- Proper permissions on repositories

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
