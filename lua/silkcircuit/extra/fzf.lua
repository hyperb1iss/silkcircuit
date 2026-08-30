-- fzf takes its whole theme through one option, so both the shell and the
-- PowerShell target render the same --color groups and only differ in how the
-- environment variable gets set. The names are the ones fzf 0.42 and later
-- accept; older builds reject the whole spec on the first unknown name.

local M = {}

--- One line of the --color spec per group, so a diff points at a region of the
--- UI rather than at one long string.
local GROUPS = {
  { { "fg", "${fg}" }, { "bg", "${bg}" }, { "hl", "${purple}" } },
  { { "fg+", "${fg_light}" }, { "bg+", "${bg_highlight}" }, { "hl+", "${pink}" } },
  {
    { "selected-fg", "${fg_light}" },
    { "selected-bg", "${bg_visual}" },
    { "selected-hl", "${pink}" },
  },
  { { "gutter", "${bg}" }, { "query", "${fg_light}" }, { "disabled", "${comment}" } },
  { { "info", "${yellow}" }, { "separator", "${bg_visual}" }, { "scrollbar", "${purple}" } },
  { { "prompt", "${purple}" }, { "pointer", "${pink}" }, { "marker", "${green}" } },
  { { "spinner", "${cyan}" }, { "header", "${cyan}" }, { "border", "${border}" } },
  { { "label", "${fg_dark}" }, { "preview-fg", "${fg}" }, { "preview-bg", "${bg_dark}" } },
  { { "preview-border", "${border}" }, { "preview-label", "${cyan}" } },
}

--- The `--color=a:#hex,b:#hex` arguments, one per group.
function M.color_args(colors)
  local extra = require("silkcircuit.extra")
  local args = {}
  for _, group in ipairs(GROUPS) do
    local pairs_ = {}
    for _, entry in ipairs(group) do
      pairs_[#pairs_ + 1] = entry[1] .. ":" .. extra.template(entry[2], colors)
    end
    args[#args + 1] = "--color=" .. table.concat(pairs_, ",")
  end
  return args
end

function M.generate(colors)
  -- A backslash-newline inside double quotes is a line continuation in every
  -- POSIX shell, so this reaches fzf as one flat option string.
  return 'export FZF_DEFAULT_OPTS=" \\\n' .. table.concat(M.color_args(colors), " \\\n") .. '"\n'
end

return M
