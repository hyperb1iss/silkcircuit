local M = {}

local TEMPLATE = [==[
[colors.primary]
background = "${bg}"
foreground = "${fg}"
dim_foreground = "${fg_dark}"
bright_foreground = "${fg_light}"

[colors.cursor]
text = "${bg}"
cursor = "${cyan}"

[colors.vi_mode_cursor]
text = "${bg}"
cursor = "${purple}"

[colors.selection]
text = "${fg}"
background = "${bg_visual}"

[colors.search.matches]
foreground = "${bg}"
background = "${yellow}"

[colors.search.focused_match]
foreground = "${bg}"
background = "${cyan}"

[colors.footer_bar]
foreground = "${fg}"
background = "${bg_highlight}"

[colors.hints.start]
foreground = "${bg}"
background = "${yellow}"

[colors.hints.end]
foreground = "${bg}"
background = "${cyan}"

[colors.normal]
black = "${terminal_black}"
red = "${terminal_red}"
green = "${terminal_green}"
yellow = "${terminal_yellow}"
blue = "${terminal_blue}"
magenta = "${terminal_magenta}"
cyan = "${terminal_cyan}"
white = "${terminal_white}"

[colors.bright]
black = "${terminal_bright_black}"
red = "${terminal_bright_red}"
green = "${terminal_bright_green}"
yellow = "${terminal_bright_yellow}"
blue = "${terminal_bright_blue}"
magenta = "${terminal_bright_magenta}"
cyan = "${terminal_bright_cyan}"
white = "${terminal_bright_white}"

[[colors.indexed_colors]]
index = 16
color = "${orange}"

[[colors.indexed_colors]]
index = 17
color = "${coral}"
]==]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
