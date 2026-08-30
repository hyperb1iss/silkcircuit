-- Zellij's styled theme spec, one component at a time.
--
-- The two theme formats cannot be mixed: zellij reads the older eleven-colour
-- palette form only when every node in the block is one of its names, so a
-- single styled node makes it ignore the palette entirely. The styled form is
-- what current zellij documents and it is the only one that can say what a
-- ribbon or a pane frame should look like, so that is what these files use.
-- It needs zellij 0.42, where the spec landed.

local M = {}

-- Zellij paints keybinding characters with the emphasis slots, so they are real
-- text and each quartet is chosen against the surface behind it. Anything
-- printed on the filled purple ribbon has to come from the dark end of the
-- palette; a neon accent on neon purple lands near 1.4:1.
local ON_SURFACE = { "${purple}", "${cyan}", "${pink}", "${fg_dark}" }
local ON_RIBBON = { "${purple}", "${pink}", "${fg_light}", "${fg_dark}" }
local ON_ACCENT = { "${bg_dark}", "${bg_darker}", "${bg_highlight}", "${bg}" }
-- bg_visual is a mid tone in every variant, so no accent clears 4.5:1 on it.
local ON_SELECTION = { "${fg_light}", "${fg_dark}", "${fg}", "${fg_dark}" }

-- name, base, background, then the emphasis quartet. Zellij requires base and
-- all four emphasis slots on any component it finds; only background falls back
-- to a default. Spelling out all six keeps the file readable either way.
local COMPONENTS = {
  { "text_unselected", "${fg}", "${bg}", ON_SURFACE },
  { "text_selected", "${fg}", "${bg_visual}", ON_SELECTION },
  { "ribbon_unselected", "${fg_dark}", "${bg_highlight}", ON_RIBBON },
  { "ribbon_selected", "${bg}", "${purple}", ON_ACCENT },
  { "table_title", "${cyan}", "${bg}", ON_SURFACE },
  { "table_cell_unselected", "${fg}", "${bg}", ON_SURFACE },
  { "table_cell_selected", "${fg}", "${bg_visual}", ON_SELECTION },
  { "list_unselected", "${fg}", "${bg}", ON_SURFACE },
  { "list_selected", "${fg}", "${bg_visual}", ON_SELECTION },
  { "frame_unselected", "${comment}", "${bg}", ON_SURFACE },
  { "frame_selected", "${border}", "${bg}", ON_SURFACE },
  { "frame_highlight", "${pink}", "${bg}", ON_SURFACE },
  { "exit_code_success", "${green}", "${bg}", ON_SURFACE },
  { "exit_code_error", "${red}", "${bg}", ON_SURFACE },
}

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
    local name, base, background, emphasis = component[1], component[2], component[3], component[4]
    lines[#lines + 1] = indent .. step .. name .. " {"
    lines[#lines + 1] = indent .. step .. step .. 'base "' .. base .. '"'
    lines[#lines + 1] = indent .. step .. step .. 'background "' .. background .. '"'
    for index, color in ipairs(emphasis) do
      lines[#lines + 1] = indent
        .. step
        .. step
        .. "emphasis_"
        .. (index - 1)
        .. ' "'
        .. color
        .. '"'
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
