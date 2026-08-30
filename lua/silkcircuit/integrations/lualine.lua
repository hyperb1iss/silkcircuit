local M = {}

-- lua/lualine/themes/silkcircuit.lua is the one definition of the statusline
-- palette. It reads the active variant when it is required, and lualine caches
-- the result, so a variant switch would otherwise leave the statusline painted
-- from the old palette until Neovim restarts.
--
-- Dropping the cache entry here, mid colorscheme load, means the module is
-- rebuilt from the new palette before lualine's own ColorScheme handler
-- re-requires it. The groups below are derived from that same table so the two
-- can never disagree, and so a lualine that loaded before the colorscheme
-- still gets the right colors.
local THEME = "lualine.themes.silkcircuit"

function M.get()
  package.loaded[THEME] = nil

  local highlights = {}
  for mode, sections in pairs(require(THEME)) do
    for section, attrs in pairs(sections) do
      highlights["lualine_" .. section .. "_" .. mode] = {
        fg = attrs.fg,
        bg = attrs.bg,
        bold = attrs.gui == "bold" or nil,
      }
    end
  end

  return highlights
end

return M
