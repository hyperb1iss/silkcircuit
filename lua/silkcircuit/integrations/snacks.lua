local M = {}

-- snacks.nvim is a dozen sub-plugins behind one name, and each one prefixes
-- its own groups. The picker is the largest surface: it builds five windows
-- (the picker itself, the list, the input, the preview and the box that holds
-- them) and derives Border, Title, Footer and CursorLine under each prefix,
-- so all five have to be defined or a layout falls back to Neovim's defaults
-- halfway through.
local PICKER_WINDOWS = { "", "List", "Input", "Preview", "Box" }

-- LSP symbol kinds in the picker, linked to the captures the theme already
-- defines so a symbol list matches the code it came from.
local PICKER_ICON_LINKS = {
  Array = "@punctuation.bracket",
  Boolean = "@boolean",
  Class = "@type",
  Constant = "@constant",
  Constructor = "@constructor",
  Enum = "@lsp.type.enum",
  EnumMember = "@lsp.type.enumMember",
  Event = "@lsp.type.event",
  Field = "@variable.member",
  File = "Normal",
  Function = "@function",
  Interface = "@lsp.type.interface",
  Key = "@lsp.type.keyword",
  Method = "@function.method",
  Module = "@module",
  Namespace = "@module",
  Null = "@constant.builtin",
  Number = "@number",
  Object = "@constant",
  Operator = "@operator",
  Package = "@module",
  Property = "@property",
  String = "@string",
  Struct = "@lsp.type.struct",
  TypeParameter = "@lsp.type.typeParameter",
  Variable = "@variable",
}

local NOTIFIER_LEVELS = { "Trace", "Debug", "Info", "Warn", "Error" }

function M.get(colors, opts)
  local float_bg = opts.transparent and colors.none or colors.bg_float

  local highlights = {
    -- Dashboard
    SnacksDashboardNormal = { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg },
    SnacksDashboardHeader = { fg = colors.purple, bold = true },
    SnacksDashboardTitle = { fg = colors.pink, bold = true },
    SnacksDashboardDesc = { fg = colors.cyan },
    SnacksDashboardKey = { fg = colors.pink, bold = true },
    SnacksDashboardIcon = { fg = colors.purple },
    SnacksDashboardFooter = { fg = colors.purple_muted, italic = true },
    SnacksDashboardFile = { fg = colors.fg },
    SnacksDashboardDir = { fg = colors.purple_muted },
    SnacksDashboardSpecial = { fg = colors.pink_bright },
    SnacksDashboardTerminal = { link = "SnacksDashboardNormal" },

    -- Notifications. Snacks suffixes every level onto its own groups, so
    -- SnacksNotifierInfo and SnacksNotifierBorderInfo are separate surfaces.
    SnacksNotifierHistory = { fg = colors.fg, bg = float_bg },
    SnacksNotifierHistoryTitle = { fg = colors.pink, bold = true },
    SnacksNotifierHistoryDateTime = { fg = colors.purple_muted },
    SnacksNotifierMinimal = { fg = colors.fg, bg = float_bg },
    SnacksNotifierTitle = { fg = colors.purple, bold = true },
    SnacksNotifierBorder = { fg = colors.purple_muted },

    -- Indent guides and scope
    SnacksIndent = { fg = colors.bg_highlight },
    SnacksIndentBlank = { fg = colors.bg_highlight },
    SnacksIndentScope = { fg = colors.purple_muted },
    SnacksIndentChunk = { fg = colors.purple_muted },
    SnacksIndent1 = { fg = colors.red },
    SnacksIndent2 = { fg = colors.coral },
    SnacksIndent3 = { fg = colors.yellow },
    SnacksIndent4 = { fg = colors.green },
    SnacksIndent5 = { fg = colors.cyan },
    SnacksIndent6 = { fg = colors.blue },
    SnacksIndent7 = { fg = colors.purple },
    SnacksIndent8 = { fg = colors.pink },

    -- Status column
    SnacksStatusColumnMark = { fg = colors.cyan },

    -- Zen mode and dimming
    SnacksZenIcon = { fg = colors.purple },
    SnacksDim = { link = "DiagnosticUnnecessary" },

    -- Images
    SnacksImageSpinner = { fg = colors.purple },
    SnacksImageAnchor = { fg = colors.pink_bright },
    SnacksImageLoading = { fg = colors.purple_muted },
    SnacksImageMath = { fg = colors.green_bright },

    -- Debug helpers
    SnacksDebugIndent = { link = "LineNr" },
    SnacksDebugPrint = { fg = colors.purple_muted },

    -- Scroll
    SnacksScroll = { fg = colors.purple, bg = colors.bg_dark },
    SnacksScrollHandle = { fg = colors.purple, bg = colors.bg_highlight },

    -- Picker content
    SnacksPickerMatch = { fg = colors.pink, bold = true },
    SnacksPickerSearch = { fg = colors.bg, bg = colors.yellow },
    SnacksPickerPrompt = { fg = colors.pink },
    SnacksPickerInputSearch = { fg = colors.purple, bold = true },
    SnacksPickerSpecial = { fg = colors.pink_bright },
    SnacksPickerLabel = { fg = colors.pink_bright },
    SnacksPickerTotals = { fg = colors.purple_muted },
    SnacksPickerFile = { fg = colors.fg },
    SnacksPickerDir = { fg = colors.purple_muted },
    SnacksPickerDirectory = { fg = colors.blue },
    SnacksPickerPathHidden = { fg = colors.purple_muted },
    SnacksPickerPathIgnored = { fg = colors.purple_muted },
    SnacksPickerLink = { fg = colors.cyan },
    SnacksPickerLinkBroken = { fg = colors.error },
    SnacksPickerToggle = { link = "DiagnosticVirtualTextInfo" },
    SnacksPickerDimmed = { link = "Comment" },
    SnacksPickerRow = { fg = colors.pink_soft },
    SnacksPickerCol = { link = "LineNr" },
    SnacksPickerComment = { link = "Comment" },
    SnacksPickerDesc = { link = "Comment" },
    SnacksPickerDelim = { fg = colors.fg_dark },
    SnacksPickerSpinner = { fg = colors.purple },
    SnacksPickerSelected = { fg = colors.coral },
    SnacksPickerUnselected = { fg = colors.purple_muted },
    SnacksPickerSelection = { fg = colors.bg, bg = colors.purple },
    SnacksPickerIdx = { fg = colors.coral },
    SnacksPickerTree = { fg = colors.bg_visual },
    SnacksPickerBold = { bold = true },
    SnacksPickerItalic = { italic = true },
    SnacksPickerCode = { fg = colors.yellow, bg = colors.bg_highlight },
    SnacksPickerRule = { fg = colors.purple_muted },
    SnacksPickerCmd = { fg = colors.cyan },
    SnacksPickerCmdBuiltin = { fg = colors.purple },
    SnacksPickerTime = { fg = colors.pink_bright },

    -- Picker: buffers, keymaps, autocmds, registers
    SnacksPickerBufNr = { fg = colors.coral },
    SnacksPickerBufFlags = { fg = colors.purple_muted },
    SnacksPickerBufType = { fg = colors.cyan },
    SnacksPickerFileType = { fg = colors.hint },
    SnacksPickerKeymapMode = { fg = colors.coral },
    SnacksPickerKeymapLhs = { fg = colors.pink_bright },
    SnacksPickerKeymapRhs = { fg = colors.purple_muted },
    SnacksPickerKeymapNowait = { fg = colors.coral, italic = true },
    SnacksPickerAuPattern = { fg = colors.pink_soft },
    SnacksPickerAuEvent = { fg = colors.coral },
    SnacksPickerAuGroup = { fg = colors.yellow },
    SnacksPickerRegister = { fg = colors.coral },
    SnacksPickerManSection = { fg = colors.coral },
    SnacksPickerManPage = { fg = colors.pink_bright },
    SnacksPickerDiagnosticCode = { fg = colors.pink_bright },
    SnacksPickerDiagnosticSource = { link = "Comment" },
    SnacksPickerPickWin = { fg = colors.bg, bg = colors.yellow, bold = true },
    SnacksPickerPickWinCurrent = { fg = colors.bg, bg = colors.pink, bold = true },

    -- Picker: undo tree
    SnacksPickerUndoAdded = { link = "Added" },
    SnacksPickerUndoRemoved = { link = "Removed" },
    SnacksPickerUndoCurrent = { fg = colors.coral },
    SnacksPickerUndoSaved = { fg = colors.pink_bright },

    -- Picker: git
    SnacksPickerGitCommit = { fg = colors.coral },
    SnacksPickerGitBreaking = { fg = colors.error, bold = true },
    SnacksPickerGitDetached = { fg = colors.warning },
    SnacksPickerGitBranch = { fg = colors.pink, bold = true },
    SnacksPickerGitBranchCurrent = { fg = colors.coral, bold = true },
    SnacksPickerGitDate = { fg = colors.pink_bright },
    SnacksPickerGitIssue = { fg = colors.coral },
    SnacksPickerGitAuthor = { fg = colors.cyan },
    SnacksPickerGitType = { fg = colors.purple, bold = true },
    SnacksPickerGitScope = { fg = colors.cyan, italic = true },
    SnacksPickerGitStatus = { fg = colors.pink_bright },
    SnacksPickerGitStatusAdded = { link = "Added" },
    SnacksPickerGitStatusModified = { link = "Changed" },
    SnacksPickerGitStatusDeleted = { link = "Removed" },
    SnacksPickerGitStatusRenamed = { link = "SnacksPickerGitStatus" },
    SnacksPickerGitStatusCopied = { link = "SnacksPickerGitStatus" },
    SnacksPickerGitStatusUntracked = { fg = colors.purple_muted },
    SnacksPickerGitStatusIgnored = { fg = colors.purple_muted },
    SnacksPickerGitStatusUnmerged = { fg = colors.error },
    SnacksPickerGitStatusStaged = { fg = colors.hint },

    -- Picker: LSP server list
    SnacksPickerLspEnabled = { fg = colors.green },
    SnacksPickerLspDisabled = { fg = colors.warning },
    SnacksPickerLspAttached = { fg = colors.cyan },
    SnacksPickerLspAttachedBuf = { fg = colors.info },
    SnacksPickerLspUnavailable = { fg = colors.error },

    -- Picker: icon browser
    SnacksPickerIcon = { fg = colors.pink_bright },
    SnacksPickerIconSource = { fg = colors.coral },
    SnacksPickerIconName = { fg = colors.purple },
    SnacksPickerIconCategory = { fg = colors.cyan },

    -- Terminal
    SnacksTerminalTitle = { fg = colors.purple, bold = true },
    SnacksTerminalBorder = { fg = colors.purple_muted },

    -- Input
    SnacksInputNormal = { fg = colors.fg, bg = float_bg },
    SnacksInputTitle = { fg = colors.purple, bold = true },
    SnacksInputBorder = { fg = colors.purple_muted },
    SnacksInputIcon = { fg = colors.pink },
    SnacksInputPrompt = { fg = colors.pink },

    -- Profiler
    SnacksProfilerTime = { fg = colors.yellow },
    SnacksProfilerTimeHigh = { fg = colors.red, bold = true },
    SnacksProfilerModule = { fg = colors.cyan },
    SnacksProfilerFunction = { fg = colors.purple },
  }

  for _, level in ipairs(NOTIFIER_LEVELS) do
    local muted = level == "Trace" or level == "Debug"
    local accent = muted and colors.purple_muted
      or ({
        Info = colors.info,
        Warn = colors.warning,
        Error = colors.error,
      })[level]

    highlights["SnacksNotifier" .. level] = { fg = colors.fg, bg = float_bg }
    highlights["SnacksNotifierIcon" .. level] = { fg = accent, bg = float_bg }
    highlights["SnacksNotifierBorder" .. level] = { fg = accent, bg = float_bg }
    highlights["SnacksNotifierTitle" .. level] = { fg = accent, bg = float_bg, bold = true }
    highlights["SnacksNotifierFooter" .. level] = { fg = accent, bg = float_bg }
  end

  for _, window in ipairs(PICKER_WINDOWS) do
    local prefix = "SnacksPicker" .. window
    highlights[prefix] = { fg = colors.fg, bg = float_bg }
    highlights[prefix .. "Border"] = { fg = colors.border, bg = float_bg }
    highlights[prefix .. "Title"] = { fg = colors.pink, bg = float_bg, bold = true }
    highlights[prefix .. "Footer"] = { fg = colors.purple, bg = float_bg }
    highlights[prefix .. "CursorLine"] = { bg = colors.bg_visual }
  end

  for kind, link in pairs(PICKER_ICON_LINKS) do
    highlights["SnacksPickerIcon" .. kind] = { link = link }
  end

  return highlights
end

return M
