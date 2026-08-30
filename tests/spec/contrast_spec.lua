-- WCAG contrast for the pairs a reader looks at all day.
--
-- The ratios are computed from the formula rather than from
-- lua/silkcircuit/utils/colors.lua, so a bug in the theme's own colour maths
-- cannot make this spec agree with it.
--
-- Only body text is asserted for now: fg on bg at AAA (7:1) and the muted
-- fg_dark at AA (4.5:1). The full terminal table is printed so a later pass
-- can tighten the rest against real numbers.

local H = require("helpers")
local describe, it = H.describe, H.it

local TERMINAL_KEYS = {
  "terminal_black",
  "terminal_red",
  "terminal_green",
  "terminal_yellow",
  "terminal_blue",
  "terminal_magenta",
  "terminal_cyan",
  "terminal_white",
}

local function colors_for(variant)
  H.reset_modules()
  return require("silkcircuit.variants").get_colors(variant)
end

describe("contrast", function()
  for _, variant in ipairs(H.variants) do
    it(variant .. " keeps body text readable", function()
      local colors = colors_for(variant)

      local fg = H.contrast(colors.fg, colors.bg)
      local muted = H.contrast(colors.fg_dark, colors.bg)

      H.note(string.format("%s  bg=%s", variant, colors.bg))
      H.note(string.format("  fg       %-9s %5.2f:1", colors.fg, fg))
      H.note(string.format("  fg_dark  %-9s %5.2f:1", colors.fg_dark, muted))
      for _, key in ipairs(TERMINAL_KEYS) do
        local value = colors[key]
        if H.is_hex6(value) then
          H.note(
            string.format(
              "  %-9s %-9s %5.2f:1",
              key:gsub("^terminal_", ""),
              value,
              H.contrast(value, colors.bg)
            )
          )
        end
      end

      H.at_least(fg, 7.0, variant .. ": fg on bg is below WCAG AAA")
      H.at_least(muted, 4.5, variant .. ": fg_dark on bg is below WCAG AA")
    end)
  end
end)
