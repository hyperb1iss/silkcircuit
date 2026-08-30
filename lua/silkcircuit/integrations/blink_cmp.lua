local M = {}

-- Item kinds share the palette with integrations/cmp.lua so a switch from
-- nvim-cmp to blink.cmp does not change what a completion list looks like.
local function kind_colors(colors)
  return {
    Text = colors.fg,
    Method = colors.blue,
    Function = colors.blue,
    Constructor = colors.orange,
    Field = colors.green,
    Variable = colors.cyan,
    Class = colors.orange,
    Interface = colors.orange,
    Module = colors.purple,
    Property = colors.green,
    Unit = colors.orange,
    Value = colors.cyan,
    Enum = colors.orange,
    Keyword = colors.purple,
    Snippet = colors.green,
    Color = colors.cyan,
    File = colors.blue,
    Reference = colors.cyan,
    Folder = colors.blue,
    EnumMember = colors.cyan,
    Constant = colors.cyan,
    Struct = colors.orange,
    Event = colors.orange,
    Operator = colors.cyan,
    TypeParameter = colors.cyan,
  }
end

function M.get(colors, opts)
  local float_bg = opts.transparent and colors.none or colors.bg_float

  local highlights = {
    -- Label column
    BlinkCmpLabel = { fg = colors.fg },
    BlinkCmpLabelMatch = { fg = colors.pink, bold = true },
    BlinkCmpLabelDeprecated = { fg = colors.purple_muted, strikethrough = true },
    BlinkCmpLabelDetail = { fg = colors.purple_muted },
    BlinkCmpLabelDescription = { fg = colors.purple_muted },
    BlinkCmpSource = { fg = colors.purple_muted, italic = true },

    -- Kind column
    BlinkCmpKind = { fg = colors.purple },

    -- Menu window
    BlinkCmpMenu = { fg = colors.fg, bg = float_bg },
    BlinkCmpMenuBorder = { fg = colors.border, bg = float_bg },
    BlinkCmpMenuSelection = { fg = colors.bg, bg = colors.purple, bold = true },
    BlinkCmpScrollBarThumb = { bg = colors.purple },
    BlinkCmpScrollBarGutter = { bg = colors.bg_dark },

    -- Ghost text preview of the selected item
    BlinkCmpGhostText = { fg = colors.purple_muted, italic = true },

    -- Documentation window
    BlinkCmpDoc = { fg = colors.fg, bg = float_bg },
    BlinkCmpDocBorder = { fg = colors.border, bg = float_bg },
    BlinkCmpDocSeparator = { fg = colors.purple_muted, bg = float_bg },
    BlinkCmpDocCursorLine = { bg = colors.bg_visual },

    -- Signature help window
    BlinkCmpSignatureHelp = { fg = colors.fg, bg = float_bg },
    BlinkCmpSignatureHelpBorder = { fg = colors.border, bg = float_bg },
    BlinkCmpSignatureHelpActiveParameter = { fg = colors.pink_bright, bold = true },
  }

  for kind, color in pairs(kind_colors(colors)) do
    highlights["BlinkCmpKind" .. kind] = { fg = color }
  end

  return highlights
end

return M
