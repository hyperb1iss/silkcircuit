local M = {}

function M.highlights(colors, opts)
  return {
    TelescopeNormal = {
      fg = colors.fg,
      bg = opts.transparent and colors.none or colors.bg_highlight,
    },
    TelescopeBorder = {
      fg = colors.bg_highlight,
      bg = opts.transparent and colors.none or colors.bg_highlight,
    },
    TelescopeTitle = { fg = colors.purple, bold = true },

    TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_highlight },
    TelescopePromptBorder = { fg = colors.bg_highlight, bg = colors.bg_highlight },
    TelescopePromptTitle = { fg = colors.purple, bg = colors.bg_highlight, bold = true },
    TelescopePromptPrefix = { fg = colors.purple },
    TelescopePromptCounter = { fg = colors.gray },

    TelescopeResultsNormal = { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg },
    TelescopeResultsBorder = {
      fg = colors.bg_highlight,
      bg = opts.transparent and colors.none or colors.bg,
    },
    TelescopeResultsTitle = { fg = colors.cyan, bold = true },

    TelescopePreviewNormal = { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg },
    TelescopePreviewBorder = {
      fg = colors.bg_highlight,
      bg = opts.transparent and colors.none or colors.bg,
    },
    TelescopePreviewTitle = { fg = colors.green, bold = true },

    TelescopeSelection = { fg = colors.fg_light, bg = colors.selection },
    TelescopeSelectionCaret = { fg = colors.cyan_bright, bg = colors.selection },
    TelescopeMultiSelection = { fg = colors.cyan, bg = colors.selection },
    TelescopeMultiIcon = { fg = colors.cyan },

    TelescopeMatching = { fg = colors.yellow, bold = true },
    TelescopePreviewMatch = { fg = colors.yellow, bold = true },

    TelescopePreviewLine = { bg = colors.bg_highlight },
    TelescopePreviewExecute = { fg = colors.green },
    TelescopePreviewHyphen = { fg = colors.gray },
    TelescopePreviewDirectory = { fg = colors.blue },
    TelescopePreviewSize = { fg = colors.green },
    TelescopePreviewDate = { fg = colors.blue },
    TelescopePreviewRead = { fg = colors.yellow },
    TelescopePreviewWrite = { fg = colors.red },
  }
end

return M
