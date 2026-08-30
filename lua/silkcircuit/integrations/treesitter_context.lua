local M = {}

-- The sticky context lines pinned above the viewport. They sit on top of real
-- code, so the background is the only thing separating them from it and the
-- bottom border has to read as an edge rather than as another line of source.
function M.get(colors, _)
  return {
    TreesitterContext = { bg = colors.bg_highlight },
    TreesitterContextLineNumber = { fg = colors.purple, bg = colors.bg_highlight },
    TreesitterContextSeparator = { fg = colors.purple_muted },
    TreesitterContextBottom = { sp = colors.purple_muted, underline = true },
    TreesitterContextLineNumberBottom = { sp = colors.purple_muted, underline = true },
  }
end

return M
