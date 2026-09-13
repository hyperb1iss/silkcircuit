-- Herdr keeps no theme files. Its UI palette is the `[theme]` table in
-- ~/.config/herdr/config.toml: a built-in base plus `[theme.custom]` token
-- overrides, so this ships that table alone for merging into the user's config.
--
-- All nineteen tokens Herdr exposes are set, which leaves the base with nothing
-- to paint. It still matters for any token a newer Herdr adds, and `terminal`
-- is the one base that hands those to the terminal's own ANSI palette instead
-- of a stranger's.

local M = {}

-- Herdr token, palette key. The roles are Herdr's, from its Palette struct.
local TOKENS = {
  { "accent", "purple" }, -- highlights, active borders, the focused tab
  { "panel_bg", "bg_dark" }, -- tab bar, floating panels, overlays
  { "sidebar_bg", "bg_dark" }, -- desktop sidebar
  { "active_row_bg", "bg_float" }, -- active workspace and focused agent rows
  { "selection_bg", "bg_visual" }, -- navigate-mode cursor row
  { "surface0", "bg_float" }, -- selected items, unfocused tabs
  { "surface1", "bg_visual" }, -- dragged rows, copy-mode matches
  { "surface_dim", "divider" }, -- separators
  { "overlay0", "gray" }, -- muted text
  { "overlay1", "comment" }, -- brighter muted text
  { "text", "fg" },
  { "subtext0", "fg_dark" }, -- workspace numbers, dim labels
  { "mauve", "pink" }, -- branch names, the resize mode bar
  { "green", "green" }, -- done and idle agents
  { "yellow", "yellow" }, -- working agents
  { "red", "red" }, -- blocked agents
  { "blue", "blue" }, -- finished notifications
  { "teal", "cyan" }, -- notification accents, unseen markers
  { "peach", "coral" }, -- interrupted agents, warnings
}

-- Herdr paints the focused tab and the mode bar as panel_bg on accent, and
-- every other foreground token on panel_bg, sidebar_bg, active_row_bg, or
-- surface0. Each of those pairs clears 4.5:1 in all five variants, which is
-- why the row and the tab surface share bg_float: it is the one raised surface
-- that sits past bg_dark in both the dark variants and Dawn, where
-- bg_highlight is lighter than bg_dark and would vanish against the sidebar.
-- The navigate cursor row and the dragged row are the palette's Visual color,
-- a mid tone, so accents there clear Herdr's own 3:1 floor for text and not
-- 4.5:1, as in the Neovim theme.

local HEADER = [[
# Merge the tables below into ~/.config/herdr/config.toml, replacing any
# [theme] table already there, then reload:
#   herdr server reload-config
# Prefix then Shift+R does the same from inside Herdr, and `herdr config check`
# validates the result.
#
# This is the theme block only. Keys, sounds, sidebar layout, and everything
# else in config.toml stay yours.]]

--- The `token = "#hex"` lines for one variant, under `header`.
function M.table(colors, header)
  local extra = require("silkcircuit.extra")
  local lines = { header }
  for _, token in ipairs(TOKENS) do
    lines[#lines + 1] = string.format('%s = "${%s}"', token[1], token[2])
  end
  return extra.template(table.concat(lines, "\n"), colors)
end

function M.generate(colors)
  return table.concat({
    HEADER,
    "",
    "[theme]",
    'name = "terminal"',
    "",
    M.table(colors, "[theme.custom]"),
  }, "\n")
end

return M
