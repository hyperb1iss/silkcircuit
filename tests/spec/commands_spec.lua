-- Every user command has to survive being run headless, and checkhealth has
-- to come back without an ERROR.

local H = require("helpers")
local describe, it = H.describe, H.it

local function load_theme()
  H.reset()
  H.quiet(function()
    require("silkcircuit").setup({})
    vim.cmd("colorscheme silkcircuit")
  end)
end

-- Running without throwing is not the same as succeeding: the commands report
-- most problems through vim.notify at ERROR level and return normally, so a
-- bad variant or a contrast violation would otherwise pass silently.
local function run(command)
  local ok, err
  local messages = H.quiet(function()
    ok, err = pcall(vim.cmd, command)
  end)
  H.ok(ok, ":" .. command .. " failed: " .. tostring(err))

  local reported = {}
  for _, entry in ipairs(messages) do
    if entry.level and entry.level >= vim.log.levels.ERROR then
      reported[#reported + 1] = entry.message
    end
  end
  H.empty(reported, ":" .. command .. " reported errors")
  return messages
end

describe("commands", function()
  it("registers its user commands", function()
    load_theme()
    local defined = vim.api.nvim_get_commands({})
    local missing = {}
    for _, name in ipairs({
      "SilkCircuit",
      "SilkCircuitGlow",
      "SilkCircuitContrast",
      "SilkCircuitIntegrations",
    }) do
      if not defined[name] then
        missing[#missing + 1] = name
      end
    end
    H.empty(missing, "user commands that were never created")
  end)

  for _, variant in ipairs(H.variants) do
    it(":SilkCircuit " .. variant .. " runs", function()
      load_theme()
      run("SilkCircuit " .. variant)
      H.eq(
        require("silkcircuit.variants").get_current_variant(),
        variant,
        "the command did not switch the active variant"
      )
    end)
  end

  it(":SilkCircuit with no argument reports the current variant", function()
    load_theme()
    run("SilkCircuit")
  end)

  it(":SilkCircuitGlow toggles on and back off", function()
    load_theme()
    run("SilkCircuitGlow")
    H.ok(require("silkcircuit.glow").is_enabled(), "glow mode did not turn on")
    run("SilkCircuitGlow")
    H.ok(not require("silkcircuit.glow").is_enabled(), "glow mode did not turn off")
  end)

  it(":SilkCircuitContrast runs", function()
    load_theme()
    run("SilkCircuitContrast")
  end)

  it(":SilkCircuitIntegrations runs", function()
    load_theme()
    run("SilkCircuitIntegrations")
  end)

  it("checkhealth silkcircuit reports no errors", function()
    load_theme()

    local lines
    H.quiet(function()
      vim.cmd("silent checkhealth silkcircuit")
      lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      vim.cmd("silent! bwipeout!")
    end)

    H.ok(#lines > 0, "checkhealth produced no output")

    local errors = {}
    for _, line in ipairs(lines) do
      if line:match("ERROR") then
        errors[#errors + 1] = line
      end
    end
    H.empty(errors, "checkhealth silkcircuit reported errors")
  end)
end)
