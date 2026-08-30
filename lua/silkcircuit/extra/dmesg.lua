-- terminal-colors.d schemes are plain SGR parameter lists, not hex, so every
-- color goes out as `38;2;r;g;b`. util-linux reads the file named after the
-- utility, so this installs as dmesg.scheme whichever variant you pick.

local M = {}

local TEMPLATE = [[
# Install: cp this file to ~/.config/terminal-colors.d/dmesg.scheme

subsys    38;2;${rgb.cyan.r};${rgb.cyan.g};${rgb.cyan.b}
time      38;2;${rgb.purple_muted.r};${rgb.purple_muted.g};${rgb.purple_muted.b}
timebreak 38;2;${rgb.purple_muted.r};${rgb.purple_muted.g};${rgb.purple_muted.b}
alert     1;38;2;${rgb.coral.r};${rgb.coral.g};${rgb.coral.b}
crit      1;38;2;${rgb.red.r};${rgb.red.g};${rgb.red.b}
err       38;2;${rgb.red.r};${rgb.red.g};${rgb.red.b}
warn      38;2;${rgb.purple_muted.r};${rgb.purple_muted.g};${rgb.purple_muted.b}
segfault  1;4;38;2;${rgb.red.r};${rgb.red.g};${rgb.red.b}
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
