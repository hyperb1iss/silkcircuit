local M = {}
local preferences = require("silkcircuit.preferences")

-- Glow Mode: Special visual effects for SilkCircuit
-- Adds glowing accents and enhanced highlights for a true neon experience

local glow_enabled = false

-- Brighten a base color into its glow form
local function get_glow_color(base_color, intensity)
  local color_utils = require("silkcircuit.utils.colors")
  return color_utils.lighten(base_color, intensity * 0.3)
end

-- Apply glow effects to highlight groups
local function apply_glow_highlights()
  local colors = require("silkcircuit.palette").colors
  local util = require("silkcircuit.util")

  -- Define which groups get glow effects
  local glow_targets = {
    -- Functions get purple glow
    {
      groups = { "Function", "@function", "@function.method" },
      color = colors.glow_purple,
      bg_glow = false,
    },

    -- Keywords get subtle purple glow
    { groups = { "Keyword", "@keyword" }, color = colors.purple, bg_glow = false },

    -- Strings get pink glow
    { groups = { "String", "@string" }, color = colors.glow_pink, bg_glow = false },

    -- Classes/Types get cyan glow
    {
      groups = { "Type", "@type", "@type.builtin" },
      color = colors.glow_cyan,
      bg_glow = false,
    },

    -- Important punctuation gets subtle glow
    {
      groups = { "@punctuation.bracket", "@tag.delimiter" },
      color = colors.cyan_bright,
      bg_glow = false,
    },
  }

  -- Apply glow effects
  for _, target in ipairs(glow_targets) do
    local glow_color = get_glow_color(target.color, 1.0)

    for _, group in ipairs(target.groups) do
      local hl = { fg = glow_color, bold = true }

      if group:match("Function") then
        hl.italic = true
        hl.bold = true
      end

      util.highlight(group, hl)
    end
  end

  -- Floating window borders get the brightest glow
  util.highlight("FloatBorder", {
    fg = get_glow_color(colors.cyan_bright, 1.2),
  })
end

-- Enable glow mode
function M.enable()
  if glow_enabled then
    return
  end

  glow_enabled = true
  apply_glow_highlights()
  preferences.set("glow_enabled", true)
end

-- Disable glow mode
function M.disable()
  if not glow_enabled then
    return
  end

  glow_enabled = false
  preferences.set("glow_enabled", false)

  -- Reload the theme to restore original colors
  vim.cmd("colorscheme silkcircuit")
end

-- Toggle glow mode
function M.toggle()
  if glow_enabled then
    M.disable()
  else
    M.enable()
  end
end

-- Check if glow mode is active
function M.is_enabled()
  return glow_enabled
end

-- Setup glow mode commands
function M.setup()
  vim.api.nvim_create_user_command("SilkCircuitGlow", function(opts)
    local action = opts.args
    if action == "on" then
      M.enable()
    elseif action == "off" then
      M.disable()
    elseif action == "toggle" or action == "" then
      M.toggle()
    else
      vim.notify("Usage: :SilkCircuitGlow [on|off|toggle]", vim.log.levels.WARN)
    end
  end, {
    nargs = "?",
    complete = function()
      return { "on", "off", "toggle" }
    end,
    desc = "Control SilkCircuit Glow Mode",
  })
end

return M
