-- Every variant must hand out colours Neovim can actually consume, and all
-- five must describe the same palette so a highlight written against one is
-- meaningful in the others.

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
  "terminal_bright_black",
  "terminal_bright_red",
  "terminal_bright_green",
  "terminal_bright_yellow",
  "terminal_bright_blue",
  "terminal_bright_magenta",
  "terminal_bright_cyan",
  "terminal_bright_white",
}

-- Keys the theme and its integrations read by name. A missing one resolves to
-- nil, and a highlight built from nil is a cleared highlight.
local REQUIRED_KEYS = {
  "bg",
  "bg_dark",
  "bg_highlight",
  "bg_float",
  "divider",
  "shadow",
  "fg",
  "fg_dark",
  "border",
  "accent_border",
  "accent_hover",
  "accent_warm",
  "keyword",
  "operator",
  "string",
  "comment",
  "error",
  "warning",
  "info",
  "hint",
}
for _, key in ipairs(TERMINAL_KEYS) do
  REQUIRED_KEYS[#REQUIRED_KEYS + 1] = key
end

local function colors_for(variant)
  H.reset_modules()
  return require("silkcircuit.variants").get_colors(variant)
end

describe("palette", function()
  for _, variant in ipairs(H.variants) do
    it(variant .. " uses only 6-digit hex colours", function()
      local colors = colors_for(variant)
      local offenders = {}
      for _, key in ipairs(H.sorted_keys(colors)) do
        local value = colors[key]
        if type(value) == "string" and value:sub(1, 1) == "#" and not H.is_hex6(value) then
          offenders[#offenders + 1] = key .. " = " .. value
        end
      end
      H.empty(
        offenders,
        variant
          .. ": nvim_set_hl rejects anything but #RRGGBB, so these values never reach a highlight"
      )
    end)

    it(variant .. " defines every colour the theme reads", function()
      local colors = colors_for(variant)
      local missing = {}
      for _, key in ipairs(REQUIRED_KEYS) do
        if colors[key] == nil then
          missing[#missing + 1] = key
        end
      end
      H.empty(missing, variant .. ": colour keys read by the theme but never defined")
    end)
  end

  -- derive_keys answers accent_border off border for anything that does not
  -- name its own, which is right for the dark variants and wrong for dawn: a
  -- deleted literal would quietly hand the light theme the cyan chrome ring
  -- the dark variants use. Nothing else in the suite can see that happen, so
  -- dawn's own answers are pinned to the families it is built around.
  it("keeps dawn's accents in its own purple and pink", function()
    local colors = colors_for("dawn")
    H.eq(colors.accent_border, colors.purple, "dawn: accent_border left the purple family")
    H.eq(colors.accent_hover, colors.pink, "dawn: accent_hover left the pink family")
    H.eq(colors.accent_warm, colors.pink, "dawn: accent_warm left the pink family")
  end)

  it("gives all five variants the same key set", function()
    local reference = colors_for("neon")
    local expected = H.sorted_keys(reference)

    for _, variant in ipairs(H.variants) do
      if variant ~= "neon" then
        local colors = colors_for(variant)
        H.eq(H.sorted_keys(colors), expected, variant .. " does not match neon's key set")
      end
    end
  end)
end)
