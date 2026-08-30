local M = {}

-- dropbar.nvim puts an IDE-style breadcrumb in the winbar and opens each crumb
-- as a drop-down menu. The kind icons link to the captures the theme already
-- defines, so a breadcrumb reads with the same colours as the symbols it
-- names. Upstream links DropBarIconKindEnumMember to itself, which resolves to
-- nothing; it points at the semantic token here instead.
local ICON_KIND_LINKS = {
  Array = "@punctuation.bracket",
  BlockMappingPair = "DropBarIconKindDefault",
  Boolean = "@boolean",
  BreakStatement = "@keyword.exception",
  Call = "@function.call",
  CaseStatement = "@keyword.conditional",
  Class = "@type",
  Constant = "@constant",
  Constructor = "@constructor",
  ContinueStatement = "@keyword.repeat",
  Declaration = "DropBarIconKindDefault",
  Delete = "@keyword.exception",
  DoStatement = "@keyword.repeat",
  Element = "DropBarIconKindDefault",
  ElseStatement = "@keyword.conditional",
  Enum = "@lsp.type.enum",
  EnumMember = "@lsp.type.enumMember",
  Event = "@lsp.type.event",
  Field = "@variable.member",
  File = "DropBarIconKindFolder",
  Folder = "Directory",
  ForStatement = "@keyword.repeat",
  Function = "@function",
  GotoStatement = "@keyword.return",
  Identifier = "DropBarIconKindDefault",
  IfStatement = "@keyword.conditional",
  Interface = "@lsp.type.interface",
  Keyword = "@keyword",
  List = "@punctuation.bracket",
  Macro = "@function.macro",
  MarkdownH1 = "markdownH1",
  MarkdownH2 = "markdownH2",
  MarkdownH3 = "markdownH3",
  MarkdownH4 = "markdownH4",
  MarkdownH5 = "markdownH5",
  MarkdownH6 = "markdownH6",
  Method = "@function.method",
  Module = "@module",
  Namespace = "@lsp.type.namespace",
  Null = "@constant.builtin",
  Number = "@number",
  Object = "@constant",
  Operator = "@operator",
  Package = "@module",
  Pair = "DropBarIconKindDefault",
  Property = "@property",
  Reference = "DropBarIconKindDefault",
  Repeat = "@keyword.repeat",
  ReturnStatement = "@keyword.return",
  Rule = "@lsp.type.namespace",
  RuleSet = "@lsp.type.namespace",
  Scope = "@lsp.type.namespace",
  Section = "Title",
  Specifier = "@keyword",
  Statement = "@keyword",
  String = "@string",
  Struct = "@lsp.type.struct",
  SwitchStatement = "@keyword.conditional",
  Table = "DropBarIconKindDefault",
  Terminal = "@number",
  Type = "@type",
  TypeParameter = "@lsp.type.typeParameter",
  Unit = "DropBarIconKindDefault",
  Value = "@number",
  Variable = "@variable",
  WhileStatement = "@keyword.repeat",
}

function M.get(colors, opts)
  local float_bg = opts.transparent and colors.none or colors.bg_float

  local highlights = {
    -- The crumb the cursor is inside
    DropBarCurrentContext = { bg = colors.bg_visual },
    -- The visual background is light enough in three variants that an accent
    -- colour on it lands under 4.5:1, so the icon takes the muted foreground
    -- and the name carries the emphasis instead.
    DropBarCurrentContextIcon = { fg = colors.fg_dark, bg = colors.bg_visual },
    DropBarCurrentContextName = { fg = colors.fg_light, bg = colors.bg_visual, bold = true },
    DropBarHover = { bg = colors.bg_visual },
    DropBarPreview = { bg = colors.bg_visual },
    DropBarFzfMatch = { fg = colors.pink, bold = true },

    -- Winbar separators and pick-mode pivots
    DropBarIconUISeparator = { fg = colors.purple_muted },
    DropBarIconUISeparatorMenu = { link = "DropBarIconUISeparator" },
    DropBarIconUIIndicator = { fg = colors.cyan },
    DropBarIconUIPickPivot = { fg = colors.bg, bg = colors.pink, bold = true },

    -- Drop-down menu
    DropBarMenuNormalFloat = { fg = colors.fg, bg = float_bg },
    DropBarMenuFloatBorder = { fg = colors.border, bg = float_bg },
    DropBarMenuCurrentContext = { fg = colors.bg, bg = colors.purple },
    DropBarMenuHoverEntry = { bg = colors.bg_visual },
    DropBarMenuHoverIcon = { fg = colors.pink_bright, bold = true },
    DropBarMenuHoverSymbol = { bold = true },
    DropBarMenuSbar = { bg = colors.bg_dark },
    DropBarMenuThumb = { bg = colors.purple },

    -- Icon kinds. Default carries the winbar's own colour, and the NC default
    -- is the one every non-current-window variant inherits from.
    DropBarIconKindDefault = { fg = colors.pink_bright },
    DropBarIconKindDefaultNC = { fg = colors.purple_muted },
  }

  for kind, link in pairs(ICON_KIND_LINKS) do
    highlights["DropBarIconKind" .. kind] = { link = link }
    highlights["DropBarIconKind" .. kind .. "NC"] = { link = "DropBarIconKindDefaultNC" }
  end

  return highlights
end

return M
