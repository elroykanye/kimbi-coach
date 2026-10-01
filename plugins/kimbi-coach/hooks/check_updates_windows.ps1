$ErrorActionPreference = "Stop"
$CheckIntervalSeconds = 24 * 60 * 60
$FailureRetrySeconds = 6 * 60 * 60
$RepoApi = "https://api.github.com/repos/elroykanye/kimbi-coach/releases/latest"
$DataDir = if ($env:PLUGIN_DATA) { $env:PLUGIN_DATA } else { $env:CLAUDE_PLUGIN_DATA }

if (-not $DataDir) { exit 0 }
New-Item -ItemType Directory -Force -Path $DataDir | Out-Null
$StatePath = Join-Path $DataDir "update-state-windows.json"
$Now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
$State = @{}
if (Test-Path $StatePath) {
    try {
        $Loaded = Get-Content $StatePath -Raw | ConvertFrom-Json
        if ($null -ne $Loaded.last_attempt) { $State.last_attempt = [long]$Loaded.last_attempt }
        if ($null -ne $Loaded.last_success) { $State.last_success = [long]$Loaded.last_success }
    } catch { $State = @{} }
}
$LastAttempt = if ($State.last_attempt) { [long]$State.last_attempt } else { 0 }
$LastSuccess = if ($State.last_success) { [long]$State.last_success } else { 0 }
$Wait = if ($LastSuccess -ge $LastAttempt) { $CheckIntervalSeconds } else { $FailureRetrySeconds }
if (($Now - $LastAttempt) -lt $Wait) { exit 0 }

$State.last_attempt = $Now
try {
    $CurrentManifest = Join-Path $env:PLUGIN_ROOT ".codex-plugin\plugin.json"
    $CurrentVersion = (Get-Content $CurrentManifest -Raw | ConvertFrom-Json).version
    $Headers = @{ "User-Agent" = "Kimbi-Coach-Updater"; "Accept" = "application/vnd.github+json" }
    $Release = Invoke-RestMethod -Uri $RepoApi -Headers $Headers
    $LatestVersion = ([string]$Release.tag_name).TrimStart("v")

    if ($CurrentVersion -ne $LatestVersion) {
        $Asset = @($Release.assets | Where-Object { $_.name -eq "kimbi-coach-$LatestVersion.zip" })[0]
        if (-not $Asset) { throw "The v$LatestVersion Windows package is missing from GitHub Releases." }
        $TempDir = Join-Path ([IO.Path]::GetTempPath()) ("kimbi-coach-update-" + [guid]::NewGuid())
        New-Item -ItemType Directory -Path $TempDir | Out-Null
        try {
            $Archive = Join-Path $TempDir $Asset.name
            Invoke-WebRequest -Uri $Asset.browser_download_url -Headers $Headers -OutFile $Archive
            Expand-Archive -Path $Archive -DestinationPath $TempDir -Force
            $NewPlugin = Join-Path $TempDir "kimbi-coach"
            $Installer = Join-Path $NewPlugin "scripts\install-windows.ps1"
            if (-not (Test-Path $Installer)) { throw "The downloaded package has no Windows installer." }
            & $Installer -SourcePath $NewPlugin -Quiet
        } finally {
            Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
        }
        $State.status = "updated"
        $State.latest_version = $LatestVersion
        $State.last_success = $Now
        $State | ConvertTo-Json | Set-Content $StatePath -Encoding UTF8
        [pscustomobject]@{
            continue = $true
            systemMessage = "Kimbi Coach updated to v$LatestVersion. Restart ChatGPT and start a new chat when convenient to load the update."
        } | ConvertTo-Json -Compress
        exit 0
    }

    $State.status = "current"
    $State.latest_version = $LatestVersion
    $State.last_success = $Now
    $State | ConvertTo-Json | Set-Content $StatePath -Encoding UTF8
    exit 0
} catch {
    $State.status = "failed"
    $State.error = ([string]$_.Exception.Message).Substring(0, [Math]::Min(1000, ([string]$_.Exception.Message).Length))
    $State | ConvertTo-Json | Set-Content $StatePath -Encoding UTF8
    [pscustomobject]@{
        continue = $true
        systemMessage = "Kimbi Coach could not complete its daily update check. Study features still work, and it will retry later."
    } | ConvertTo-Json -Compress
    exit 0
}
