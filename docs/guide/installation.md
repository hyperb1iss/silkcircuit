# Installation

SilkCircuit requires **Neovim 0.8.0+** with true color support enabled.

## Prerequisites

Ensure true colors are enabled in your config:

```lua
vim.opt.termguicolors = true
```

## Package Managers

### lazy.nvim (Recommended)

```lua
{
  "hyperb1iss/silkcircuit",
  lazy = false,
  priority = 1000,
  config = function()
    require("silkcircuit").setup({
      -- your options here
    })
    vim.cmd.colorscheme("silkcircuit")
  end,
}
```

### packer.nvim

```lua
use {
  "hyperb1iss/silkcircuit",
  config = function()
    require("silkcircuit").setup({})
    vim.cmd("colorscheme silkcircuit")
  end
}
```

### vim-plug

```vim
Plug 'hyperb1iss/silkcircuit'

" In your config:
lua require("silkcircuit").setup({})
colorscheme silkcircuit
```

## AstroNvim Integration

SilkCircuit works with AstroNvim out of the box:

```lua
-- In your lua/community.lua file:
return {
  "AstroNvim/astrocommunity",
  { "hyperb1iss/silkcircuit", name = "silkcircuit" },
}

-- In your lua/plugins/astroui.lua file:
return {
  "AstroNvim/astroui",
  opts = {
    colorscheme = "silkcircuit",
  },
}
```

## Verifying Installation

After installation, run the health check:

```vim
:checkhealth silkcircuit
```

This will verify:

- Neovim version compatibility
- True color support
- Theme loading status
- Plugin integrations
- WCAG contrast compliance

## Troubleshooting

### Theme not loading?

1. Ensure Neovim 0.8.0+ is installed
2. Add `vim.opt.termguicolors = true` to your config
3. Verify plugin installation with `:Lazy` or `:PackerStatus`

### Colors look wrong?

1. Your terminal must support true colors (24-bit)
2. Check your terminal's color settings
3. Try a different terminal emulator

### Performance issues?

1. Run `:checkhealth silkcircuit`
2. Check cache directory permissions
3. Try `:SilkCircuitCompile` to regenerate cache

## Next Steps

- [Configuration](/guide/configuration): Customize the theme
- [Theme Variants](/guide/variants): Switch between variants
