local M = {}

-- Get preferences file path
local function get_preferences_file()
  return vim.fn.stdpath("data") .. "/silkcircuit_preferences.json"
end

-- Load preferences from disk
function M.load()
  local file_path = get_preferences_file()
  if vim.fn.filereadable(file_path) == 0 then
    return {}
  end

  local file = io.open(file_path, "r")
  if not file then
    return {}
  end

  local content = file:read("*a")
  file:close()

  local ok, prefs = pcall(vim.json.decode, content)
  if ok then
    return prefs
  else
    return {}
  end
end

-- Save preferences to disk
function M.save(prefs)
  local file_path = get_preferences_file()
  local file = io.open(file_path, "w")
  if not file then
    vim.notify("Failed to save SilkCircuit preferences", vim.log.levels.ERROR)
    return false
  end

  file:write(vim.json.encode(prefs))
  file:close()
  return true
end

-- Get a preference value. A stored false is a value, not an absence.
function M.get(key, default)
  local value = M.load()[key]
  if value == nil then
    return default
  end
  return value
end

-- Set a preference value, touching the disk only when it actually changed
function M.set(key, value)
  local prefs = M.load()
  if prefs[key] == value then
    return true
  end
  prefs[key] = value
  return M.save(prefs)
end

-- Fold saved preferences into the config. Must run before the theme reads
-- the config, otherwise a saved variant only takes effect on the next load.
function M.apply()
  local config = require("silkcircuit.config")
  local variant = M.get("variant")

  -- An explicit setup({ variant = ... }) wins; the saved choice fills the gap.
  if variant and not config.is_explicit("variant") then
    config.set("variant", variant)
  end
end

-- Restore toggles that sit on top of an applied theme
function M.restore()
  if M.get("glow_enabled", false) then
    require("silkcircuit.glow").enable()
  end
end

return M
