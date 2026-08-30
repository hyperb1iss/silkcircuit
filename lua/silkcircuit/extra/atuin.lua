-- Atuin maps a fixed set of "meanings" to foreground colors. Anything left out
-- falls back to atuin's built-in defaults, which are ANSI palette slots, so the
-- syntax meanings are spelled out here to keep the search bar on-palette even
-- when the surrounding terminal is not.

local M = {}

local TEMPLATE = [[
# Install to ~/.config/atuin/themes/${meta.slug}.toml, then select it with
# `name = "${meta.slug}"` under [theme] in ~/.config/atuin/config.toml.

[theme]
name = "${meta.slug}"

[colors]
# General text
Base = "${fg}"
# De-emphasised text
Muted = "${gray}"
# Emphasised entries
Important = "${purple}"
# Section headings
Title = "${cyan}"
# Help text and hints
Guidance = "${blue_gray}"
# Metadata shown beside a result
Annotation = "${coral}"

# Log levels
AlertInfo = "${green}"
AlertWarn = "${yellow}"
AlertError = "${red}"

# Command syntax highlighting, matching the editor theme's roles
SyntaxCommand = "${green}"
SyntaxFlag = "${cyan}"
SyntaxString = "${string}"
SyntaxVariable = "${purple}"
SyntaxOperator = "${operator}"
SyntaxComment = "${comment}"
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
