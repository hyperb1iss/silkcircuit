local M = {}

-- which-key v3 renders in its own float with a Normal and a Title, and colours
-- each entry's icon by name. The colour names are which-key's own vocabulary
-- (it borrows them from mini.icons), so Azure and Grey have to exist even
-- though the theme has no colour by either name; each maps onto the nearest
-- role the palette already carries.
function M.get(colors, opts)
  local icon_colors = {
    Azure = colors.blue,
    Blue = colors.info,
    Cyan = colors.cyan,
    Green = colors.green,
    Grey = colors.fg_dark,
    Orange = colors.coral,
    Purple = colors.purple,
    Red = colors.error,
    Yellow = colors.warning,
  }

  local highlights = {
    WhichKey = { link = "NormalFloat" },
    WhichKeyNormal = {
      fg = colors.fg,
      bg = opts.transparent and colors.none or colors.bg_float,
    },
    WhichKeyBorder = { fg = colors.purple },
    WhichKeyTitle = { fg = colors.pink, bold = true },

    WhichKeyGroup = { fg = colors.pink, bold = true },
    WhichKeySeparator = { fg = colors.purple_muted },
    WhichKeySeperator = { fg = colors.purple_muted },
    WhichKeyDesc = { fg = colors.cyan },
    WhichKeyValue = { fg = colors.green },

    WhichKeyFloat = { bg = colors.bg_dark },
    WhichKeyIcon = { fg = colors.pink_bright },
  }

  for name, color in pairs(icon_colors) do
    highlights["WhichKeyIcon" .. name] = { fg = color }
  end

  return highlights
end

return M
