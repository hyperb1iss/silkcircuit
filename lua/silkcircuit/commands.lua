local M = {}
local preferences = require("silkcircuit.preferences")

function M.setup()
  -- Check contrast command
  vim.api.nvim_create_user_command("SilkCircuitContrast", function()
    local colors = require("silkcircuit.palette").get_colors()
    local color_utils = require("silkcircuit.utils.colors")

    local issues, checked = color_utils.validate_theme_contrast(colors)
    local variant = require("silkcircuit.config").get().variant

    if #issues == 0 then
      vim.notify(
        string.format("√ All %d text colors in '%s' meet WCAG AA", checked, variant),
        vim.log.levels.INFO
      )
      return
    end

    local lines = {
      string.format(
        "%d of %d text colors in '%s' meet WCAG AA:",
        checked - #issues,
        checked,
        variant
      ),
    }
    for _, issue in ipairs(issues) do
      table.insert(lines, "  ! " .. issue.message)
    end
    vim.notify(table.concat(lines, "\n"), vim.log.levels.WARN)
  end, { desc = "Check SilkCircuit theme contrast ratios" })

  -- Theme variant switcher
  vim.api.nvim_create_user_command("SilkCircuit", function(args)
    local variant = args.args
    local variants = require("silkcircuit.variants")

    if variant == "" then
      local current = variants.get_current_variant()
      vim.notify("Current variant: " .. current, vim.log.levels.INFO)
      vim.notify(
        "Available variants: neon (default), vibrant, soft, glow, dawn",
        vim.log.levels.INFO
      )
      return
    end

    -- Validate variant
    if not variants.variants[variant] then
      vim.notify("Unknown variant: " .. variant, vim.log.levels.ERROR)
      return
    end

    require("silkcircuit.config").set("variant", variant)
    preferences.set("variant", variant)

    vim.cmd("colorscheme silkcircuit")
    vim.notify(
      "Switched to '" .. variant .. "' variant → " .. variants.variants[variant].description,
      vim.log.levels.INFO
    )
  end, {
    nargs = "?",
    complete = function()
      return { "neon", "vibrant", "soft", "glow", "dawn" }
    end,
    desc = "Switch SilkCircuit theme variant",
  })

  -- Integration status command
  vim.api.nvim_create_user_command("SilkCircuitIntegrations", function()
    local integrations = require("silkcircuit.integrations")
    integrations.debug()
  end, { desc = "Show detected plugin integrations" })
end

return M
