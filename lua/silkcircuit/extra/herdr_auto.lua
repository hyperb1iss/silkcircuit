-- One config for both appearances. Herdr can follow the terminal's light or
-- dark mode when `auto_switch` is on, layering `[theme.custom.dark]` or
-- `[theme.custom.light]` over the shared tokens. Neon takes the dark side and
-- Dawn the light, so a terminal that flips with the OS carries Herdr with it.

local M = {}

local HEADER = [[
# Neon by night, Dawn by day. Merge into ~/.config/herdr/config.toml in place
# of any [theme] table already there, then reload:
#   herdr server reload-config
# Herdr switches when the terminal reports a light or dark appearance change.
# Prefer another dark variant? Replace the [theme.custom.dark] table with the
# [theme.custom] table from that variant's file.]]

function M.generate(ordered)
  local herdr = require("silkcircuit.extra.herdr")
  local by_variant = {}
  for _, entry in ipairs(ordered) do
    by_variant[entry.variant] = entry.colors
  end

  return table.concat({
    HEADER,
    "",
    "[theme]",
    'name = "terminal"',
    "auto_switch = true",
    'dark_name = "terminal"',
    'light_name = "terminal"',
    "",
    herdr.table(by_variant.neon, "[theme.custom.dark]"),
    "",
    herdr.table(by_variant.dawn, "[theme.custom.light]"),
  }, "\n")
end

return M
