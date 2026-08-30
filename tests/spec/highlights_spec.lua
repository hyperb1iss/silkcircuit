-- Load each variant with every integration on and check what actually landed
-- in the highlight table. lua/silkcircuit/util.lua wraps nvim_set_hl in a
-- pcall, so a rejected colour is invisible at runtime; the capture record is
-- where those show up.

local H = require("helpers")
local describe, it = H.describe, H.it

-- Groups an editing session is visibly wrong without. Each must be set by the
-- theme and carry real attributes.
local REQUIRED_GROUPS = {
  "Normal",
  "NormalFloat",
  "FloatBorder",
  "Visual",
  "Pmenu",
  "PmenuSel",
  "CursorLine",
  "LineNr",
  "StatusLine",
  "DiffAdd",
  "DiffDelete",
  "DiffChange",
  "DiffText",
  "DiagnosticError",
  "DiagnosticWarn",
  "DiagnosticInfo",
  "DiagnosticHint",
  "@keyword",
  "@keyword.conditional",
  "@string",
  "@function",
  "@variable",
  "@comment",
  "LspReferenceText",
  "TelescopeSelection",
  "NeoTreeNormal",
  "GitSignsAdd",
  "NoiceCursor",
  "FlashLabel",
  "HarpoonWindow",
  "NeogitBranch",
}

describe("highlights", function()
  for _, variant in ipairs(H.variants) do
    it(variant .. " applies every highlight without an API error", function()
      local record = H.load_full(variant)
      local reported = {}
      for _, failure in ipairs(record.errors) do
        reported[#reported + 1] = failure.group .. ": " .. failure.message
      end
      H.empty(reported, variant .. ": nvim_set_hl refused these groups, so they are never defined")
    end)

    it(variant .. " passes only 6-digit hex colours to nvim_set_hl", function()
      local record = H.load_full(variant)
      local reported = {}
      for _, entry in ipairs(record.invalid) do
        reported[#reported + 1] = string.format("%s.%s = %s", entry.group, entry.key, entry.value)
      end
      H.empty(reported, variant .. ": colour values Neovim cannot parse")
    end)

    it(variant .. " defines the groups editors depend on", function()
      local record = H.load_full(variant)
      local missing = {}
      local rejected = {}
      for _, failure in ipairs(record.errors) do
        rejected[failure.group] = failure.message
      end

      for _, group in ipairs(REQUIRED_GROUPS) do
        if rejected[group] then
          missing[#missing + 1] = group .. " (rejected by nvim_set_hl: " .. rejected[group] .. ")"
        elseif record.opts[group] == nil then
          missing[#missing + 1] = group .. " (no integration defines it)"
        elseif not H.has_attributes(H.get_hl(group)) then
          missing[#missing + 1] = group .. " (set, but resolves to nothing)"
        end
      end
      H.empty(missing, variant .. ": required highlight groups missing or empty")
    end)

    it(variant .. " gives @keyword.conditional a foreground", function()
      H.load_full(variant)
      local hl = H.get_hl("@keyword.conditional") or {}
      H.ok(
        hl.fg ~= nil or hl.link ~= nil,
        variant
          .. ": @keyword.conditional has no fg, so conditionals render unstyled. Got "
          .. vim.inspect(hl)
      )
    end)

    it(variant .. " keeps NoiceCursor's blend", function()
      H.load_full(variant)
      local hl = H.get_hl("NoiceCursor") or {}
      H.eq(
        hl.blend,
        100,
        variant .. ": blend was dropped on the way to nvim_set_hl. Got " .. vim.inspect(hl)
      )
    end)
  end
end)
