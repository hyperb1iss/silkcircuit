local M = {}

local TEMPLATE = [[
background = ${bg}
foreground = ${fg}
cursor-color = ${cyan}
cursor-text = ${bg}
selection-background = ${bg_visual}
selection-foreground = ${fg}
split-divider-color = ${border}

# Normal colors
palette = 0=${terminal_black}
palette = 1=${terminal_red}
palette = 2=${terminal_green}
palette = 3=${terminal_yellow}
palette = 4=${terminal_blue}
palette = 5=${terminal_magenta}
palette = 6=${terminal_cyan}
palette = 7=${terminal_white}

# Bright colors
palette = 8=${terminal_bright_black}
palette = 9=${terminal_bright_red}
palette = 10=${terminal_bright_green}
palette = 11=${terminal_bright_yellow}
palette = 12=${terminal_bright_blue}
palette = 13=${terminal_bright_magenta}
palette = 14=${terminal_bright_cyan}
palette = 15=${terminal_bright_white}
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
