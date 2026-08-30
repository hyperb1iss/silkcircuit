-- Zellij's styled theme spec, one component at a time.
--
-- The two theme formats cannot be mixed: zellij reads the older eleven-colour
-- palette form only when every node in the block is one of its names, so a
-- single styled node makes it ignore the palette entirely. The styled form is
-- what current zellij documents and it is the only one that can say what a
-- ribbon or a pane frame should look like, so that is what these files use.
-- It needs zellij 0.41 or newer.

local M = {}

-- base, background, then the four emphasis slots a component highlights words
-- with. Every component has to spell out all six; zellij errors on a partial
-- declaration.
local COMPONENTS = {
  { "text_unselected", "${fg}", "${bg}", "${purple}", "${cyan}", "${pink}", "${yellow}" },
  { "text_selected", "${fg}", "${bg_visual}", "${purple}", "${cyan}", "${pink}", "${yellow}" },
  {
    "ribbon_unselected",
    "${fg_dark}",
    "${bg_highlight}",
    "${purple}",
    "${cyan}",
    "${pink}",
    "${yellow}",
  },
  { "ribbon_selected", "${bg}", "${purple}", "${fg_light}", "${cyan}", "${green}", "${yellow}" },
  { "table_title", "${cyan}", "${bg}", "${purple}", "${cyan}", "${pink}", "${yellow}" },
  {
    "table_cell_unselected",
    "${fg}",
    "${bg}",
    "${purple}",
    "${cyan}",
    "${pink}",
    "${yellow}",
  },
  {
    "table_cell_selected",
    "${fg}",
    "${bg_visual}",
    "${purple}",
    "${cyan}",
    "${pink}",
    "${yellow}",
  },
  { "list_unselected", "${fg}", "${bg}", "${purple}", "${cyan}", "${pink}", "${yellow}" },
  { "list_selected", "${fg}", "${bg_visual}", "${purple}", "${cyan}", "${pink}", "${yellow}" },
  { "frame_unselected", "${bg_visual}", "${bg}", "${purple}", "${cyan}", "${pink}", "${yellow}" },
  { "frame_selected", "${border}", "${bg}", "${purple}", "${cyan}", "${pink}", "${yellow}" },
  { "frame_highlight", "${pink}", "${bg}", "${purple}", "${cyan}", "${green}", "${yellow}" },
  { "exit_code_success", "${green}", "${bg}", "${purple}", "${cyan}", "${pink}", "${yellow}" },
  { "exit_code_error", "${red}", "${bg}", "${purple}", "${cyan}", "${pink}", "${yellow}" },
}

local FIELDS = { "base", "background", "emphasis_0", "emphasis_1", "emphasis_2", "emphasis_3" }

-- Ten collaborators, ten colours the palette already owns. Some variants
-- resolve two of these to the same hex, which zellij is fine with.
local PLAYERS = {
  "${purple}",
  "${cyan}",
  "${pink}",
  "${green}",
  "${yellow}",
  "${blue}",
  "${coral}",
  "${red}",
  "${fg_dark}",
  "${comment}",
}

--- One `silkcircuit-<variant> { ... }` block, indented to sit at `indent`.
function M.theme(colors, indent)
  local extra = require("silkcircuit.extra")
  local step = "    "
  local lines = { indent .. "${meta.slug} {" }

  for _, component in ipairs(COMPONENTS) do
    lines[#lines + 1] = indent .. step .. component[1] .. " {"
    for index, field in ipairs(FIELDS) do
      lines[#lines + 1] = indent .. step .. step .. field .. ' "' .. component[index + 1] .. '"'
    end
    lines[#lines + 1] = indent .. step .. "}"
  end

  lines[#lines + 1] = indent .. step .. "multiplayer_user_colors {"
  for index, color in ipairs(PLAYERS) do
    lines[#lines + 1] = indent .. step .. step .. "player_" .. index .. ' "' .. color .. '"'
  end
  lines[#lines + 1] = indent .. step .. "}"

  lines[#lines + 1] = indent .. "}"
  return extra.template(table.concat(lines, "\n"), colors)
end

function M.generate(colors)
  return "themes {\n" .. M.theme(colors, "    ") .. "\n}"
end

return M
