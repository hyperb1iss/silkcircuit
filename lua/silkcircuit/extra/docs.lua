-- Regenerates the extras tables that live between the `extras:start` and
-- `extras:end` markers. Everything outside the markers is hand-written.
--
-- Two block shapes exist. A bare `extras:start` marker takes the whole
-- registry, which is what the three overview pages want. An
-- `extras:start target=<name>` marker takes one target's five files, which is
-- what that target's own docs page wants.

local M = {}

local MARK_START = "<!-- extras:start -->"
local MARK_END = "<!-- extras:end -->"

--- Compare two marker blocks ignoring table alignment.
---
--- The generator writes single-space table cells and prettier then pads them
--- into columns, so comparing raw text calls every file changed on every run.
--- That buries the pages that really did change, and an aborted run leaves
--- alignment churn behind in the tree.
local function same_table(a, b)
  local function normalize(text)
    return (
      text:gsub(" *|+ *", "|"):gsub("%-%-+", "-"):gsub("%s+", " "):gsub("^ ", ""):gsub(" $", "")
    )
  end
  return normalize(a) == normalize(b)
end

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

-- A per-target block on a docs page. One target per block, several blocks per
-- page where a page covers a target that ships in two formats. The end marker
-- has to be escaped: its dashes are pattern quantifiers otherwise.
local TARGET_BLOCK = "(<!%-%- extras:start target=([%w%-]+) %-%->)(.-)(<!%-%- extras:end %-%->)"

--- File list for one target, for the block on that target's own docs page.
local function files_for(extra, name)
  local dir = extra.dir(name)
  local lines = {
    "| Variant | File |",
    "| ------- | ---- |",
  }

  if extra.targets[name].is_full then
    lines[#lines + 1] =
      string.format("| every variant | `extras/%s/%s` |", dir, extra.filename(name))
    return table.concat(lines, "\n")
  end

  for _, variant in ipairs(extra.variants) do
    lines[#lines + 1] =
      string.format("| %s | `extras/%s/%s` |", variant, dir, extra.filename(name, variant))
  end
  return table.concat(lines, "\n")
end

--- Rewrite the per-target blocks on every page under docs/extras. Pages
--- without a block are left alone. Returns the paths that changed.
local function generate_pages(extra, root, changed)
  local dir = root .. "/docs/extras"
  if vim.fn.isdirectory(dir) == 0 then
    return
  end

  local entries = {}
  for entry, kind in vim.fs.dir(dir) do
    if kind == "file" and entry:match("%.md$") then
      entries[#entries + 1] = entry
    end
  end
  table.sort(entries)

  for _, entry in ipairs(entries) do
    local path = dir .. "/" .. entry
    local content = table.concat(vim.fn.readfile(path), "\n")

    local updated = content:gsub(TARGET_BLOCK, function(open, name, body, close)
      if not extra.targets[name] then
        error(
          string.format("silkcircuit.extra: docs/extras/%s names unknown target '%s'", entry, name),
          0
        )
      end
      local rendered = files_for(extra, name)
      if same_table(body, rendered) then
        return open .. body .. close
      end
      return open .. "\n\n" .. rendered .. "\n\n" .. close
    end)

    if updated ~= content then
      extra.write(path, updated)
      changed[#changed + 1] = "docs/extras/" .. entry
      print("  docs/extras/" .. entry)
    end
  end
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

    local rendered = table_for(extra, destination)
    local body = content:sub(head + #MARK_START, tail - 1)
    local updated = content
    if not same_table(body, rendered) then
      updated = content:sub(1, head + #MARK_START - 1)
        .. "\n\n"
        .. rendered
        .. "\n\n"
        .. content:sub(tail)
    end

    if updated ~= content then
      extra.write(path, updated)
      changed[#changed + 1] = destination.path
      print("  " .. destination.path)
    end
  end

  generate_pages(extra, root, changed)

  return changed
end

return M
