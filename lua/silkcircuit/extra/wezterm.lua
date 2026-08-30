local M = {}

local TEMPLATE = [[
[metadata]
name = "${meta.name}"
author = "${meta.author}"
origin_url = "${meta.url}"

[colors]
foreground = "${fg}"
background = "${bg}"
cursor_bg = "${cyan}"
cursor_fg = "${bg}"
cursor_border = "${cyan}"
compose_cursor = "${yellow}"
selection_fg = "${fg}"
selection_bg = "${bg_visual}"
scrollbar_thumb = "${bg_visual}"
split = "${border}"

ansi = [
  "${terminal_black}",
  "${terminal_red}",
  "${terminal_green}",
  "${terminal_yellow}",
  "${terminal_blue}",
  "${terminal_magenta}",
  "${terminal_cyan}",
  "${terminal_white}",
]
brights = [
  "${terminal_bright_black}",
  "${terminal_bright_red}",
  "${terminal_bright_green}",
  "${terminal_bright_yellow}",
  "${terminal_bright_blue}",
  "${terminal_bright_magenta}",
  "${terminal_bright_cyan}",
  "${terminal_bright_white}",
]

[colors.indexed]
16 = "${orange}"
17 = "${coral}"

[colors.tab_bar]
background = "${bg_dark}"
inactive_tab_edge = "${border}"

[colors.tab_bar.active_tab]
bg_color = "${bg_highlight}"
fg_color = "${fg}"
intensity = "Bold"
underline = "None"
italic = false
strikethrough = false

[colors.tab_bar.inactive_tab]
bg_color = "${bg_dark}"
fg_color = "${fg_dark}"

[colors.tab_bar.inactive_tab_hover]
bg_color = "${bg_highlight}"
fg_color = "${fg}"
italic = true

[colors.tab_bar.new_tab]
bg_color = "${bg_dark}"
fg_color = "${fg_dark}"

[colors.tab_bar.new_tab_hover]
bg_color = "${bg_highlight}"
fg_color = "${cyan}"
italic = true
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
