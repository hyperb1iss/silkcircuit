local M = {}
local color_utils = require("silkcircuit.utils.colors")

function M.highlights(colors, opts)
  local conflict_bg = color_utils.blend(colors.red, colors.bg, 0.125)

  return {
    -- Main Neo-tree window with subtle background
    NeoTreeNormal = { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg_dark },
    NeoTreeNormalNC = {
      fg = colors.fg_dark,
      bg = opts.transparent and colors.none or colors.bg_darker,
    },
    NeoTreeWinSeparator = { fg = colors.purple_muted, bg = colors.none },
    NeoTreeEndOfBuffer = { fg = colors.bg_dark },

    -- Root directory with softer purple
    NeoTreeRootName = { fg = colors.purple, bold = true, italic = true },

    -- Git status with softer colors
    NeoTreeGitAdded = { fg = colors.green },
    NeoTreeGitModified = { fg = colors.yellow },
    NeoTreeGitDeleted = { fg = colors.pink },
    NeoTreeGitRenamed = { fg = colors.cyan },
    NeoTreeGitUntracked = { fg = colors.purple_muted, italic = true },
    NeoTreeGitIgnored = { fg = colors.gray, italic = true },
    NeoTreeGitConflict = { fg = colors.red, bold = true, bg = conflict_bg },
    NeoTreeGitStaged = { fg = colors.green, bold = true },
    NeoTreeGitUnstaged = { fg = colors.orange, bold = true },

    -- Tree structure with softer accents
    NeoTreeIndentMarker = { fg = colors.purple_muted },
    NeoTreeExpander = { fg = colors.purple, bold = true },
    NeoTreeDimText = { fg = colors.gray },

    -- Directories with subtle purple styling
    NeoTreeDirectoryIcon = { fg = colors.purple, bold = true },
    NeoTreeDirectoryName = { fg = colors.purple, bold = true },

    -- Files with subtle styling
    NeoTreeFileName = { fg = colors.fg },
    NeoTreeFileNameOpened = { fg = colors.cyan, bold = true },
    NeoTreeSymbolicLinkTarget = { fg = colors.cyan, italic = true },

    -- Floating windows with softer borders
    NeoTreeFloatBorder = { fg = colors.purple, bg = colors.none },
    NeoTreeFloatTitle = { fg = colors.pink, bold = true, bg = colors.bg_dark },
    NeoTreeTitleBar = { fg = colors.purple, bg = colors.bg_highlight, bold = true },

    -- File icons and modifiers
    NeoTreeFileIcon = { fg = colors.cyan },
    NeoTreeModified = { fg = colors.orange, bold = true },
    NeoTreeBufferNumber = { fg = colors.purple_muted, italic = true },
    NeoTreeCursorLine = { bg = colors.bg_highlight },

    -- Tabs with softer styling
    NeoTreeTabActive = { fg = colors.bg, bg = colors.purple, bold = true },
    NeoTreeTabInactive = { fg = colors.fg_dark, bg = colors.bg_highlight },
    NeoTreeTabSeparatorActive = { fg = colors.purple, bg = colors.purple },
    NeoTreeTabSeparatorInactive = { fg = colors.bg_highlight, bg = colors.bg_highlight },

    -- Preview window
    NeoTreePreviewBorder = { fg = colors.cyan },
    NeoTreePreviewTitle = { fg = colors.cyan, bold = true },

    -- Message and status
    NeoTreeMessage = { fg = colors.fg_dark, italic = true },
    NeoTreeStats = { fg = colors.purple_muted, italic = true },

    -- File type specific colors
    NeoTreeFileStatsIcon = { fg = colors.yellow },
    NeoTreeFileStatsSize = { fg = colors.yellow_bright },
    NeoTreeFileStatsDate = { fg = colors.cyan },

    -- Diagnostic integration
    NeoTreeDiagnosticError = { fg = colors.error, bold = true },
    NeoTreeDiagnosticWarn = { fg = colors.warning, bold = true },
    NeoTreeDiagnosticInfo = { fg = colors.info },
    NeoTreeDiagnosticHint = { fg = colors.hint },

    -- Filter and search
    NeoTreeFilterTerm = { fg = colors.pink, bold = true, italic = true },
    NeoTreeDotfile = { fg = colors.gray, italic = true },

    -- Special file types with distinctive colors
    NeoTreeExecutable = { fg = colors.green, bold = true },
    NeoTreeHiddenFile = { fg = colors.gray, italic = true },
    NeoTreeImageFile = { fg = colors.pink },
    NeoTreeMarkdownFile = { fg = colors.purple },
    NeoTreeConfigFile = { fg = colors.yellow },
    NeoTreeLockFile = { fg = colors.orange },

    -- Enhanced folder states
    NeoTreeFolderIcon = { fg = colors.purple },
    NeoTreeFolderName = { fg = colors.purple },
    NeoTreeFolderEmpty = { fg = colors.purple_muted, italic = true },

    -- Window picker integration
    NeoTreeWindowsHidden = { fg = colors.gray, italic = true },

    -- Bookmarks and marks
    NeoTreeBookmark = { fg = colors.cyan, bold = true },
    NeoTreeBookmarkIcon = { fg = colors.cyan },
  }
end

return M
