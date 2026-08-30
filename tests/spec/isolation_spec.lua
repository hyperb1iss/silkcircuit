-- Loading a colorscheme must never reach for a plugin.
--
-- Under lazy.nvim the colorscheme is applied during startup, long before
-- lualine or telescope exist. A theme that decides what to highlight by
-- requiring those modules therefore skips every integration on a cold start
-- and only looks right after something else happens to load the plugin.
--
-- The watcher is a deny-list: anything reaching the module searchers that the
-- theme does not own (see H.own_module_patterns) is recorded, so a new
-- integration reaching for a new plugin is caught without anyone remembering
-- to add its name to a list.

local H = require("helpers")
local describe, it = H.describe, H.it

local function load(variant)
  require("silkcircuit").setup({ variant = variant })
  vim.cmd("colorscheme silkcircuit")
end

local function unique(names)
  local seen, out = {}, {}
  for _, name in ipairs(names) do
    if not seen[name] then
      seen[name] = true
      out[#out + 1] = name
    end
  end
  table.sort(out)
  return out
end

describe("isolation", function()
  for _, variant in ipairs(H.variants) do
    it(variant .. " loads without requiring a foreign module", function()
      H.reset()
      local attempts
      H.quiet(function()
        attempts = H.watch_requires(function()
          load(variant)
        end)
      end)

      H.empty(
        unique(attempts),
        variant
          .. ": the colorscheme required these modules. Under lazy.nvim they do not exist yet."
      )
    end)
  end

  -- The cost of probing, not just the fact of it. Here every foreign module
  -- raises while loading, which is what a lazy.nvim stub does before its
  -- plugin is set up. LuaJIT leaves a sentinel in package.loaded when a loader
  -- raises, and every later require of that module fails with "loop or
  -- previous error loading module", so a theme that probes on startup can
  -- break the plugin it was looking for, for the rest of the session.
  it("leaves no module poisoned in package.loaded", function()
    H.reset()

    local before = {}
    for name in pairs(package.loaded) do
      before[name] = true
    end

    local attempts
    H.quiet(function()
      attempts = H.watch_requires(function()
        load("neon")
      end, { raise = true })
    end)

    local poisoned = {}
    for _, name in ipairs(unique(attempts)) do
      if not before[name] and package.loaded[name] ~= nil then
        poisoned[#poisoned + 1] = name
        package.loaded[name] = nil
      end
    end

    H.empty(poisoned, "these modules can no longer be required in this session")
  end)
end)
