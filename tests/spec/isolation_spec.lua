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

  it("leaves no plugin module in package.loaded", function()
    H.reset()
    H.quiet(function()
      H.watch_requires(H.foreign_modules, function()
        require("silkcircuit").setup({})
        vim.cmd("colorscheme silkcircuit")
      end)
    end)

    local leaked = {}
    for _, name in ipairs(H.foreign_modules) do
      if package.loaded[name] ~= nil then
        leaked[#leaked + 1] = name .. " = " .. type(package.loaded[name])
      end
    end
    H.empty(leaked, "plugin modules left behind in package.loaded")
  end)
end)
