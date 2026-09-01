local M = {}

local NEON_PROMPT = {
  background = "#1a1a2e",
  segment_1 = "#4a1a4a",
  segment_2 = "#7a2d7a",
  segment_3 = "#a040a0",
  segment_4 = "#d060d0",
  segment_5 = "#ff69b4",
  foreground_1 = "#ff99ff",
  foreground_root = "#ff4444",
  foreground_host = "#ff66ff",
  foreground_2 = "#ff99cc",
  foreground_3 = "#ff99ff",
  foreground_4 = "#ffeeff",
  foreground_warning = "#1a1a2e",
  warning = "#ffcc00",
  danger = "#ff6666",
}

local function prompt_colors(colors)
  if colors.meta.variant == "neon" then
    return NEON_PROMPT
  end

  return {
    background = colors.bg,
    segment_1 = colors.purple_dark,
    segment_2 = colors.purple,
    segment_3 = colors.pink_bright,
    segment_4 = colors.pink,
    segment_5 = colors.cyan,
    foreground_1 = colors.bg,
    foreground_root = colors.red,
    foreground_host = colors.bg,
    foreground_2 = colors.bg,
    foreground_3 = colors.bg,
    foreground_4 = colors.bg,
    foreground_warning = colors.bg,
    warning = colors.yellow,
    danger = colors.red,
  }
end

local TEMPLATE = [==[
format = """
[](bg:${starship.background} fg:${starship.segment_1})\
$os\
$username\
$hostname\
[ ](bold bg:${starship.segment_1})\
[](bg:${starship.segment_2} fg:${starship.segment_1})\
$directory\
[](bg:${starship.segment_3} fg:${starship.segment_2})\
$git_branch\
$git_status\
[](bg:${starship.segment_4} fg:${starship.segment_3})\
$nodejs\
$python\
$rust\
$golang\
$java\
$kotlin\
$gradle\
$c\
$lua\
$kubernetes\
[](bg:${starship.segment_5} fg:${starship.segment_4})\
[](bg:${starship.background} fg:${starship.segment_5})\
$character\
"""

# Disable the blank line at the start of the prompt
add_newline = false
command_timeout = 1000

[character]
success_symbol = "[➤](bold fg:${starship.segment_5}) "
error_symbol = "[➤](bold fg:${red}) "

# OS module
[os]
format = '[ $symbol]($style)'
style = "bold fg:${starship.foreground_1} bg:${starship.segment_1}"
disabled = false

[os.symbols]
Alpine = ""
Amazon = ""
Android = ""
Arch = ""
CachyOS = ""
CentOS = ""
Debian = ""
DragonFly = "🐉"
Emscripten = "🔗"
EndeavourOS = ""
Fedora = ""
FreeBSD = ""
Garuda = ""
Gentoo = ""
HardenedBSD = "聯"
Illumos = "🐦"
Linux = ""
Macos = ""
Manjaro = ""
Mariner = ""
MidnightBSD = "🌘"
Mint = ""
NetBSD = ""
NixOS = ""
OpenBSD = ""
OpenCloudOS = "☁️"
openEuler = ""
openSUSE = ""
OracleLinux = "⊂⊃"
Pop = ""
Raspbian = ""
Redhat = ""
RedHatEnterprise = ""
Redox = "🧪"
Solus = ""
SUSE = ""
Ubuntu = ""
Unknown = ""
Windows = ""

# Username module
[username]
style_user = "bold fg:${starship.foreground_1} bg:${starship.segment_1}"
style_root = "bold fg:${starship.foreground_root} bg:${starship.segment_1}"
format = '[ $user]($style)'
disabled = false
show_always = true

# Hostname configuration for SSH awareness
[hostname]
style = "bold fg:${starship.foreground_host} bg:${starship.segment_1}"
ssh_only = true
format = '[@$hostname]($style)'
trim_at = "."
disabled = false

# Directory module
[directory]
truncation_length = 3
truncation_symbol = "…/"
style = "bold fg:${starship.foreground_2} bg:${starship.segment_2}"
format = "[ $path ]($style)"

# Git branch module
[git_branch]
symbol = " "
style = "bold fg:${starship.foreground_3} bg:${starship.segment_3}"
format = "[ $symbol$branch ]($style)"

# Git status module
# ignore_submodules: scanning submodules made this module regularly blow
# past command_timeout and drop out of the prompt entirely
[git_status]
ignore_submodules = true
style = "bold fg:${starship.foreground_3} bg:${starship.segment_3}"
format = "[$all_status]($style)"

# Node.js module
[nodejs]
symbol = " "
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
format = "[ $symbol($version) ]($style)"
disabled = false

# Python module
[python]
symbol = " "
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
format = '([ $symbol($${virtualenv}) ]($style))'
detect_extensions = ["py"]
detect_files = [
  "requirements.txt",
  "pyproject.toml",
  "Pipfile",
  "tox.ini",
  "setup.py",
]
disabled = false

# Rust module
[rust]
symbol = "󱘗 "
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
format = "[ $symbol($version) ]($style)"
disabled = false

# Go module
[golang]
symbol = "󰟓 "
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
format = "[ $symbol($version) ]($style)"
disabled = false

# Java module
[java]
symbol = "󰬷 "
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
format = "[ $symbol($version) ]($style)"
disabled = false

# Kotlin module
[kotlin]
symbol = "󱈙 "
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
format = "[ $symbol($version) ]($style)"
disabled = false

# Gradle module
[gradle]
symbol = "󱎐 "
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
format = "[ $symbol($version) ]($style)"
disabled = false

# C module
[c]
symbol = "󰙱 "
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
format = "[ $symbol($version) ]($style)"
disabled = false

# Lua module
[lua]
symbol = "󰢱 "
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
format = "[ $symbol($version) ]($style)"
disabled = false

# Kubernetes context — shouts when on prod
[kubernetes]
symbol = "󱃾 "
format = "[ $symbol$context ]($style)"
style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}"
disabled = false
contexts = [
  { context_pattern = ".*[Pp][Rr][Oo][Dd].*", context_alias = "PROD", style = "bold fg:${starship.foreground_warning} bg:${starship.warning}", symbol = " " },
  # EKS contexts — strip region (e.g., eks-us-west-2-int → eks-int)
  { context_pattern = "eks-[a-z]+-[a-z]+-\\d+-(?P<env>.*)", context_alias = "eks-$env", style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}" },
  # Fallback
  { context_pattern = ".*", style = "bold fg:${starship.foreground_4} bg:${starship.segment_4}" }
]

# Time
[time]
disabled = true
format = '󱑍 [\[ $time \]]($style) '
time_format = "%T"

# Command duration
[cmd_duration]
min_time = 500
format = "took [$duration]($style) "
style = "bold fg:${starship.danger}"

# Battery
[battery]
full_symbol = "󰁹 "
charging_symbol = "󰂄 "
discharging_symbol = "󰂃 "
unknown_symbol = "󰁽 "
empty_symbol = "󰂎 "
disabled = false

[[battery.display]]
threshold = 10
style = "bold red"

# Package version
[package]
symbol = "󰏗 "
style = "bold fg:${starship.danger}"
disabled = false

# Shell indicator
[shell]
fish_indicator = "󰈺 "
powershell_indicator = "󰨊 "
bash_indicator = "󱆃 "
zsh_indicator = "󱐋 "
unknown_indicator = "󰀣 "
style = "cyan bold"
disabled = true
]==]

function M.generate(colors)
  local variables = vim.tbl_extend("force", colors, { starship = prompt_colors(colors) })
  return require("silkcircuit.extra").template(TEMPLATE, variables)
end

return M
