-- btop reads one `theme[key]="#rrggbb"` per line, so the gradients are spelled
-- out start/mid/end rather than interpolated. Every gradient runs through the
-- same purple, pink, cyan family the rest of the theme uses.

local M = {}

local TEMPLATE = [[
# Main background, empty for terminal default, need to be empty if you want transparent background
theme[main_bg]="${bg}"

# Main text color
theme[main_fg]="${fg}"

# Title color for boxes
theme[title]="${pink}"

# Highlight color for keyboard shortcuts
theme[hi_fg]="${cyan}"

# Background color of selected item in processes box
theme[selected_bg]="${bg_visual}"

# Foreground color of selected item in processes box
theme[selected_fg]="${pink}"

# Color of inactive/disabled text
theme[inactive_fg]="${comment}"

# Color of text appearing on top of graphs, i.e uptime and current network graph scaling
theme[graph_text]="${pink_soft}"

# Background color of the percentage meters
theme[meter_bg]="${bg_highlight}"

# Misc colors for processes box including mini cpu graphs, details memory graph and details status text
theme[proc_misc]="${pink}"

# CPU, Memory, Network, Proc box outline colors
theme[cpu_box]="${purple}"
theme[mem_box]="${cyan}"
theme[net_box]="${pink}"
theme[proc_box]="${green}"

# Box divider line and small boxes line color
theme[div_line]="${gray}"

# Temperature graph color (green -> yellow -> red)
theme[temp_start]="${green}"
theme[temp_mid]="${yellow}"
theme[temp_end]="${red}"

# CPU graph colors (purple -> pink -> cyan)
theme[cpu_start]="${purple}"
theme[cpu_mid]="${pink_bright}"
theme[cpu_end]="${cyan}"

# Mem/Disk free meter (cyan -> purple -> pink)
theme[free_start]="${cyan}"
theme[free_mid]="${purple}"
theme[free_end]="${pink_bright}"

# Mem/Disk cached meter (muted purple -> purple -> pink)
theme[cached_start]="${purple_muted}"
theme[cached_mid]="${purple}"
theme[cached_end]="${pink_bright}"

# Mem/Disk available meter (pink -> orange -> red)
theme[available_start]="${pink}"
theme[available_mid]="${orange}"
theme[available_end]="${red}"

# Mem/Disk used meter (green -> light cyan -> cyan)
theme[used_start]="${green}"
theme[used_mid]="${cyan_light}"
theme[used_end]="${cyan}"

# Download graph colors (light pink -> pink -> purple)
theme[download_start]="${pink_bright}"
theme[download_mid]="${pink}"
theme[download_end]="${purple}"

# Upload graph colors (cyan -> light cyan -> green)
theme[upload_start]="${cyan}"
theme[upload_mid]="${cyan_light}"
theme[upload_end]="${green}"

# Process box color gradient for threads, mem and cpu usage (cyan -> purple -> pink)
theme[process_start]="${cyan}"
theme[process_mid]="${purple}"
theme[process_end]="${pink_bright}"
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
