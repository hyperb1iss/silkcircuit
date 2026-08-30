local M = {}

-- TreeSitter integration for SilkCircuit theme
-- Provides enhanced syntax highlighting using TreeSitter's parsing capabilities

function M.get(colors, opts)
  local util = require("silkcircuit.util")
  local highlights = {}

  local function apply_style(base, style_key)
    return util.merge_styles(base, opts.styles and opts.styles[style_key])
  end

  -- Get semantic colors
  local sem = require("silkcircuit.palette").semantic

  -- Identifiers
  highlights["@variable"] = apply_style({ fg = sem.variable }, "variables")
  highlights["@variable.builtin"] = { fg = colors.coral, italic = true }
  highlights["@variable.parameter"] = { fg = sem.parameter }
  highlights["@variable.member"] = { fg = sem.property }

  highlights["@constant"] = apply_style({ fg = sem.constant }, "constants")
  highlights["@constant.builtin"] = { fg = colors.blue }
  highlights["@constant.macro"] = { fg = colors.blue }

  highlights["@module"] = { fg = sem.namespace }
  highlights["@module.builtin"] = { fg = sem.namespace }
  highlights["@label"] = { fg = colors.purple }

  -- Literals
  highlights["@string"] = apply_style({ fg = sem.string }, "strings")
  highlights["@string.documentation"] = { fg = colors.string }
  highlights["@string.regexp"] = { fg = colors.cyan_bright }
  highlights["@string.escape"] = { fg = colors.coral }
  highlights["@string.special"] = { fg = colors.coral }
  highlights["@string.special.symbol"] = { fg = colors.cyan }
  highlights["@string.special.path"] = { fg = colors.cyan }
  highlights["@string.special.url"] = { fg = colors.cyan, underline = true }

  highlights["@character"] = { fg = colors.string }
  highlights["@character.special"] = { fg = colors.coral }

  highlights["@boolean"] = apply_style({ fg = sem.boolean }, "booleans")
  highlights["@number"] = { fg = sem.number }
  highlights["@number.float"] = { fg = sem.number }

  -- Types
  highlights["@type"] = apply_style({ fg = sem.type }, "types")
  highlights["@type.builtin"] = { fg = sem.type }
  highlights["@type.definition"] = { fg = sem.type }
  highlights["@type.qualifier"] = { fg = colors.purple }

  highlights["@attribute"] = { fg = sem.attribute }
  highlights["@property"] = { fg = sem.property }

  -- Functions
  highlights["@function"] = apply_style({ fg = sem.func }, "functions")
  highlights["@function.builtin"] = { fg = sem.function_builtin }
  highlights["@function.call"] = { fg = sem.func_call }
  highlights["@function.macro"] = { fg = colors.purple }
  highlights["@function.method"] = apply_style({ fg = sem.method }, "functions")
  highlights["@function.method.call"] = { fg = sem.func_call }

  highlights["@constructor"] = { fg = sem.type }
  highlights["@operator"] = apply_style({ fg = sem.operator }, "operators")

  -- Keywords
  highlights["@keyword"] = apply_style({ fg = sem.keyword, bold = true }, "keywords")
  highlights["@keyword.coroutine"] = apply_style({ fg = colors.keyword }, "keywords")
  highlights["@keyword.function"] = apply_style({ fg = colors.purple }, "keywords")
  highlights["@keyword.operator"] = apply_style({ fg = colors.operator }, "keywords")
  highlights["@keyword.import"] = apply_style({ fg = colors.purple }, "keywords")
  highlights["@keyword.storage"] = apply_style({ fg = colors.purple }, "keywords")
  highlights["@keyword.repeat"] = apply_style({ fg = colors.keyword }, "keywords")
  highlights["@keyword.return"] = apply_style({ fg = colors.keyword }, "keywords")
  highlights["@keyword.debug"] = apply_style({ fg = colors.red }, "keywords")
  highlights["@keyword.exception"] = apply_style({ fg = colors.keyword }, "keywords")
  highlights["@keyword.conditional"] = apply_style({ fg = colors.keyword }, "keywords")
  highlights["@keyword.conditional.ternary"] = { fg = colors.operator }
  highlights["@keyword.directive"] = apply_style({ fg = colors.purple }, "keywords")
  highlights["@keyword.directive.define"] = { fg = colors.purple }

  -- Punctuation
  highlights["@punctuation.delimiter"] = { fg = sem.punctuation }
  highlights["@punctuation.bracket"] = { fg = sem.bracket }
  highlights["@punctuation.special"] = { fg = sem.punctuation }

  -- Comments
  highlights["@comment"] = apply_style({ fg = sem.comment }, "comments")
  highlights["@comment.documentation"] = apply_style({ fg = colors.comment }, "comments")
  highlights["@comment.error"] = { fg = colors.error }
  highlights["@comment.warning"] = { fg = colors.warning }
  highlights["@comment.todo"] = { fg = colors.bg, bg = colors.yellow }
  highlights["@comment.note"] = { fg = colors.bg, bg = colors.info }

  -- Markup (for markdown, rst, etc.)
  highlights["@markup"] = { fg = colors.fg }
  highlights["@markup.strong"] = { bold = true }
  highlights["@markup.italic"] = { italic = true }
  highlights["@markup.strikethrough"] = { strikethrough = true }
  highlights["@markup.underline"] = { underline = true }

  highlights["@markup.heading"] = { fg = colors.pink_bright, bold = true }
  highlights["@markup.heading.1"] =
    { fg = colors.pink_bright, bold = true, bg = colors.bg_highlight }
  highlights["@markup.heading.2"] = { fg = colors.purple, bold = true }
  highlights["@markup.heading.3"] = { fg = colors.cyan_bright, bold = true }
  highlights["@markup.heading.4"] = { fg = colors.yellow, bold = true }
  highlights["@markup.heading.5"] = { fg = colors.green_bright, bold = true }
  highlights["@markup.heading.6"] = { fg = colors.coral, bold = true }

  highlights["@markup.quote"] =
    { fg = colors.purple_muted, bg = colors.bg_highlight, italic = true }
  highlights["@markup.math"] = { fg = colors.green_bright }
  highlights["@markup.environment"] = { fg = colors.purple }
  highlights["@markup.link"] = { fg = colors.cyan_bright, underline = true, bold = true }
  highlights["@markup.link.label"] = { fg = colors.pink }
  highlights["@markup.link.url"] = { fg = colors.cyan, underline = true, italic = true }
  highlights["@markup.raw"] = { fg = colors.yellow, bg = colors.bg_highlight }
  highlights["@markup.raw.block"] = { fg = colors.yellow, bg = colors.bg_dark }
  highlights["@markup.list"] = { fg = colors.pink_bright }
  highlights["@markup.list.checked"] = { fg = colors.green_bright, bold = true }
  highlights["@markup.list.unchecked"] = { fg = colors.purple }

  -- Tags (HTML/JSX)
  highlights["@tag"] = { fg = sem.tag }
  highlights["@tag.builtin"] = { fg = colors.purple }
  highlights["@tag.attribute"] = { fg = sem.attribute }
  highlights["@tag.delimiter"] = { fg = colors.cyan_bright }

  -- Diff
  highlights["@diff.plus"] = { fg = colors.git_add }
  highlights["@diff.minus"] = { fg = colors.git_delete }
  highlights["@diff.delta"] = { fg = colors.git_change }

  -- Language specific highlights

  -- Python
  highlights["@variable.parameter.builtin.python"] = { fg = colors.coral, italic = true } -- self, cls
  highlights["@variable.builtin.python"] = { fg = colors.coral } -- __name__, __file__, etc
  -- Bash
  highlights["@function.builtin.bash"] = { fg = colors.red, italic = true }

  -- Java
  highlights["@constant.java"] = { fg = colors.cyan_bright }

  -- CSS
  highlights["@property.css"] = { fg = colors.pink }
  highlights["@property.id.css"] = { fg = colors.cyan_bright }
  highlights["@property.class.css"] = { fg = colors.yellow }
  highlights["@type.css"] = { fg = colors.pink }
  highlights["@type.tag.css"] = { fg = colors.purple }
  highlights["@string.plain.css"] = { fg = colors.coral }
  highlights["@number.css"] = { fg = colors.purple_dark }

  -- TOML
  highlights["@property.toml"] = { fg = colors.cyan_bright }

  -- JSON
  highlights["@label.json"] = { fg = colors.cyan_bright }

  -- Lua
  highlights["@constructor.lua"] = { fg = colors.pink }

  -- TypeScript/TSX
  highlights["@property.typescript"] = { fg = colors.pink }
  highlights["@constructor.typescript"] = { fg = colors.pink }
  highlights["@constructor.tsx"] = { fg = colors.pink }
  highlights["@tag.attribute.tsx"] = { fg = colors.cyan_bright, italic = true }

  -- YAML
  highlights["@variable.member.yaml"] = { fg = colors.cyan_bright }
  highlights["@field.yaml"] = { fg = colors.cyan_bright }
  highlights["@string.yaml"] = { fg = colors.pink_bright }
  highlights["@number.yaml"] = { fg = colors.purple_dark }
  highlights["@boolean.yaml"] = { fg = colors.pink }
  highlights["@constant.yaml"] = { fg = colors.purple }
  highlights["@constant.builtin.yaml"] = { fg = colors.coral }
  highlights["@punctuation.delimiter.yaml"] = { fg = colors.purple }
  highlights["@punctuation.special.yaml"] = { fg = colors.yellow }
  highlights["@label.yaml"] = { fg = colors.pink, bold = true }
  highlights["@type.yaml"] = { fg = colors.yellow }
  highlights["@keyword.yaml"] = { fg = colors.purple }
  highlights["@string.special.yaml"] = { fg = colors.coral }
  highlights["@comment.yaml"] = { fg = colors.purple_muted, italic = true }
  highlights["@operator.yaml"] = { fg = colors.cyan }
  highlights["@variable.yaml"] = { fg = colors.pink }

  -- Ruby
  highlights["@string.special.symbol.ruby"] = { fg = colors.pink }

  -- PHP
  highlights["@function.method.php"] = { link = "Function" }
  highlights["@function.method.call.php"] = { link = "Function" }

  -- C/CPP
  highlights["@type.builtin.c"] = { fg = colors.yellow }
  highlights["@property.cpp"] = { fg = colors.fg }
  highlights["@type.builtin.cpp"] = { fg = colors.yellow }

  -- Python
  highlights["@attribute.python"] = { fg = colors.green_bright }

  -- JavaScript/JSX
  highlights["@keyword.export"] = apply_style({ fg = colors.cyan }, "keywords")

  -- Gitignore
  highlights["@string.special.path.gitignore"] = { fg = colors.fg }

  -- Misc
  highlights["zshKSHFunction"] = { link = "Function" }

  -- Additional highlights for better coverage
  highlights["@keyword.modifier"] = apply_style({ fg = colors.purple }, "keywords")
  highlights["@keyword.type"] = apply_style({ fg = colors.purple }, "keywords")
  highlights["@keyword.storage"] = apply_style({ fg = colors.purple }, "keywords")

  -- Legacy mappings (for backward compatibility)
  highlights["@parameter"] = highlights["@variable.parameter"]
  highlights["@field"] = highlights["@variable.member"]
  highlights["@namespace"] = highlights["@module"]
  highlights["@float"] = highlights["@number.float"]
  highlights["@symbol"] = highlights["@string.special.symbol"]
  highlights["@string.regex"] = highlights["@string.regexp"]
  highlights["@text"] = highlights["@markup"]
  highlights["@text.strong"] = highlights["@markup.strong"]
  highlights["@text.emphasis"] = highlights["@markup.italic"]
  highlights["@text.underline"] = highlights["@markup.underline"]
  highlights["@text.strike"] = highlights["@markup.strikethrough"]
  highlights["@text.title"] = highlights["@markup.heading"]
  highlights["@text.literal"] = highlights["@markup.raw"]
  highlights["@text.uri"] = highlights["@markup.link.url"]
  highlights["@text.reference"] = highlights["@markup.link"]
  highlights["@method"] = highlights["@function.method"]
  highlights["@method.call"] = highlights["@function.method.call"]

  -- Git commit specific
  highlights["@comment.warning.gitcommit"] = { fg = colors.yellow }
  highlights["@text.gitcommit"] = { fg = colors.pink_bright }
  highlights["@text.title.gitcommit"] = { fg = colors.pink_bright, bold = true }
  highlights["@keyword.gitcommit"] = { fg = colors.purple }

  return highlights
end

return M
