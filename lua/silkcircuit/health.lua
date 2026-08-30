local M = {}

-- Health check for SilkCircuit theme
function M.check()
  local health = vim.health or require("health")
  local start = health.start or health.report_start
  local ok = health.ok or health.report_ok
  local warn = health.warn or health.report_warn
  local error = health.error or health.report_error

  start("SilkCircuit Theme")

  -- Check Neovim version
  local nvim_version = vim.version()
  if nvim_version.major >= 0 and nvim_version.minor >= 8 then
    ok(
      string.format(
        "Neovim version %d.%d.%d",
        nvim_version.major,
        nvim_version.minor,
        nvim_version.patch
      )
    )
  else
    error("SilkCircuit requires Neovim 0.8.0 or later")
  end

  -- Check termguicolors
  if vim.o.termguicolors then
    ok("termguicolors is enabled")
  else
    error("termguicolors is not enabled. Add 'vim.opt.termguicolors = true' to your config")
  end

  -- Check if theme is loaded
  if vim.g.colors_name == "silkcircuit" then
    ok("SilkCircuit theme is active")
  else
    warn("SilkCircuit theme is not active. Run ':colorscheme silkcircuit'")
  end

  -- Check configuration
  start("Configuration")
  local config = require("silkcircuit.config").get()
  ok(string.format("Variant: %s", config.variant))

  if config.transparent then
    ok("Transparent background enabled")
  end

  -- Check integrations
  start("Plugin Integrations")
  local integrations = require("silkcircuit.integrations")
  local detected = integrations.get_detected_plugins()

  if #detected > 0 then
    ok(string.format("Detected %d supported plugins", #detected))

    -- Show which integrations are active
    local active = {}
    local inactive = {}
    for _, plugin in ipairs(detected) do
      if require("silkcircuit.config").is_enabled(plugin) then
        table.insert(active, plugin)
      else
        table.insert(inactive, plugin)
      end
    end

    if #active > 0 then
      ok("Active integrations: " .. table.concat(active, ", "))
    end

    if #inactive > 0 then
      warn("Detected but disabled: " .. table.concat(inactive, ", "))
    end
  else
    warn("No supported plugins detected")
  end

  -- Check preferences
  start("User Preferences")
  local prefs = require("silkcircuit.preferences").load()
  if next(prefs) then
    ok("Preferences file found")
    if prefs.variant then
      ok(string.format("Saved variant: %s", prefs.variant))
    end
    if prefs.glow_enabled ~= nil then
      ok(string.format("Glow mode: %s", prefs.glow_enabled and "enabled" or "disabled"))
    end
  else
    ok("No saved preferences (using defaults)")
  end

  -- Check contrast compliance
  start("WCAG Contrast Compliance")
  local palette = require("silkcircuit.palette")
  local colors = palette.get_colors()
  local color_utils = require("silkcircuit.utils.colors")
  local issues = color_utils.validate_theme_contrast(colors)

  if #issues == 0 then
    ok("All colors pass WCAG AA contrast requirements")
  else
    for _, issue in ipairs(issues) do
      if issue.severity == "error" then
        error(issue.message)
      else
        warn(issue.message)
      end
    end
  end

  -- Commands available
  start("Available Commands")
  ok(":SilkCircuit [variant] - Switch theme variant (neon/vibrant/soft/glow/dawn)")
  ok(":SilkCircuitGlow - Toggle glow mode")
  ok(":SilkCircuitContrast - Check WCAG contrast compliance")
  ok(":SilkCircuitIntegrations - Show detected plugin integrations")
  ok(":help silkcircuit - View documentation")
end

return M
