local M = {}
local config = require("silkcircuit.config")
local util = require("silkcircuit.util")

-- Plugin detection mapping
local plugin_mapping = {
  -- Native features
  treesitter = function()
    return vim.treesitter ~= nil or pcall(require, "nvim-treesitter")
  end,
  native_lsp = function()
    return vim.fn.has("nvim-0.5") == 1
  end,

  -- File explorers
  nvimtree = function()
    return vim.fn.exists("g:loaded_nvim_tree") == 1
  end,
  neotree = function()
    return pcall(require, "neo-tree")
  end,

  -- Git
  gitsigns = function()
    return pcall(require, "gitsigns")
  end,
  gitgutter = function()
    return vim.fn.exists("g:loaded_gitgutter") == 1
  end,
  diffview = function()
    return pcall(require, "diffview")
  end,

  -- UI enhancements
  telescope = function()
    return pcall(require, "telescope")
  end,
  bufferline = function()
    return pcall(require, "bufferline")
  end,
  lualine = function()
    return pcall(require, "lualine")
  end,
  indent_blankline = function()
    return pcall(require, "ibl") or pcall(require, "indent_blankline")
  end,

  -- Start screens
  dashboard = function()
    return pcall(require, "dashboard")
  end,
  alpha = function()
    return pcall(require, "alpha")
  end,

  -- Completion
  cmp = function()
    return pcall(require, "cmp")
  end,

  -- Notifications
  notify = function()
    return pcall(require, "notify")
  end,
  noice = function()
    return pcall(require, "noice")
  end,

  -- Navigation
  hop = function()
    return pcall(require, "hop")
  end,
  leap = function()
    return pcall(require, "leap")
  end,
  flash = function()
    return pcall(require, "flash")
  end,

  -- Plugin management
  lazy = function()
    return pcall(require, "lazy")
  end,
  mason = function()
    return pcall(require, "mason")
  end,

  -- Debugging
  nvim_dap = function()
    return pcall(require, "dap")
  end,

  -- Diagnostics
  trouble = function()
    return pcall(require, "trouble")
  end,

  -- Code outline
  outline = function()
    return pcall(require, "outline") or pcall(require, "symbols-outline")
  end,
  aerial = function()
    return pcall(require, "aerial")
  end,

  -- Highlighting
  illuminate = function()
    return vim.fn.exists("g:loaded_illuminate") == 1 or pcall(require, "illuminate")
  end,
  rainbow_delimiters = function()
    return pcall(require, "rainbow-delimiters")
  end,

  -- Folding
  ufo = function()
    return pcall(require, "ufo")
  end,

  -- Window management
  window_picker = function()
    return pcall(require, "window-picker")
  end,
  which_key = function()
    return pcall(require, "which-key")
  end,

  -- Languages
  markdown = function()
    return true
  end, -- Always available for markdown files

  -- mini.nvim modules
  mini = function()
    return pcall(require, "mini.base16")
      or pcall(require, "mini.statusline")
      or pcall(require, "mini.starter")
      or pcall(require, "mini.tabline")
      or pcall(require, "mini.files")
      or pcall(require, "mini.pick")
  end,

  -- snacks.nvim
  snacks = function()
    return pcall(require, "snacks")
  end,

  -- render-markdown.nvim
  ["render-markdown"] = function()
    return pcall(require, "render-markdown")
  end,

  -- octo.nvim
  octo = function()
    return pcall(require, "octo")
  end,

  -- avante.nvim
  avante = function()
    return pcall(require, "avante")
  end,
}

-- Check if a plugin is installed
local function is_plugin_installed(name)
  local detector = plugin_mapping[name]
  if detector then
    return detector()
  end
  return false
end

-- List of all available integrations
local all_integrations = {
  "aerial",
  "alpha",
  "avante",
  "bufferline",
  "cmp",
  "dashboard",
  "diffview",
  "gitsigns",
  "gitgutter",
  "hop",
  "indent_blankline",
  "leap",
  "lualine",
  "markdown",
  "mason",
  "mini",
  "native_lsp",
  "neotree",
  "noice",
  "notify",
  "nvim_dap",
  "nvimtree",
  "octo",
  "outline",
  "rainbow_delimiters",
  "snacks",
  "render-markdown",
  "telescope",
  "treesitter",
  "trouble",
  "ufo",
  "which_key",
  "window_picker",
}

-- Load all enabled integrations
function M.load(colors, opts)
  -- Core integrations that should always be loaded
  local core_integrations = {
    "treesitter",
    "native_lsp",
  }

  local available = all_integrations

  -- Process core integrations first
  for _, integration in ipairs(core_integrations) do
    if config.is_enabled(integration) and is_plugin_installed(integration) then
      local ok, module = pcall(require, "silkcircuit.integrations." .. integration)
      if ok then
        local highlights = module.get and module.get(colors, opts)
          or (module.highlights and module.highlights(colors, opts))
        if highlights then
          util.load_highlights(highlights)
        end
      end
    end
  end

  -- Process other integrations
  for _, integration in ipairs(available) do
    -- Skip if already processed as core
    local is_core = vim.tbl_contains(core_integrations, integration)

    if not is_core then
      -- Auto-detect and load if enabled
      if config.is_enabled(integration) then
        if opts.integrations.auto_detect and is_plugin_installed(integration) then
          local ok, module = pcall(require, "silkcircuit.integrations." .. integration)
          if ok then
            local highlights = module.get and module.get(colors, opts)
              or (module.highlights and module.highlights(colors, opts))
            if highlights then
              util.load_highlights(highlights)
            end
          end
        elseif not opts.integrations.auto_detect then
          -- Manual mode - load if explicitly enabled
          local ok_manual, module_manual =
            pcall(require, "silkcircuit.integrations." .. integration)
          if ok_manual then
            local manual_highlights = module_manual.get and module_manual.get(colors, opts)
              or (module_manual.highlights and module_manual.highlights(colors, opts))
            if manual_highlights then
              util.load_highlights(manual_highlights)
            end
          end
        end
      end
    end
  end
end

-- Get list of detected plugins
function M.get_detected_plugins()
  local detected = {}
  for name, detector in pairs(plugin_mapping) do
    if detector() then
      table.insert(detected, name)
    end
  end
  table.sort(detected)
  return detected
end

-- Debug function to show integration status
function M.debug()
  local detected = M.get_detected_plugins()
  local enabled = {}
  local disabled = {}

  for _, plugin in ipairs(detected) do
    if config.is_enabled(plugin) then
      table.insert(enabled, plugin)
    else
      table.insert(disabled, plugin)
    end
  end

  print("SilkCircuit Integration Status:")
  print("Detected & Enabled: " .. table.concat(enabled, ", "))
  print("Detected & Disabled: " .. table.concat(disabled, ", "))
end

return M
