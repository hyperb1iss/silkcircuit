-- Configuration surface: defaults, style overrides, on_highlights,
-- transparency, switching an integration off, and keeping the returned
-- options table from leaking back into the defaults.

local H = require("helpers")
local describe, it = H.describe, H.it

local function config_module()
  H.reset()
  return require("silkcircuit.config")
end

describe("config", function()
  it("setup({}) leaves the documented defaults in place", function()
    local config = config_module()
    config.setup({})
    local opts = config.get()

    H.eq(opts.variant, "neon", "default variant")
    H.eq(opts.transparent, false, "default transparency")
    H.eq(opts.terminal_colors, true, "default terminal colours")
    H.ok(type(opts.styles) == "table", "styles table is present")
    H.ok(type(opts.integrations) == "table", "integrations table is present")
  end)

  it("styles.comments.italic = false removes italics from comments", function()
    H.load_full("neon", { styles = { comments = { italic = false } } })

    local offenders = {}
    for _, group in ipairs({ "Comment", "@comment" }) do
      local hl = H.get_hl(group) or {}
      if hl.italic then
        offenders[#offenders + 1] = group
      end
    end
    H.empty(offenders, "styles.comments.italic = false was ignored for these groups")
  end)

  it("on_highlights can override a group", function()
    H.load_full("neon", {
      on_highlights = function(highlights, colors)
        highlights.Normal = { fg = colors.fg, bg = "#010203" }
      end,
    })

    local hl = H.get_hl("Normal") or {}
    H.eq(hl.bg and H.hex(hl.bg), "#010203", "on_highlights override did not reach Normal")
  end)

  it("transparent = true clears Normal's background but keeps its text", function()
    H.load_full("neon", { transparent = true })
    local hl = H.get_hl("Normal") or {}
    -- fg first: an undefined Normal has no bg either, and would otherwise
    -- satisfy this case without the theme having loaded at all.
    H.ok(hl.fg ~= nil, "Normal has no foreground, so it was never defined: " .. vim.inspect(hl))
    H.eq(hl.bg, nil, "Normal still has a background: " .. vim.inspect(hl))
  end)

  it("a disabled integration defines none of its groups", function()
    -- Prove the group is there to lose before proving it is gone, or an
    -- integration that never defined it would pass this case for free.
    H.load_full("neon")
    H.ok(
      H.has_attributes(H.get_hl("TelescopeSelection")),
      "TelescopeSelection is undefined even with telescope enabled, so this case proves nothing"
    )

    H.load_full("neon", { integrations = { telescope = false } })
    local hl = H.get_hl("TelescopeSelection")
    H.ok(
      not H.has_attributes(hl),
      "integrations.telescope = false still produced TelescopeSelection: " .. vim.inspect(hl)
    )
  end)

  it("mutating the table config.get() returns does not change the defaults", function()
    local config = config_module()

    -- get() before setup() is the path that hands back the defaults table
    -- itself; preferences.apply() writes straight into it.
    config.get().variant = "dawn"
    config.setup({})

    H.eq(
      config.get().variant,
      "neon",
      "a write through config.get() leaked into the defaults and survived setup()"
    )
  end)
end)
