-- Slack imports a theme as one comma-separated line of ten hex colors in a
-- fixed order the paste box never names. The commented table above the line
-- is the only documentation a reader gets, so it ships with every variant.

local M = {}

local SLOTS = {
  { "Column BG", "${bg_dark}" },
  { "Menu BG Hover", "${bg_highlight}" },
  { "Active Item", "${purple}" },
  { "Active Item Text", "${bg}" },
  { "Hover Item", "${bg_visual}" },
  { "Text Color", "${fg}" },
  { "Active Presence", "${green}" },
  { "Mention Badge", "${pink}" },
  { "Top Nav BG", "${bg}" },
  { "Top Nav Text", "${fg}" },
}

local WIDTH = 0
for _, slot in ipairs(SLOTS) do
  WIDTH = math.max(WIDTH, #slot[1])
end

function M.generate(colors)
  local extra = require("silkcircuit.extra")

  local lines = {
    "Slack → Preferences → Themes → Create a custom theme, then paste the",
    "last line of this file into the color box. Setting the ten slots by",
    "hand works too:",
    "",
  }

  local values = {}
  for index, slot in ipairs(SLOTS) do
    values[index] = extra.template(slot[2], colors)
    lines[#lines + 1] = string.format("  %-" .. WIDTH .. "s  %s", slot[1], values[index])
  end

  for index, line in ipairs(lines) do
    lines[index] = line == "" and "#" or ("# " .. line)
  end

  lines[#lines + 1] = ""
  lines[#lines + 1] = table.concat(values, ",")

  return table.concat(lines, "\n")
end

return M
