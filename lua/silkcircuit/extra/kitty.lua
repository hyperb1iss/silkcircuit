local M = {}

local TEMPLATE = [[
# The basic colors
foreground              ${fg}
background              ${bg}
selection_foreground    ${fg}
selection_background    ${bg_visual}

# Cursor
cursor                  ${cyan}
cursor_text_color       ${bg}

# URL underline when hovering with the mouse
url_color               ${cyan}

# Window borders
active_border_color     ${border}
inactive_border_color   ${bg_highlight}
bell_border_color       ${yellow}

# Tab bar
tab_bar_background      ${bg_dark}
active_tab_foreground   ${fg}
active_tab_background   ${bg_highlight}
inactive_tab_foreground ${fg_dark}
inactive_tab_background ${bg_dark}

# The 16 terminal colors

# black
color0  ${terminal_black}
color8  ${terminal_bright_black}

# red
color1  ${terminal_red}
color9  ${terminal_bright_red}

# green
color2  ${terminal_green}
color10 ${terminal_bright_green}

# yellow
color3  ${terminal_yellow}
color11 ${terminal_bright_yellow}

# blue
color4  ${terminal_blue}
color12 ${terminal_bright_blue}

# magenta
color5  ${terminal_magenta}
color13 ${terminal_bright_magenta}

# cyan
color6  ${terminal_cyan}
color14 ${terminal_bright_cyan}

# white
color7  ${terminal_white}
color15 ${terminal_bright_white}

# Extended colors
color16 ${orange}
color17 ${coral}
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
