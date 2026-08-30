local M = {}

-- The lazy.nvim UI. The Reason* groups colour the badge that explains why a
-- plugin loaded (an event, a key, a command), so each one takes the colour the
-- theme already gives that concept in code.
function M.get(colors, opts)
  return {
    LazyNormal = { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg_float },
    LazyH1 = { fg = colors.bg, bg = colors.pink, bold = true },
    LazyH2 = { fg = colors.purple, bold = true },
    LazyComment = { link = "Comment" },
    LazyProp = { fg = colors.purple_muted },
    LazyDimmed = { fg = colors.purple_muted },
    LazyValue = { fg = colors.pink_soft },
    LazyLocal = { fg = colors.coral },
    LazySpecial = { fg = colors.pink_bright },
    LazyDir = { fg = colors.cyan, underline = true },
    LazyUrl = { fg = colors.cyan, underline = true },
    LazyBold = { bold = true },
    LazyItalic = { italic = true },

    -- Commits
    LazyCommit = { fg = colors.coral },
    LazyCommitIssue = { fg = colors.coral },
    LazyCommitType = { fg = colors.purple, bold = true },
    LazyCommitScope = { fg = colors.cyan, italic = true },

    -- Progress and tasks
    LazyProgressDone = { fg = colors.green, bold = true },
    LazyProgressTodo = { fg = colors.bg_visual },
    LazyButton = { fg = colors.fg, bg = colors.bg_highlight },
    LazyButtonActive = { fg = colors.fg_light, bg = colors.bg_visual, bold = true },
    LazyTaskOutput = { fg = colors.fg },
    LazyError = { fg = colors.error },
    LazyWarning = { fg = colors.warning },
    LazyInfo = { fg = colors.info },
    LazyNoCond = { fg = colors.warning },

    -- Load reasons
    LazyReasonStart = { fg = colors.pink },
    LazyReasonRuntime = { fg = colors.purple },
    LazyReasonPlugin = { fg = colors.pink_bright },
    LazyReasonEvent = { fg = colors.coral },
    LazyReasonKeys = { fg = colors.purple },
    LazyReasonSource = { fg = colors.pink_soft },
    LazyReasonFt = { fg = colors.pink_soft },
    LazyReasonCmd = { fg = colors.cyan },
    LazyReasonImport = { fg = colors.blue },
    LazyReasonRequire = { fg = colors.fg },
  }
end

return M
