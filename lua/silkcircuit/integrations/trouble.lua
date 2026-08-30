local M = {}

-- Trouble v3 draws a tree of items grouped by file. The symbol icons reuse
-- the treesitter and semantic-token captures the theme already defines, so an
-- outline reads with the same colours as the code it came from.
local ICON_LINKS = {
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

function M.get(colors, opts)
  local float_bg = opts.transparent and colors.none or colors.bg_float

  local highlights = {
    -- Window
    TroubleNormal = { fg = colors.fg, bg = float_bg },
    TroubleNormalNC = { link = "TroubleNormal" },
    TroubleText = { fg = colors.fg },
    TroublePreview = { bg = colors.bg_visual },

    -- Item
    TroubleFilename = { fg = colors.fg_light, bold = true },
    TroubleBasename = { link = "TroubleFilename" },
    TroubleDirectory = { fg = colors.blue },
    TroubleIconDirectory = { fg = colors.blue },
    TroubleSource = { link = "Comment" },
    TroubleCode = { fg = colors.purple, italic = true },
    TroublePos = { link = "LineNr" },
    TroubleCount = { fg = colors.bg, bg = colors.purple, bold = true },

    -- Indent guides. A closed fold is the one that has to be findable.
    TroubleIndent = { fg = colors.bg_visual },
    TroubleIndentFoldClosed = { fg = colors.pink, bold = true },
    TroubleIndentFoldOpen = { link = "TroubleIndent" },
    TroubleIndentTop = { link = "TroubleIndent" },
    TroubleIndentMiddle = { link = "TroubleIndent" },
    TroubleIndentLast = { link = "TroubleIndent" },
    TroubleIndentWs = { link = "TroubleIndent" },
  }

  for kind, link in pairs(ICON_LINKS) do
    highlights["TroubleIcon" .. kind] = { link = link }
  end

  -- Every source Trouble renders re-links these five under its own prefix.
  -- "fs" is the only one the plugin registers up front; the rest are created
  -- on demand and inherit from the unprefixed groups above.
  for _, part in ipairs({ "Filename", "Basename", "Source", "Pos", "Count" }) do
    highlights["TroubleFs" .. part] = { link = "Trouble" .. part }
  end

  return highlights
end

return M
