-- The extras generator is the only thing standing between the palette and
-- every non-Neovim target, and nothing else in the suite exercises it. A
-- build into a throwaway root proves the engine renders every registered
-- target for every variant without raising.

local H = require("helpers")
local describe, it = H.describe, H.it

local function build_into_tempdir()
  local root = vim.fn.tempname()
  vim.fn.mkdir(root, "p")
  local extra = require("silkcircuit.extra")
  local written = extra.build({ root = root })
  return root, extra, written
end

describe("extras generator", function()
  it("renders every registered target for every variant", function()
    H.reset_modules()
    local root, extra, written
    H.quiet(function()
      root, extra, written = build_into_tempdir()
    end)

    local expected = 0
    for _, name in ipairs(extra.names()) do
      expected = expected + (extra.targets[name].is_full and 1 or #extra.variants)
    end
    H.at_least(#written, expected, "fewer files written than the registry promises")

    local missing = {}
    for _, relative in ipairs(written) do
      local path = root .. "/" .. relative
      if vim.fn.filereadable(path) == 0 or vim.fn.getfsize(path) == 0 then
        missing[#missing + 1] = relative
      end
    end
    H.empty(missing, "written files that are unreadable or empty")

    vim.fn.delete(root, "rf")
  end)

  it("expands every template reference to a palette value", function()
    H.reset_modules()
    local root, written
    H.quiet(function()
      root, _, written = build_into_tempdir()
    end)

    local leaks = {}
    for _, relative in ipairs(written) do
      for _, line in ipairs(H.read_lines(root .. "/" .. relative)) do
        if
          line:find("${", 1, true)
          and not relative:match("starship")
          and not relative:match("fzf")
        then
          leaks[#leaks + 1] = relative .. ": " .. line
          break
        end
      end
    end
    H.empty(leaks, "generated files still carrying a ${...} reference")

    vim.fn.delete(root, "rf")
  end)

  it("preserves the Starship powerline design", function()
    H.reset_modules()
    local root, extra
    H.quiet(function()
      root, extra = build_into_tempdir()
    end)

    local symbols = { "", "", "", "", "", "" }
    for _, variant in ipairs(extra.variants) do
      local path = root .. "/extras/starship/silkcircuit-" .. variant .. ".toml"
      local content = table.concat(H.read_lines(path), "\n")
      for _, symbol in ipairs(symbols) do
        H.ok(
          content:find(symbol, 1, true),
          string.format("Starship %s is missing symbol %s", variant, symbol)
        )
      end
    end

    local neon = table.concat(H.read_lines(root .. "/extras/starship/silkcircuit-neon.toml"), "\n")
    for _, color in ipairs({ "#1a1a2e", "#4a1a4a", "#7a2d7a", "#a040a0", "#d060d0", "#ff69b4" }) do
      H.ok(neon:find(color, 1, true), "Starship neon lost gradient color " .. color)
    end

    vim.fn.delete(root, "rf")
  end)
end)
