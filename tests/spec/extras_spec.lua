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
          and not relative:match("claude")
        then
          leaks[#leaks + 1] = relative .. ": " .. line
          break
        end
      end
    end
    H.empty(leaks, "generated files still carrying a ${...} reference")

    vim.fn.delete(root, "rf")
  end)

  -- The status line is a bash script, so the only proof it works is running
  -- it. A payload shaped like Claude Code's goes in and a single line with
  -- the model, the context reading, and the branch has to come out, on every
  -- variant, with nothing on stderr and a zero exit.
  it("renders the Claude Code status line from a payload", function()
    H.reset_modules()
    local root, extra
    H.quiet(function()
      root, extra = build_into_tempdir()
    end)

    -- H.root rather than getcwd: an earlier spec may leave the cwd somewhere
    -- that is not a repository, and the line readings live in the git segment.
    local repo = H.root
    local payload = vim.json.encode({
      cwd = repo,
      session_name = "spec",
      model = { id = "claude-opus-5", display_name = "Opus" },
      workspace = { current_dir = repo, project_dir = repo },
      output_style = { name = "default" },
      cost = { total_cost_usd = 1.5, total_lines_added = 12, total_lines_removed = 3 },
      context_window = {
        total_input_tokens = 61500,
        context_window_size = 200000,
        used_percentage = 31,
        current_usage = {
          input_tokens = 8500,
          output_tokens = 1200,
          cache_creation_input_tokens = 5000,
          cache_read_input_tokens = 48000,
        },
      },
      rate_limits = { five_hour = { used_percentage = 83.5 } },
      effort = { level = "high" },
    })

    local failures = {}
    for _, variant in ipairs(extra.variants) do
      local script = root .. "/extras/claude/silkcircuit-" .. variant .. ".sh"
      local stderr = root .. "/claude-" .. variant .. ".stderr"
      local out = vim.fn.system({
        "env",
        "COLUMNS=160",
        "XDG_CACHE_HOME=" .. root,
        "bash",
        "-c",
        'exec bash "$0" 2>"$1"',
        script,
        stderr,
      }, payload)
      local err = table.concat(H.read_lines(stderr), "\n")
      if vim.v.shell_error ~= 0 then
        failures[#failures + 1] = variant .. ": exit " .. vim.v.shell_error .. " " .. err
      elseif err ~= "" then
        failures[#failures + 1] = variant .. ": stderr " .. err
      elseif out:find("\n", 1, true) then
        failures[#failures + 1] = variant .. ": printed more than one line"
      else
        for _, needle in ipairs({ "Opus", "61.5K", "31%", "$1.50", "83%", "+12", "-3", "spec" }) do
          if not out:find(needle, 1, true) then
            failures[#failures + 1] = variant .. ": missing " .. needle
          end
        end
      end
    end
    H.empty(failures, "Claude Code status line renders that went wrong")

    vim.fn.delete(root, "rf")
  end)

  it("keeps the Claude Code status line on the Starship ramp", function()
    H.reset_modules()
    local root, extra
    H.quiet(function()
      root, extra = build_into_tempdir()
    end)

    local prompt = require("silkcircuit.extra.prompt")
    for _, variant in ipairs(extra.variants) do
      local ramp = prompt.colors(extra.colors(variant))
      local path = root .. "/extras/claude/silkcircuit-" .. variant .. ".sh"
      local content = table.concat(H.read_lines(path), "\n")
      H.ok(content:sub(1, 2) == "#!", "Claude Code " .. variant .. " lost its shebang")
      -- Every ramp step the script paints with, plus the two git colours.
      local palette = extra.colors(variant)
      local expected = {
        background = ramp.background,
        warning_surface = ramp.warning_surface,
        warning_text = ramp.warning_text,
        danger_surface = ramp.danger_surface,
        danger_text = ramp.danger_text,
        git_add = palette.git_add,
        git_delete = palette.git_delete,
      }
      for i = 1, 5 do
        expected["segment_" .. i] = ramp["segment_" .. i]
      end
      for i = 1, 4 do
        expected["foreground_" .. i] = ramp["foreground_" .. i]
      end
      for key, hex in pairs(expected) do
        local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
        local triplet = string.format("%d;%d;%d", tonumber(r, 16), tonumber(g, 16), tonumber(b, 16))
        H.ok(
          content:find(triplet, 1, true),
          string.format("Claude Code %s does not carry the %s of its ramp", variant, key)
        )
      end
    end

    vim.fn.delete(root, "rf")
  end)

  it("preserves the Starship powerline design", function()
    H.reset_modules()
    local root, extra
    H.quiet(function()
      root, extra = build_into_tempdir()
    end)

    local symbols = { "", "", "", "", "" }
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
