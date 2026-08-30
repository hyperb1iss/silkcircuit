local M = {}

-- Default configuration
M.defaults = {
  variant = "neon", -- "neon" | "vibrant" | "soft" | "glow" | "dawn"
  transparent = false, -- Enable transparent background
  terminal_colors = true, -- Configure terminal colors
  dim_inactive = false, -- Dim inactive windows

  styles = {
    comments = { italic = true },
    keywords = {},
    functions = {},
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
    oil = true,

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
    fzf_lua = true,
    snacks = true,
    dropbar = true,
    lazy = true,

    -- Completion and messages
    cmp = true,
    blink_cmp = true,
    notify = true,
    noice = true,
    fidget = true,

    -- Navigation and motion
    flash = true,
    harpoon = true,
    trouble = true,
    grug_far = true,

    -- Development tools
    mason = true,
    mini = true,
    dap = true, -- Alias for nvim_dap
    nvim_dap = true,
    neotest = true,
    aerial = true,
    avante = true,

    -- Visual enhancements
    rainbow_delimiters = true,
    ["render-markdown"] = true,
    treesitter_context = true,

    -- Folding and windows
    ufo = true,
    window_picker = true,
  },
}

-- Current configuration
M.options = {}

-- What setup() was handed, so a persisted preference knows when to yield
local user_options = {}

-- Setup function
function M.setup(options)
  user_options = options or {}
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), user_options)
end

-- Did the caller pass this option to setup() explicitly?
function M.is_explicit(key)
  return user_options[key] ~= nil
end

-- Set one option on the live configuration
function M.set(key, value)
  M.get()
  M.options[key] = value
end

-- Get the current configuration. Materializes a copy of the defaults on
-- first use, so nothing downstream can write through to M.defaults.
function M.get()
  if vim.tbl_isempty(M.options) then
    M.options = vim.deepcopy(M.defaults)
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
  return M.get().styles[group] or {}
end

return M
