-- Minimal, hermetic Neovim config for the SilkCircuit test suite.
--
--   nvim --headless --clean -u tests/minimal_init.lua -l tests/run.lua
--
-- Nothing from the developer's own Neovim setup is visible here: --clean drops
-- the user config, and every XDG directory is redirected into a throwaway
-- sandbox so preferences, caches and shada never leak between a test run and a
-- real editing session.

local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
vim.opt.runtimepath:prepend(root)

-- vim.fn.stdpath() re-reads these variables on every call, so setting them
-- after startup is enough to move the whole state tree.
local sandbox = vim.fn.tempname()
for _, name in ipairs({ "DATA", "STATE", "CACHE", "CONFIG" }) do
  vim.env["XDG_" .. name .. "_HOME"] = sandbox .. "/" .. name:lower()
end

-- Neovim only creates these lazily, and preferences.save() needs the data
-- directory to already exist.
for _, kind in ipairs({ "data", "state", "cache", "config" }) do
  vim.fn.mkdir(vim.fn.stdpath(kind), "p")
end

vim.o.termguicolors = true
vim.o.swapfile = false
vim.o.shadafile = "NONE"
vim.o.more = false
vim.o.showcmd = false
vim.o.showmode = false

vim.g.silkcircuit_test_root = root
vim.g.silkcircuit_test_sandbox = sandbox
