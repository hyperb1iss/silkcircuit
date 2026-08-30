local M = {}

-- Load modules
local config = require("silkcircuit.config")
local theme = require("silkcircuit.theme")
local preferences = require("silkcircuit.preferences")

-- Setup function
function M.setup(options)
  config.setup(options)
end

-- Load the theme
function M.load()
  -- Check if termguicolors is enabled
  if not vim.o.termguicolors then
    vim.notify("silkcircuit.nvim: termguicolors must be enabled", vim.log.levels.ERROR)
    return
  end

  local start_time = vim.uv.hrtime()

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = "silkcircuit"

  -- Before theme.apply, so a saved variant lands on this load, not the next
  preferences.apply()

  theme.apply()

  if vim.g.silkcircuit_debug then
    local load_time = (vim.uv.hrtime() - start_time) / 1e6
    vim.notify(string.format("» SilkCircuit loaded in %.2fms", load_time), vim.log.levels.INFO)
  end

  -- Set terminal colors if enabled
  if config.get().terminal_colors then
    theme.set_terminal_colors()
  end

  -- Setup commands
  require("silkcircuit.commands").setup()

  -- Setup glow mode
  require("silkcircuit.glow").setup()

  -- Glow sits on top of the applied theme, so it restores last
  preferences.restore()
end

-- Get the color palette for the active variant
function M.get_colors()
  return require("silkcircuit.palette").get_colors()
end

-- Removed in v2. Kept as a no-op so existing configs do not error.
function M.compile()
  vim.notify(
    "silkcircuit: the compiled cache was removed in v2, loading is fast without it",
    vim.log.levels.WARN
  )
end

-- Apply colorscheme
function M.colorscheme()
  M.load()
end

return M
