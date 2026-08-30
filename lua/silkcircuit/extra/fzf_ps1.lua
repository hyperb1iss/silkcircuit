-- The PowerShell half of the fzf theme. Same --color groups as the shell
-- script, joined into one string because fzf reads FZF_DEFAULT_OPTS as a flat
-- option line.

local M = {}

function M.generate(colors)
  local lines = { "$env:FZF_DEFAULT_OPTS = @(" }
  for _, arg in ipairs(require("silkcircuit.extra.fzf").color_args(colors)) do
    lines[#lines + 1] = '    "' .. arg .. '"'
  end
  lines[#lines + 1] = ') -join " "'
  return table.concat(lines, "\n")
end

return M
