-- Lualine theme for the SilkCircuit colorscheme.
--
-- Built from the active variant every time this module is required. The
-- silkcircuit lualine integration drops this module from package.loaded on
-- each colorscheme load, so lualine rebuilds it after a variant switch.

local colors = require("silkcircuit.palette").get_colors()

local silkcircuit = {}

-- Normal mode - Purple with vibrant accent
silkcircuit.normal = {
  a = { bg = colors.glow_purple, fg = colors.bg, gui = "bold" },
  b = { bg = colors.purple_dark, fg = colors.fg_light, gui = "bold" },
  c = { bg = colors.bg_highlight, fg = colors.fg_dark },
  x = { bg = colors.bg_highlight, fg = colors.purple },
  y = { bg = colors.purple_dark, fg = colors.fg_light, gui = "bold" },
  z = { bg = colors.glow_purple, fg = colors.bg, gui = "bold" },
}

-- Insert mode - Neon pink glow
silkcircuit.insert = {
  a = { bg = colors.glow_pink, fg = colors.bg, gui = "bold" },
  b = { bg = colors.pink, fg = colors.bg, gui = "bold" },
  c = { bg = colors.bg_highlight, fg = colors.fg_dark },
  x = { bg = colors.bg_highlight, fg = colors.pink },
  y = { bg = colors.pink, fg = colors.bg, gui = "bold" },
  z = { bg = colors.glow_pink, fg = colors.bg, gui = "bold" },
}

-- Visual mode - Electric cyan
silkcircuit.visual = {
  a = { bg = colors.glow_cyan, fg = colors.bg, gui = "bold" },
  b = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
  c = { bg = colors.bg_highlight, fg = colors.fg_dark },
  x = { bg = colors.bg_highlight, fg = colors.cyan },
  y = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
  z = { bg = colors.glow_cyan, fg = colors.bg, gui = "bold" },
}

-- Replace mode - Bright pink emphasis
silkcircuit.replace = {
  a = { bg = colors.pink_bright, fg = colors.bg, gui = "bold" },
  b = { bg = colors.glow_pink, fg = colors.bg, gui = "bold" },
  c = { bg = colors.bg_highlight, fg = colors.fg_dark },
  x = { bg = colors.bg_highlight, fg = colors.pink_bright },
  y = { bg = colors.glow_pink, fg = colors.bg, gui = "bold" },
  z = { bg = colors.pink_bright, fg = colors.bg, gui = "bold" },
}

-- Command mode - Deep purple accent
silkcircuit.command = {
  a = { bg = colors.purple_dark, fg = colors.fg_light, gui = "bold" },
  b = { bg = colors.glow_purple, fg = colors.bg, gui = "bold" },
  c = { bg = colors.bg_highlight, fg = colors.fg_dark },
  x = { bg = colors.bg_highlight, fg = colors.purple_dark },
  y = { bg = colors.glow_purple, fg = colors.bg, gui = "bold" },
  z = { bg = colors.purple_dark, fg = colors.fg_light, gui = "bold" },
}

-- Terminal mode - Green highlight
silkcircuit.terminal = {
  a = { bg = colors.green, fg = colors.bg, gui = "bold" },
  b = { bg = colors.green_bright, fg = colors.bg, gui = "bold" },
  c = { bg = colors.bg_highlight, fg = colors.fg_dark },
  x = { bg = colors.bg_highlight, fg = colors.green },
  y = { bg = colors.green_bright, fg = colors.bg, gui = "bold" },
  z = { bg = colors.green, fg = colors.bg, gui = "bold" },
}

-- Inactive windows - Muted
silkcircuit.inactive = {
  a = { bg = colors.bg_highlight, fg = colors.gray, gui = "bold" },
  b = { bg = colors.bg_dark, fg = colors.gray },
  c = { bg = colors.bg_dark, fg = colors.gray },
}

return silkcircuit
