-- foot wants bare 6-digit hex with no '#', and since 1.26 it splits its colours
-- into [colors-dark] and [colors-light] so a single config can hold both and
-- switch at runtime. Each variant lands in the section its appearance calls
-- for, which is what foot's own bundled themes do.

local M = {}

local TEMPLATE = [[
[colors-${meta.appearance}]
foreground=${hex_nohash.fg}
background=${hex_nohash.bg}

# Text colour first, then the cursor block itself.
cursor=${hex_nohash.bg} ${hex_nohash.cyan}

selection-foreground=${hex_nohash.fg}
selection-background=${hex_nohash.bg_visual}

# Regular
regular0=${hex_nohash.terminal_black}
regular1=${hex_nohash.terminal_red}
regular2=${hex_nohash.terminal_green}
regular3=${hex_nohash.terminal_yellow}
regular4=${hex_nohash.terminal_blue}
regular5=${hex_nohash.terminal_magenta}
regular6=${hex_nohash.terminal_cyan}
regular7=${hex_nohash.terminal_white}

# Bright
bright0=${hex_nohash.terminal_bright_black}
bright1=${hex_nohash.terminal_bright_red}
bright2=${hex_nohash.terminal_bright_green}
bright3=${hex_nohash.terminal_bright_yellow}
bright4=${hex_nohash.terminal_bright_blue}
bright5=${hex_nohash.terminal_bright_magenta}
bright6=${hex_nohash.terminal_bright_cyan}
bright7=${hex_nohash.terminal_bright_white}

# URL mode, scrollback search, and the visual bell. The paired options take a
# foreground and then a background.
urls=${hex_nohash.cyan}
jump-labels=${hex_nohash.bg} ${hex_nohash.yellow}
scrollback-indicator=${hex_nohash.bg} ${hex_nohash.purple}
search-box-match=${hex_nohash.bg} ${hex_nohash.cyan}
search-box-no-match=${hex_nohash.bg} ${hex_nohash.red}
flash=${hex_nohash.yellow}
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
