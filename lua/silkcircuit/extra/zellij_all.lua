-- Every variant in one themes block, so a single file dropped into
-- ~/.config/zellij/themes/ registers all five names at once.

local M = {}

function M.generate(entries)
  local theme = require("silkcircuit.extra.zellij").theme
  local parts = {}
  for _, entry in ipairs(entries) do
    parts[#parts + 1] = theme(entry.colors, "    ")
  end
  return "themes {\n" .. table.concat(parts, "\n") .. "\n}"
end

return M
