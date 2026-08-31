local M = {}

function M.highlights(colors, opts)
  return {
    NvimTreeNormal = { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg },
    NvimTreeNormalNC = { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg },
    NvimTreeWinSeparator = { fg = colors.divider },
    NvimTreeEndOfBuffer = { fg = colors.bg },

    NvimTreeFolderName = { fg = colors.blue },
    NvimTreeFolderIcon = { fg = colors.blue },
    NvimTreeOpenedFolderName = { fg = colors.blue, bold = true },
    NvimTreeEmptyFolderName = { fg = colors.gray },
    NvimTreeRootFolder = { fg = colors.purple, bold = true },

    NvimTreeSpecialFile = { fg = colors.yellow, underline = true },
    NvimTreeImageFile = { fg = colors.purple },
    NvimTreeExecFile = { fg = colors.green },
    NvimTreeSymlink = { fg = colors.cyan },

    NvimTreeIndentMarker = { fg = colors.bg_highlight },
    NvimTreeCursorLine = { bg = colors.bg_highlight },

    NvimTreeGitDirty = { fg = colors.git_change },
    NvimTreeGitStaged = { fg = colors.git_add },
    NvimTreeGitMerge = { fg = colors.git_change },
    NvimTreeGitRenamed = { fg = colors.git_change },
    NvimTreeGitNew = { fg = colors.git_add },
    NvimTreeGitDeleted = { fg = colors.git_delete },
    NvimTreeGitIgnored = { fg = colors.gray },

    NvimTreeWindowPicker = { fg = colors.bg, bg = colors.purple, bold = true },

    NvimTreeLiveFilterPrefix = { fg = colors.purple, bold = true },
    NvimTreeLiveFilterValue = { fg = colors.green },

    NvimTreeBookmark = { fg = colors.pink },
    NvimTreeFileIcon = { fg = colors.fg },

    NvimTreeModifiedFile = { fg = colors.git_change },
    NvimTreeOpenedFile = { fg = colors.green },
    NvimTreeCopiedFile = { fg = colors.cyan },
    NvimTreeCutFile = { fg = colors.red },
  }
end

return M
