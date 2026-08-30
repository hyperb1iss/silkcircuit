local M = {}

-- Convert hex to RGB
function M.hex_to_rgb(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  local red, green, blue = string.match(hex_str, pat)
  return tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16)
end

-- Convert RGB to hex
function M.rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

-- Blend two colors together
-- @param fg string foreground color
-- @param bg string background color
-- @param alpha number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(fg, bg, alpha)
  local bg_r, bg_g, bg_b = M.hex_to_rgb(bg)
  local fg_r, fg_g, fg_b = M.hex_to_rgb(fg)

  local blend_channel = function(c1, c2)
    local ret = (alpha * c1 + ((1 - alpha) * c2))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format(
    "#%02x%02x%02x",
    blend_channel(fg_r, bg_r),
    blend_channel(fg_g, bg_g),
    blend_channel(fg_b, bg_b)
  )
end

-- Darken a color
function M.darken(hex, amount, bg)
  return M.blend(hex, bg or "#000000", math.abs(amount))
end

-- Lighten a color
function M.lighten(hex, amount, fg)
  return M.blend(hex, fg or "#ffffff", math.abs(amount))
end

-- Calculate relative luminance for WCAG compliance
function M.get_luminance(hex)
  local r, g, b = M.hex_to_rgb(hex)
  r, g, b = r / 255, g / 255, b / 255

  -- Apply gamma correction
  local function gamma_correct(c)
    if c <= 0.03928 then
      return c / 12.92
    else
      return ((c + 0.055) / 1.055) ^ 2.4
    end
  end

  r = gamma_correct(r)
  g = gamma_correct(g)
  b = gamma_correct(b)

  -- Calculate relative luminance
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

-- Calculate contrast ratio between two colors
function M.get_contrast_ratio(fg, bg)
  local lum1 = M.get_luminance(fg)
  local lum2 = M.get_luminance(bg)
  local lighter = math.max(lum1, lum2)
  local darker = math.min(lum1, lum2)
  return (lighter + 0.05) / (darker + 0.05)
end

-- Check WCAG AA compliance (4.5:1 for normal text, 3:1 for large text)
function M.meets_wcag_aa(fg, bg, large_text)
  local ratio = M.get_contrast_ratio(fg, bg)
  local required = large_text and 3.0 or 4.5
  return ratio >= required, ratio
end

-- Check WCAG AAA compliance (7:1 for normal text, 4.5:1 for large text)
function M.meets_wcag_aaa(fg, bg, large_text)
  local ratio = M.get_contrast_ratio(fg, bg)
  local required = large_text and 4.5 or 7.0
  return ratio >= required, ratio
end

-- Check if a color is bright
function M.is_bright(hex)
  local luminance = M.get_luminance(hex)
  return luminance > 0.5
end

-- Add a glow effect to a color (for our neon theme!)
function M.glow(hex, amount)
  -- Make it brighter and more saturated
  return M.lighten(hex, amount or 0.2)
end

-- Create a neon variant of a color
function M.neonify(hex)
  -- Increase brightness significantly
  return M.lighten(hex, 0.3)
end

-- Validate all theme colors for contrast
function M.validate_theme_contrast(colors)
  local issues = {}
  local bg = colors.bg or "#1e1a2e"

  -- Check critical text colors
  local critical_colors = {
    { name = "fg", color = colors.fg },
    { name = "purple", color = colors.purple },
    { name = "pink", color = colors.pink },
    { name = "cyan", color = colors.cyan },
    { name = "comment", color = colors.purple_muted },
  }

  for _, item in ipairs(critical_colors) do
    local passes_aa, ratio = M.meets_wcag_aa(item.color, bg)
    if not passes_aa then
      table.insert(issues, {
        severity = ratio < 3.0 and "error" or "warning",
        message = string.format(
          "%s (%s) has contrast ratio %.2f:1 (needs 4.5:1)",
          item.name,
          item.color,
          ratio
        ),
      })
    end
  end

  return issues
end

-- Suggest a better color if contrast is too low
function M.improve_contrast(fg, bg, target_ratio)
  target_ratio = target_ratio or 4.5
  local current_ratio = M.get_contrast_ratio(fg, bg)

  if current_ratio >= target_ratio then
    return fg -- Already good
  end

  -- Try lightening the color
  local attempts = 10
  local step = 0.05
  local improved = fg

  for _ = 1, attempts do
    improved = M.lighten(improved, step)
    local new_ratio = M.get_contrast_ratio(improved, bg)
    if new_ratio >= target_ratio then
      return improved
    end
  end

  return improved -- Return best attempt
end

return M
