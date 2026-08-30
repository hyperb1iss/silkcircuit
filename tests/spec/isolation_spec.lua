-- Loading a colorscheme must never reach for a plugin.
--
-- Under lazy.nvim the colorscheme is applied during startup, long before
-- lualine or telescope exist. A theme that decides what to highlight by
-- requiring those modules therefore skips every integration on a cold start
-- and only looks right after something else happens to load the plugin.
--
-- The searcher installed here declines to load the watched modules, so require
-- fails exactly as it would for a plugin that is not installed, and records
-- that the attempt was made.

local H = require("helpers")
local describe, it = H.describe, H.it

describe("isolation", function()
  for _, variant in ipairs(H.variants) do
    it(variant .. " loads without requiring a plugin module", function()
      H.reset()
      local attempts
      H.quiet(function()
        attempts = H.watch_requires(H.foreign_modules, function()
          require("silkcircuit").setup({ variant = variant })
          vim.cmd("colorscheme silkcircuit")
        end)
      end)

      local unique = {}
      local reported = {}
      for _, name in ipairs(attempts) do
        if not unique[name] then
          unique[name] = true
          reported[#reported + 1] = name
        end
      end

      H.empty(
        reported,
        variant
          .. ": the colorscheme required these plugin modules. Under lazy.nvim they do not exist yet."
      )
    end)
  end

  -- The cost of probing, not just the fact of it. Here the watched modules
  -- exist but raise while loading, which is what a lazy.nvim stub does before
  -- its plugin is set up. LuaJIT leaves a sentinel in package.loaded when a
  -- loader raises, and every later require of that module fails with "loop or
  -- previous error loading module" -- so a theme that probes on startup can
  -- break the plugin it was looking for, for the rest of the session.
  it("leaves no plugin module poisoned in package.loaded", function()
    H.reset()
    for _, name in ipairs(H.foreign_modules) do
      package.loaded[name] = nil
    end

    H.quiet(function()
      H.watch_requires(H.foreign_modules, function()
        require("silkcircuit").setup({})
        vim.cmd("colorscheme silkcircuit")
      end, { raise = true })
    end)

    local poisoned = {}
    for _, name in ipairs(H.foreign_modules) do
      if package.loaded[name] ~= nil then
        poisoned[#poisoned + 1] = name
        package.loaded[name] = nil
      end
    end
    H.empty(poisoned, "these modules can no longer be required in this session")
  end)
end)
