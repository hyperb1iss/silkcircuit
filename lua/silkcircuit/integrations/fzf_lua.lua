local M = {}

-- fzf-lua paints two surfaces: the Neovim floats it owns (FzfLua*) and fzf's
-- own TUI, which it renders by reading the FzfLuaFzf* groups and converting
-- them to fzf colour flags. Both sets need a real foreground, so nothing here
-- relies on a group Neovim would otherwise resolve at draw time.
function M.get(colors, opts)
  local float_bg = opts.transparent and colors.none or colors.bg_float

  return {
    -- Main window
    FzfLuaNormal = { fg = colors.fg, bg = float_bg },
    FzfLuaBorder = { fg = colors.border, bg = float_bg },
    FzfLuaTitle = { fg = colors.pink, bg = float_bg, bold = true },
    FzfLuaTitleFlags = { fg = colors.purple, bg = float_bg },
    FzfLuaBackdrop = { bg = colors.bg_darker },

    -- Builtin previewer
    FzfLuaPreviewNormal = { fg = colors.fg, bg = float_bg },
    FzfLuaPreviewBorder = { fg = colors.border, bg = float_bg },
    FzfLuaPreviewTitle = { fg = colors.green, bg = float_bg, bold = true },
    FzfLuaCursor = { fg = colors.bg, bg = colors.pink },
    FzfLuaCursorLine = { bg = colors.bg_visual },
    FzfLuaCursorLineNr = { fg = colors.fg_light, bg = colors.bg_visual, bold = true },
    FzfLuaSearch = { fg = colors.bg, bg = colors.coral },

    -- Preview scrollbars, drawn either as a border column or a float
    FzfLuaScrollBorderEmpty = { fg = colors.purple_muted, bg = float_bg },
    FzfLuaScrollBorderFull = { fg = colors.purple, bg = float_bg },
    FzfLuaScrollFloatEmpty = { bg = colors.bg_dark },
    FzfLuaScrollFloatFull = { bg = colors.purple },

    -- Help window
    FzfLuaHelpNormal = { fg = colors.fg, bg = float_bg },
    FzfLuaHelpBorder = { fg = colors.border, bg = float_bg },

    -- Header line
    FzfLuaHeaderBind = { fg = colors.pink, bold = true },
    FzfLuaHeaderText = { fg = colors.cyan },

    -- Path decorations
    FzfLuaPathColNr = { fg = colors.cyan },
    FzfLuaPathLineNr = { fg = colors.green },
    FzfLuaDirIcon = { fg = colors.blue },
    FzfLuaDirPart = { link = "Comment" },
    FzfLuaFilePart = { fg = colors.fg },

    -- Buffer and tab pickers
    FzfLuaBufName = { fg = colors.blue },
    FzfLuaBufId = { fg = colors.purple },
    FzfLuaBufNr = { fg = colors.yellow },
    FzfLuaBufLineNr = { link = "LineNr" },
    FzfLuaBufFlagCur = { fg = colors.pink, bold = true },
    FzfLuaBufFlagAlt = { fg = colors.cyan },
    FzfLuaTabTitle = { fg = colors.cyan, bold = true },
    FzfLuaTabMarker = { fg = colors.pink, bold = true },

    -- Live queries
    FzfLuaLivePrompt = { fg = colors.pink },
    FzfLuaLiveSym = { fg = colors.pink, bold = true },

    -- Command picker
    FzfLuaCmdEx = { fg = colors.purple },
    FzfLuaCmdBuf = { link = "Added" },
    FzfLuaCmdGlobal = { fg = colors.blue },

    -- fzf's own TUI
    FzfLuaFzfNormal = { fg = colors.fg, bg = float_bg },
    FzfLuaFzfCursorLine = { fg = colors.fg_light, bg = colors.bg_visual },
    FzfLuaFzfMatch = { fg = colors.pink, bold = true },
    FzfLuaFzfBorder = { fg = colors.border, bg = float_bg },
    FzfLuaFzfScrollbar = { fg = colors.purple, bg = float_bg },
    FzfLuaFzfSeparator = { fg = colors.purple_muted, bg = float_bg },
    FzfLuaFzfGutter = { bg = float_bg },
    FzfLuaFzfHeader = { fg = colors.pink, bg = float_bg, bold = true },
    FzfLuaFzfInfo = { fg = colors.purple_muted, bg = float_bg },
    FzfLuaFzfPointer = { fg = colors.pink, bg = float_bg },
    FzfLuaFzfMarker = { fg = colors.cyan, bg = float_bg },
    FzfLuaFzfSpinner = { fg = colors.purple, bg = float_bg },
    FzfLuaFzfPrompt = { fg = colors.purple, bg = float_bg },
    FzfLuaFzfQuery = { fg = colors.fg_light, bg = float_bg },
  }
end

return M
