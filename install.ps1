#requires -Version 5.1
[CmdletBinding()]
param(
    [Alias("V")]
    [ValidateSet("neon", "vibrant", "soft", "glow", "dawn", "all")]
    [string]$Variant = "all",

    [Alias("n")]
    [switch]$DryRun,

    [Alias("y")]
    [switch]$Yes,

    [Alias("h")]
    [switch]$Help
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

# Every external command this script runs is a query, and a nonzero exit is a
# legitimate answer from all of them: git config on an unset key, git rev-parse
# outside a repo, k9s info without a config. With
# $PSNativeCommandUseErrorActionPreference opted in, ErrorActionPreference of
# Stop would turn each of those answers into a fatal error mid-install.
$PSNativeCommandUseErrorActionPreference = $false

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

$script:AllVariants = @("neon", "vibrant", "soft", "glow", "dawn")
# Variants this run installs, and the one every printed "turn it on" line
# names. Tools that read a single file get the primary and nothing else.
$script:Selected = @()
$script:Primary = "neon"

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

function Resolve-Variants {
    # ValidateSet matches case-insensitively but preserves what the caller
    # typed, and every generated file name is lowercase.
    $script:Variant = $Variant.ToLowerInvariant()
    if ($Variant -eq "all") {
        $script:Selected = $script:AllVariants
        $script:Primary = "neon"
    } else {
        $script:Selected = @($Variant)
        $script:Primary = $Variant
    }
}

function Get-VariantLabel {
    param([string]$Name)
    return $Name.Substring(0, 1).ToUpperInvariant() + $Name.Substring(1)
}

# Set-Content -Encoding UTF8 writes a BOM on Windows PowerShell 5.1, which we
# would be prepending to a config the user already had. Write the bytes instead.
function Write-PlainText {
    param(
        [string]$Path,
        [string]$Content
    )

    $directory = Split-Path -Parent $Path
    if ($directory -and -not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }
    [System.IO.File]::WriteAllText($Path, $Content, (New-Object System.Text.UTF8Encoding($false)))
}

# Detection accepts a tool's config directory in any of several places, so the
# install has to land in the one that actually exists rather than assuming.
function Resolve-ToolDir {
    param(
        [string[]]$Candidates,
        [string]$Default
    )

    foreach ($candidate in $Candidates) {
        if ($candidate -and (Test-Path -LiteralPath $candidate -PathType Container)) {
            return $candidate
        }
    }
    return $Default
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

# Tools that read exactly one file cannot hold five themes at once, so `all`
# gives them neon and says as much rather than silently picking for you.
function Write-SingleSlotNote {
    param([string]$Tool)
    if ($Variant -eq "all") {
        Write-Dim "$Tool reads one file, so -Variant all installs neon here"
    }
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

    if ($Path.StartsWith("~")) {
        $Path = Join-Path $script:HomeDir $Path.Substring(1).TrimStart([char[]]"\/")
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

$script:SourceGitRoot = $null
$script:SourceGitRootResolved = $false

function Test-ExternalGitTarget {
    param(
        [string]$Source,
        [string]$Destination
    )

    $destinationDir = Split-Path -Parent $Destination
    if (-not (Test-Path -LiteralPath $destinationDir)) {
        return $false
    }

    # Every source lives in this repository, so its root is worth asking for
    # once rather than twice per copied file.
    if (-not $script:SourceGitRootResolved) {
        $script:SourceGitRoot = Get-GitRoot -Path $script:ScriptDir
        $script:SourceGitRootResolved = $true
    }
    $sourceRoot = $script:SourceGitRoot
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

    # A source that is not there is a skip, never a stop. One missing file must
    # not strand every tool that comes after it.
    if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
        Write-Warn "${Label}: $(Split-Path -Leaf $Source) not found, skipping"
        [void]$script:Skipped.Add($Label)
        return $false
    }

    # Adding an untracked file to someone's dotfiles repo is rude; replacing a
    # file that is already tracked is not, because git is their backup. This is
    # the same rule install.sh applies.
    $inExternalGit = Test-ExternalGitTarget -Source $Source -Destination $Destination
    if ($inExternalGit -and -not (Test-Path -LiteralPath $Destination -PathType Leaf)) {
        Write-Dim "${Label}: skipped new file in a git repo this installer does not own"
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

    $destinationItem = Get-Item -LiteralPath $Destination -Force -ErrorAction SilentlyContinue

    if ($destinationItem -and -not $inExternalGit) {
        try {
            Copy-Item -LiteralPath $Destination -Destination "$Destination.silkcircuit.bak" -Force -ErrorAction Stop
        } catch {
            Write-Dim "${Label}: could not back up existing config, replacing it"
        }
    }

    # Copy-Item follows a symlink and writes through to its target, which would
    # edit whatever repo the link points into. Drop the link, write a real file.
    if ($destinationItem -and $destinationItem.LinkType) {
        Remove-Item -LiteralPath $Destination -Force -ErrorAction SilentlyContinue
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

# Copy one file per selected variant. `Pattern` is the file name with `@` where
# the variant goes. Returns the number that landed.
function Copy-SilkVariants {
    param(
        [string]$SourceDir,
        [string]$DestinationDir,
        [string]$Label,
        [string]$Pattern
    )

    $count = 0
    foreach ($variant in $script:Selected) {
        $name = $Pattern.Replace("@", $variant)
        $source = Join-Path $SourceDir $name
        $destination = Join-Path $DestinationDir $name
        if (Copy-SilkFile $source $destination "${Label}:${variant}") {
            $count++
        }
    }
    return $count
}

function Get-WindowsTerminalFragmentDir {
    return Join-PathParts $script:LocalAppData "Microsoft" "Windows Terminal" "Fragments" "SilkCircuit"
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
            $plain = $line -replace "$script:Esc\[[0-9;]*m", ""
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

# Indentation of the first child under the block opened at $At, read off the
# file rather than assumed, so a config written with four spaces keeps its shape.
function Get-BlockIndent {
    param(
        [string[]]$Lines,
        [int]$At,
        [int]$Own
    )

    for ($i = $At + 1; $i -lt $Lines.Count; $i++) {
        if ($Lines[$i] -match "^\s*$") {
            continue
        }
        $width = ($Lines[$i] -replace "^(\s*).*$", '$1').Length
        if ($width -gt $Own) {
            return $width
        }
        break
    }
    return $Own + 2
}

# Point an existing k9s config at a skin without ever writing a second
# top-level "k9s:" mapping. k9s parses with gopkg.in/yaml.v3, which rejects a
# duplicate key outright, so appending a sibling block does not merely look
# untidy: it stops k9s reading its config at all. More permissive parsers keep
# only the last mapping and silently drop the rest of the user's settings.
function Set-K9sSkin {
    param(
        [string]$ConfigPath,
        [string]$Skin
    )

    if ($DryRun) {
        Write-Dim "dry-run: would set the skin to $Skin in $ConfigPath"
        return
    }

    $configDir = Split-Path -Parent $ConfigPath
    if (-not (Test-Path -LiteralPath $configDir)) {
        New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    }

    if (-not (Test-Path -LiteralPath $ConfigPath)) {
        Write-PlainText $ConfigPath "k9s:`r`n  ui:`r`n    skin: $Skin`r`n"
        return
    }

    Copy-Item -LiteralPath $ConfigPath -Destination "$ConfigPath.silkcircuit.bak" -Force

    $raw = Get-Content -LiteralPath $ConfigPath -Raw
    if (-not $raw) {
        $raw = ""
    }

    # Keep whatever line ending the file already uses; splicing CRLF into an LF
    # config leaves a mixed file and a noisy diff.
    $newline = if ($raw.Contains("`r`n")) { "`r`n" } else { "`n" }
    $lines = [string[]]($raw -split "`r?`n")
    while ($lines.Count -gt 0 -and $lines[-1] -eq "") {
        $lines = $lines[0..($lines.Count - 2)]
    }

    $skinAt = -1
    $uiAt = -1
    $rootAt = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($skinAt -lt 0 -and $lines[$i] -match "^\s*skin:") { $skinAt = $i }
        if ($uiAt -lt 0 -and $lines[$i] -match "^\s*ui:\s*$") { $uiAt = $i }
        if ($rootAt -lt 0 -and $lines[$i] -match "^k9s:\s*$") { $rootAt = $i }
    }

    $out = [System.Collections.Generic.List[string]]::new()
    if ($skinAt -ge 0) {
        $indent = ($lines[$skinAt] -replace "^(\s*).*$", '$1')
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($i -eq $skinAt) { $out.Add("${indent}skin: $Skin") } else { $out.Add($lines[$i]) }
        }
    } elseif ($uiAt -ge 0) {
        $own = ($lines[$uiAt] -replace "^(\s*).*$", '$1').Length
        $inner = " " * (Get-BlockIndent $lines $uiAt $own)
        for ($i = 0; $i -lt $lines.Count; $i++) {
            $out.Add($lines[$i])
            if ($i -eq $uiAt) { $out.Add("${inner}skin: $Skin") }
        }
    } elseif ($rootAt -ge 0) {
        $inner = " " * (Get-BlockIndent $lines $rootAt 0)
        $deeper = " " * (2 * $inner.Length)
        for ($i = 0; $i -lt $lines.Count; $i++) {
            $out.Add($lines[$i])
            if ($i -eq $rootAt) {
                $out.Add("${inner}ui:")
                $out.Add("${deeper}skin: $Skin")
            }
        }
    } else {
        foreach ($line in $lines) { $out.Add($line) }
        $out.Add("")
        $out.Add("k9s:")
        $out.Add("  ui:")
        $out.Add("    skin: $Skin")
    }

    Write-PlainText $ConfigPath (($out -join $newline) + $newline)
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
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "alacritty"),
            (Join-PathParts $script:HomeConfig "alacritty")
        ))
    )

    Add-Detection "wezterm" "WezTerm" (
        (Test-Command "wezterm") -or
        (Test-AnyPath @(
            (Join-PathParts $script:HomeConfig "wezterm"),
            (Join-PathParts $script:AppData "wezterm")
        ))
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

    Add-Detection "helix" "Helix" (
        (Test-Command "hx") -or
        (Test-Command "helix") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "helix"),
            (Join-PathParts $script:HomeConfig "helix")
        ))
    )

    Add-Detection "fzf" "fzf" (
        (Test-Command "fzf") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "fzf"),
            (Join-PathParts $script:HomeConfig "fzf")
        ))
    )

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

    Add-Detection "tmux" "tmux" (
        (Test-Command "tmux") -or
        (Test-AnyPath @((Join-PathParts $script:HomeConfig "tmux")))
    )

    Add-Detection "bat" "bat" (
        (Test-Command "bat") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "bat"),
            (Join-PathParts $script:HomeConfig "bat")
        ))
    )

    Add-Detection "lsd" "lsd" (
        (Test-Command "lsd") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "lsd"),
            (Join-PathParts $script:HomeConfig "lsd")
        ))
    )

    Add-Detection "procs" "procs" (
        (Test-Command "procs") -or
        (Test-AnyPath @(
            (Join-PathParts $script:AppData "procs"),
            (Join-PathParts $script:HomeConfig "procs")
        ))
    )

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

    $sourceDir = Join-Path $script:ExtrasDir "windows-terminal"
    $combined = Join-Path $sourceDir "silkcircuit.json"

    # silkcircuit.json is already shaped like a Windows Terminal fragment
    # ({ "schemes": [...] }), so dropping it in the Fragments directory adds
    # all five schemes without anyone editing settings.json.
    $fragment = Join-Path (Get-WindowsTerminalFragmentDir) "silkcircuit.json"
    $installed = Copy-SilkFile $combined $fragment "windows-terminal:fragment"

    # Keep a copy where it can be pasted by hand, for Windows Terminal builds
    # that predate fragment extensions.
    $staged = Join-Path $script:ConfigRoot "windows-terminal"
    $count = Copy-SilkVariants $sourceDir $staged "windows-terminal" "silkcircuit-@.json"
    [void](Copy-SilkFile $combined (Join-Path $staged "silkcircuit.json") "windows-terminal:staged")

    if ($installed) {
        Write-Success "Installed the schemes as a Windows Terminal fragment, $count staged"
        Write-Dim "The fragment carries all five schemes; Windows Terminal picks per profile"
        Write-Dim "Restart Windows Terminal, then set a profile colorScheme to SilkCircuit $(Get-VariantLabel $script:Primary)"
    } else {
        Write-Success "Staged $count Windows Terminal schemes"
    }
    Write-Dim "To paste by hand instead: $(Join-Path $staged 'silkcircuit.json')"
}

function Install-Ghostty {
    Write-Host "$script:Purple$script:Bold  >> Ghostty$script:Reset"

    $sourceDir = Join-Path $script:ExtrasDir "ghostty"
    $root = Resolve-ToolDir @(
        (Join-PathParts $script:AppData "ghostty"),
        (Join-PathParts $script:AppData "com.mitchellh.ghostty"),
        (Join-PathParts $script:LocalAppData "ghostty")
    ) (Join-PathParts $script:AppData "ghostty")
    $themeDir = Join-Path $root "themes"
    $count = Copy-SilkVariants $sourceDir $themeDir "ghostty" "silkcircuit-@"

    Write-Success "Installed $count Ghostty themes"
    Write-Dim "In the Ghostty config: theme = silkcircuit-$script:Primary"
    # Only worth suggesting when both halves of the pair actually landed.
    if ($Variant -eq "all") {
        Write-Dim "Follow the system: theme = dark:silkcircuit-neon,light:silkcircuit-dawn"
    }
}

function Install-Alacritty {
    Write-Host "$script:Purple$script:Bold  >> Alacritty$script:Reset"

    $themeDir = Join-Path (Resolve-ToolDir @(
        (Join-PathParts $script:AppData "alacritty"),
        (Join-PathParts $script:HomeConfig "alacritty")
    ) (Join-PathParts $script:AppData "alacritty")) "themes"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "alacritty") $themeDir "alacritty" "silkcircuit-@.toml"

    $import = "$($themeDir -replace '\\', '/')/silkcircuit-$script:Primary.toml"
    Write-Success "Installed $count Alacritty themes"
    Write-Dim "In alacritty.toml, under [general]: import = [`"$import`"]"
    Write-Dim "Needs Alacritty 0.13 or newer for TOML config"
}

function Install-WezTerm {
    Write-Host "$script:Purple$script:Bold  >> WezTerm$script:Reset"

    # WezTerm on Windows reads %USERPROFILE%\.config\wezterm, the same path the
    # Unix installer uses. It does not consult %APPDATA%.
    $themeDir = Join-Path (Resolve-ToolDir @(
        (Join-PathParts $script:HomeConfig "wezterm"),
        (Join-PathParts $script:AppData "wezterm")
    ) (Join-PathParts $script:HomeConfig "wezterm")) "colors"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "wezterm") $themeDir "wezterm" "silkcircuit-@.toml"

    Write-Success "Installed $count WezTerm color schemes"
    Write-Dim "In wezterm.lua: config.color_scheme = `"SilkCircuit $(Get-VariantLabel $script:Primary)`""
}

function Install-Helix {
    Write-Host "$script:Purple$script:Bold  >> Helix$script:Reset"

    $themeDir = Join-Path (Resolve-ToolDir @(
        (Join-PathParts $script:AppData "helix"),
        (Join-PathParts $script:HomeConfig "helix")
    ) (Join-PathParts $script:AppData "helix")) "themes"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "helix") $themeDir "helix" "silkcircuit-@.toml"

    Write-Success "Installed $count Helix themes"
    Write-Dim "In the Helix config.toml: theme = `"silkcircuit-$script:Primary`""
}

function Install-Btop {
    Write-Host "$script:Purple$script:Bold  >> btop$script:Reset"

    $themeDir = Join-Path (Resolve-ToolDir @(
        (Join-PathParts $script:AppData "btop"),
        (Join-PathParts $script:HomeConfig "btop")
    ) (Join-PathParts $script:AppData "btop")) "themes"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "btop") $themeDir "btop" "silkcircuit-@.theme"

    Write-Success "Installed $count btop themes"
    Write-Dim "In btop: Esc -> Options -> Color theme -> silkcircuit-$script:Primary"
}

function Install-K9s {
    Write-Host "$script:Purple$script:Bold  >> k9s$script:Reset"

    $k9sDir = Get-K9sConfigDir
    $skinDir = Join-Path $k9sDir "skins"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "k9s") $skinDir "k9s" "silkcircuit-@.yaml"

    $skin = "silkcircuit-$script:Primary"
    Set-K9sSkin (Join-Path $k9sDir "config.yaml") $skin
    Write-Success "Installed $count k9s skins"
    Write-Dim "Active skin: $skin"
}

function Install-Fzf {
    Write-Host "$script:Purple$script:Bold  >> fzf$script:Reset"

    $targetDir = Join-Path $script:ConfigRoot "fzf"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "fzf") $targetDir "fzf" "silkcircuit-@.ps1"

    $profileLine = Join-Path $targetDir "silkcircuit-$script:Primary.ps1"
    Write-Success "Installed $count fzf color sets"
    Write-Dim "Add to your profile: . `"$profileLine`""
    Write-Dim "Needs fzf 0.52 or newer for the selected-* and border color names"
}

function Install-Git {
    Write-Host "$script:Purple$script:Bold  >> Git$script:Reset"

    $targetDir = Join-Path $script:ConfigRoot "git"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "git") $targetDir "git" "silkcircuit-@.gitconfig"

    $target = Join-Path $targetDir "silkcircuit-$script:Primary.gitconfig"
    $includes = & git config --global --get-all include.path 2>$null
    $alreadyIncluded = $false
    foreach ($include in $includes) {
        if ((Normalize-Path $include) -eq (Normalize-Path $target)) {
            $alreadyIncluded = $true
            break
        }
    }

    if ($alreadyIncluded) {
        Write-Success "Installed $count Git color configs, include already in place"
    } elseif ($DryRun) {
        Write-Success "Installed $count Git color configs (dry-run: would add the include)"
    } else {
        & git config --global --add include.path $target
        Write-Success "Installed $count Git color configs and added the include"
    }

    Write-Dim "Include: git config --global --add include.path `"$target`""
    if (-not (Test-Command "delta")) {
        Write-Dim "Tip: install delta for diffs that use the matching bat theme"
    }
}

function Install-Starship {
    Write-Host "$script:Purple$script:Bold  >> Starship$script:Reset"

    $target = if ($env:STARSHIP_CONFIG) {
        $env:STARSHIP_CONFIG
    } else {
        Join-Path $script:HomeConfig "starship.toml"
    }

    $source = Join-PathParts $script:ExtrasDir "starship" "silkcircuit-$script:Primary.toml"
    if (Copy-SilkFile $source $target "starship") {
        Write-Success "Installed the Starship prompt"
        Write-Dim "Config: $target"
        Write-SingleSlotNote "Starship"
    }
}

function Install-Tmux {
    Write-Host "$script:Purple$script:Bold  >> tmux$script:Reset"

    $targetDir = Join-Path $script:HomeConfig "tmux"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "tmux") $targetDir "tmux" "silkcircuit-@.conf"

    Write-Success "Installed $count tmux themes"
    Write-Dim "In tmux.conf: source-file ~/.config/tmux/silkcircuit-$script:Primary.conf"
    Write-Dim "Needs tmux 3.4 or newer. These are colors only, no key bindings."
}

function Install-Bat {
    Write-Host "$script:Purple$script:Bold  >> bat$script:Reset"

    # Detection also fires on the config directory alone, so bat itself may not
    # be on PATH. Ask it only when it is there.
    $configDir = $null
    if (Test-Command "bat") {
        $configDir = (& bat --config-dir 2>$null | Select-Object -First 1)
    }
    if (-not $configDir) {
        $configDir = Join-Path $script:AppData "bat"
    }

    $themeDir = Join-Path $configDir "themes"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "bat") $themeDir "bat" "silkcircuit-@.tmTheme"

    if (-not $DryRun -and (Test-Command "bat")) {
        & bat cache --build *> $null
    }

    Write-Success "Installed $count bat themes"
    Write-Dim "Use it: bat --theme=silkcircuit-$script:Primary file.lua"
    Write-Dim "Or add --theme=silkcircuit-$script:Primary to $(Join-Path $configDir 'config')"
    Write-Dim "Add --italic-text=always too, the theme leans on italics"
}

function Install-Lsd {
    Write-Host "$script:Purple$script:Bold  >> lsd$script:Reset"

    $configDir = Resolve-ToolDir @(
        (Join-PathParts $script:AppData "lsd"),
        (Join-PathParts $script:HomeConfig "lsd")
    ) (Join-PathParts $script:AppData "lsd")
    # lsd reads exactly one file, and it has to be called colors.yaml.
    $source = Join-PathParts $script:ExtrasDir "lsd" "silkcircuit-$script:Primary.yaml"
    if (-not (Copy-SilkFile $source (Join-Path $configDir "colors.yaml") "lsd")) {
        return
    }

    $config = Join-Path $configDir "config.yaml"
    if ($DryRun) {
        Write-Dim "dry-run: would set color.theme to custom in $config"
    } elseif (Test-Path -LiteralPath $config) {
        if ((Get-Content -LiteralPath $config -Raw) -notmatch "theme:\s*custom") {
            Write-Dim "Add to ${config}:"
            Write-Dim "color:"
            Write-Dim "  theme: custom"
        }
    } else {
        Write-PlainText $config "color:`r`n  theme: custom`r`n"
    }

    Write-Success "Installed the lsd color file"
    Write-SingleSlotNote "lsd"
}

function Install-Procs {
    Write-Host "$script:Purple$script:Bold  >> procs$script:Reset"

    $target = Join-PathParts $script:AppData "procs" "config.toml"
    $source = Join-PathParts $script:ExtrasDir "procs" "silkcircuit-$script:Primary.toml"
    if (Copy-SilkFile $source $target "procs") {
        Write-Success "Installed the procs config"
        Write-SingleSlotNote "procs"
    }
}

function Install-Atuin {
    Write-Host "$script:Purple$script:Bold  >> Atuin$script:Reset"

    $themeDir = Join-Path (Resolve-ToolDir @(
        (Join-PathParts $script:AppData "atuin"),
        (Join-PathParts $script:HomeConfig "atuin")
    ) (Join-PathParts $script:HomeConfig "atuin")) "themes"
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "atuin") $themeDir "atuin" "silkcircuit-@.toml"

    Write-Success "Installed $count Atuin themes"
    Write-Dim "In the atuin config.toml, under [theme]: name = `"silkcircuit-$script:Primary`""
}

function Install-Lazygit {
    Write-Host "$script:Purple$script:Bold  >> lazygit$script:Reset"

    $configDir = Resolve-ToolDir @(
        (Join-PathParts $script:AppData "lazygit"),
        (Join-PathParts $script:HomeConfig "lazygit")
    ) (Join-PathParts $script:AppData "lazygit")
    $count = Copy-SilkVariants (Join-Path $script:ExtrasDir "lazygit") $configDir "lazygit" "silkcircuit-@.yml"

    $theme = Join-Path $configDir "silkcircuit-$script:Primary.yml"
    Write-Success "Installed $count lazygit themes"
    Write-Dim "Merge the gui.theme block into your lazygit config.yml, or load both:"
    Write-Dim "lazygit --use-config-file `"$(Join-Path $configDir 'config.yml'),$theme`""
}

function Install-Fastfetch {
    Write-Host "$script:Purple$script:Bold  >> fastfetch$script:Reset"

    $configDir = if (Test-Path -LiteralPath (Join-Path $script:LocalAppData "fastfetch")) {
        Join-Path $script:LocalAppData "fastfetch"
    } else {
        Join-Path $script:HomeConfig "fastfetch"
    }

    $source = Join-PathParts $script:ExtrasDir "fastfetch" "silkcircuit-$script:Primary.jsonc"
    if (Copy-SilkFile $source (Join-Path $configDir "config.jsonc") "fastfetch") {
        Write-Success "Installed the fastfetch config"
        Write-SingleSlotNote "fastfetch"
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
        Write-Success "Installed the VS Code extension"
        Write-Dim "The extension is one package carrying all five themes, so -Variant"
        Write-Dim "does not narrow it. Pick one in the editor instead:"
        Write-Dim "Restart VS Code, then Ctrl+K Ctrl+T -> SilkCircuit $(Get-VariantLabel $script:Primary)"
    }
}

function Install-Slack {
    Write-Host "$script:Purple$script:Bold  >> Slack$script:Reset"

    $sourceDir = Join-Path $script:ExtrasDir "slack"
    $targetDir = Join-Path $script:ConfigRoot "slack"
    $count = Copy-SilkVariants $sourceDir $targetDir "slack" "silkcircuit-@.txt"

    Write-Success "Staged $count Slack themes"
    Write-Dim "Preferences -> Themes -> Create a custom theme, then paste this line:"

    # The line to paste is ten hex colours, so it starts with "#" exactly like
    # the comments above it. Match its shape rather than filtering comments out.
    $source = Join-Path $sourceDir "silkcircuit-$script:Primary.txt"
    $line = $null
    if (Test-Path -LiteralPath $source) {
        $line = Get-Content -LiteralPath $source |
            Where-Object { $_ -match "^#[0-9a-fA-F]{6}(,#[0-9a-fA-F]{6}){9}$" } |
            Select-Object -Last 1
    }
    if ($line) {
        Write-Dim $line
    } else {
        Write-Dim "Could not read the colours from $source"
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
    if ($count -eq 0) {
        Write-Dim "No AstroNvim plugin configs installed"
    } else {
        Write-Success "Installed $count AstroNvim plugin configs"
    }
}

function Run-Installs {
    $scope = if ($Variant -eq "all") { "all five variants" } else { "the $Variant variant" }
    Write-Host "$script:Purple$script:Bold  INSTALLING$script:Reset$script:Cyan >> $scope$script:Reset"
    Write-NeonLine 40
    Write-Host ""

    foreach ($app in $script:Detected) {
        switch ($app) {
            "windows-terminal" { Install-WindowsTerminal }
            "ghostty" { Install-Ghostty }
            "alacritty" { Install-Alacritty }
            "wezterm" { Install-WezTerm }
            "helix" { Install-Helix }
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
    $scriptName = if ($PSCommandPath) { Split-Path -Leaf $PSCommandPath } else { "install.ps1" }

    Write-Host "$script:Purple$script:Bold SilkCircuit Windows Installer$script:Reset"
    Write-Host ""
    Write-Host "$script:White Usage:$script:Reset .\$scriptName [options]"
    Write-Host ""
    Write-Host "$script:White Options:$script:Reset"
    Write-Host "$script:Cyan   -Variant, -V$script:Reset  neon, vibrant, soft, glow, dawn, or all (default: all)"
    Write-Host "$script:Cyan   -DryRun, -n$script:Reset   Show what would be installed"
    Write-Host "$script:Cyan   -Yes, -y$script:Reset      Skip confirmation prompts"
    Write-Host "$script:Cyan   -Help, -h$script:Reset     Show this help"
    Write-Host ""
    Write-Host "$script:Gray  Tools that hold a directory of themes get every selected variant."
    Write-Host "  Tools that read a single file get neon unless -Variant says otherwise.$script:Reset"
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

    Resolve-Variants

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
