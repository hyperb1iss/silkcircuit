-- The powerline ramp the Starship prompt and the Claude Code status line
-- share, so the prompt above the input box and the status line below it read
-- as one instrument.
--
-- Neon is hand-tuned: a magenta ramp at roughly sixty percent saturation,
-- climbing from near the page to a hot pink cap, with light pink text on every
-- step. Every other variant is derived to match its shape.

local M = {}

local color_utils = require("silkcircuit.utils.colors")

M.NEON = {
  background = "#1a1a2e",
  segment_1 = "#4a1a4a",
  segment_2 = "#7a2d7a",
  segment_3 = "#a040a0",
  segment_4 = "#d060d0",
  segment_5 = "#ff69b4",
  foreground_1 = "#ff99ff",
  foreground_root = "#ff4444",
  foreground_host = "#ff66ff",
  foreground_2 = "#ff99cc",
  foreground_3 = "#ff99ff",
  foreground_4 = "#ffeeff",
  foreground_warning = "#1a1a2e",
  warning = "#ffcc00",
  danger = "#ff6666",
}

-- Blend tone toward bg until the result sits at the luminance of target, so
-- a variant's ramp climbs the same ladder neon does in its own hue.
local function match_luminance(tone, bg, target)
  local goal = color_utils.get_luminance(target)
  local lo, hi = 0, 1
  for _ = 1, 24 do
    local mid = (lo + hi) / 2
    if color_utils.get_luminance(color_utils.blend(tone, bg, mid)) < goal then
      lo = mid
    else
      hi = mid
    end
  end
  return color_utils.blend(tone, bg, (lo + hi) / 2)
end

-- The hue each dark variant climbs. Neon owns magenta, so the others take
-- their purple: glow's is a true electric violet, while vibrant and soft
-- name a magenta there and keep the violet in purple_dark.
local TONE = {
  glow = "purple",
  vibrant = "purple_dark",
  soft = "purple_dark",
}

-- Dark variants ramp their tone up the neon luminance ladder, so every step
-- lands at the brightness of its neon twin, and cap with the variant's
-- hottest pink.
local function dark(colors)
  local tone = colors[TONE[colors.meta.variant] or "purple_dark"]
  return {
    background = colors.bg,
    segment_1 = match_luminance(tone, colors.bg, M.NEON.segment_1),
    segment_2 = match_luminance(tone, colors.bg, M.NEON.segment_2),
    segment_3 = match_luminance(tone, colors.bg, M.NEON.segment_3),
    segment_4 = match_luminance(tone, colors.bg, M.NEON.segment_4),
    segment_5 = colors.coral,
    foreground_1 = colors.pink_soft,
    foreground_root = colors.red,
    foreground_host = colors.pink_bright,
    foreground_2 = colors.pink_soft,
    foreground_3 = colors.pink_soft,
    foreground_4 = colors.fg,
    foreground_warning = colors.bg,
    warning = colors.yellow,
    danger = colors.red,
  }
end

-- A light page mirrors the ladder: pink tints deepen step by step under dark
-- text, and the cap is the full pink.
local function light(colors)
  local tone = colors.pink
  return {
    background = colors.bg,
    segment_1 = color_utils.blend(tone, colors.bg, 0.15),
    segment_2 = color_utils.blend(tone, colors.bg, 0.3),
    segment_3 = color_utils.blend(tone, colors.bg, 0.45),
    segment_4 = color_utils.blend(tone, colors.bg, 0.65),
    segment_5 = tone,
    foreground_1 = colors.fg,
    foreground_root = colors.red,
    foreground_host = colors.purple,
    foreground_2 = colors.fg,
    foreground_3 = colors.fg,
    foreground_4 = colors.fg,
    foreground_warning = colors.bg,
    warning = colors.yellow,
    danger = colors.red,
  }
end

-- Lift text away from surface, toward the ramp's brightest text, until the
-- pair clears WCAG AA. The alert colours are mid-luminance reds and golds
-- that do not all read on their own dark surface unlit.
local function readable(text, surface, toward)
  if color_utils.get_contrast_ratio(text, surface) >= 4.5 then
    return text
  end
  local lo, hi = 0, 1
  for _ = 1, 24 do
    local mid = (lo + hi) / 2
    if color_utils.get_contrast_ratio(color_utils.blend(toward, text, mid), surface) < 4.5 then
      lo = mid
    else
      hi = mid
    end
  end
  return color_utils.blend(toward, text, hi)
end

-- A hot reading sits on a dark pill, the alert hue sunk a quarter of the way
-- into the page, with the alert colour itself as text. The status line stays
-- in the dark even when every reading is red.
local function with_alerts(ramp)
  for _, alert in ipairs({ "warning", "danger" }) do
    local surface = color_utils.blend(ramp[alert], ramp.background, 0.25)
    ramp[alert .. "_surface"] = surface
    ramp[alert .. "_text"] = readable(ramp[alert], surface, ramp.foreground_4)
  end
  return ramp
end

--- The ramp for one variant's palette, as `#rrggbb` strings.
function M.colors(colors)
  if colors.meta.variant == "neon" then
    return M.NEON
  end
  if color_utils.is_bright(colors.bg) then
    return with_alerts(light(colors))
  end
  return with_alerts(dark(colors))
end

with_alerts(M.NEON)

return M
