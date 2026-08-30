-- Shared helpers for the SilkCircuit specs: fresh-state control, highlight
-- capture, colour maths and assertions.
--
-- The global `assert` is deliberately left alone. Specs assert through the
-- functions below so a failure carries a message the runner can print.

local H = {}

H.root = vim.g.silkcircuit_test_root or vim.fn.getcwd()

H.variants = { "neon", "vibrant", "soft", "glow", "dawn" }

-- Plugin modules the colorscheme must never `require`. A lazy-loaded setup
-- hands the colorscheme to Neovim long before these exist, so touching one is
-- either a hard error or a silent no-op that skips the integration.
H.foreign_modules = { "lualine", "gitsigns", "telescope", "cmp", "neo-tree", "snacks" }

-- ---------------------------------------------------------------------------
-- Assertions
-- ---------------------------------------------------------------------------

function H.fail(message)
  error(message, 2)
end

function H.ok(value, message)
  if not value then
    error(message or ("expected a truthy value, got " .. vim.inspect(value)), 2)
  end
  return value
end

function H.eq(actual, expected, message)
  if not vim.deep_equal(actual, expected) then
    error(
      string.format(
        "%s\n  expected: %s\n  actual:   %s",
        message or "values differ",
        vim.inspect(expected),
        vim.inspect(actual)
      ),
      2
    )
  end
end

function H.empty(list, message)
  if #list > 0 then
    error(string.format("%s\n%s", message or "expected an empty list", vim.inspect(list)), 2)
  end
end

function H.at_least(actual, minimum, message)
  if not (actual >= minimum) then
    error(
      string.format("%s\n  expected >= %s, got %s", message or "value too small", minimum, actual),
      2
    )
  end
end

-- ---------------------------------------------------------------------------
-- Output
-- ---------------------------------------------------------------------------

-- Written straight to stdout rather than through print(): Neovim's message
-- system chunks headless output and occasionally drops the separator between
-- two consecutive messages, which corrupts the TAP stream.
function H.emit(line)
  io.write(line, "\n")
end

local emit = H.emit

-- Write a TAP diagnostic line. Visible in CI logs, ignored by TAP consumers.
function H.note(text)
  text = tostring(text)
  if text == "" then
    emit("#")
    return
  end
  for line in text:gmatch("[^\n]+") do
    emit("# " .. line)
  end
end

-- ---------------------------------------------------------------------------
-- Colours
-- ---------------------------------------------------------------------------

function H.is_hex6(value)
  return type(value) == "string" and value:match("^#%x%x%x%x%x%x$") ~= nil
end

function H.is_none(value)
  return type(value) == "string" and value:upper() == "NONE"
end

-- nvim_get_hl() reports colours as integers; render one back to hex.
function H.hex(number)
  return string.format("#%06x", number)
end

local function channel(value)
  value = value / 255
  if value <= 0.03928 then
    return value / 12.92
  end
  return ((value + 0.055) / 1.055) ^ 2.4
end

-- WCAG 2.1 relative luminance. Written out here rather than borrowed from
-- lua/silkcircuit/utils/colors.lua so the specs measure the theme instead of
-- agreeing with it.
function H.luminance(hex)
  if not H.is_hex6(hex) then
    error("luminance: expected a 6-digit hex colour, got " .. vim.inspect(hex), 2)
  end
  local r = channel(tonumber(hex:sub(2, 3), 16))
  local g = channel(tonumber(hex:sub(4, 5), 16))
  local b = channel(tonumber(hex:sub(6, 7), 16))
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

function H.contrast(fg, bg)
  local a, b = H.luminance(fg), H.luminance(bg)
  local lighter, darker = math.max(a, b), math.min(a, b)
  return (lighter + 0.05) / (darker + 0.05)
end

-- ---------------------------------------------------------------------------
-- Fresh state
-- ---------------------------------------------------------------------------

local function preferences_file()
  return vim.fn.stdpath("data") .. "/silkcircuit_preferences.json"
end

-- Forget every SilkCircuit module and clear the highlight table, leaving
-- anything already written to disk alone.
function H.reset_modules()
  for name in pairs(package.loaded) do
    if name == "silkcircuit" or name:match("^silkcircuit%.") then
      package.loaded[name] = nil
    end
  end
  package.loaded["lualine.themes.silkcircuit"] = nil

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = nil
end

-- Full reset: modules, highlights, saved preferences and any compiled cache.
function H.reset()
  H.reset_modules()
  os.remove(preferences_file())

  local cache = vim.fn.stdpath("cache")
  os.remove(cache .. "/silkcircuit_compiled.lua")
  os.remove(cache .. "/silkcircuit_compiled.luac")
  os.remove(cache .. "/silkcircuit_hash")
end

-- Run `fn` against a private data directory so saved preferences cannot reach
-- any other spec.
function H.with_data_home(fn)
  local previous = vim.env.XDG_DATA_HOME
  local scratch = vim.fn.tempname()
  vim.env.XDG_DATA_HOME = scratch
  vim.fn.mkdir(vim.fn.stdpath("data"), "p")

  local ok, err = pcall(fn)

  vim.env.XDG_DATA_HOME = previous
  if not ok then
    error(err, 0)
  end
end

-- ---------------------------------------------------------------------------
-- Capture
-- ---------------------------------------------------------------------------

-- Swallow `vim.notify` and `print` while `fn` runs so theme chatter stays out
-- of the TAP stream. Errors still propagate. Returns everything captured.
function H.quiet(fn)
  local messages = {}

  local notify = vim.notify
  local write = _G.print

  vim.notify = function(message, level)
    messages[#messages + 1] = { message = tostring(message), level = level }
  end
  _G.print = function(...)
    local parts = {}
    for index = 1, select("#", ...) do
      parts[#parts + 1] = tostring(select(index, ...))
    end
    messages[#messages + 1] = { message = table.concat(parts, "\t") }
  end

  local ok, err = pcall(fn)

  vim.notify = notify
  _G.print = write

  if not ok then
    error(err, 0)
  end
  return messages
end

-- Wrap nvim_set_hl for the duration of `fn` and record what the theme asked
-- for. lua/silkcircuit/util.lua swallows API errors in a pcall, so this is the
-- only place a rejected highlight is visible.
--
-- The returned record holds:
--   errors  - list of { group, message } the API refused
--   invalid - list of { group, key, value } colours that are not 6-digit hex
--   applied - sorted list of groups that were set without error
--   opts    - the last table passed for each group
function H.capture_highlights(fn)
  local record = { errors = {}, invalid = {}, applied = {}, opts = {} }
  local seen = {}
  local set_hl = vim.api.nvim_set_hl

  vim.api.nvim_set_hl = function(ns, group, opts)
    if type(opts) == "table" then
      for _, key in ipairs({ "fg", "bg", "sp" }) do
        local value = opts[key]
        if type(value) == "string" and not H.is_hex6(value) and not H.is_none(value) then
          record.invalid[#record.invalid + 1] = { group = group, key = key, value = value }
        end
      end
    end

    local ok, err = pcall(set_hl, ns, group, opts)
    if ok then
      record.opts[group] = opts
      if not seen[group] then
        seen[group] = true
        record.applied[#record.applied + 1] = group
      end
    else
      record.errors[#record.errors + 1] = { group = group, message = tostring(err) }
    end
  end

  local ok, err = pcall(fn)
  vim.api.nvim_set_hl = set_hl

  if not ok then
    error(err, 0)
  end

  -- lua/silkcircuit/util.lua walks the highlight table with pairs(), so call
  -- order follows LuaJIT hash order and varies per process. Sort everything
  -- the specs report on, or the diagnostics reshuffle between runs.
  table.sort(record.applied)
  table.sort(record.errors, function(a, b)
    return a.group < b.group
  end)
  table.sort(record.invalid, function(a, b)
    if a.group ~= b.group then
      return a.group < b.group
    end
    return a.key < b.key
  end)
  return record
end

-- ---------------------------------------------------------------------------
-- Loading the theme
-- ---------------------------------------------------------------------------

-- Options that make every shipped integration load, whether or not the plugin
-- is installed. `auto_detect` is the pre-v2 switch for that; once integrations
-- always load the key is accepted and inert.
function H.all_integrations(opts)
  return vim.tbl_deep_extend("force", { integrations = { auto_detect = false } }, opts or {})
end

-- Reset, load `variant` with `opts`, and return the capture record.
function H.load(variant, opts)
  opts = vim.tbl_deep_extend("force", opts or {}, { variant = variant })
  H.reset()

  local record
  local messages = H.quiet(function()
    record = H.capture_highlights(function()
      require("silkcircuit").setup(opts)
      vim.cmd("colorscheme silkcircuit")
    end)
  end)
  record.messages = messages
  return record
end

-- Load `variant` with every integration enabled.
function H.load_full(variant, opts)
  return H.load(variant, H.all_integrations(opts))
end

-- Deliberately unguarded: nvim_get_hl only errors on a malformed group name,
-- which is a bug in the spec, not a fact about the theme. An undefined group
-- comes back as an empty table.
function H.get_hl(group)
  return vim.api.nvim_get_hl(0, { name = group })
end

-- True when a highlight carries any actual styling. nvim_get_hl() returns an
-- empty dict for a group that was defined with nothing in it, which is how a
-- nil colour shows up.
function H.has_attributes(hl)
  return type(hl) == "table" and next(hl) ~= nil
end

-- ---------------------------------------------------------------------------
-- Plugin isolation
-- ---------------------------------------------------------------------------

-- Run `fn` with a searcher in front of the module path that records any
-- attempt to require one of `names`, and return the attempts.
--
-- By default the searcher declines, so `require` fails exactly as it would for
-- a plugin that is not installed. With `opts.raise` it instead hands back a
-- loader that throws, which is what a lazy.nvim stub does for a plugin that
-- exists but has not been set up yet. That distinction matters: LuaJIT leaves
-- a sentinel in package.loaded after a loader raises, and every later require
-- of that module fails with "loop or previous error loading module". A theme
-- that probes for plugins can therefore poison them for the whole session.
function H.watch_requires(names, fn, opts)
  opts = opts or {}
  local watched = {}
  for _, name in ipairs(names) do
    watched[name] = true
  end

  local attempts = {}
  -- Neovim runs LuaJIT, so this is package.loaders rather than 5.2's
  -- package.searchers.
  local searchers = package.loaders
  local searcher = function(name)
    if not watched[name] then
      return nil
    end
    attempts[#attempts + 1] = name
    if opts.raise then
      return function()
        error("silkcircuit test: " .. name .. " is not loaded yet")
      end
    end
    return nil
  end

  table.insert(searchers, 1, searcher)
  local ok, err = pcall(fn)
  for index, entry in ipairs(searchers) do
    if entry == searcher then
      table.remove(searchers, index)
      break
    end
  end

  if not ok then
    error(err, 0)
  end
  return attempts
end

-- ---------------------------------------------------------------------------
-- Misc
-- ---------------------------------------------------------------------------

function H.sorted_keys(tbl)
  local keys = {}
  for key in pairs(tbl) do
    keys[#keys + 1] = key
  end
  table.sort(keys)
  return keys
end

function H.read_lines(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end
  local lines = {}
  for line in file:lines() do
    local trimmed = line:match("^%s*(.-)%s*$")
    if trimmed ~= "" then
      lines[#lines + 1] = trimmed
    end
  end
  file:close()
  return lines
end

function H.write_lines(path, lines)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  local file = assert(io.open(path, "w"))
  for _, line in ipairs(lines) do
    file:write(line, "\n")
  end
  file:close()
end

return H
