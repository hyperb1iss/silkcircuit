local M = {}

-- lsd deserialises every colour through crossterm, which accepts a name, a
-- 256-palette index, or a three-element RGB array. The array is the only form
-- that carries the palette exactly, so the theme uses it everywhere.
--
-- The struct is `deny_unknown_fields`, and `file-type` is `serde(skip)`. Only
-- the keys below parse; file and extension colours come from LS_COLORS.
local TEMPLATE = [[
---
user: [${rgb.cyan.r}, ${rgb.cyan.g}, ${rgb.cyan.b}]
group: [${rgb.purple_muted.r}, ${rgb.purple_muted.g}, ${rgb.purple_muted.b}]

permission:
  read: [${rgb.purple.r}, ${rgb.purple.g}, ${rgb.purple.b}]
  write: [${rgb.pink.r}, ${rgb.pink.g}, ${rgb.pink.b}]
  exec: [${rgb.cyan.r}, ${rgb.cyan.g}, ${rgb.cyan.b}]
  exec-sticky: [${rgb.cyan_bright.r}, ${rgb.cyan_bright.g}, ${rgb.cyan_bright.b}]
  no-access: [${rgb.red.r}, ${rgb.red.g}, ${rgb.red.b}]
  octal: [${rgb.purple_muted.r}, ${rgb.purple_muted.g}, ${rgb.purple_muted.b}]
  acl: [${rgb.green.r}, ${rgb.green.g}, ${rgb.green.b}]
  context: [${rgb.blue.r}, ${rgb.blue.g}, ${rgb.blue.b}]

attributes:
  archive: [${rgb.yellow.r}, ${rgb.yellow.g}, ${rgb.yellow.b}]
  read: [${rgb.cyan.r}, ${rgb.cyan.g}, ${rgb.cyan.b}]
  hidden: [${rgb.purple_muted.r}, ${rgb.purple_muted.g}, ${rgb.purple_muted.b}]
  system: [${rgb.red.r}, ${rgb.red.g}, ${rgb.red.b}]

date:
  hour-old: [${rgb.green.r}, ${rgb.green.g}, ${rgb.green.b}]
  day-old: [${rgb.yellow.r}, ${rgb.yellow.g}, ${rgb.yellow.b}]
  older: [${rgb.purple_muted.r}, ${rgb.purple_muted.g}, ${rgb.purple_muted.b}]

size:
  none: [${rgb.gray.r}, ${rgb.gray.g}, ${rgb.gray.b}]
  small: [${rgb.green.r}, ${rgb.green.g}, ${rgb.green.b}]
  medium: [${rgb.yellow.r}, ${rgb.yellow.g}, ${rgb.yellow.b}]
  large: [${rgb.coral.r}, ${rgb.coral.g}, ${rgb.coral.b}]

inode:
  valid: [${rgb.fg_dark.r}, ${rgb.fg_dark.g}, ${rgb.fg_dark.b}]
  invalid: [${rgb.red.r}, ${rgb.red.g}, ${rgb.red.b}]

links:
  valid: [${rgb.cyan.r}, ${rgb.cyan.g}, ${rgb.cyan.b}]
  invalid: [${rgb.red.r}, ${rgb.red.g}, ${rgb.red.b}]

tree-edge: [${rgb.purple.r}, ${rgb.purple.g}, ${rgb.purple.b}]

git-status:
  default: [${rgb.gray.r}, ${rgb.gray.g}, ${rgb.gray.b}]
  unmodified: [${rgb.gray.r}, ${rgb.gray.g}, ${rgb.gray.b}]
  ignored: [${rgb.gray_muted.r}, ${rgb.gray_muted.g}, ${rgb.gray_muted.b}]
  new-in-index: [${rgb.git_add.r}, ${rgb.git_add.g}, ${rgb.git_add.b}]
  new-in-workdir: [${rgb.green.r}, ${rgb.green.g}, ${rgb.green.b}]
  typechange: [${rgb.yellow.r}, ${rgb.yellow.g}, ${rgb.yellow.b}]
  deleted: [${rgb.git_delete.r}, ${rgb.git_delete.g}, ${rgb.git_delete.b}]
  renamed: [${rgb.git_change.r}, ${rgb.git_change.g}, ${rgb.git_change.b}]
  modified: [${rgb.yellow.r}, ${rgb.yellow.g}, ${rgb.yellow.b}]
  conflicted: [${rgb.red.r}, ${rgb.red.g}, ${rgb.red.b}]
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
