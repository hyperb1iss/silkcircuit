local M = {}

-- Starship resolves a style string against the active palette before it falls
-- back to its own colour names, so the prompt can name palette roles and the
-- hex values live in exactly one table at the top of the file.
--
-- Segments are bright with dark text: fg:bg on bg:<accent>. That reads on all
-- five variants, including dawn, where the accents are dark and `bg` is the
-- near-white page. The caps set no background, so they take the terminal's own
-- background rather than assuming it matches the variant.
local TEMPLATE = [==[
format = """
[](fg:purple_dark)\
$os\
$username\
$hostname\
[ ](bg:purple_dark)\
[](bg:purple fg:purple_dark)\
$directory\
[](bg:pink_bright fg:purple)\
$git_branch\
$git_status\
[](bg:pink fg:pink_bright)\
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
[](bg:cyan fg:pink)\
[](fg:cyan)\
$character\
"""

# Disable the blank line at the start of the prompt
add_newline = false
command_timeout = 1000

palette = "silkcircuit"

# Every colour the prompt uses, plus the rest of the accent roles so a local
# tweak can reach for them by name instead of pasting a hex.
[palettes.silkcircuit]
bg = "${bg}"
fg = "${fg}"
purple_dark = "${purple_dark}"
purple = "${purple}"
pink_bright = "${pink_bright}"
pink = "${pink}"
cyan = "${cyan}"
green = "${green}"
yellow = "${yellow}"
orange = "${orange}"
red = "${red}"

[character]
success_symbol = "[➤](bold fg:cyan) "
error_symbol = "[➤](bold fg:red) "

# OS module
[os]
format = '[ $symbol]($style)'
style = "bold fg:bg bg:purple_dark"
disabled = false

[os.symbols]
Alpine = ""
Amazon = ""
Android = ""
Arch = ""
CachyOS = ""
CentOS = ""
Debian = ""
DragonFly = "🐉"
Emscripten = "🔗"
EndeavourOS = ""
Fedora = ""
FreeBSD = ""
Garuda = ""
Gentoo = ""
HardenedBSD = "聯"
Illumos = "🐦"
Linux = ""
Macos = ""
Manjaro = ""
Mariner = ""
MidnightBSD = "🌘"
Mint = ""
NetBSD = ""
NixOS = ""
OpenBSD = ""
OpenCloudOS = "☁️"
openEuler = ""
openSUSE = ""
OracleLinux = "⊂⊃"
Pop = ""
Raspbian = ""
Redhat = ""
RedHatEnterprise = ""
Redox = "🧪"
Solus = ""
SUSE = ""
Ubuntu = ""
Unknown = ""
Windows = ""

# Username module. Root turns the whole segment red rather than tinting the
# text, which is the one state worth breaking the gradient for.
[username]
style_user = "bold fg:bg bg:purple_dark"
style_root = "bold fg:bg bg:red"
format = '[ $user]($style)'
disabled = false
show_always = true

# Hostname configuration for SSH awareness
[hostname]
style = "bold fg:bg bg:purple_dark"
ssh_only = true
format = '[@$hostname]($style)'
trim_at = "."
disabled = false

# Directory module
[directory]
truncation_length = 3
truncation_symbol = "…/"
style = "bold fg:bg bg:purple"
format = "[ $path ]($style)"

# Git branch module
[git_branch]
symbol = " "
style = "bold fg:bg bg:pink_bright"
format = "[ $symbol$branch ]($style)"

# Git status module
# ignore_submodules: scanning submodules made this module regularly blow
# past command_timeout and drop out of the prompt entirely
[git_status]
ignore_submodules = true
style = "bold fg:bg bg:pink_bright"
format = "[$all_status]($style)"

# Node.js module
[nodejs]
symbol = " "
style = "bold fg:bg bg:pink"
format = "[ $symbol($version) ]($style)"
disabled = false

# Python module
[python]
symbol = " "
style = "bold fg:bg bg:pink"
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
style = "bold fg:bg bg:pink"
format = "[ $symbol($version) ]($style)"
disabled = false

# Go module
[golang]
symbol = "󰟓 "
style = "bold fg:bg bg:pink"
format = "[ $symbol($version) ]($style)"
disabled = false

# Java module
[java]
symbol = "󰬷 "
style = "bold fg:bg bg:pink"
format = "[ $symbol($version) ]($style)"
disabled = false

# Kotlin module
[kotlin]
symbol = "󱈙 "
style = "bold fg:bg bg:pink"
format = "[ $symbol($version) ]($style)"
disabled = false

# Gradle module
[gradle]
symbol = "󱎐 "
style = "bold fg:bg bg:pink"
format = "[ $symbol($version) ]($style)"
disabled = false

# C module
[c]
symbol = "󰙱 "
style = "bold fg:bg bg:pink"
format = "[ $symbol($version) ]($style)"
disabled = false

# Lua module
[lua]
symbol = "󰢱 "
style = "bold fg:bg bg:pink"
format = "[ $symbol($version) ]($style)"
disabled = false

# Kubernetes context — shouts when on prod
[kubernetes]
symbol = "󱃾 "
format = "[ $symbol$context ]($style)"
style = "bold fg:bg bg:pink"
disabled = false
contexts = [
  { context_pattern = ".*[Pp][Rr][Oo][Dd].*", context_alias = "PROD", style = "bold fg:bg bg:red", symbol = " " },
  # EKS contexts — strip region (e.g., eks-us-west-2-int → eks-int)
  { context_pattern = "eks-[a-z]+-[a-z]+-\\d+-(?P<env>.*)", context_alias = "eks-$env", style = "bold fg:bg bg:pink" },
  # Fallback
  { context_pattern = ".*", style = "bold fg:bg bg:pink" }
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
style = "bold fg:red"

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
style = "bold fg:red"

# Package version
[package]
symbol = "󰏗 "
style = "bold fg:red"
disabled = false

# Shell indicator
[shell]
fish_indicator = "󰈺 "
powershell_indicator = "󰨊 "
bash_indicator = "󱆃 "
zsh_indicator = "󱐋 "
unknown_indicator = "󰀣 "
style = "bold fg:cyan"
disabled = true
]==]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
