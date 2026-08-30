-- Colour maths in lua/silkcircuit/utils/colors.lua. Everything the palette and
-- the contrast tooling are built on.

local H = require("helpers")
local describe, it = H.describe, H.it

local function utils()
  H.reset_modules()
  return require("silkcircuit.utils.colors")
end

describe("colour utils", function()
  it("hex_to_rgb splits the channels", function()
    local colors = utils()

    local r, g, b = colors.hex_to_rgb("#ff0000")
    H.eq({ r, g, b }, { 255, 0, 0 }, "red")

    r, g, b = colors.hex_to_rgb("#00ff00")
    H.eq({ r, g, b }, { 0, 255, 0 }, "green")

    r, g, b = colors.hex_to_rgb("#0000FF")
    H.eq({ r, g, b }, { 0, 0, 255 }, "blue, upper case")
  end)

  it("rgb_to_hex round-trips", function()
    local colors = utils()
    H.eq(colors.rgb_to_hex(255, 0, 0), "#ff0000", "red")
    H.eq(colors.rgb_to_hex(0, 255, 0), "#00ff00", "green")
    H.eq(colors.rgb_to_hex(0, 0, 255), "#0000ff", "blue")
  end)

  it("blend mixes two colours", function()
    local colors = utils()
    H.eq(colors.blend("#ff0000", "#0000ff", 0.5):lower(), "#800080", "half red, half blue")
    H.eq(colors.blend("#ffffff", "#000000", 0.5):lower(), "#808080", "half white, half black")
  end)

  it("darken and lighten move brightness", function()
    local colors = utils()
    H.eq(colors.darken("#ffffff", 0.5):lower(), "#808080", "white darkened by half")
    H.eq(colors.lighten("#808080", 0.5):lower(), "#c0c0c0", "grey lightened by half")
  end)

  it("get_luminance brackets black and white", function()
    local colors = utils()
    H.ok(colors.get_luminance("#ffffff") > 0.99, "white is at the top of the range")
    H.ok(colors.get_luminance("#000000") < 0.01, "black is at the bottom")
  end)

  it("its contrast maths agrees with the specs' own", function()
    local colors = utils()
    for _, pair in ipairs({
      { "#ffffff", "#000000" },
      { "#e9d5ff", "#12101a" },
      { "#777777", "#888888" },
    }) do
      local theirs = colors.get_contrast_ratio(pair[1], pair[2])
      local ours = H.contrast(pair[1], pair[2])
      H.ok(
        math.abs(theirs - ours) < 0.01,
        string.format("%s on %s: theme says %.3f, spec says %.3f", pair[1], pair[2], theirs, ours)
      )
    end
  end)

  it("meets_wcag_aa applies the 4.5:1 threshold", function()
    local colors = utils()
    H.eq(colors.meets_wcag_aa("#ffffff", "#000000"), true, "white on black passes")
    H.eq(colors.meets_wcag_aa("#777777", "#888888"), false, "near-identical greys fail")
  end)
end)
