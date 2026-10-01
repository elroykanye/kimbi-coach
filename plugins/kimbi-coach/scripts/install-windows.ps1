[CmdletBinding()]
param(
    [string]$SourcePath = (Split-Path -Parent $PSScriptRoot),
    [switch]$Quiet
)

$ErrorActionPreference = "Stop"
$PluginName = "kimbi-coach"
$ProfileRoot = [Environment]::GetFolderPath("UserProfile")
$PluginParent = Join-Path $ProfileRoot ".codex\plugins"
$PluginTarget = Join-Path $PluginParent $PluginName
$MarketplaceDir = Join-Path $ProfileRoot ".agents\plugins"
$MarketplacePath = Join-Path $MarketplaceDir "marketplace.json"
$SourcePath = (Resolve-Path $SourcePath).Path.TrimEnd("\")

function Write-Step([string]$Message) {
    if (-not $Quiet) { Write-Host $Message -ForegroundColor Cyan }
}

function New-PluginEntry {
    return [pscustomobject][ordered]@{
        name = $PluginName
        source = [pscustomobject][ordered]@{
            source = "local"
            path = "./plugins/kimbi-coach"
        }
        policy = [pscustomobject][ordered]@{
            installation = "AVAILABLE"
            authentication = "ON_INSTALL"
        }
        category = "Productivity"
    }
}

$ManifestPath = Join-Path $SourcePath ".codex-plugin\plugin.json"
if (-not (Test-Path $ManifestPath -PathType Leaf)) {
    throw "The selected folder is not a complete Kimbi Coach package: $ManifestPath is missing."
}
$Manifest = Get-Content $ManifestPath -Raw | ConvertFrom-Json
if ($Manifest.name -ne $PluginName) {
    throw "The package identifies itself as '$($Manifest.name)', not '$PluginName'."
}

New-Item -ItemType Directory -Force -Path $PluginParent, $MarketplaceDir | Out-Null
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"

if (Test-Path $PluginTarget) {
    $BackupPath = "$PluginTarget.backup-$Stamp"
    Write-Step "Backing up the previous Kimbi Coach installation..."
    Move-Item -Path $PluginTarget -Destination $BackupPath
}

Write-Step "Installing Kimbi Coach $($Manifest.version) for this Windows user..."
Copy-Item -Path $SourcePath -Destination $PluginTarget -Recurse -Force

if (Test-Path $MarketplacePath) {
    Copy-Item $MarketplacePath "$MarketplacePath.backup-$Stamp" -Force
    $Marketplace = Get-Content $MarketplacePath -Raw | ConvertFrom-Json
    if (-not $Marketplace.name) {
        throw "The existing personal marketplace has no name. Its backup is $MarketplacePath.backup-$Stamp"
    }
    if (-not $Marketplace.interface) {
        $Marketplace | Add-Member -NotePropertyName interface -NotePropertyValue ([pscustomobject]@{ displayName = "Personal" })
    }
    $OtherPlugins = @($Marketplace.plugins | Where-Object { $_.name -ne $PluginName })
    if ($null -eq $Marketplace.PSObject.Properties["plugins"]) {
        $Marketplace | Add-Member -NotePropertyName plugins -NotePropertyValue @((New-PluginEntry))
    } else {
        $Marketplace.plugins = @($OtherPlugins) + @(New-PluginEntry)
    }
} else {
    $Marketplace = [pscustomobject][ordered]@{
        name = "personal"
        interface = [pscustomobject][ordered]@{ displayName = "Personal" }
        plugins = @((New-PluginEntry))
    }
}

$Marketplace | ConvertTo-Json -Depth 20 | Set-Content -Path $MarketplacePath -Encoding UTF8

if (-not $Quiet) {
    Write-Host "" 
    Write-Host "Kimbi Coach files are installed." -ForegroundColor Green
    Write-Host ""
    Write-Host "Finish in the ChatGPT desktop app:" -ForegroundColor Yellow
    Write-Host "  1. Fully close and reopen ChatGPT."
    Write-Host "  2. Open Codex or Work, then open Plugins."
    Write-Host "  3. Choose the Personal source, open Kimbi Coach, and select Install plugin."
    Write-Host "  4. Start a new chat and say: Set up Kimbi Coach."
    Write-Host ""
    Write-Host "No Codex command-line installation is required."
}
