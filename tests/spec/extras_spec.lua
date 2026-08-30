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
end)
