-- Every variant in one file, shaped so it can be pasted straight into the
-- "schemes" array of a Windows Terminal settings.json.

local M = {}

function M.generate(entries)
  local scheme = require("silkcircuit.extra.windows_terminal").scheme
  local parts = {}
  for _, entry in ipairs(entries) do
    parts[#parts + 1] = scheme(entry.colors, "    ")
  end
  return '{\n  "schemes": [\n' .. table.concat(parts, ",\n") .. "\n  ]\n}"
end

return M
