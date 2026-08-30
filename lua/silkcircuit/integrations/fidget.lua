local M = {}

-- Fidget v2 styles its notifications by pointing config options at built-in
-- groups rather than defining its own, so the LSP progress colours come from
-- integrations/native_lsp.lua. Three groups still carry the Fidget name:
-- FidgetNoBlend, which the window uses to punch a hole through winblend, and
-- the two the v1 line still ships.
function M.get(colors, opts)
  return {
    FidgetTitle = { fg = colors.pink, bold = true },
    FidgetTask = { fg = colors.purple_muted },
    FidgetNoBlend = {
      fg = colors.fg,
      bg = opts.transparent and colors.none or colors.bg_float,
      blend = 0,
    },
  }
end

return M
