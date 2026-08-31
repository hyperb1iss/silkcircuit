-- WCAG contrast for the pairs a reader looks at all day.
--
-- The ratios are computed from the formula rather than from
-- lua/silkcircuit/utils/colors.lua, so a bug in the theme's own colour maths
-- cannot make this spec agree with it.
--
-- Two bars, matching what each role actually is:
--
--   ink     4.5:1, body text. Every syntax and diagnostic colour, plus gray,
--           which carries line numbers. Measured against every surface a
--           target paints text on: the page, the float body and the
--           cursorline band. gray reaches a float through Noice, whose
--           NoiceFormatDate, NoiceFormatLevelDebug and NoiceFormatLevelOff
--           carry no background and so composite on NoiceCmdlinePopup.
--   chrome  3:1, non-text UI: separators, borders, indent guides, and the
--           accents that only ever fill an ANSI bright slot or a gradient
--           stop. A key earns this tier by having no consumer that renders
--           it as text, which is checked by grep, not assumed.
--
-- divider is not text at all and takes neither bar. A contrast floor would
-- push a line toward reading as text, so it is gated on being distinct from
-- the three surfaces it most often has to be seen against instead. The other
-- surfaces it can border, bg_dark and bg_statusline, are not covered.
--
-- gray_muted is the one text colour under neither bar. It marks ignored and
-- trace-level output in Snacks, lsd and bat, where being hard to read is the
-- point, and it measures 2.43 to 3.03:1. It is left ungated deliberately
-- rather than by omission.
--
-- The terminal table takes 3:1 on the page for the six chromatic normals.
-- black and white are the poles of the ramp rather than colours, and on dawn
-- ANSI white is the page itself, so gating them would assert nothing.

local H = require("helpers")
local describe, it = H.describe, H.it

local INK_ROLES = {
  "fg",
  "fg_dark",
  "purple",
  "purple_dark",
  "purple_muted",
  "pink",
  "pink_soft",
  "pink_bright",
  "cyan",
  "cyan_bright",
  "green",
  "green_bright",
  "yellow",
  "coral",
  "orange",
  "blue",
  "red",
  "error",
  "warning",
  "info",
  "hint",
  "git_add",
  "git_change",
  "git_delete",
  "fg_light",
  -- carries line numbers, and Noice composites it on a float body
  "gray",
  -- type.builtin in Helix, rainbow delimiters and neotree file sizes in
  -- Neovim, and git_changed in the AstroNvim contrib theme
  "yellow_bright",
  "red_dark",
  "red_error",
  -- markdown headings, Aerial and Alpha titles, and glow.lua's String
  "glow_purple",
  "glow_pink",
  "glow_cyan",
  -- derived in variants.lua, and rendered as syntax like the rest
  "keyword",
  "string",
  "comment",
  "operator",
}

local CHROME_ROLES = {
  "fg_gutter",
  "blue_gray",
  "gray_dark",
  "border",
  "red_bright",
  "blue_bright",
  "cyan_light",
  "green_light",
  "blue_light",
  "yellow_light",
  -- focus rings, active indicators and the hovered button. accent_border also
  -- reaches six VS Code foregrounds, but it is the same value the ink tier
  -- already gates under cyan_bright or purple, so 3:1 here is the floor for
  -- its chrome duty rather than the only bar the colour has to clear.
  "accent_border",
  "accent_hover",
}

-- divider is under neither bar. It is the line between two surfaces, so a
-- contrast floor would push it toward reading as text and a ceiling is not
-- something WCAG has an opinion about. What has to hold is that it is not any
-- of the surfaces it separates, which is what the spec below checks.
local DIVIDER_NEIGHBOURS = { "bg", "bg_float", "bg_highlight" }

local TERMINAL_NORMALS = {
  "terminal_red",
  "terminal_green",
  "terminal_yellow",
  "terminal_blue",
  "terminal_magenta",
  "terminal_cyan",
}

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

-- Surfaces a target paints text on, named for the report.
local INK_SURFACES = { "bg", "bg_float", "bg_highlight" }

local function colors_for(variant)
  H.reset_modules()
  return require("silkcircuit.variants").get_colors(variant)
end

-- Measure `keys` against `surfaces` and report the worst pair per key.
local function check(colors, keys, surfaces, minimum, variant, label)
  for _, key in ipairs(keys) do
    local value = colors[key]
    if H.is_hex6(value) then
      for _, surface in ipairs(surfaces) do
        local ratio = H.contrast(value, colors[surface])
        H.at_least(
          ratio,
          minimum,
          string.format(
            "%s: %s (%s, %s) on %s (%s) is %.2f:1, needs %.1f:1",
            variant,
            key,
            value,
            label,
            surface,
            colors[surface],
            ratio,
            minimum
          )
        )
      end
    end
  end
end

-- The lowest ratio any of `keys` reaches across `surfaces`, for the log.
local function worst(colors, keys, surfaces)
  local low, low_key, low_surface = math.huge, nil, nil
  for _, key in ipairs(keys) do
    local value = colors[key]
    if H.is_hex6(value) then
      for _, surface in ipairs(surfaces) do
        local ratio = H.contrast(value, colors[surface])
        if ratio < low then
          low, low_key, low_surface = ratio, key, surface
        end
      end
    end
  end
  return low, low_key, low_surface
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

    it(variant .. " keeps every syntax colour at AA on every text surface", function()
      local colors = colors_for(variant)

      local low, key, surface = worst(colors, INK_ROLES, INK_SURFACES)
      H.note(
        string.format(
          "%s  worst ink %s (%s) on %s: %.2f:1",
          variant,
          key,
          colors[key],
          surface,
          low
        )
      )

      check(colors, INK_ROLES, INK_SURFACES, 4.5, variant, "ink")
    end)

    it(variant .. " keeps chrome and accents at 3:1", function()
      local colors = colors_for(variant)

      local low, key, surface = worst(colors, CHROME_ROLES, INK_SURFACES)
      H.note(
        string.format(
          "%s  worst chrome %s (%s) on %s: %.2f:1",
          variant,
          key,
          colors[key],
          surface,
          low
        )
      )

      check(colors, CHROME_ROLES, INK_SURFACES, 3.0, variant, "chrome")
    end)

    it(variant .. " keeps the divider off every surface it separates", function()
      local colors = colors_for(variant)
      local collisions = {}

      for _, surface in ipairs(DIVIDER_NEIGHBOURS) do
        H.note(
          string.format(
            "  divider %s on %-13s %-9s %5.2f:1",
            colors.divider,
            surface,
            colors[surface],
            H.contrast(colors.divider, colors[surface])
          )
        )
        if colors.divider == colors[surface] then
          collisions[#collisions + 1] = surface .. " (" .. colors[surface] .. ")"
        end
      end

      H.empty(
        collisions,
        variant .. ": divider is the same colour as a surface, so the line it draws is not there"
      )
    end)

    it(variant .. " keeps the terminal normals at 3:1", function()
      local colors = colors_for(variant)

      check(colors, TERMINAL_NORMALS, { "bg" }, 3.0, variant, "ansi normal")
    end)
  end
end)
