local M = {}

-- Default configuration
M.defaults = {
  variant = "neon", -- Theme variant: "neon" | "vibrant" | "soft"
  transparent = false, -- Enable transparent background
  terminal_colors = true, -- Configure terminal colors
  dim_inactive = false, -- Dim inactive windows

  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = { bold = false },
    variables = {},
    operators = {},
    booleans = {},
    strings = {},
    types = {},
    constants = {},
  },

  -- Custom highlight group overrides
  on_highlights = nil,

  -- Plugin integrations. One key per module in silkcircuit/integrations, all
  -- enabled by default. Highlights are defined whether or not the plugin is
  -- installed; set a key to false to skip its groups entirely.
  integrations = {
    -- Deprecated no-op. Detection is passive now and never gates highlights.
    auto_detect = true,

    -- Core
    treesitter = true,
    lsp = true,
    native_lsp = { enabled = true }, -- Alias for lsp
    markdown = true,

    -- File explorers
    neotree = true,
    nvimtree = true,

    -- Git
    gitsigns = true,
    neogit = true,
    octo = true,

    -- UI
    bufferline = true,
    lualine = true,
    indent_blankline = true,
    alpha = true,
    which_key = true,
    telescope = true,
    snacks = true,

    -- Completion and messages
    cmp = true,
    notify = true,
    noice = true,

    -- Navigation and motion
    flash = true,
    harpoon = true,

    -- Development tools
    mason = true,
    mini = true,
    dap = true, -- Alias for nvim_dap
    nvim_dap = true,
    aerial = true,
    avante = true,

    -- Visual enhancements
    rainbow_delimiters = true,
    ["render-markdown"] = true,

    -- Folding and windows
    ufo = true,
    window_picker = true,
  },
}

-- Current configuration
M.options = {}

-- Setup function
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", M.defaults, options or {})
end

-- Get the current configuration
function M.get()
  -- If setup hasn't been called, use defaults
  if vim.tbl_isempty(M.options) then
    M.options = M.defaults
  end
  return M.options
end

-- Config keys that name the same integration. An explicit false on either
-- spelling disables it, so older configs keep working.
local aliases = {
  native_lsp = "lsp",
  lsp = "native_lsp",
  nvim_dap = "dap",
  dap = "nvim_dap",
  ["render-markdown"] = "render_markdown",
}

-- Check if a plugin integration is enabled. Integrations are on unless a
-- config key says otherwise.
function M.is_enabled(integration)
  local integrations = M.get().integrations

  for _, key in ipairs({ integration, aliases[integration] }) do
    local status = integrations[key]
    if type(status) == "table" then
      if status.enabled == false then
        return false
      end
    elseif status == false then
      return false
    end
  end

  return true
end

-- Get style for a syntax group
function M.get_style(group)
  return M.options.styles[group] or {}
end

return M
