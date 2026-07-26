-- SilkCircuit theme configuration for AstroNvim
-- Place this in your ~/.config/nvim/lua/plugins/silkcircuit.lua

return {
  "hyperb1iss/silkcircuit",
  name = "silkcircuit",
  lazy = false,
  priority = 1000,
  config = function()
    require("silkcircuit").setup({
      transparent = false,
      terminal_colors = true,
      dim_inactive = false,

      styles = {
        comments = { italic = true },
        keywords = { italic = false, bold = true },
        functions = { bold = true, italic = true },
        variables = {},
        operators = {},
        booleans = { bold = true },
        strings = { italic = true },
        types = { bold = true },
        constants = { bold = true },
      },
    })
  end,
}
