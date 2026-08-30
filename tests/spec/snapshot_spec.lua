-- A record of which highlight groups each variant successfully defines.
--
-- Losing a group is a regression: something the theme used to style now falls
-- back to Neovim's default. Gaining one is fine and gets reported. Refresh
-- after an intentional change with:
--
--   SILKCIRCUIT_UPDATE_SNAPSHOTS=1 scripts/test --filter snapshot
--
-- The snapshot holds only groups the theme set without error, so it is
-- unaffected by Neovim's own default highlight table and stays stable across
-- Neovim versions.

local H = require("helpers")
local describe, it = H.describe, H.it

local UPDATE = vim.env.SILKCIRCUIT_UPDATE_SNAPSHOTS == "1"

local function snapshot_path(variant)
  return H.root .. "/tests/snapshots/" .. variant .. ".txt"
end

describe("snapshot", function()
  for _, variant in ipairs(H.variants) do
    it(variant .. " still defines every group in its snapshot", function()
      local record = H.load_full(variant)
      local path = snapshot_path(variant)

      if UPDATE then
        H.write_lines(path, record.applied)
        H.note(string.format("updated %s (%d groups)", path, #record.applied))
        return
      end

      local expected = H.read_lines(path)
      if not expected or #expected == 0 then
        H.fail(
          string.format(
            "%s is missing or empty, so it guards nothing. Write it with SILKCIRCUIT_UPDATE_SNAPSHOTS=1 scripts/test --filter snapshot",
            path
          )
        )
      end

      local present = {}
      for _, group in ipairs(record.applied) do
        present[group] = true
      end

      local missing = {}
      for _, group in ipairs(expected) do
        if not present[group] then
          missing[#missing + 1] = group
        end
      end

      local known = {}
      for _, group in ipairs(expected) do
        known[group] = true
      end
      local added = {}
      for _, group in ipairs(record.applied) do
        if not known[group] then
          added[#added + 1] = group
        end
      end

      if #added > 0 then
        H.note(
          string.format("%s gained %d group(s): %s", variant, #added, table.concat(added, ", "))
        )
      end

      H.empty(missing, variant .. ": groups in the snapshot that are no longer defined")
    end)
  end
end)
