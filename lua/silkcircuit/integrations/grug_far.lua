local M = {}

-- grug-far.nvim is a search-and-replace buffer, so the results read like a
-- diff: what the match is now, what it becomes, and what disappears. The
-- indicator groups colour the single character in the sign area, which
-- upstream ships as two hardcoded hex values that belong to no theme.
function M.get(colors, _)
  return {
    -- Help
    GrugFarHelpHeader = { fg = colors.purple, bold = true },
    GrugFarHelpHeaderKey = { fg = colors.pink, bold = true },
    GrugFarHelpWinHeader = { fg = colors.pink, bold = true },
    GrugFarHelpWinActionPrefix = { fg = colors.purple },
    GrugFarHelpWinActionText = { fg = colors.fg },
    GrugFarHelpWinActionKey = { fg = colors.pink, bold = true },
    GrugFarHelpWinActionDescription = { fg = colors.fg_dark },

    -- Inputs
    GrugFarInputLabel = { fg = colors.purple, bold = true },
    GrugFarInputPlaceholder = { link = "Comment" },

    -- Results header
    GrugFarResultsHeader = { fg = colors.purple, bold = true },
    GrugFarResultsStats = { link = "Comment" },
    GrugFarResultsActionMessage = { fg = colors.cyan },
    GrugFarResultsCmdHeader = { fg = colors.cyan, underline = true },
    GrugFarResultsPath = { fg = colors.blue, underline = true },
    GrugFarResultsLongLineStr = { link = "Comment" },

    -- Matches
    GrugFarResultsMatch = { bg = colors.diff_text },
    GrugFarResultsMatchAdded = { bg = colors.diff_add },
    GrugFarResultsMatchRemoved = { bg = colors.diff_delete },
    GrugFarCurrentMatch = { fg = colors.bg, bg = colors.pink, bold = true },
    GrugFarVisualBufrange = { bg = colors.bg_visual },

    -- Position columns
    GrugFarResultsLineNr = { link = "LineNr" },
    GrugFarResultsColumnNr = { link = "LineNr" },
    GrugFarResultsNumbersSeparator = { link = "LineNr" },
    GrugFarResultsCursorLineNo = { fg = colors.fg_light, bold = true },
    GrugFarResultsNumberLabel = { fg = colors.purple },

    -- Change indicators in the sign area
    GrugFarResultsAddIndicator = { fg = colors.git_add, bg = colors.none },
    GrugFarResultsRemoveIndicator = { fg = colors.git_delete, bg = colors.none },
    GrugFarResultsChangeIndicator = { fg = colors.git_change, bg = colors.none },
    GrugFarResultsDiffSeparatorIndicator = { fg = colors.purple_muted },
  }
end

return M
