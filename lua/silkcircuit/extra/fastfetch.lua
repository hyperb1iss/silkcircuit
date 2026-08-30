local M = {}

-- fastfetch has taken #RRGGBB in every colour slot since 2.42.0, so the logo
-- ramp and the key, separator and value colours are palette hexes rather than
-- ANSI approximations. The ramp runs cool to hot across nine logo slots, which
-- is as many as fastfetch exposes.
local TEMPLATE = [[
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "display": {
    "separator": " ╎ ",
    "disableLinewrap": true,
    "color": {
      "keys": "${purple}",
      "separator": "${cyan}",
      "output": "${fg_dark}"
    },
    "key": {
      "width": 0,
      "type": "string"
    },
    "percent": {
      "color": {
        "green": "${green}",
        "yellow": "${yellow}",
        "red": "${red}"
      }
    }
  },
  "logo": {
    "type": "auto",
    "padding": { "top": 1, "right": 6 },
    "color": {
      "1": "${cyan_bright}",
      "2": "${cyan}",
      "3": "${blue}",
      "4": "${purple_dark}",
      "5": "${purple}",
      "6": "${pink_bright}",
      "7": "${pink}",
      "8": "${pink_soft}",
      "9": "${coral}"
    }
  },
  "modules": [
    "break",
    "break",
    "break",
    { "type": "os", "key": "  os         " },
    { "type": "host", "key": "  host       " },
    { "type": "kernel", "key": "󰌽  kernel     " },
    { "type": "uptime", "key": "󰥔  uptime     " },
    { "type": "packages", "key": "  packages   " },
    { "type": "shell", "key": "  shell      " },
    { "type": "terminal", "key": "  terminal   " },
    { "type": "wm", "key": "  wm         " },
    { "type": "de", "key": "  de         " },
    { "type": "cpu", "key": "  cpu        " },
    { "type": "gpu", "key": "󰒓  gpu        " },
    { "type": "memory", "key": "⧈  memory     " },
    { "type": "disk", "key": "  disk       " },
    { "type": "display", "key": "󰍺  displays   " },
    { "type": "battery", "key": "󰂄  battery    " }
  ]
}
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
