local M = {}

-- oil.nvim renders a directory as an editable buffer, so the entry types read
-- like a file listing (Directory blue, links cyan) and the pending-change
-- markers read like a diff (create green, delete red, move and copy amber).
-- The Hidden variants are the same entries when `view_options.show_hidden`
-- reveals them, and they stay dimmer so a dotfile is legible without
-- competing with the rest of the listing.
function M.get(colors, _)
  return {
    OilDir = { fg = colors.blue, bold = true },
    OilDirIcon = { fg = colors.blue },
    OilFile = { fg = colors.fg },
    OilLink = { fg = colors.cyan },
    OilLinkTarget = { fg = colors.cyan, italic = true },
    OilOrphanLink = { fg = colors.red, strikethrough = true },
    OilOrphanLinkTarget = { fg = colors.red, italic = true },
    OilSocket = { fg = colors.purple },
    OilEmpty = { link = "Comment" },
    OilHidden = { fg = colors.purple_muted },

    -- The same entry types once hidden files are shown
    OilDirHidden = { fg = colors.purple_muted, bold = true },
    OilFileHidden = { fg = colors.purple_muted },
    OilLinkHidden = { fg = colors.purple_muted },
    OilLinkTargetHidden = { fg = colors.purple_muted, italic = true },
    OilOrphanLinkHidden = { fg = colors.purple_muted, strikethrough = true },
    OilOrphanLinkTargetHidden = { fg = colors.purple_muted, italic = true },
    OilSocketHidden = { fg = colors.purple_muted },

    -- Pending changes in the confirmation window
    OilCreate = { fg = colors.git_add },
    OilDelete = { fg = colors.git_delete },
    OilMove = { fg = colors.git_change },
    OilCopy = { fg = colors.cyan },
    OilChange = { fg = colors.git_change },
    OilRestore = { fg = colors.git_add },
    OilTrash = { fg = colors.warning },
    OilPurge = { fg = colors.error, bold = true },
    OilTrashSourcePath = { link = "Comment" },
  }
end

return M
