# AstroNvim Integration

Complete AstroNvim setup with SilkCircuit styling.

## Overview

AstroNvim is an aesthetic and feature-rich Neovim configuration. SilkCircuit provides complete integration with custom configurations for all AstroNvim components.

## Installation

```bash
# Copy the AstroNvim configs to your config directory
cp -r extras/astronvim/community.lua extras/astronvim/plugins ~/.config/nvim/lua/
```

## Included Configurations

### Core Setup

| File                      | Purpose                    |
| ------------------------- | -------------------------- |
| `community.lua`           | AstroCommunity integration |
| `plugins/silkcircuit.lua` | Theme configuration        |
| `plugins/astroui.lua`     | UI customization           |

### Component Styling

| File                             | Purpose                   |
| -------------------------------- | ------------------------- |
| `plugins/neo-tree.lua`           | File explorer styling     |
| `plugins/lualine-max-effect.lua` | Maximum effect statusline |

## Files Structure

```
extras/astronvim/
├── README.md
├── community.lua
└── plugins/
    ├── astroui.lua
    ├── lualine-max-effect.lua
    ├── neo-tree.lua
    └── silkcircuit.lua
```

## Configuration Details

### community.lua

```lua
return {
  "AstroNvim/astrocommunity",
  { "hyperb1iss/silkcircuit", name = "silkcircuit" },
}
```

### astroui.lua

```lua
return {
  "AstroNvim/astroui",
  opts = {
    colorscheme = "silkcircuit",
  },
}
```

### silkcircuit.lua

```lua
return {
  "hyperb1iss/silkcircuit",
  lazy = false,
  priority = 1000,
  opts = {
    variant = "neon",
    transparent = false,
    styles = {
      comments = { italic = true },
      keywords = { bold = true },
      functions = { bold = true, italic = true },
    },
  },
}
```

## Lualine Maximum Effect

The included Lualine config provides an enhanced statusline:

```lua
-- Features:
-- Electric purple mode indicator
-- Neon cyan file info
-- Gradient backgrounds
-- Git integration with SilkCircuit colors
```

### Toggle Effect

```vim
" Switch between default and maximum effect
:lua require("lualine").setup(require("plugins.lualine-max-effect"))
```

## Neo-tree Styling

Custom Neo-tree icons and colors:

- **Directories**: Cyan icons
- **Files**: Type-based coloring
- **Git status**: SilkCircuit git colors
- **Modified**: Yellow indicator
- **Untracked**: Red indicator

## Switching Variants

Change variant in your config:

```lua
-- In plugins/silkcircuit.lua
opts = {
  variant = "dawn",  -- neon, vibrant, soft, glow, dawn
}
```

Or at runtime:

```vim
:SilkCircuit dawn
```

## Customization

Override settings in your AstroNvim config:

```lua
-- In user config
return {
  "hyperb1iss/silkcircuit",
  opts = function(_, opts)
    opts.styles.comments = { italic = true, bold = true }
    return opts
  end,
}
```

## Troubleshooting

### Theme not loading

1. Verify installation: `:Lazy`
2. Check colorscheme: `:colorscheme silkcircuit`
3. Restart Neovim

### Lualine not styled

Ensure SilkCircuit loads before Lualine:

```lua
priority = 1000,  -- Load first
lazy = false,     -- Don't lazy load
```

### Neo-tree icons missing

Install a Nerd Font and configure your terminal to use it.
