-- COSMIC theme builders read ron with 0..1 float channels rather than hex, so
-- every color here goes through the rgbf table. The file is assembled from key
-- lists instead of one long template because the same triplet shape repeats
-- forty times and a typo in any of them is invisible until COSMIC rejects it.

local M = {}

-- palette.<field> -> palette key. Rendered with an alpha channel.
local PALETTE = {
  { "blue", "blue" },
  { "red", "red" },
  { "green", "green" },
  { "yellow", "yellow" },
  { "gray_1", "bg_dark" },
  { "gray_2", "bg" },
}

-- The accent and extended ramps, rendered after the neutral ramp.
local ACCENTS = {
  { "bright_green", "green" },
  { "bright_red", "red" },
  { "bright_orange", "orange" },
  { "ext_warm_grey", "gray" },
  { "ext_orange", "orange" },
  { "ext_yellow", "yellow" },
  { "ext_blue", "blue" },
  { "ext_purple", "purple" },
  { "ext_pink", "pink" },
  { "ext_indigo", "purple_muted" },
  { "accent_blue", "blue" },
  { "accent_indigo", "purple_muted" },
  { "accent_purple", "purple" },
  { "accent_pink", "pink" },
  { "accent_red", "red" },
  { "accent_orange", "orange" },
  { "accent_yellow", "yellow" },
  { "accent_green", "green" },
  { "accent_warm_grey", "gray" },
}

-- Top-level surfaces, rendered as Some((...)) with an alpha channel.
local SURFACES = {
  { "bg_color", "bg" },
  { "primary_container_bg", "bg_highlight" },
  { "secondary_container_bg", "bg_dark" },
}

-- Top-level tints and semantic colors. COSMIC reads these without alpha.
local TINTS = {
  { "text_tint", "fg_dark" },
  { "neutral_tint", "purple_muted" },
  { "accent", "purple" },
  { "success", "green" },
  { "warning", "yellow" },
  { "destructive", "red" },
}

local SPACING = [[
    spacing: (
        space_none: 0,
        space_xxxs: 4,
        space_xxs: 8,
        space_xs: 12,
        space_s: 16,
        space_m: 24,
        space_l: 32,
        space_xl: 48,
        space_xxl: 64,
        space_xxxl: 128,
    ),
    corner_radii: (
        radius_0: (0.0, 0.0, 0.0, 0.0),
        radius_xs: (4.0, 4.0, 4.0, 4.0),
        radius_s: (8.0, 8.0, 8.0, 8.0),
        radius_m: (16.0, 16.0, 16.0, 16.0),
        radius_l: (32.0, 32.0, 32.0, 32.0),
        radius_xl: (160.0, 160.0, 160.0, 160.0),
    ),]]

local function triplet(colors, key, alpha)
  local c = colors.rgbf[key]
  if not c then
    error(string.format("silkcircuit.extra.cosmic: no color '%s' in the palette", key), 0)
  end
  return string.format(
    "(red: %s, green: %s, blue: %s%s)",
    c.r,
    c.g,
    c.b,
    alpha and ", alpha: 1.0" or ""
  )
end

--- COSMIC's neutral_0 through neutral_10 is an even eleven-step ramp between
--- the palette's darkest and lightest anchors. Dark variants run bg_dark up to
--- fg; the light variant runs the same two colors the other way round, because
--- the ramp is always ordered dark end first.
local function neutrals(colors, indent)
  local light = colors.meta.appearance == "light"
  local from = light and colors.rgb.fg or colors.rgb.bg_dark
  local to = light and colors.rgb.bg_dark or colors.rgb.fg

  local lines = {}
  for step = 0, 10 do
    local t = step / 10
    local channels = {}
    for index, channel in ipairs({ "r", "g", "b" }) do
      local value = math.floor(from[channel] + (to[channel] - from[channel]) * t + 0.5)
      channels[index] = string.format("%.6f", value / 255)
    end
    lines[#lines + 1] = string.format(
      "%sneutral_%d: (red: %s, green: %s, blue: %s, alpha: 1.0),",
      indent,
      step,
      channels[1],
      channels[2],
      channels[3]
    )
  end
  return table.concat(lines, "\n")
end

local function entries(colors, list, indent, alpha)
  local lines = {}
  for _, entry in ipairs(list) do
    lines[#lines + 1] = indent .. entry[1] .. ": " .. triplet(colors, entry[2], alpha) .. ","
  end
  return table.concat(lines, "\n")
end

local function some(colors, list, indent, alpha)
  local lines = {}
  for _, entry in ipairs(list) do
    lines[#lines + 1] = indent .. entry[1] .. ": Some(" .. triplet(colors, entry[2], alpha) .. "),"
  end
  return table.concat(lines, "\n")
end

function M.generate(colors)
  local mode = colors.meta.appearance == "light" and "Light" or "Dark"

  return table.concat({
    "(",
    "    palette: " .. mode .. "((",
    '        name: "' .. colors.meta.name .. '",',
    entries(colors, PALETTE, "        ", true),
    neutrals(colors, "        "),
    entries(colors, ACCENTS, "        ", true),
    "    )),",
    SPACING,
    some(colors, SURFACES, "    ", true),
    some(colors, TINTS, "    ", false),
    "    is_frosted: false,",
    "    window_hint: Some(" .. triplet(colors, "purple", false) .. "),",
    "    gaps: (0, 8),",
    "    active_hint: 3,",
    ")",
  }, "\n")
end

return M
