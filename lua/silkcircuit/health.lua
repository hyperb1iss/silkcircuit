local M = {}

local health = vim.health

-- Health check for SilkCircuit theme
function M.check()
  health.start("SilkCircuit")

  local version = vim.version()
  if vim.fn.has("nvim-0.10") == 1 then
    health.ok(string.format("Neovim %d.%d.%d", version.major, version.minor, version.patch))
  else
    health.error("SilkCircuit requires Neovim 0.10 or later")
  end

  if vim.o.termguicolors then
    health.ok("termguicolors is enabled")
  else
    health.error("termguicolors is off. Set vim.o.termguicolors = true")
  end

  if vim.g.colors_name == "silkcircuit" then
    health.ok("SilkCircuit is the active colorscheme")
  else
    health.warn("SilkCircuit is not active. Run :colorscheme silkcircuit")
  end

  -- Configuration
  health.start("Configuration")
  local config = require("silkcircuit.config").get()
  health.ok(string.format("Variant: %s", config.variant))
  health.ok(string.format("Transparent: %s", tostring(config.transparent)))
  health.ok(string.format("Terminal colors: %s", tostring(config.terminal_colors)))
  health.ok(string.format("Dim inactive: %s", tostring(config.dim_inactive)))

  -- Integrations
  health.start("Plugin integrations")
  local integrations = require("silkcircuit.integrations")
  local all = integrations.list()
  local detected = integrations.get_detected_plugins()

  health.ok(string.format("%d integrations available, %d plugins detected", #all, #detected))
  if #detected > 0 then
    health.ok("Detected: " .. table.concat(detected, ", "))
  end

  local disabled = {}
  for _, name in ipairs(all) do
    if not require("silkcircuit.config").is_enabled(name) then
      table.insert(disabled, name)
    end
  end
  if #disabled > 0 then
    health.warn("Disabled by config: " .. table.concat(disabled, ", "))
  end

  -- Preferences
  health.start("User preferences")
  local prefs = require("silkcircuit.preferences").load()
  if next(prefs) then
    if prefs.variant then
      health.ok(string.format("Saved variant: %s", prefs.variant))
    end
    if prefs.glow_enabled ~= nil then
      health.ok(string.format("Glow mode: %s", prefs.glow_enabled and "on" or "off"))
    end
  else
    health.ok("No saved preferences, using the configured values")
  end

  -- Contrast, measured against this variant's own background
  health.start("WCAG contrast")
  local colors = require("silkcircuit.palette").get_colors()
  local issues, checked = require("silkcircuit.utils.colors").validate_theme_contrast(colors)

  health.ok(
    string.format(
      "Checked %d distinct text colors against the '%s' background (%s)",
      checked,
      config.variant,
      colors.bg
    )
  )

  if #issues == 0 then
    health.ok(string.format("All %d meet WCAG AA (4.5:1)", checked))
  else
    health.ok(string.format("%d of %d meet WCAG AA (4.5:1)", checked - #issues, checked))
    for _, issue in ipairs(issues) do
      if issue.severity == "error" then
        health.error(issue.message)
      else
        health.warn(issue.message)
      end
    end
  end

  -- Commands
  health.start("Commands")
  health.ok(":SilkCircuit [neon|vibrant|soft|glow|dawn] - switch variant")
  health.ok(":SilkCircuitGlow [on|off|toggle] - control glow mode")
  health.ok(":SilkCircuitContrast - check WCAG contrast")
  health.ok(":SilkCircuitIntegrations - show integration status")
  health.ok(":help silkcircuit - documentation")
end

return M
