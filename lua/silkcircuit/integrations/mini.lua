local M = {}

function M.get(colors, _)
  return {
    -- mini.statusline
    MiniStatuslineModeNormal = { fg = colors.bg, bg = colors.purple, bold = true },
    MiniStatuslineModeInsert = { fg = colors.bg, bg = colors.green, bold = true },
    MiniStatuslineModeVisual = { fg = colors.bg, bg = colors.yellow, bold = true },
    MiniStatuslineModeReplace = { fg = colors.bg, bg = colors.red, bold = true },
    MiniStatuslineModeCommand = { fg = colors.bg, bg = colors.pink, bold = true },
    MiniStatuslineModeOther = { fg = colors.bg, bg = colors.cyan, bold = true },
    MiniStatuslineDevinfo = { fg = colors.fg, bg = colors.bg_highlight },
    MiniStatuslineFilename = { fg = colors.fg, bg = colors.bg_highlight },
    MiniStatuslineFileinfo = { fg = colors.fg, bg = colors.bg_highlight },
    MiniStatuslineInactive = { fg = colors.gray, bg = colors.bg_dark },

    -- mini.tabline
    MiniTablineCurrent = { fg = colors.fg, bg = colors.bg, bold = true },
    MiniTablineVisible = { fg = colors.fg, bg = colors.bg_highlight },
    MiniTablineHidden = { fg = colors.gray, bg = colors.bg_dark },
    MiniTablineModifiedCurrent = { fg = colors.yellow, bg = colors.bg, bold = true },
    MiniTablineModifiedVisible = { fg = colors.yellow, bg = colors.bg_highlight },
    MiniTablineModifiedHidden = { fg = colors.yellow, bg = colors.bg_dark },
    MiniTablineFill = { bg = colors.bg_dark },

    -- mini.starter
    MiniStarterHeader = { fg = colors.purple, bold = true },
    MiniStarterFooter = { fg = colors.purple_muted, italic = true },
    MiniStarterItem = { fg = colors.fg },
    MiniStarterItemBullet = { fg = colors.pink },
    MiniStarterItemPrefix = { fg = colors.yellow },
    MiniStarterSection = { fg = colors.cyan, bold = true },
    MiniStarterQuery = { fg = colors.green },
    MiniStarterInactive = { fg = colors.gray, italic = true },
    MiniStarterCurrent = { fg = colors.pink, bold = true },

    -- mini.cursorword
    MiniCursorword = { bg = colors.bg_highlight },
    MiniCursorwordCurrent = { bg = colors.bg_highlight },

    -- mini.notify
    MiniNotifyBorder = { fg = colors.border },
    MiniNotifyNormal = { fg = colors.fg, bg = colors.bg_float },
    MiniNotifyTitle = { fg = colors.pink, bold = true },

    -- mini.completion
    MiniCompletionActiveParameter = { underline = true },

    -- mini.surround
    MiniSurround = { fg = colors.bg, bg = colors.coral },

    -- mini.test
    MiniTestEmphasis = { bold = true },
    MiniTestFail = { fg = colors.red, bold = true },
    MiniTestPass = { fg = colors.green, bold = true },

    -- mini.files
    MiniFilesFile = { fg = colors.fg },
    MiniFilesDirectory = { fg = colors.blue, bold = true },
    -- mini.files draws its title on a border that carries no background of
    -- its own, so the title composites on the float window, not the cursorline.
    MiniFilesTitle = { fg = colors.fg, bg = colors.bg_float, bold = true },
    MiniFilesTitleFocused = { fg = colors.fg, bg = colors.purple, bold = true },
    MiniFilesBorder = { fg = colors.border },
    MiniFilesBorderModified = { fg = colors.yellow },
    -- The float body is bg_float, which sits above bg_highlight, so the row
    -- marker has to rise off it rather than sink into it.
    MiniFilesCursorLine = { bg = colors.bg_visual },

    -- mini.pick
    MiniPickBorder = { fg = colors.border },
    MiniPickBorderBusy = { fg = colors.yellow },
    MiniPickBorderText = { fg = colors.purple, bold = true },
    MiniPickIconDirectory = { fg = colors.blue },
    MiniPickIconFile = { fg = colors.fg },
    MiniPickHeader = { fg = colors.pink, bold = true },
    MiniPickMatchCurrent = { bg = colors.bg_highlight },
    MiniPickMatchMarked = { fg = colors.coral, bold = true },
    MiniPickMatchRanges = { fg = colors.green, bold = true },
    MiniPickNormal = { fg = colors.fg, bg = colors.bg_float },
    MiniPickPreviewLine = { bg = colors.bg_highlight },
    MiniPickPreviewRegion = { bg = colors.selection },
    MiniPickPrompt = { fg = colors.cyan, bg = colors.bg_highlight },

    -- mini.jump
    MiniJump = { fg = colors.bg, bg = colors.pink, bold = true },

    -- mini.jump2d
    MiniJump2dSpot = { fg = colors.pink, bold = true, nocombine = true },
    MiniJump2dSpotAhead = { fg = colors.cyan, bg = colors.bg_highlight, nocombine = true },
    MiniJump2dSpotUnique = { fg = colors.coral, bold = true, nocombine = true },
    MiniJump2dDim = { fg = colors.gray },

    -- mini.map
    MiniMapNormal = { fg = colors.gray, bg = colors.bg_dark },
    MiniMapSymbolCount = { fg = colors.purple },
    MiniMapSymbolLine = { fg = colors.blue },
    MiniMapSymbolView = { fg = colors.cyan },

    -- mini.animate
    MiniAnimateCursor = { reverse = true },
    MiniAnimateNormalFloat = { link = "NormalFloat" },

    -- mini.indentscope
    MiniIndentscopeSymbol = { fg = colors.purple_muted },
    MiniIndentscopePrefix = { nocombine = true },

    -- mini.hipatterns
    MiniHipatternsFixme = { fg = colors.bg, bg = colors.red, bold = true },
    MiniHipatternsTodo = { fg = colors.bg, bg = colors.yellow, bold = true },
    MiniHipatternsHack = { fg = colors.bg, bg = colors.yellow, bold = true },
    MiniHipatternsNote = { fg = colors.bg, bg = colors.cyan, bold = true },

    -- mini.diff
    MiniDiffSignAdd = { fg = colors.git_add },
    MiniDiffSignChange = { fg = colors.git_change },
    MiniDiffSignDelete = { fg = colors.git_delete },
    MiniDiffOverAdd = { bg = colors.diff_add },
    MiniDiffOverChange = { bg = colors.diff_change },
    MiniDiffOverContext = { bg = colors.bg_highlight },
    MiniDiffOverDelete = { bg = colors.diff_delete },

    -- mini.trailspace
    MiniTrailspace = { bg = colors.red },

    -- mini.operators
    MiniOperatorsExchangeFrom = { bg = colors.bg_highlight },

    -- mini.misc
    MiniMiscCursor = { reverse = true },

    -- mini.extra
    MiniExtraAnnotation = { fg = colors.purple_muted },
    MiniExtraSignature = { fg = colors.green },

    -- mini.ai
    MiniAiBracket = { fg = colors.pink },
  }
end

return M
