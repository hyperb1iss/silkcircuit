local M = {}
local config = require("silkcircuit.config")
local util = require("silkcircuit.util")

-- The single registry: one entry per integration module in this directory.
--
-- `modules` and `plugin` describe how to *recognize* the plugin, and are used
-- only for reporting through :SilkCircuitIntegrations and :checkhealth. They
-- never gate whether highlights load. Defining a highlight group for a plugin
-- that is not installed costs nothing, and gating on detection is what forced
-- the theme to require foreign plugins in the first place.
--
-- Order matters: treesitter and native_lsp go first so later entries can
-- override anything they set.
local registry = {
  { name = "treesitter", always = true },
  { name = "native_lsp", always = true },
  { name = "markdown", always = true },

  { name = "aerial", modules = { "aerial" }, plugin = "aerial.nvim" },
  { name = "alpha", modules = { "alpha" }, plugin = "alpha-nvim" },
  { name = "avante", modules = { "avante" }, plugin = "avante.nvim" },
  { name = "bufferline", modules = { "bufferline" }, plugin = "bufferline.nvim" },
  { name = "cmp", modules = { "cmp" }, plugin = "nvim-cmp" },
  { name = "flash", modules = { "flash" }, plugin = "flash.nvim" },
  { name = "gitsigns", modules = { "gitsigns" }, plugin = "gitsigns.nvim" },
  { name = "harpoon", modules = { "harpoon" }, plugin = "harpoon" },
  {
    name = "indent_blankline",
    modules = { "ibl", "indent_blankline" },
    plugin = "indent-blankline.nvim",
  },
  { name = "lualine", modules = { "lualine" }, plugin = "lualine.nvim" },
  { name = "mason", modules = { "mason" }, plugin = "mason.nvim" },
  {
    name = "mini",
    modules = { "mini.statusline", "mini.files", "mini.pick" },
    plugin = "mini.nvim",
  },
  { name = "neogit", modules = { "neogit" }, plugin = "neogit" },
  { name = "neotree", modules = { "neo-tree" }, plugin = "neo-tree.nvim" },
  { name = "noice", modules = { "noice" }, plugin = "noice.nvim" },
  { name = "notify", modules = { "notify" }, plugin = "nvim-notify" },
  { name = "nvim_dap", modules = { "dap" }, plugin = "nvim-dap" },
  { name = "nvimtree", modules = { "nvim-tree" }, plugin = "nvim-tree.lua" },
  { name = "octo", modules = { "octo" }, plugin = "octo.nvim" },
  {
    name = "rainbow_delimiters",
    modules = { "rainbow-delimiters" },
    plugin = "rainbow-delimiters.nvim",
  },
  { name = "render-markdown", modules = { "render-markdown" }, plugin = "render-markdown.nvim" },
  { name = "snacks", modules = { "snacks" }, plugin = "snacks.nvim" },
  { name = "telescope", modules = { "telescope" }, plugin = "telescope.nvim" },
  { name = "ufo", modules = { "ufo" }, plugin = "nvim-ufo" },
  { name = "which_key", modules = { "which-key" }, plugin = "which-key.nvim" },
  { name = "window_picker", modules = { "window-picker" }, plugin = "nvim-window-picker" },
}

-- Is a lua module present on the runtime path, without loading it?
local function module_on_rtp(mod)
  local path = mod:gsub("%.", "/")
  return #vim.api.nvim_get_runtime_file("lua/" .. path .. ".lua", false) > 0
    or #vim.api.nvim_get_runtime_file("lua/" .. path .. "/init.lua", false) > 0
end

-- Is a plugin known to lazy.nvim? Reading lazy's own spec avoids touching the
-- plugin: under lazy, `require` is not passive, it force-loads the spec and
-- runs its config.
local function known_to_lazy(entry)
  if not package.loaded["lazy.core.config"] then
    return false
  end
  local ok, lazy_config = pcall(require, "lazy.core.config")
  if not ok or type(lazy_config.plugins) ~= "table" then
    return false
  end
  return lazy_config.plugins[entry.plugin] ~= nil
end

-- Detect a plugin without ever requiring it.
local function is_installed(entry)
  if entry.always then
    return true
  end
  for _, mod in ipairs(entry.modules or {}) do
    if package.loaded[mod] then
      return true
    end
  end
  if known_to_lazy(entry) then
    return true
  end
  for _, mod in ipairs(entry.modules or {}) do
    if module_on_rtp(mod) then
      return true
    end
  end
  return false
end

-- Load every enabled integration's highlights, installed or not
function M.load(colors, opts)
  for _, entry in ipairs(registry) do
    if config.is_enabled(entry.name) then
      local module = require("silkcircuit.integrations." .. entry.name)
      local get = module.get or module.highlights
      if get then
        util.load_highlights(get(colors, opts))
      end
    end
  end
end

-- Names of the plugins we can see, for reporting only
function M.get_detected_plugins()
  local detected = {}
  for _, entry in ipairs(registry) do
    if is_installed(entry) then
      table.insert(detected, entry.name)
    end
  end
  table.sort(detected)
  return detected
end

-- Every integration this theme ships, in load order
function M.list()
  local names = {}
  for _, entry in ipairs(registry) do
    table.insert(names, entry.name)
  end
  return names
end

-- Report integration status for :SilkCircuitIntegrations
function M.debug()
  local lines = { "SilkCircuit integrations" }
  local themed, detected, off = {}, {}, {}

  for _, entry in ipairs(registry) do
    local enabled = config.is_enabled(entry.name)
    if not enabled then
      table.insert(off, entry.name)
    elseif is_installed(entry) then
      table.insert(detected, entry.name)
    else
      table.insert(themed, entry.name)
    end
  end

  table.insert(lines, "  detected: " .. table.concat(detected, ", "))
  if #themed > 0 then
    table.insert(lines, "  themed anyway (not installed): " .. table.concat(themed, ", "))
  end
  if #off > 0 then
    table.insert(lines, "  disabled: " .. table.concat(off, ", "))
  end

  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end

return M
