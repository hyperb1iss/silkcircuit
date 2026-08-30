-- Regenerates the extras tables that live between the `extras:start` and
-- `extras:end` markers. Everything outside the markers is hand-written.

local M = {}

local MARK_START = "<!-- extras:start -->"
local MARK_END = "<!-- extras:end -->"

-- The docs site links to pages, not to repository files, so it lists the
-- generated names as code instead of as links that VitePress would try to
-- resolve into routes.
local DESTINATIONS = {
  { path = "README.md", prefix = "extras/", links = true },
  { path = "extras/README.md", prefix = "", links = true },
  { path = "docs/extras/index.md", prefix = "extras/", links = false },
}

local function link_cell(extra, name, prefix)
  local parts = {}
  if extra.targets[name].is_full then
    local path = prefix .. extra.dir(name) .. "/" .. extra.filename(name)
    return "[every variant](" .. path .. ")"
  end
  for _, variant in ipairs(extra.variants) do
    local path = prefix .. extra.dir(name) .. "/" .. extra.filename(name, variant)
    parts[#parts + 1] = "[" .. variant .. "](" .. path .. ")"
  end
  return table.concat(parts, " · ")
end

local function code_cell(extra, name, prefix)
  local spec = extra.targets[name]
  local suffix = spec.ext ~= "" and ("." .. spec.ext) or ""
  local base = prefix .. extra.dir(name) .. "/silkcircuit"
  if spec.is_full then
    return "`" .. base .. suffix .. "`"
  end
  return "`" .. base .. "-{" .. table.concat(extra.variants, ",") .. "}" .. suffix .. "`"
end

local function table_for(extra, destination)
  local lines = {
    "| Target | Format | Generated files |",
    "| ------ | ------ | --------------- |",
  }
  for _, name in ipairs(extra.names()) do
    local spec = extra.targets[name]
    local files = destination.links and link_cell(extra, name, destination.prefix)
      or code_cell(extra, name, destination.prefix)
    lines[#lines + 1] = string.format("| %s | [reference](%s) | %s |", spec.label, spec.url, files)
  end
  return table.concat(lines, "\n")
end

--- Rewrite every marker block. Returns the paths that changed.
function M.generate(opts)
  opts = opts or {}
  local extra = require("silkcircuit.extra")
  local root = opts.root or vim.uv.cwd()

  local changed = {}
  for _, destination in ipairs(DESTINATIONS) do
    local path = root .. "/" .. destination.path
    local content = table.concat(vim.fn.readfile(path), "\n")

    local head = content:find(MARK_START, 1, true)
    local tail = content:find(MARK_END, 1, true)
    if not head or not tail then
      error(string.format("silkcircuit.extra: %s has no extras marker block", destination.path), 0)
    end

    local updated = content:sub(1, head + #MARK_START - 1)
      .. "\n\n"
      .. table_for(extra, destination)
      .. "\n\n"
      .. content:sub(tail)

    if updated ~= content then
      extra.write(path, updated)
      changed[#changed + 1] = destination.path
      print("  " .. destination.path)
    end
  end

  return changed
end

return M
