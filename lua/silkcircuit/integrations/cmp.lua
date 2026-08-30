local M = {}

function M.highlights(colors, _)
  return {
    CmpItemAbbr = { fg = colors.fg },
    CmpItemAbbrDeprecated = { fg = colors.gray, strikethrough = true },
    CmpItemAbbrMatch = { fg = colors.cyan, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = colors.cyan, bold = true },

    CmpItemKind = { fg = colors.purple },
    CmpItemKindText = { fg = colors.fg },
    CmpItemKindMethod = { fg = colors.blue },
    CmpItemKindFunction = { fg = colors.blue },
    CmpItemKindConstructor = { fg = colors.orange },
    CmpItemKindField = { fg = colors.green },
    CmpItemKindVariable = { fg = colors.cyan },
    CmpItemKindClass = { fg = colors.orange },
    CmpItemKindInterface = { fg = colors.orange },
    CmpItemKindModule = { fg = colors.purple },
    CmpItemKindProperty = { fg = colors.green },
    CmpItemKindUnit = { fg = colors.orange },
    CmpItemKindValue = { fg = colors.cyan },
    CmpItemKindEnum = { fg = colors.orange },
    CmpItemKindKeyword = { fg = colors.purple },
    CmpItemKindSnippet = { fg = colors.green },
    CmpItemKindColor = { fg = colors.cyan },
    CmpItemKindFile = { fg = colors.blue },
    CmpItemKindReference = { fg = colors.cyan },
    CmpItemKindFolder = { fg = colors.blue },
    CmpItemKindEnumMember = { fg = colors.cyan },
    CmpItemKindConstant = { fg = colors.cyan },
    CmpItemKindStruct = { fg = colors.orange },
    CmpItemKindEvent = { fg = colors.orange },
    CmpItemKindOperator = { fg = colors.cyan },
    CmpItemKindTypeParameter = { fg = colors.cyan },

    CmpItemMenu = { fg = colors.gray },

    -- Ghost text
    CmpGhostText = { fg = colors.gray, italic = true },

    -- Copilot
    CmpItemKindCopilot = { fg = colors.cyan },

    -- Codeium
    CmpItemKindCodeium = { fg = colors.cyan },

    -- TabNine
    CmpItemKindTabNine = { fg = colors.cyan },
  }
end

return M
