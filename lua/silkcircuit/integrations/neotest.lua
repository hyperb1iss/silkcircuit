local M = {}

-- The neotest summary tree and its status signs. The four outcomes carry the
-- theme's diagnostic colours so a failing test reads the same as a diagnostic
-- error does in the gutter beside it.
function M.get(colors, _)
  return {
    -- Outcomes
    NeotestPassed = { fg = colors.green },
    NeotestFailed = { fg = colors.error },
    NeotestRunning = { fg = colors.yellow },
    NeotestSkipped = { fg = colors.blue },
    NeotestUnknown = { fg = colors.purple_muted },

    -- Tree
    NeotestDir = { fg = colors.blue },
    NeotestFile = { fg = colors.cyan },
    NeotestNamespace = { fg = colors.purple, bold = true },
    NeotestTest = { fg = colors.fg },
    NeotestAdapterName = { fg = colors.purple, bold = true },
    NeotestIndent = { fg = colors.bg_visual },
    NeotestExpandMarker = { fg = colors.bg_visual },

    -- Cursor and marks
    NeotestFocused = { fg = colors.pink, bold = true, underline = true },
    NeotestMarked = { fg = colors.coral, bold = true },
    NeotestTarget = { fg = colors.pink },
    NeotestWatching = { fg = colors.yellow },

    -- Windows
    NeotestBorder = { fg = colors.border },
    NeotestWinSelect = { fg = colors.cyan, bold = true },
  }
end

return M
