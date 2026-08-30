-- AstroNvim integration helpers for SilkCircuit
-- Provides color mappings for AstroNvim's Heirline-based status system
local M = {}

-- Returns a status.colors function compatible with AstroUI opts.
-- Usage in your astroui.lua:
--   status = {
--     colorscheme = "silkcircuit",
--     colors = require("silkcircuit.contrib.astronvim").status_colors,
--   }
function M.status_colors(_)
  local c = require("silkcircuit.palette").get_colors()

  return {
    -- Base
    fg = c.fg,
    bg = c.bg,
    dark_bg = c.bg_dark,

    -- Mode colors (used by AstroNvim's mode indicator)
    blue = c.glow_purple,
    green = c.green,
    yellow = c.yellow_bright,
    yellow_1 = c.yellow,
    orange = c.orange,
    red = c.glow_pink,
    red_1 = c.pink,
    purple = c.purple,
    cyan = c.glow_cyan,

    -- Core status colors
    section_fg = c.fg,
    section_bg = c.bg_highlight,
    normal = c.fg,
    insert = c.glow_pink,
    visual = c.purple,
    replace = c.orange,
    command = c.yellow_bright,
    terminal = c.green,
    select = c.glow_cyan,

    -- UI element colors
    bright_bg = c.bg_highlight,
    bright_fg = c.fg_light,

    -- Diagnostics
    diag_ERROR = c.error,
    diag_WARN = c.warning,
    diag_INFO = c.info,
    diag_HINT = c.hint,
    diag_ERROR_bg = c.bg_highlight,
    diag_WARN_bg = c.bg_highlight,
    diag_INFO_bg = c.bg_highlight,
    diag_HINT_bg = c.bg_highlight,

    -- Git
    git_branch_fg = c.glow_purple,
    git_added = c.green,
    git_changed = c.yellow_bright,
    git_removed = c.glow_pink,

    -- LSP and treesitter
    lsp = c.cyan,
    lsp_bg = c.bg_highlight,
    treesitter_fg = c.cyan,

    -- Buffer colors
    buffer_fg = c.fg_dark,
    buffer_bg = c.bg_highlight,
    buffer_path_fg = c.purple_muted,
    buffer_close_fg = c.gray,

    buffer_active_fg = c.bg,
    buffer_active_bg = c.glow_purple,
    buffer_active_path_fg = c.bg,
    buffer_active_close_fg = c.bg,

    buffer_visible_fg = c.fg,
    buffer_visible_bg = c.purple_muted,
    buffer_visible_path_fg = c.fg_light,
    buffer_visible_close_fg = c.fg_dark,

    buffer_overflow_fg = c.bg,
    buffer_overflow_bg = c.pink,
    buffer_picker_fg = c.glow_cyan,

    -- Tab colors
    tab_fg = c.fg_dark,
    tab_bg = c.bg_highlight,
    tab_active_fg = c.bg,
    tab_active_bg = c.glow_purple,
    tab_close_fg = c.fg_dark,
    tab_close_bg = c.bg_highlight,

    -- Winbar
    winbar = c.fg_dark,
    winbar_fg = c.fg_dark,
    winbar_bg = c.bg,
    winbar_nc = c.gray,
    winbarnc_fg = c.gray,
    winbarnc_bg = c.bg_dark,
    tabline_bg = c.bg_dark,
    tabline_fg = c.fg_dark,
    scrollbar = c.purple_muted,

    -- Status
    status_bg = c.bg_highlight,
    status_fg = c.fg,

    -- Text states
    none = "NONE",
    text = c.fg,
    text_active = c.fg_light,
    text_inactive = c.fg_dark,
    bg_active = c.bg_highlight,
    bg_inactive = c.bg_dark,

    -- Component colors
    file_info_bg = c.bg_highlight,
    file_info_fg = c.fg,
    nav_bg = c.bg_highlight,
    nav_fg = c.fg,
    folder_closed = c.purple,
    folder_open = c.glow_purple,

    -- Completion menu
    pmenu_bg = c.bg_float,
    pmenu_fg = c.fg,
    pmenu_sel_bg = c.glow_purple,
    pmenu_sel_fg = c.bg,
  }
end

-- Recommended separator styles
M.separators = {
  left = { "", "" },
  right = { "", "" },
  tab = { "", "" },
  breadcrumbs = "  ",
  path = "  ",
}

return M
