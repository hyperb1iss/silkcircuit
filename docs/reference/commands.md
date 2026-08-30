# Commands

All available SilkCircuit commands.

## Theme Commands

### :SilkCircuit

Switch theme variant.

```vim
:SilkCircuit {variant}
```

**Arguments:**

| Variant   | Description               |
| --------- | ------------------------- |
| `neon`    | 100% intensity (default)  |
| `vibrant` | 85% intensity             |
| `soft`    | 70% intensity             |
| `glow`    | Ultra-dark with pure neon |
| `dawn`    | Light theme               |

**Examples:**

```vim
:SilkCircuit neon
:SilkCircuit dawn
```

Your choice is automatically saved for future sessions.

---

### :SilkCircuitGlow

Toggle glow mode for enhanced visual effects.

```vim
:SilkCircuitGlow
```

Glow mode adds subtle text shadows and enhanced highlighting to syntax elements.

---

### :SilkCircuitContrast

Validate WCAG contrast compliance.

```vim
:SilkCircuitContrast
```

Checks all highlight groups against WCAG AA standards (4.5:1 ratio) and reports any issues.

---

### :SilkCircuitIntegrations

Show detected plugin integrations.

```vim
:SilkCircuitIntegrations
```

Lists all plugins that SilkCircuit has detected and themed.

---

## Health Check

### :checkhealth silkcircuit

Run comprehensive diagnostics.

```vim
:checkhealth silkcircuit
```

Verifies:

- Neovim version compatibility
- True color support
- Theme loading status
- Plugin integrations
- WCAG contrast compliance
- Cache status

---

## Lua API

### Get Current Variant

```lua
local variant = require("silkcircuit.variants").get_current_variant()
print(variant)  -- "neon"
```

### Get Colors

```lua
local colors = require("silkcircuit.variants").get_colors("neon")
print(colors.purple)  -- "#e135ff"
```

### Switch Variant Programmatically

```lua
require("silkcircuit").setup({ variant = "dawn" })
vim.cmd.colorscheme("silkcircuit")
```

### Check If Theme Is Loaded

```lua
if vim.g.colors_name == "silkcircuit" then
  -- Theme is active
end
```

---

## Keymaps

SilkCircuit doesn't set any keymaps by default. Add your own:

```lua
-- Quick variant switching
vim.keymap.set("n", "<leader>tn", ":SilkCircuit neon<CR>", { desc = "Neon variant" })
vim.keymap.set("n", "<leader>td", ":SilkCircuit dawn<CR>", { desc = "Dawn variant" })
vim.keymap.set("n", "<leader>tg", ":SilkCircuitGlow<CR>", { desc = "Toggle glow" })

-- Cycle variants
local variants = { "neon", "vibrant", "soft", "glow", "dawn" }
local current = 1

vim.keymap.set("n", "<leader>tc", function()
  current = current % #variants + 1
  vim.cmd("SilkCircuit " .. variants[current])
end, { desc = "Cycle variants" })
```

---

## Autocmds

Create automations with SilkCircuit events:

```lua
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "silkcircuit",
  callback = function()
    -- Theme just loaded
    print("SilkCircuit activated!")
  end,
})
```
