#requires -Version 5.1
[CmdletBinding()]
param(
    [Alias("n")]
    [switch]$DryRun,

    [Alias("y")]
    [switch]$Yes,

    [Alias("h")]
    [switch]$Help
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$script:ScriptDir = if ($PSScriptRoot) {
    $PSScriptRoot
} else {
    Split-Path -Parent $MyInvocation.MyCommand.Path
}
$script:ExtrasDir = Join-Path $script:ScriptDir "extras"
$script:HomeDir = $HOME
$script:AppData = if ($env:APPDATA) {
    $env:APPDATA
} else {
    Join-Path $script:HomeDir "AppData\Roaming"
}
$script:LocalAppData = if ($env:LOCALAPPDATA) {
    $env:LOCALAPPDATA
} else {
    Join-Path $script:HomeDir "AppData\Local"
}
$script:ConfigRoot = Join-Path $script:AppData "silkcircuit"
$script:HomeConfig = Join-Path $script:HomeDir ".config"

$script:Detected = [System.Collections.Generic.List[string]]::new()
$script:Installed = [System.Collections.Generic.List[string]]::new()
$script:Skipped = [System.Collections.Generic.List[string]]::new()
$script:Failed = [System.Collections.Generic.List[string]]::new()

$script:UseAnsi = -not [bool]$env:NO_COLOR
$script:Esc = [char]27
if ($script:UseAnsi) {
    $script:Reset = "$script:Esc[0m"
    $script:Bold = "$script:Esc[1m"
    $script:Dim = "$script:Esc[2m"
    $script:Purple = "$script:Esc[38;2;225;53;255m"
    $script:Cyan = "$script:Esc[38;2;128;255;234m"
    $script:Pink = "$script:Esc[38;2;255;0;255m"
    $script:Green = "$script:Esc[38;2;80;250;123m"
    $script:Yellow = "$script:Esc[38;2;241;250;140m"
    $script:Red = "$script:Esc[38;2;255;99;99m"
    $script:Coral = "$script:Esc[38;2;255;106;193m"
    $script:White = "$script:Esc[38;2;248;248;242m"
    $script:Gray = "$script:Esc[38;2;99;119;119m"
} else {
    $script:Reset = ""
    $script:Bold = ""
    $script:Dim = ""
    $script:Purple = ""
    $script:Cyan = ""
    $script:Pink = ""
    $script:Green = ""
    $script:Yellow = ""
    $script:Red = ""
    $script:Coral = ""
    $script:White = ""
    $script:Gray = ""
}

function Join-PathParts {
    param(
        [Parameter(Mandatory)]
        [string]$Root,

        [Parameter(Mandatory, ValueFromRemainingArguments)]
        [string[]]$Parts
    )

    $path = $Root
    foreach ($part in $Parts) {
        if ([string]::IsNullOrWhiteSpace($part)) {
            continue
        }
        $path = Join-Path -Path $path -ChildPath $part
    }
    return $path
}

function Write-Success {
    param([string]$Message)
    Write-Host "$script:Green$script:Bold  $Message$script:Reset"
}

function Write-Warn {
    param([string]$Message)
    Write-Host "$script:Yellow  ! $Message$script:Reset"
}

function Write-Fail {
    param([string]$Message)
    Write-Host "$script:Red  x $Message$script:Reset"
}

function Write-Info {
    param([string]$Message)
    Write-Host "$script:White  $Message$script:Reset"
}

function Write-Dim {
    param([string]$Message)
    Write-Host "$script:Gray    $Message$script:Reset"
}

function Write-NeonLine {
    param([int]$Width = 50)
    $line = "".PadLeft($Width, "-")
    Write-Host "$script:Purple  $line$script:Reset"
}

function Show-Banner {
    Write-Host ""
    Write-Host "$script:Purple$script:Bold             S I L K C I R C U I T$script:Reset"
    Write-NeonLine 39
    Write-Host "$script:Gray             Electric meets elegant.$script:Reset"
    Write-Host ""
    Write-Host "$script:Gray             hyperbliss technologies$script:Reset"
    Write-Host "$script:Coral     https://github.com/sponsors/hyperb1iss$script:Reset"
    Write-Host ""
}

function Test-Command {
    param([string]$Name)
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

function Test-AnyPath {
    param([string[]]$Paths)
    foreach ($path in $Paths) {
        if ($path -and (Test-Path -LiteralPath $path)) {
            return $true
        }
    }
    return $false
}

function Add-Detection {
    param(
        [string]$Id,
        [string]$Label,
        [bool]$Found
    )

    if ($Found) {
        [void]$script:Detected.Add($Id)
        Write-Host "$script:Green$script:Bold  [+]$script:Reset $script:White$Label$script:Reset"
    } else {
        Write-Host "$script:Gray  [ ] $Label$script:Reset"
    }
}

function Normalize-Path {
    param([string]$Path)
    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $null
    }

    try {
        return [System.IO.Path]::GetFullPath($Path).TrimEnd([char[]]"\/").ToLowerInvariant()
    } catch {
        return $Path.TrimEnd([char[]]"\/").ToLowerInvariant()
    }
}

function Get-GitRoot {
    param([string]$Path)

    if (-not (Test-Command "git") -or [string]::IsNullOrWhiteSpace($Path)) {
        return $null
    }

    $candidate = $Path
    while ($candidate -and -not (Test-Path -LiteralPath $candidate)) {
        $parent = Split-Path -Parent $candidate
        if ([string]::IsNullOrWhiteSpace($parent) -or $parent -eq $candidate) {
            return $null
        }
        $candidate = $parent
    }

    if (-not $candidate) {
        return $null
    }

    $oldErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "SilentlyContinue"
    try {
        $root = & git -C $candidate rev-parse --show-toplevel 2>$null
    } finally {
        $ErrorActionPreference = $oldErrorActionPreference
    }

    if ($LASTEXITCODE -eq 0 -and $root) {
        return [System.IO.Path]::GetFullPath(($root | Select-Object -First 1))
    }
    return $null
}

function Test-ExternalGitTarget {
    param(
        [string]$Source,
        [string]$Destination
    )

    $destinationDir = Split-Path -Parent $Destination
    if (-not (Test-Path -LiteralPath $destinationDir)) {
        return $false
    }

    $sourceRoot = Get-GitRoot -Path (Split-Path -Parent $Source)
    $destinationRoot = Get-GitRoot -Path $destinationDir
    if (-not $sourceRoot -or -not $destinationRoot) {
        return $false
    }

    return (Normalize-Path $sourceRoot) -ne (Normalize-Path $destinationRoot)
}

function Copy-SilkFile {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Label
    )

    if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
        Write-Fail "${Label}: source not found"
        [void]$script:Failed.Add($Label)
        return $false
    }

    $externalGitTarget = Test-ExternalGitTarget -Source $Source -Destination $Destination
    if ($externalGitTarget -and -not (Test-Path -LiteralPath $Destination)) {
        Write-Dim "${Label}: skipped new file in git repo"
        [void]$script:Skipped.Add($Label)
        return $false
    }

    if ($DryRun) {
        Write-Dim "dry-run: $Source -> $Destination"
        [void]$script:Installed.Add($Label)
        return $true
    }

    $destinationDir = Split-Path -Parent $Destination
    if (-not (Test-Path -LiteralPath $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
    }

    if ((Test-Path -LiteralPath $Destination) -and -not $externalGitTarget) {
        Copy-Item -LiteralPath $Destination -Destination "$Destination.silkcircuit.bak" -Force
    }

    try {
        Copy-Item -LiteralPath $Source -Destination $Destination -Force
        [void]$script:Installed.Add($Label)
        return $true
    } catch {
        Write-Fail "${Label}: $($_.Exception.Message)"
        [void]$script:Failed.Add($Label)
        return $false
    }
}

function Copy-SilkDirectory {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Label
    )

    if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
        Write-Fail "${Label}: source not found"
        [void]$script:Failed.Add($Label)
        return $false
    }

    if ($DryRun) {
        Write-Dim "dry-run: $Source -> $Destination"
        [void]$script:Installed.Add($Label)
        return $true
    }

    if (-not (Test-Path -LiteralPath $Destination)) {
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    }

    try {
        Get-ChildItem -LiteralPath $Source -Force | ForEach-Object {
            Copy-Item -LiteralPath $_.FullName -Destination $Destination -Recurse -Force
        }
        [void]$script:Installed.Add($Label)
        return $true
    } catch {
        Write-Fail "${Label}: $($_.Exception.Message)"
        [void]$script:Failed.Add($Label)
        return $false
    }
}

function Get-WindowsTerminalStateDirs {
    $packageNames = @(
        "Microsoft.WindowsTerminal_8wekyb3d8bbwe",
        "Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe"
    )

    $dirs = @()
    foreach ($packageName in $packageNames) {
        $dirs += Join-PathParts $script:LocalAppData "Packages" $packageName "LocalState"
    }
    return $dirs
}

function Test-AstroNvim {
    $nvimConfig = Join-PathParts $script:LocalAppData "nvim"
    $knownFiles = @(
        (Join-PathParts $nvimConfig "lua" "astronvim" "init.lua"),
        (Join-PathParts $nvimConfig "lua" "community.lua")
    )

    if (Test-AnyPath $knownFiles) {
        return $true
    }

    return $false
}

function Get-K9sConfigDir {
    if (Test-Command "k9s") {
        $info = & k9s info 2>$null
        foreach ($line in $info) {
            $plain = $line -replace "`e\[[0-9;]*m", ""
            if ($plain -match "^\s*Config:\s*(.+)$") {
                $configPath = $matches[1].Trim()
                if ($configPath) {
                    return Split-Path -Parent $configPath
                }
            }
        }
    }

    $candidates = @(
        (Join-PathParts $script:LocalAppData "k9s"),
        (Join-PathParts $script:AppData "k9s"),
        (Join-PathParts $script:HomeConfig "k9s")
    )
    foreach ($candidate in $candidates) {
        if (Test-Path -LiteralPath $candidate) {
            return $candidate
        }
    }

    return Join-PathParts $script:LocalAppData "k9s"
}

function Set-K9sSkin {
    param([string]$ConfigPath)

    if ($DryRun) {
        Write-Dim "dry-run: would set skin to silkcircuit in $ConfigPath"
        return
    }

    $configDir = Split-Path -Parent $ConfigPath
    if (-not (Test-Path -LiteralPath $configDir)) {
        New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    }

    if (-not (Test-Path -LiteralPath $ConfigPath)) {
        Set-Content -LiteralPath $ConfigPath -Value "k9s:`r`n  ui:`r`n    skin: silkcircuit`r`n" -Encoding UTF8
        return
    }

    Copy-Item -LiteralPath $ConfigPath -Destination "$ConfigPath.silkcircuit.bak" -Force
    $content = Get-Content -LiteralPath $ConfigPath -Raw
    if ($content -match "(?m)^\s*skin:\s*") {
        $content = [regex]::Replace($content, "(?m)^(\s*)skin:\s*.*$", '${1}skin: silkcircuit')
    } elseif ($content -match "(?m)^(\s*)ui:\s*$") {
        $indent = $matches[1]
        $uiPattern = [regex]"(?m)^(\s*)ui:\s*$"
        $content = $uiPattern.Replace($content, "${indent}ui:`r`n${indent}  skin: silkcircuit", 1)
    } else {
        $content = $content.TrimEnd() + "`r`n`r`nk9s:`r`n  ui:`r`n    skin: silkcircuit`r`n"
    }

    Set-Content -LiteralPath $ConfigPath -Value $content -Encoding UTF8
}

function Detect-All {
    Write-Host ""

    Add-Detection "windows-terminal" "Windows Terminal" (
        (Test-Command "wt") -or (Test-AnyPath (Get-WindowsTerminalStateDirs))
    )

    Add-Detection "ghostty" "Ghostty" (
        (Test-Command "ghostty") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "ghostty"),
            (Join-PathParts $script:AppData "com.mitchellh.ghostty"),
            (Join-PathParts $script:LocalAppData "ghostty")
        ))
    )

    Add-Detection "alacritty" "Alacritty" (
        (Test-Command "alacritty") -or
        (Test-AnyPath @((Join-PathParts $script:AppData "alacritty")))
    )

    Add-Detection "btop" "btop" (
        (Test-Command "btop") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "btop"),
            (Join-PathParts $script:HomeConfig "btop")
        ))
    )

    Add-Detection "k9s" "k9s" (
        (Test-Command "k9s") -or
        (Test-AnyPath @(
            (Join-PathParts $script:LocalAppData "k9s"),
            (Join-PathParts $script:AppData "k9s"),
            (Join-PathParts $script:HomeConfig "k9s")
        ))
    )

    Add-Detection "fzf" "fzf" (Test-Command "fzf")

    Add-Detection "fastfetch" "fastfetch" (
        (Test-Command "fastfetch") -or
        (Test-AnyPath @(
            (Join-PathParts $script:LocalAppData "fastfetch"),
            (Join-PathParts $script:HomeConfig "fastfetch")
        ))
    )

    Add-Detection "starship" "Starship" (
        (Test-Command "starship") -or
        (Test-AnyPath @(
            $env:STARSHIP_CONFIG,
            (Join-PathParts $script:HomeConfig "starship.toml")
        ))
    )

    Add-Detection "tmux" "tmux" (Test-Command "tmux")
    Add-Detection "bat" "bat" (Test-Command "bat")
    Add-Detection "lsd" "lsd" (Test-Command "lsd")
    Add-Detection "procs" "procs" (Test-Command "procs")

    Add-Detection "atuin" "Atuin" (
        (Test-Command "atuin") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "atuin"),
            (Join-PathParts $script:HomeConfig "atuin")
        ))
    )

    Add-Detection "lazygit" "lazygit" (
        (Test-Command "lazygit") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "lazygit"),
            (Join-PathParts $script:HomeConfig "lazygit")
        ))
    )

    Add-Detection "git" "Git" (Test-Command "git")
    if (Test-Command "delta") {
        Write-Host "$script:Green$script:Bold  [+]$script:Reset $script:White  delta (git pager)$script:Reset"
    }

    Add-Detection "neovim" "Neovim" (
        (Test-Command "nvim") -or
        (Test-AnyPath @(
            (Join-PathParts $script:LocalAppData "nvim"),
            (Join-PathParts $script:LocalAppData "nvim-data")
        ))
    )

    if (Test-AstroNvim) {
        [void]$script:Detected.Add("astronvim")
        Write-Host "$script:Green$script:Bold  [+]$script:Reset $script:White  AstroNvim$script:Reset"
    }

    Add-Detection "vscode" "VS Code" (
        (Test-Command "code") -or
        (Test-Command "code-insiders") -or
        (Test-AnyPath @(
            (Join-PathParts $script:HomeDir ".vscode" "extensions"),
            (Join-PathParts $script:HomeDir ".vscode-insiders" "extensions")
        ))
    )

    Add-Detection "slack" "Slack" (
        (Test-Command "slack") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "Slack"),
            (Join-PathParts $script:LocalAppData "slack")
        ))
    )

    Write-Host ""
    Write-Host "$script:Green$script:Bold  $($script:Detected.Count)$script:Reset$script:White apps detected$script:Reset"
    Write-Host ""
}

function Install-WindowsTerminal {
    Write-Host "$script:Purple$script:Bold  >> Windows Terminal$script:Reset"

    $target = Join-Path $script:ConfigRoot "windows-terminal.json"
    if (Copy-SilkFile (Join-Path $script:ExtrasDir "windows-terminal.json") $target "windows-terminal") {
        Write-Success "Windows Terminal scheme installed"
        Write-Dim "Import into Windows Terminal settings.json from: $target"
    }
}

function Install-Ghostty {
    Write-Host "$script:Purple$script:Bold  >> Ghostty$script:Reset"

    $themeDir = Join-PathParts $script:AppData "ghostty" "themes"
    $count = 0
    Get-ChildItem -LiteralPath (Join-Path $script:ExtrasDir "ghostty") -File -Filter "silkcircuit-*" | ForEach-Object {
        $target = Join-Path $themeDir $_.Name
        if (Copy-SilkFile $_.FullName $target "ghostty:$($_.Name)") {
            $count++
        }
    }
    Write-Success "Installed $count Ghostty themes"
    Write-Dim "Activate: theme = silkcircuit-neon"
}

function Install-Alacritty {
    Write-Host "$script:Purple$script:Bold  >> Alacritty$script:Reset"

    $themeDir = Join-PathParts $script:AppData "alacritty" "themes"
    Copy-SilkFile (Join-Path $script:ExtrasDir "alacritty.yml") (Join-Path $themeDir "silkcircuit.yml") "alacritty:dark" | Out-Null
    Copy-SilkFile (Join-Path $script:ExtrasDir "alacritty-dawn.yml") (Join-Path $themeDir "silkcircuit-dawn.yml") "alacritty:dawn" | Out-Null
    Write-Success "Installed Alacritty themes"
    Write-Dim "Import in alacritty.toml: import = [`"$($themeDir -replace '\\', '/')/silkcircuit.yml`"]"
}

function Install-Btop {
    Write-Host "$script:Purple$script:Bold  >> btop$script:Reset"

    $themeDir = Join-PathParts $script:AppData "btop" "themes"
    $count = 0
    Get-ChildItem -LiteralPath (Join-Path $script:ExtrasDir "btop") -File -Filter "silkcircuit_*.theme" | ForEach-Object {
        if (Copy-SilkFile $_.FullName (Join-Path $themeDir $_.Name) "btop:$($_.Name)") {
            $count++
        }
    }
    Write-Success "Installed $count btop themes"
    Write-Dim "Select in btop: Esc -> Options -> Color theme"
}

function Install-K9s {
    Write-Host "$script:Purple$script:Bold  >> k9s$script:Reset"

    $k9sDir = Get-K9sConfigDir
    $skinDir = Join-Path $k9sDir "skins"
    $count = 0
    Get-ChildItem -LiteralPath (Join-Path $script:ExtrasDir "k9s") -File -Filter "silkcircuit*.yaml" | ForEach-Object {
        if (Copy-SilkFile $_.FullName (Join-Path $skinDir $_.Name) "k9s:$($_.Name)") {
            $count++
        }
    }

    Set-K9sSkin (Join-Path $k9sDir "config.yaml")
    Write-Success "Installed $count k9s skins"
    Write-Dim "Active skin: silkcircuit"
}

function Install-Fzf {
    Write-Host "$script:Purple$script:Bold  >> fzf$script:Reset"

    $target = Join-Path $script:ConfigRoot "fzf.ps1"
    if (Copy-SilkFile (Join-Path $script:ExtrasDir "fzf.ps1") $target "fzf") {
        Write-Success "Installed fzf PowerShell theme"
        Write-Dim "Add to profile: . `"$target`""
    }
}

function Install-Git {
    Write-Host "$script:Purple$script:Bold  >> Git$script:Reset"

    $target = Join-Path $script:ConfigRoot "gitconfig"
    if (Copy-SilkFile (Join-Path $script:ExtrasDir "gitconfig") $target "git") {
        $includes = & git config --global --get-all include.path 2>$null
        $alreadyIncluded = $false
        foreach ($include in $includes) {
            if ((Normalize-Path $include) -eq (Normalize-Path $target)) {
                $alreadyIncluded = $true
                break
            }
        }

        if ($alreadyIncluded) {
            Write-Success "Git theme already configured"
        } elseif ($DryRun) {
            Write-Success "Git theme (dry-run: would add include to .gitconfig)"
        } else {
            & git config --global --add include.path $target
            Write-Success "Installed Git theme"
        }

        if (-not (Test-Command "delta")) {
            Write-Dim "Tip: install delta for enhanced git diffs"
        }
    }
}

function Install-Starship {
    Write-Host "$script:Purple$script:Bold  >> Starship$script:Reset"

    $target = if ($env:STARSHIP_CONFIG) {
        $env:STARSHIP_CONFIG
    } else {
        Join-Path $script:HomeConfig "starship.toml"
    }

    if (Copy-SilkFile (Join-PathParts $script:ExtrasDir "starship" "starship.toml") $target "starship") {
        Write-Success "Installed Starship config"
    }
}

function Install-Tmux {
    Write-Host "$script:Purple$script:Bold  >> tmux$script:Reset"

    $target = Join-Path $script:HomeDir ".tmux.conf"
    if ((Test-Path -LiteralPath $target) -and ((Get-Content -LiteralPath $target -Raw) -match "silkcircuit")) {
        Write-Success "tmux already has SilkCircuit theme"
        [void]$script:Installed.Add("tmux")
        return
    }

    if (Copy-SilkFile (Join-Path $script:ExtrasDir "tmux.conf") $target "tmux") {
        Write-Success "Installed tmux config"
    }
}

function Install-Bat {
    Write-Host "$script:Purple$script:Bold  >> bat$script:Reset"

    $configDir = (& bat --config-dir 2>$null | Select-Object -First 1)
    if (-not $configDir) {
        $configDir = Join-Path $script:AppData "bat"
    }

    $themeDir = Join-Path $configDir "themes"
    if (Copy-SilkFile (Join-PathParts $script:ExtrasDir "bat" "SilkCircuit.tmTheme") (Join-Path $themeDir "SilkCircuit.tmTheme") "bat:theme") {
        Copy-SilkFile (Join-PathParts $script:ExtrasDir "bat" "config") (Join-Path $configDir "config") "bat:config" | Out-Null
        if (-not $DryRun) {
            & bat cache --build *> $null
        }
        Write-Success "Installed bat theme"
    }
}

function Install-Lsd {
    Write-Host "$script:Purple$script:Bold  >> lsd$script:Reset"

    $configDir = Join-Path $script:AppData "lsd"
    Copy-SilkFile (Join-PathParts $script:ExtrasDir "lsd" "colors.yaml") (Join-Path $configDir "colors.yaml") "lsd:colors" | Out-Null
    Copy-SilkFile (Join-PathParts $script:ExtrasDir "lsd" "config.yaml") (Join-Path $configDir "config.yaml") "lsd:config" | Out-Null
    Write-Success "Installed lsd theme"
}

function Install-Procs {
    Write-Host "$script:Purple$script:Bold  >> procs$script:Reset"

    $target = Join-PathParts $script:AppData "procs" "config.toml"
    if (Copy-SilkFile (Join-PathParts $script:ExtrasDir "procs" "config.toml") $target "procs") {
        Write-Success "Installed procs config"
    }
}

function Install-Atuin {
    Write-Host "$script:Purple$script:Bold  >> Atuin$script:Reset"

    $target = Join-PathParts $script:HomeConfig "atuin" "themes" "silkcircuit.toml"
    if (Copy-SilkFile (Join-PathParts $script:ExtrasDir "atuin" "silkcircuit.toml") $target "atuin") {
        Write-Success "Installed Atuin theme"
        Write-Dim "Add to atuin config.toml: theme = `"silkcircuit`""
    }
}

function Install-Lazygit {
    Write-Host "$script:Purple$script:Bold  >> lazygit$script:Reset"

    $configDir = Join-Path $script:AppData "lazygit"
    $target = Join-Path $configDir "config.yml"

    if ((Test-Path -LiteralPath $target) -and ((Get-Content -LiteralPath $target -Raw) -match "silkcircuit|neonPurple|#e135ff")) {
        Write-Success "lazygit already has SilkCircuit theme"
        [void]$script:Installed.Add("lazygit")
        return
    }

    if ((Test-Path -LiteralPath $target) -and ((Get-Content -LiteralPath $target -Raw) -match "(?m)^gui:")) {
        Write-Warn "Existing lazygit config found - theme file saved separately"
        Copy-SilkFile (Join-PathParts $script:ExtrasDir "lazygit" "config.yml") (Join-Path $configDir "silkcircuit-theme.yml") "lazygit:theme-ref" | Out-Null
        Write-Dim "Merge theme settings from: $(Join-Path $configDir "silkcircuit-theme.yml")"
        return
    }

    if (Copy-SilkFile (Join-PathParts $script:ExtrasDir "lazygit" "config.yml") $target "lazygit") {
        Write-Success "Installed lazygit theme"
    }
}

function Install-Fastfetch {
    Write-Host "$script:Purple$script:Bold  >> fastfetch$script:Reset"

    $configDir = if (Test-Path -LiteralPath (Join-Path $script:LocalAppData "fastfetch")) {
        Join-Path $script:LocalAppData "fastfetch"
    } else {
        Join-Path $script:HomeConfig "fastfetch"
    }

    if (Copy-SilkFile (Join-PathParts $script:ExtrasDir "fastfetch" "config.jsonc") (Join-Path $configDir "config.jsonc") "fastfetch") {
        Write-Success "Installed fastfetch config"
    }
}

function Install-VSCode {
    Write-Host "$script:Purple$script:Bold  >> VS Code$script:Reset"

    $extensionDirs = @(
        (Join-PathParts $script:HomeDir ".vscode" "extensions"),
        (Join-PathParts $script:HomeDir ".vscode-insiders" "extensions")
    )

    $extensionDir = $null
    foreach ($candidate in $extensionDirs) {
        if (Test-Path -LiteralPath $candidate) {
            $extensionDir = $candidate
            break
        }
    }

    if (-not $extensionDir) {
        Write-Warn "VS Code extensions directory not found"
        Write-Dim "Install from the VS Code Marketplace or copy extras/vscode manually"
        [void]$script:Skipped.Add("vscode")
        return
    }

    $destination = Join-Path $extensionDir "silkcircuit-theme"
    if (Copy-SilkDirectory (Join-Path $script:ExtrasDir "vscode") $destination "vscode") {
        Write-Success "Installed VS Code theme"
        Write-Dim "Restart VS Code and select: SilkCircuit Neon"
    }
}

function Install-Slack {
    Write-Host "$script:Purple$script:Bold  >> Slack$script:Reset"

    $target = Join-Path $script:ConfigRoot "slack-theme.txt"
    if (Copy-SilkFile (Join-Path $script:ExtrasDir "slack-theme.txt") $target "slack") {
        Write-Success "Slack theme reference installed"
        Write-Dim "Open: Preferences -> Themes -> paste colors from $target"
    }
}

function Install-Neovim {
    Write-Host "$script:Purple$script:Bold  >> Neovim$script:Reset"

    $searchRoots = @(
        (Join-PathParts $script:LocalAppData "nvim"),
        (Join-PathParts $script:LocalAppData "nvim-data")
    )

    foreach ($root in $searchRoots) {
        if ((Test-Path -LiteralPath $root) -and (Get-ChildItem -LiteralPath $root -Recurse -Filter "*.lua" -ErrorAction SilentlyContinue | Where-Object { $_.FullName -match "silkcircuit" } | Select-Object -First 1)) {
            Write-Success "SilkCircuit already installed in Neovim"
            [void]$script:Installed.Add("neovim")
            return
        }
    }

    Write-Info "Add to your plugin manager:"
    Write-Dim '{ "hyperb1iss/silkcircuit", lazy = false, priority = 1000 }'
    [void]$script:Skipped.Add("neovim")
}

function Install-AstroNvim {
    Write-Host "$script:Purple$script:Bold  >> AstroNvim$script:Reset"

    $destination = Join-PathParts $script:LocalAppData "nvim" "lua" "plugins"
    if (-not (Test-Path -LiteralPath $destination) -and -not $DryRun) {
        Write-Warn "AstroNvim plugins directory not found"
        [void]$script:Skipped.Add("astronvim")
        return
    }

    $count = 0
    Get-ChildItem -LiteralPath (Join-PathParts $script:ExtrasDir "astronvim" "plugins") -File -Filter "*.lua" | ForEach-Object {
        if (Copy-SilkFile $_.FullName (Join-Path $destination $_.Name) "astronvim:$($_.Name)") {
            $count++
        }
    }
    Write-Success "Installed $count AstroNvim plugin configs"
}

function Run-Installs {
    Write-Host "$script:Purple$script:Bold  INSTALLING$script:Reset$script:Cyan >> all variants$script:Reset"
    Write-NeonLine 40
    Write-Host ""

    foreach ($app in $script:Detected) {
        switch ($app) {
            "windows-terminal" { Install-WindowsTerminal }
            "ghostty" { Install-Ghostty }
            "alacritty" { Install-Alacritty }
            "btop" { Install-Btop }
            "k9s" { Install-K9s }
            "fzf" { Install-Fzf }
            "fastfetch" { Install-Fastfetch }
            "starship" { Install-Starship }
            "tmux" { Install-Tmux }
            "bat" { Install-Bat }
            "lsd" { Install-Lsd }
            "procs" { Install-Procs }
            "atuin" { Install-Atuin }
            "lazygit" { Install-Lazygit }
            "git" { Install-Git }
            "vscode" { Install-VSCode }
            "slack" { Install-Slack }
            "neovim" { Install-Neovim }
            "astronvim" { Install-AstroNvim }
        }
        Write-Host ""
    }
}

function Show-Summary {
    Write-NeonLine 50
    Write-Host "$script:Purple$script:Bold  TRANSMISSION COMPLETE$script:Reset"
    Write-NeonLine 50
    Write-Host ""

    if ($script:Installed.Count -gt 0) {
        Write-Host "$script:Green$script:Bold  Installed ($($script:Installed.Count))$script:Reset"
        foreach ($item in $script:Installed) {
            Write-Host "$script:Green    + $item$script:Reset"
        }
        Write-Host ""
    }

    if ($script:Skipped.Count -gt 0) {
        Write-Host "$script:Yellow  Skipped ($($script:Skipped.Count))$script:Reset"
        foreach ($item in $script:Skipped) {
            Write-Host "$script:Yellow    ~ $item$script:Reset"
        }
        Write-Host ""
    }

    if ($script:Failed.Count -gt 0) {
        Write-Host "$script:Red  Failed ($($script:Failed.Count))$script:Reset"
        foreach ($item in $script:Failed) {
            Write-Host "$script:Red    x $item$script:Reset"
        }
        Write-Host ""
    }

    Write-Host "$script:Cyan  Your Windows environment is now running on SilkCircuit.$script:Reset"
    Write-Host "$script:Gray  Backups saved as *.silkcircuit.bak where applicable.$script:Reset"
    Write-Host ""
}

function Show-Usage {
    $scriptName = Split-Path -Leaf $MyInvocation.ScriptName
    if (-not $scriptName) {
        $scriptName = "install.ps1"
    }

    Write-Host "$script:Purple$script:Bold SilkCircuit Windows Installer$script:Reset"
    Write-Host ""
    Write-Host "$script:White Usage:$script:Reset .\$scriptName [options]"
    Write-Host ""
    Write-Host "$script:White Options:$script:Reset"
    Write-Host "$script:Cyan   -DryRun, -n$script:Reset  Show what would be installed"
    Write-Host "$script:Cyan   -Yes, -y$script:Reset     Skip confirmation prompts"
    Write-Host "$script:Cyan   -Help, -h$script:Reset    Show this help"
    Write-Host ""
}

function Confirm-Install {
    if ($Yes) {
        return
    }

    Write-Host "$script:White  Install SilkCircuit for $($script:Detected.Count) detected apps? $script:Reset" -NoNewline
    Write-Host "$script:Gray[Y/n] $script:Reset" -NoNewline
    $answer = Read-Host
    if ($answer -match "^[nN]") {
        Write-Host ""
        Write-Host "$script:Gray  Aborted.$script:Reset"
        exit 0
    }
    Write-Host ""
}

function Main {
    if ($Help) {
        Show-Usage
        return
    }

    if ($env:OS -ne "Windows_NT") {
        Write-Warn "install.ps1 targets Windows. Use ./install.sh on Unix-like systems."
        exit 1
    }

    Show-Banner
    Detect-All
    Confirm-Install

    if ($script:Detected.Count -eq 0) {
        Write-Warn "No supported apps detected"
        return
    }

    if ($DryRun) {
        Write-Host "$script:Yellow$script:Bold  DRY RUN MODE$script:Reset$script:Gray - no files will be modified$script:Reset"
        Write-Host ""
    }

    Run-Installs
    Show-Summary
}

Main
