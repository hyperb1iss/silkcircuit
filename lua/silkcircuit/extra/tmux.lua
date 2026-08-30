-- A theme, not a config. Everything here is a colour or a status format, so
-- the file can be sourced from any tmux.conf without arguing about bindings.
-- Needs tmux 3.4, which is where menu-style and menu-border-style landed.
--
-- Every foreground here clears 4.5:1 against the surface behind it in all five
-- variants, which is what rules cyan and yellow out of the status bar: dawn's
-- near-white bg_dark leaves them at 4.1 and 3.0.

local M = {}

local TEMPLATE = [[
# Status bar
set -g status on
set -g status-justify left
set -g status-left-length 40
set -g status-right-length 80
set -g status-style "bg=${bg_dark},fg=${fg_dark}"

# Left: the session name in an electric purple segment
set -g status-left "#[fg=${bg},bg=${purple},bold] #S #[fg=${purple},bg=${bg_dark},nobold] "

# Right: host, clock, date. The separator is the one deliberately faint part.
set -g status-right "#[fg=${pink}]#h #[fg=${comment}]|#[fg=${purple}] %H:%M #[fg=${comment}]|#[fg=${fg_dark}] %d %b "

# Window list
set -g window-status-separator ""
set -g window-status-style "bg=${bg_dark},fg=${fg_dark}"
set -g window-status-format "#[fg=${fg_dark},bg=${bg_dark}] #I:#W#F "
set -g window-status-current-format "#[fg=${pink},bg=${bg_dark}]#[fg=${bg},bg=${pink},bold] #I:#W#{?window_zoomed_flag,+,} #[fg=${pink},bg=${bg_dark},nobold]"
set -g window-status-activity-style "bg=${bg_dark},fg=${purple}"
set -g window-status-bell-style "bg=${bg_dark},fg=${red},bold"
set -g window-status-last-style "bg=${bg_dark},fg=${fg}"

# Panes
set -g pane-border-style "fg=${comment}"
set -g pane-active-border-style "fg=${border}"
set -g display-panes-colour "${fg_dark}"
set -g display-panes-active-colour "${purple}"

# Messages and the command prompt
set -g message-style "bg=${bg_highlight},fg=${pink},bold"
set -g message-command-style "bg=${bg_highlight},fg=${fg}"

# Copy mode. Search highlights are filled blocks, so they use accents that keep
# dark text legible on every variant.
set -g mode-style "bg=${bg_visual},fg=${fg}"
set -g copy-mode-match-style "bg=${purple},fg=${bg}"
set -g copy-mode-current-match-style "bg=${pink},fg=${bg},bold"
set -g copy-mode-mark-style "bg=${cyan},fg=${bg}"

# Clock
set -g clock-mode-colour "${cyan}"

# Popups and menus
set -g popup-style "bg=${bg},fg=${fg}"
set -g popup-border-style "fg=${border}"
set -g menu-style "bg=${bg_highlight},fg=${fg}"
set -g menu-selected-style "bg=${purple},fg=${bg},bold"
set -g menu-border-style "fg=${border}"
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
