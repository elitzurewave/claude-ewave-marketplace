# Quick Setup Script for Ewave Marketplace
# PowerShell script to initialize both marketplace and plugin repositories

param(
    [Parameter(Mandatory=$false)]
    [string]$OrgName = "ewave",

    [Parameter(Mandatory=$false)]
    [switch]$UseGitHub,

    [Parameter(Mandatory=$false)]
    [string]$GitServer = ""
)

$ErrorActionPreference = "Stop"

function Write-Success { Write-Host $args -ForegroundColor Green }
function Write-Info { Write-Host $args -ForegroundColor Cyan }
function Write-Warning { Write-Host $args -ForegroundColor Yellow }
function Write-Error { Write-Host $args -ForegroundColor Red }

Write-Info "=========================================="
Write-Info "Ewave Marketplace - Quick Setup"
Write-Info "=========================================="
Write-Info ""

# Determine Git server URL base
if ($UseGitHub) {
    $GitBase = "https://github.com/$OrgName"
    Write-Info "Using GitHub: $GitBase"
} elseif ($GitServer) {
    $GitBase = $GitServer
    Write-Info "Using custom Git server: $GitBase"
} else {
    Write-Warning "No Git server specified."
    Write-Info "Options:"
    Write-Info "  -UseGitHub                 Use GitHub"
    Write-Info "  -GitServer <url>           Use custom Git server"
    Write-Info ""
    Write-Info "Example: .\quick-setup.ps1 -UseGitHub"
    Write-Info "Example: .\quick-setup.ps1 -GitServer https://gitlab.ewave.internal/devops"
    exit 0
}

$MARKETPLACE_DIR = $PSScriptRoot
$PLUGIN_DIR = Split-Path -Parent $MARKETPLACE_DIR | Join-Path -ChildPath "ewave-development-suite-beta"

# Check if plugin directory exists
if (-not (Test-Path $PLUGIN_DIR)) {
    Write-Error "Plugin directory not found: $PLUGIN_DIR"
    Write-Error "Expected structure:"
    Write-Error "  claude-plugins/"
    Write-Error "    ├── marketplace/          (current directory)"
    Write-Error "    └── ewave-development-suite-beta/"
    exit 1
}

Write-Info ""
Write-Info "Step 1: Initialize Marketplace Repository"
Write-Info "-------------------------------------------"

cd $MARKETPLACE_DIR

if (Test-Path ".git") {
    Write-Warning "Git already initialized in marketplace"
} else {
    git init
    git add .
    git commit -m "Initial commit: Ewave marketplace v1.0.0"
    Write-Success "✓ Marketplace repository initialized"
}

Write-Info ""
Write-Info "Step 2: Initialize Plugin Repository"
Write-Info "-------------------------------------"

cd $PLUGIN_DIR

if (Test-Path ".git") {
    Write-Warning "Git already initialized in plugin"
} else {
    git init
    git add .
    git commit -m "Initial commit: Ewave Development Suite v0.1.0-beta"
    Write-Success "✓ Plugin repository initialized"
}

Write-Info ""
Write-Info "=========================================="
Write-Success "Local Setup Complete!"
Write-Info "=========================================="
Write-Info ""
Write-Info "Next Steps:"
Write-Info ""
Write-Info "1. Create repositories on your Git server:"
Write-Info "   - $GitBase/claude-plugins-marketplace"
Write-Info "   - $GitBase/ewave-development-suite-beta"
Write-Info ""
Write-Info "2. Push marketplace:"
Write-Info "   cd `"$MARKETPLACE_DIR`""
Write-Info "   git remote add origin $GitBase/claude-plugins-marketplace.git"
Write-Info "   git push -u origin main"
Write-Info ""
Write-Info "3. Push plugin:"
Write-Info "   cd `"$PLUGIN_DIR`""
Write-Info "   git remote add origin $GitBase/ewave-development-suite-beta.git"
Write-Info "   git push -u origin main"
Write-Info ""
Write-Info "4. Update marketplace.json URLs with your actual repository URLs"
Write-Info ""
Write-Info "5. Team members can then install:"
Write-Info "   claude marketplace add ewave $GitBase/claude-plugins-marketplace"
Write-Info "   claude plugins install ewave-development-suite-beta"
Write-Info ""
