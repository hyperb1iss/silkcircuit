-- A variant saved with :SilkCircuit has to be in force the next time the
-- colorscheme loads. If preferences are applied after the theme has already
-- been painted, the saved choice only shows up on the second load, which is
-- what a user sees as "my theme resets on startup".
--
-- Each case runs against its own data directory so nothing here can reach
-- another spec or the developer's real preferences file.

local H = require("helpers")
local describe, it = H.describe, H.it

local function load_theme(opts)
  H.quiet(function()
    require("silkcircuit").setup(opts or {})
    vim.cmd("colorscheme silkcircuit")
  end)
end

local function normal_bg()
  local hl = H.get_hl("Normal") or {}
  return hl.bg and H.hex(hl.bg) or nil
end

describe("preferences", function()
  it(":SilkCircuit writes the chosen variant to disk", function()
    H.with_data_home(function()
      H.reset()
      load_theme({})
      H.quiet(function()
        vim.cmd("SilkCircuit glow")
      end)

      local saved = require("silkcircuit.preferences").load()
      H.eq(saved.variant, "glow", "the variant was not persisted")
    end)
  end)

  it("a saved variant is in force on the first load", function()
    H.with_data_home(function()
      H.reset()
      load_theme({})
      H.quiet(function()
        vim.cmd("SilkCircuit glow")
      end)

      local expected = require("silkcircuit.variants").get_colors("glow").bg

      -- Forget the modules but keep the preference file: this is a fresh
      -- Neovim session that finds a saved variant.
      H.reset_modules()
      load_theme({})

      H.eq(
        normal_bg(),
        expected,
        "the first load ignored the saved variant, so it only takes effect on the second"
      )
    end)
  end)

  it("an explicit variant wins over the saved one", function()
    H.with_data_home(function()
      H.reset()
      load_theme({})
      H.quiet(function()
        vim.cmd("SilkCircuit glow")
      end)

      local expected = require("silkcircuit.variants").get_colors("dawn").bg

      H.reset_modules()
      load_theme({ variant = "dawn" })

      H.eq(normal_bg(), expected, "setup({ variant = ... }) lost to the saved preference")
    end)
  end)
end)
