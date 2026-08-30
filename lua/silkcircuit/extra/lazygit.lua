-- lazygit takes every theme color as a list, because each entry may be followed
-- by attributes like `bold`. It also accepts a comma-separated list of config
-- files, so this ships the gui.theme block alone rather than a whole config.

local M = {}

local TEMPLATE = [[
# Merge this into your lazygit config, or load it alongside your own:
#   lazygit --use-config-file ~/.config/lazygit/config.yml,<this file>
# The LG_CONFIG_FILE environment variable takes the same comma-separated list.
#
# This is the theme block only. Layout and font settings such as
# gui.nerdFontsVersion, gui.showBottomLine, gui.showPanelJumps and gui.border
# are preferences rather than colors, so they stay in your own config.

gui:
  theme:
    activeBorderColor:
      - "${purple}"
      - bold
    inactiveBorderColor:
      - "${gray}"
    searchingActiveBorderColor:
      - "${cyan}"
      - bold
    optionsTextColor:
      - "${cyan}"
    selectedLineBgColor:
      - "${bg_visual}"
    cherryPickedCommitBgColor:
      - "${word_highlight_strong}"
    cherryPickedCommitFgColor:
      - "${purple}"
    markedBaseCommitBgColor:
      - "${yellow}"
    markedBaseCommitFgColor:
      - "${bg}"
    unstagedChangesColor:
      - "${red}"
    defaultFgColor:
      - "${fg}"
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
