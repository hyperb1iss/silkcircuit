local M = {}

-- procs parses a colour as one of sixteen ANSI names or as a bare 256-palette
-- index, and nothing else, so every colour here is quantised. A value may carry
-- a dark and a light form separated by '|'; these files are already per-variant,
-- so one value covers both and procs' own theme detection cannot pull the
-- process list away from the variant the user chose.
local TEMPLATE = [==[
[[columns]]
kind = "Pid"
style = "${x256.purple}"
numeric_search = true
nonnumeric_search = false
align = "Left"

[[columns]]
kind = "User"
style = "${x256.cyan}"
numeric_search = false
nonnumeric_search = true
align = "Left"

[[columns]]
kind = "Separator"
style = "${x256.blue_gray}"
numeric_search = false
nonnumeric_search = false
align = "Left"

[[columns]]
kind = "State"
style = "ByState"
numeric_search = false
nonnumeric_search = false
align = "Left"

[[columns]]
kind = "UsageCpu"
style = "ByPercentage"
numeric_search = false
nonnumeric_search = false
align = "Right"

[[columns]]
kind = "UsageMem"
style = "ByPercentage"
numeric_search = false
nonnumeric_search = false
align = "Right"

[[columns]]
kind = "CpuTime"
style = "${x256.blue}"
numeric_search = false
nonnumeric_search = false
align = "Left"

[[columns]]
kind = "MultiSlot"
style = "ByUnit"
numeric_search = false
nonnumeric_search = false
align = "Right"

[[columns]]
kind = "Separator"
style = "${x256.blue_gray}"
numeric_search = false
nonnumeric_search = false
align = "Left"

[[columns]]
kind = "Command"
style = "${x256.fg}"
numeric_search = false
nonnumeric_search = true
align = "Left"

[style]
header = "${x256.green}"
unit = "${x256.fg}"
tree = "${x256.fg}"

[style.by_percentage]
color_000 = "${x256.blue}"
color_025 = "${x256.green}"
color_050 = "${x256.yellow}"
color_075 = "${x256.red}"
color_100 = "${x256.red}"

[style.by_state]
color_d = "${x256.red}"
color_r = "${x256.green}"
color_s = "${x256.blue}"
color_t = "${x256.cyan}"
color_z = "${x256.purple}"
color_x = "${x256.purple}"
color_k = "${x256.yellow}"
color_w = "${x256.yellow}"
color_p = "${x256.yellow}"

[style.by_unit]
color_k = "${x256.blue}"
color_m = "${x256.green}"
color_g = "${x256.yellow}"
color_t = "${x256.red}"
color_p = "${x256.red}"
color_x = "${x256.blue}"

[search]
numeric_search = "Exact"
nonnumeric_search = "Partial"
logic = "And"
case = "Smart"

[display]
show_self = false
show_self_parents = false
show_thread = false
show_thread_in_tree = true
show_parent_in_tree = true
show_children_in_tree = true
show_header = true
show_footer = true
cut_to_terminal = true
cut_to_pager = false
cut_to_pipe = false
color_mode = "Auto"
separator = "│"
ascending = "▲"
descending = "▼"
tree_symbols = ["│", "─", "┬", "├", "└"]
abbr_sid = true
theme = "Auto"
show_kthreads = true

[sort]
column = 0
order = "Ascending"

[docker]
path = "unix:///var/run/docker.sock"

[pager]
mode = "Disable"
detect_width = false
use_builtin = false
]==]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
