local M = {}
local util = require("silkcircuit.util")
local config = require("silkcircuit.config")

-- Get highlights
function M.get_highlights(colors, opts)
  local sem = require("silkcircuit.palette").semantic
  local highlights = {}

  -- Merge user style preferences
  local function apply_style(base, style_key)
    return util.merge_styles(base, opts.styles[style_key])
  end

  -- Editor highlights
  highlights.Normal = { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg }
  highlights.NormalFloat =
    { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg_highlight }
  highlights.NormalNC = opts.dim_inactive and { fg = colors.fg, bg = colors.bg_dark }
    or { link = "Normal" }
  highlights.Cursor = { fg = colors.bg, bg = colors.fg }
  highlights.CursorIM = { link = "Cursor" }
  highlights.CursorLine = { bg = colors.bg_highlight }
  highlights.CursorLineNr = { fg = colors.fg_light, bg = colors.bg_highlight, bold = true }
  highlights.CursorColumn = { link = "CursorLine" }
  highlights.ColorColumn = { bg = colors.bg_highlight }
  highlights.LineNr = { fg = colors.gray }
  highlights.LineNrAbove = { link = "LineNr" }
  highlights.LineNrBelow = { link = "LineNr" }
  highlights.VertSplit = { fg = colors.bg_highlight }
  highlights.WinSeparator = { fg = colors.bg_highlight }
  highlights.FloatBorder =
    { fg = sem.border, bg = opts.transparent and colors.none or colors.bg_highlight }
  highlights.FloatTitle =
    { fg = colors.pink, bg = opts.transparent and colors.none or colors.bg_highlight, bold = true }
  highlights.FloatFooter =
    { fg = colors.purple, bg = opts.transparent and colors.none or colors.bg_highlight }
  highlights.WinBar = { fg = colors.pink_bright }
  highlights.WinBarNC = { fg = colors.purple_muted }
  highlights.SignColumn = { fg = colors.fg, bg = opts.transparent and colors.none or colors.bg }
  highlights.CursorLineSign = { bg = colors.bg_highlight }
  highlights.Folded = { fg = colors.gray, bg = colors.bg_highlight }
  highlights.FoldColumn = { fg = colors.gray }
  highlights.CursorLineFold = { fg = colors.purple, bg = colors.bg_highlight }
  highlights.EndOfBuffer = { fg = colors.bg }

  -- Statusline
  highlights.StatusLine = { fg = colors.fg_light, bg = colors.bg_highlight }
  highlights.StatusLineNC = { fg = colors.gray, bg = colors.bg_highlight }
  highlights.StatusLineTerm = { fg = colors.fg_light, bg = colors.bg_statusline, bold = true }
  highlights.StatusLineTermNC = { fg = colors.fg_dark, bg = colors.bg_statusline }

  -- Pmenu. Neovim 0.11 splits the popup row into label, kind and extra, and
  -- highlights the matched prefix separately from the rest of the label.
  highlights.Pmenu = { fg = colors.fg, bg = colors.bg_highlight }
  highlights.PmenuSel = { fg = colors.bg, bg = colors.purple }
  highlights.PmenuSbar = { bg = colors.bg_highlight }
  highlights.PmenuThumb = { bg = colors.gray }
  highlights.PmenuMatch = { fg = colors.pink, bg = colors.bg_highlight, bold = true }
  highlights.PmenuMatchSel = { fg = colors.bg, bg = colors.purple, bold = true }
  highlights.PmenuKind = { fg = colors.purple, bg = colors.bg_highlight }
  highlights.PmenuKindSel = { fg = colors.bg, bg = colors.purple }
  highlights.PmenuExtra = { fg = colors.purple_muted, bg = colors.bg_highlight }
  highlights.PmenuExtraSel = { fg = colors.bg, bg = colors.purple, italic = true }
  highlights.ComplMatchIns = { link = "Comment" }

  -- Tabs
  highlights.TabLine = { fg = colors.gray, bg = colors.bg_highlight }
  highlights.TabLineFill = { bg = colors.bg_highlight }
  highlights.TabLineSel = { fg = colors.fg_light, bg = colors.bg }

  -- Search & Selection
  highlights.Search = { fg = colors.bg, bg = colors.yellow }
  highlights.IncSearch = { fg = colors.bg, bg = colors.coral }
  highlights.CurSearch = { fg = colors.bg, bg = colors.pink }
  highlights.Substitute = { fg = colors.bg, bg = colors.red }
  highlights.Visual = { bg = colors.selection }
  highlights.VisualNOS = { bg = colors.selection }
  highlights.Selection = { bg = colors.selection }
  highlights.MatchParen = { fg = colors.pink, bold = true }
  highlights.SnippetTabstop = { bg = colors.selection }
  highlights.QuickFixLine = { bg = colors.bg_visual, bold = true }

  -- Diagnostics handled in integrations/native_lsp.lua

  -- Misc
  highlights.Directory = { fg = colors.blue }
  highlights.NonText = { fg = colors.gray }
  highlights.SpecialKey = { fg = colors.gray }
  highlights.Title = { fg = colors.blue, bold = true }
  highlights.Conceal = { fg = colors.gray }
  highlights.Question = { fg = colors.green }
  highlights.MoreMsg = { fg = colors.green }
  highlights.WarningMsg = { fg = colors.warning }
  highlights.ErrorMsg = { fg = colors.error }
  highlights.WildMenu = { fg = colors.bg, bg = colors.purple }
  highlights.ModeMsg = { fg = colors.fg, bold = true }
  highlights.Whitespace = { fg = colors.gray }
  highlights.TermCursor = { fg = colors.bg, bg = colors.pink }
  highlights.TermCursorNC = { fg = colors.bg, bg = colors.purple_muted }

  -- Diff
  highlights.DiffAdd = { bg = colors.diff_add }
  highlights.DiffChange = { bg = colors.diff_change }
  highlights.DiffDelete = { bg = colors.diff_delete }
  highlights.DiffText = { bg = colors.diff_text }
  highlights.diffAdded = { fg = colors.git_add }
  highlights.diffRemoved = { fg = colors.git_delete }
  highlights.diffChanged = { fg = colors.git_change }

  -- The unprefixed diff groups Neovim exposes for statuslines and plugins
  highlights.Added = { fg = colors.git_add }
  highlights.Changed = { fg = colors.git_change }
  highlights.Removed = { fg = colors.git_delete }

  -- Spell
  highlights.SpellBad = { undercurl = true, sp = colors.error }
  highlights.SpellCap = { undercurl = true, sp = colors.warning }
  highlights.SpellLocal = { undercurl = true, sp = colors.info }
  highlights.SpellRare = { undercurl = true, sp = colors.hint }

  -- Syntax highlights
  highlights.Comment = apply_style({ fg = sem.comment, italic = true }, "comments")
  highlights.SpecialComment = { fg = colors.purple_muted, italic = true, bold = true }
  highlights.Constant = apply_style({ fg = sem.constant }, "constants")
  highlights.String = apply_style({ fg = sem.string, italic = true }, "strings")
  highlights.Character = { fg = colors.cyan_bright }
  highlights.Number = { fg = sem.number }
  highlights.Boolean = apply_style({ fg = sem.boolean }, "booleans")
  highlights.Float = { fg = sem.number }

  highlights.Identifier = apply_style({ fg = sem.variable }, "variables")
  highlights.Function = apply_style({ fg = sem.func }, "functions")

  highlights.Statement = apply_style({ fg = sem.keyword }, "keywords")
  highlights.Conditional = apply_style({ fg = sem.keyword }, "keywords")
  highlights.Repeat = apply_style({ fg = sem.keyword }, "keywords")
  highlights.Label = { fg = colors.cyan_bright }
  highlights.Operator = apply_style({ fg = sem.operator }, "operators")
  highlights.Keyword = apply_style({ fg = sem.keyword, bold = true }, "keywords")
  highlights.Exception = { fg = colors.purple }

  highlights.PreProc = { fg = colors.pink_bright }
  highlights.Include = { fg = colors.purple }
  highlights.Define = { fg = colors.pink_bright }
  highlights.Macro = { fg = colors.purple }
  highlights.PreCondit = { fg = colors.pink_bright }

  highlights.Type = apply_style({ fg = sem.type }, "types")
  highlights.StorageClass = { fg = colors.yellow }
  highlights.Structure = { fg = colors.yellow }
  highlights.Typedef = { fg = colors.yellow }

  highlights.Special = { fg = colors.pink_bright }
  highlights.SpecialChar = { fg = colors.coral }
  highlights.Tag = { fg = colors.pink, bold = true }
  highlights.Delimiter = { fg = colors.fg_dark }
  highlights.Debug = { fg = colors.red }

  highlights.Underlined = { underline = true }
  highlights.Bold = { bold = true }
  highlights.Italic = { italic = true }
  highlights.Ignore = { fg = colors.gray }
  highlights.Error = { fg = colors.error }
  highlights.Todo = { fg = colors.bg, bg = colors.pink, bold = true }

  -- Additional vim syntax groups
  highlights.qfLineNr = { fg = colors.yellow }
  highlights.qfFileName = { fg = colors.cyan_bright }
  highlights.htmlH1 = { fg = colors.pink, bold = true }
  highlights.htmlH2 = { fg = colors.cyan_bright, bold = true }
  highlights.mkdCodeDelimiter = { bg = colors.bg, fg = colors.fg }
  highlights.mkdCodeStart = { fg = colors.pink, bold = true }
  highlights.mkdCodeEnd = { fg = colors.pink, bold = true }

  -- Health check
  highlights.healthError = { fg = colors.red }
  highlights.healthSuccess = { fg = colors.green_bright }
  highlights.healthWarning = { fg = colors.yellow }

  -- Illuminate
  highlights.illuminatedWord = { bg = colors.bg_highlight }
  highlights.illuminatedCurWord = { bg = colors.bg_highlight }

  -- Rainbow delimiters
  highlights.rainbow1 = { fg = colors.red }
  highlights.rainbow2 = { fg = colors.coral }
  highlights.rainbow3 = { fg = colors.yellow }
  highlights.rainbow4 = { fg = colors.green }
  highlights.rainbow5 = { fg = colors.cyan_bright }
  highlights.rainbow6 = { fg = colors.pink }

  -- Apply user overrides
  if opts.on_highlights then
    opts.on_highlights(highlights, colors)
  end

  return highlights
end

-- Apply the theme
function M.apply()
  local palette = require("silkcircuit.palette")
  local opts = config.get()
  local colors = palette.get_colors()
  palette.update_semantic(colors) -- Update semantic colors with variant colors
  local highlights = M.get_highlights(colors, opts)

  -- Clear any existing autocmds that might interfere
  vim.api.nvim_create_augroup("SilkCircuit", { clear = true })

  util.load_highlights(highlights)

  -- Load plugin integrations
  if opts.integrations then
    require("silkcircuit.integrations").load(colors, opts)
  else
    vim.notify("SilkCircuit: integrations disabled in config", vim.log.levels.WARN)
  end
end

-- Set terminal colors
function M.set_terminal_colors()
  local palette = require("silkcircuit.palette")
  local colors = palette.get_colors()

  vim.g.terminal_color_0 = colors.terminal_black
  vim.g.terminal_color_1 = colors.terminal_red
  vim.g.terminal_color_2 = colors.terminal_green
  vim.g.terminal_color_3 = colors.terminal_yellow
  vim.g.terminal_color_4 = colors.terminal_blue
  vim.g.terminal_color_5 = colors.terminal_magenta
  vim.g.terminal_color_6 = colors.terminal_cyan
  vim.g.terminal_color_7 = colors.terminal_white
  vim.g.terminal_color_8 = colors.terminal_bright_black
  vim.g.terminal_color_9 = colors.terminal_bright_red
  vim.g.terminal_color_10 = colors.terminal_bright_green
  vim.g.terminal_color_11 = colors.terminal_bright_yellow
  vim.g.terminal_color_12 = colors.terminal_bright_blue
  vim.g.terminal_color_13 = colors.terminal_bright_magenta
  vim.g.terminal_color_14 = colors.terminal_bright_cyan
  vim.g.terminal_color_15 = colors.terminal_bright_white
end

return M
