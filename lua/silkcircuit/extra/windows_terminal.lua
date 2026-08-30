-- Windows Terminal reads schemes as strict JSON, so these files carry no
-- provenance comment. The scheme name is the only place to say what they are.

local M = {}

local KEYS = {
  { "name", "${meta.name}" },
  { "background", "${bg}" },
  { "foreground", "${fg}" },
  { "cursorColor", "${cyan}" },
  { "selectionBackground", "${bg_visual}" },
  { "black", "${terminal_black}" },
  { "red", "${terminal_red}" },
  { "green", "${terminal_green}" },
  { "yellow", "${terminal_yellow}" },
  { "blue", "${terminal_blue}" },
  { "purple", "${terminal_magenta}" },
  { "cyan", "${terminal_cyan}" },
  { "white", "${terminal_white}" },
  { "brightBlack", "${terminal_bright_black}" },
  { "brightRed", "${terminal_bright_red}" },
  { "brightGreen", "${terminal_bright_green}" },
  { "brightYellow", "${terminal_bright_yellow}" },
  { "brightBlue", "${terminal_bright_blue}" },
  { "brightPurple", "${terminal_bright_magenta}" },
  { "brightCyan", "${terminal_bright_cyan}" },
  { "brightWhite", "${terminal_bright_white}" },
}

--- One scheme object, indented so it can nest inside the combined file.
function M.scheme(colors, indent)
  local extra = require("silkcircuit.extra")
  local lines = { indent .. "{" }
  for index, entry in ipairs(KEYS) do
    lines[#lines + 1] = string.format(
      '%s  "%s": "%s"%s',
      indent,
      entry[1],
      extra.template(entry[2], colors),
      index < #KEYS and "," or ""
    )
  end
  lines[#lines + 1] = indent .. "}"
  return table.concat(lines, "\n")
end

function M.generate(colors)
  return M.scheme(colors, "")
end

return M
