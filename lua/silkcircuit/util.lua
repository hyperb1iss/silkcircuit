local M = {}

-- Apply a highlight group. The table goes to nvim_set_hl untouched, so every
-- attribute nvim understands works (reverse, nocombine, blend, ...) and a bad
-- value raises instead of vanishing.
function M.highlight(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Load highlight groups
function M.load_highlights(highlights)
  for group, opts in pairs(highlights) do
    M.highlight(group, opts)
  end
end

-- Merge a user style override onto a base highlight. An explicit false
-- removes the attribute, so styles.comments = { italic = false } actually
-- turns italic comments off instead of being ignored.
function M.merge_styles(base, styles)
  if not styles or vim.tbl_isempty(styles) then
    return base
  end

  local result = vim.tbl_extend("force", {}, base)
  for attribute, enabled in pairs(styles) do
    result[attribute] = enabled or nil
  end

  return result
end

return M
