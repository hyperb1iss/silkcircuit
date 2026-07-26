-- AstroUI configuration for SilkCircuit theme
-- Place this in your ~/.config/nvim/lua/plugins/astroui.lua

return {
  "AstroNvim/astroui",
  dependencies = { "silkcircuit" },
  ---@type AstroUIOpts
  opts = function(_, opts)
    local sc = require("silkcircuit.contrib.astronvim")
    opts.colorscheme = "silkcircuit"
    opts.status = vim.tbl_deep_extend("force", opts.status or {}, {
      colorscheme = "silkcircuit",
      separators = sc.separators,
      colors = sc.status_colors,
    })
  end,
}
