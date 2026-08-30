-- foot wants bare 6-digit hex with no '#', and since 1.26 it keeps two colour
-- themes in one config: [colors-dark] and [colors-light], switched at runtime
-- by a key binding or SIGUSR1/SIGUSR2.
--
-- foot picks [colors-dark] unless initial-color-theme=light is set, so a file
-- carrying only [colors-light] would silently do nothing. Every file therefore
-- fills both sections, the way foot's own bundled themes do: the variant in
-- [colors-dark], and Dawn as its light counterpart in [colors-light]. The Dawn
-- file uses Dawn on both sides, so it looks the same whichever theme is active.

local M = {}

local BODY = [[
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

local function section(appearance, colors)
  local body = require("silkcircuit.extra").template(BODY, colors)
  return "[colors-" .. appearance .. "]\n" .. body:gsub("^\n", "")
end

function M.generate(colors)
  local extra = require("silkcircuit.extra")
  local light = colors.meta.variant == "dawn" and colors or extra.colors("dawn")
  return section("dark", colors) .. "\n" .. section("light", light)
end

return M
