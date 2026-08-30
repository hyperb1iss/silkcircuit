local M = {}

local TEMPLATE = [[
name: "${meta.name}"
accent: "${purple}"
background: "${bg}"
foreground: "${fg}"
cursor: "${cyan}"
details: ${warp_details}
terminal_colors:
  normal:
    black: "${terminal_black}"
    red: "${terminal_red}"
    green: "${terminal_green}"
    yellow: "${terminal_yellow}"
    blue: "${terminal_blue}"
    magenta: "${terminal_magenta}"
    cyan: "${terminal_cyan}"
    white: "${terminal_white}"
  bright:
    black: "${terminal_bright_black}"
    red: "${terminal_bright_red}"
    green: "${terminal_bright_green}"
    yellow: "${terminal_bright_yellow}"
    blue: "${terminal_bright_blue}"
    magenta: "${terminal_bright_magenta}"
    cyan: "${terminal_bright_cyan}"
    white: "${terminal_bright_white}"
]]

function M.generate(colors)
  -- Warp asks the theme to declare its own brightness rather than infer it.
  local details = colors.meta.appearance == "light" and "lighter" or "darker"
  return require("silkcircuit.extra").template(
    TEMPLATE,
    vim.tbl_extend("force", colors, { warp_details = details })
  )
end

return M
