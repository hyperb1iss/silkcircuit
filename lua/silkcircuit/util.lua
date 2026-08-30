local M = {}

-- Apply highlight group using nvim_set_hl API
function M.highlight(group, opts)
  local hl = {}

  if opts.link then
    hl.link = opts.link
  else
    if opts.fg then
      hl.fg = opts.fg
    end
    if opts.bg then
      hl.bg = opts.bg
    end
    if opts.sp then
      hl.sp = opts.sp
    end

    -- Collect style attributes
    if opts.style then
      local styles = type(opts.style) == "table" and opts.style or { opts.style }
      for _, s in ipairs(styles) do
        hl[s] = true
      end
    end
    if opts.italic then
      hl.italic = true
    end
    if opts.bold then
      hl.bold = true
    end
    if opts.underline then
      hl.underline = true
    end
    if opts.undercurl then
      hl.undercurl = true
    end
    if opts.strikethrough then
      hl.strikethrough = true
    end
  end

  pcall(vim.api.nvim_set_hl, 0, group, hl)
end

-- Load highlight groups
function M.load_highlights(highlights)
  for group, opts in pairs(highlights) do
    M.highlight(group, opts)
  end
end

-- Merge styles from config
function M.merge_styles(base, styles)
  if not styles or vim.tbl_isempty(styles) then
    return base
  end

  local result = vim.tbl_deep_extend("force", base, {})

  if styles.italic then
    result.style = result.style or {}
    table.insert(result.style, "italic")
  end

  if styles.bold then
    result.style = result.style or {}
    table.insert(result.style, "bold")
  end

  if styles.underline then
    result.style = result.style or {}
    table.insert(result.style, "underline")
  end

  return result
end

return M
