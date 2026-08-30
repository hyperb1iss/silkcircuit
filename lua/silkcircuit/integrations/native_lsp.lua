local M = {}

-- Native LSP integration for SilkCircuit theme
-- Provides enhanced syntax highlighting and UI elements for Neovim's built-in LSP

function M.get(colors, opts)
  local highlights = {}

  -- LSP Diagnostic Signs
  highlights.DiagnosticError = { fg = colors.error }
  highlights.DiagnosticWarn = { fg = colors.warning }
  highlights.DiagnosticInfo = { fg = colors.info }
  highlights.DiagnosticHint = { fg = colors.hint }
  highlights.DiagnosticOk = { fg = colors.green_bright }

  -- LSP Diagnostic Virtual Text
  highlights.DiagnosticVirtualTextError =
    { fg = colors.error, bg = colors.bg_highlight, italic = true }
  highlights.DiagnosticVirtualTextWarn =
    { fg = colors.warning, bg = colors.bg_highlight, italic = true }
  highlights.DiagnosticVirtualTextInfo =
    { fg = colors.info, bg = colors.bg_highlight, italic = true }
  highlights.DiagnosticVirtualTextHint =
    { fg = colors.hint, bg = colors.bg_highlight, italic = true }
  highlights.DiagnosticVirtualTextOk =
    { fg = colors.green_bright, bg = colors.bg_highlight, italic = true }

  -- LSP Diagnostic Underlines
  highlights.DiagnosticUnderlineError = { undercurl = true, sp = colors.error }
  highlights.DiagnosticUnderlineWarn = { undercurl = true, sp = colors.warning }
  highlights.DiagnosticUnderlineInfo = { undercurl = true, sp = colors.info }
  highlights.DiagnosticUnderlineHint = { undercurl = true, sp = colors.hint }
  highlights.DiagnosticUnderlineOk = { undercurl = true, sp = colors.green_bright }

  -- LSP Diagnostic Floating Windows
  highlights.DiagnosticFloatingError = { fg = colors.error, bg = colors.bg_highlight }
  highlights.DiagnosticFloatingWarn = { fg = colors.warning, bg = colors.bg_highlight }
  highlights.DiagnosticFloatingInfo = { fg = colors.info, bg = colors.bg_highlight }
  highlights.DiagnosticFloatingHint = { fg = colors.hint, bg = colors.bg_highlight }
  highlights.DiagnosticFloatingOk = { fg = colors.green_bright, bg = colors.bg_highlight }

  -- LSP Diagnostic Signs in Sign Column
  highlights.DiagnosticSignError = { fg = colors.error, bg = colors.bg }
  highlights.DiagnosticSignWarn = { fg = colors.warning, bg = colors.bg }
  highlights.DiagnosticSignInfo = { fg = colors.info, bg = colors.bg }
  highlights.DiagnosticSignHint = { fg = colors.hint, bg = colors.bg }
  highlights.DiagnosticSignOk = { fg = colors.green_bright, bg = colors.bg }

  -- Code the server marks as unused or deprecated. Both are deliberately
  -- de-emphasised: Unnecessary reads as dead weight, Deprecated keeps the
  -- surrounding foreground and only strikes through in the warning colour.
  highlights.DiagnosticUnnecessary = { link = "Comment" }
  highlights.DiagnosticDeprecated = { strikethrough = true, sp = colors.warning }

  -- LSP References. Target is the symbol under the cursor itself, the one the
  -- other three are references to.
  highlights.LspReferenceText = { bg = colors.bg_highlight, bold = true }
  highlights.LspReferenceRead = { bg = colors.bg_highlight, bold = true }
  highlights.LspReferenceWrite = { bg = colors.selection, bold = true }
  highlights.LspReferenceTarget = { bg = colors.selection_highlight, bold = true }

  -- LSP Signature Help
  highlights.LspSignatureActiveParameter = { fg = colors.pink_bright, bold = true, italic = true }

  -- LSP Code Lens
  highlights.LspCodeLens = { fg = colors.purple_muted, italic = true }
  highlights.LspCodeLensSeparator = { fg = colors.gray }

  -- LSP Info Border (for hover/signature help)
  highlights.LspInfoBorder = { fg = colors.cyan_bright, bg = colors.bg_highlight }

  -- LSP Semantic Tokens
  -- These provide more granular syntax highlighting
  highlights.LspKindText = { fg = colors.fg }
  highlights.LspKindMethod = { fg = colors.glow_purple }
  highlights.LspKindFunction = { fg = colors.glow_purple }
  highlights.LspKindConstructor = { fg = colors.pink }
  highlights.LspKindField = { fg = colors.cyan_bright }
  highlights.LspKindVariable = { fg = colors.pink }
  highlights.LspKindClass = { fg = colors.yellow }
  highlights.LspKindInterface = { fg = colors.pink }
  highlights.LspKindModule = { fg = colors.purple }
  highlights.LspKindProperty = { fg = colors.cyan_bright }
  highlights.LspKindUnit = { fg = colors.purple_dark }
  highlights.LspKindValue = { fg = colors.purple_dark }
  highlights.LspKindEnum = { fg = colors.yellow }
  highlights.LspKindKeyword = { fg = colors.purple }
  highlights.LspKindSnippet = { fg = colors.cyan }
  highlights.LspKindColor = { fg = colors.coral }
  highlights.LspKindFile = { fg = colors.blue }
  highlights.LspKindReference = { fg = colors.cyan }
  highlights.LspKindFolder = { fg = colors.blue }
  highlights.LspKindEnumMember = { fg = colors.purple_dark }
  highlights.LspKindConstant = { fg = colors.purple_dark }
  highlights.LspKindStruct = { fg = colors.yellow }
  highlights.LspKindEvent = { fg = colors.pink }
  highlights.LspKindOperator = { fg = colors.cyan }
  highlights.LspKindTypeParameter = { fg = colors.purple }

  highlights.LspInlayHint = {
    fg = colors.purple_muted,
    bg = opts.transparent and colors.none or colors.bg_dark,
    italic = true,
  }

  -- Document Highlight Groups (when cursor is on a symbol)
  highlights.IlluminatedWordText = { bg = colors.selection }
  highlights.IlluminatedWordRead = { bg = colors.selection }
  highlights.IlluminatedWordWrite = { bg = colors.selection_highlight }

  -- LSP Diagnostics Line Number highlights
  highlights.DiagnosticLineNrError = { fg = colors.error, bg = colors.bg_highlight, bold = true }
  highlights.DiagnosticLineNrWarn = { fg = colors.warning, bg = colors.bg_highlight, bold = true }
  highlights.DiagnosticLineNrInfo = { fg = colors.info, bg = colors.bg_highlight, bold = true }
  highlights.DiagnosticLineNrHint = { fg = colors.hint, bg = colors.bg_highlight, bold = true }

  -- LSP Progress (for fidget.nvim or similar)
  highlights.LspProgressTitle = { fg = colors.pink_bright, bold = true }
  highlights.LspProgressClient = { fg = colors.purple }
  highlights.LspProgressSpinner = { fg = colors.cyan_bright }

  -- Hover Documentation
  highlights.HoverBorder = { fg = colors.cyan_bright, bg = colors.bg_highlight }
  highlights.HoverNormal = { fg = colors.fg, bg = colors.bg_highlight }

  -- Code Actions
  highlights.CodeActionBorder = { fg = colors.purple, bg = colors.bg_highlight }
  highlights.CodeActionNormal = { fg = colors.fg, bg = colors.bg_highlight }
  highlights.CodeActionTitle = { fg = colors.pink_bright, bg = colors.bg_highlight, bold = true }

  -- Rename
  highlights.RenameBorder = { fg = colors.pink, bg = colors.bg_highlight }
  highlights.RenameNormal = { fg = colors.fg, bg = colors.bg_highlight }
  highlights.RenameTitle = { fg = colors.pink_bright, bg = colors.bg_highlight, bold = true }

  -- LSP Saga specific (if used)
  highlights.SagaBorder = { fg = colors.cyan_bright }
  highlights.SagaNormal = { bg = colors.bg_highlight }
  highlights.SagaTitle = { fg = colors.pink_bright, bold = true }
  highlights.SagaCodeActionTitle = { fg = colors.purple, bold = true }
  highlights.SagaCodeActionContent = { fg = colors.fg }
  highlights.SagaFinderSelection = { fg = colors.pink, bg = colors.selection }
  highlights.SagaHoverBorder = { fg = colors.cyan_bright }
  highlights.SagaRenameBorder = { fg = colors.pink }
  highlights.SagaRenameMatch = { bg = colors.selection, fg = colors.pink_bright }

  -- Lightbulb (code action indicator)
  highlights.LightBulbSign = { fg = colors.yellow, bg = colors.bg }
  highlights.LightBulbVirtualText = { fg = colors.yellow, italic = true }

  -- LSP Semantic Token Type highlights
  local sem = require("silkcircuit.palette").semantic
  highlights["@lsp.type.namespace"] = { fg = sem.namespace }
  highlights["@lsp.type.type"] = { fg = sem.type }
  highlights["@lsp.type.class"] = { fg = sem.class }
  highlights["@lsp.type.enum"] = { fg = sem.type }
  highlights["@lsp.type.interface"] = { fg = colors.pink }
  highlights["@lsp.type.struct"] = { fg = sem.type }
  highlights["@lsp.type.parameter"] = { fg = sem.parameter }
  highlights["@lsp.type.variable"] = { fg = sem.variable }
  highlights["@lsp.type.property"] = { fg = sem.property }
  highlights["@lsp.type.enumMember"] = { fg = sem.constant }
  highlights["@lsp.type.function"] = { fg = sem.func }
  highlights["@lsp.type.method"] = { fg = sem.method }
  highlights["@lsp.type.macro"] = { fg = colors.purple }
  highlights["@lsp.type.decorator"] = { fg = sem.decorator }

  highlights["@lsp.type.event"] = { link = "@constant" }
  highlights["@lsp.type.modifier"] = { link = "@keyword.modifier" }
  highlights["@lsp.type.regexp"] = { link = "@string.regexp" }
  highlights["@lsp.type.string"] = { link = "@string" }
  highlights["@lsp.type.typeParameter"] = { link = "@type" }

  -- LSP Semantic Token links
  highlights["@lsp.type.boolean"] = { link = "@boolean" }
  highlights["@lsp.type.builtinType"] = { link = "@type.builtin" }
  highlights["@lsp.type.comment"] = { link = "@comment" }
  highlights["@lsp.type.escapeSequence"] = { link = "@string.escape" }
  highlights["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" }
  highlights["@lsp.type.keyword"] = { link = "@keyword" }
  highlights["@lsp.type.number"] = { link = "@number" }
  highlights["@lsp.type.operator"] = { link = "@operator" }
  highlights["@lsp.type.selfKeyword"] = { link = "@variable.builtin" }
  highlights["@lsp.type.typeAlias"] = { link = "@type.definition" }
  highlights["@lsp.type.unresolvedReference"] = { link = "@error" }
  highlights["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" }
  highlights["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" }
  highlights["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" }
  highlights["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" }
  highlights["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" }
  highlights["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" }
  highlights["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" }
  highlights["@lsp.typemod.operator.injected"] = { link = "@operator" }
  highlights["@lsp.typemod.string.injected"] = { link = "@string" }
  highlights["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" }
  highlights["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" }
  highlights["@lsp.typemod.variable.injected"] = { link = "@variable" }
  highlights["@lsp.mod.deprecated"] = { link = "DiagnosticDeprecated" }

  return highlights
end

return M
