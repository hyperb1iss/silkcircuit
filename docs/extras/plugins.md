# Neovim Plugin Integrations

SilkCircuit automatically themes 25+ Neovim plugins.

## Auto-Detection

SilkCircuit detects installed plugins and applies matching styles automatically. No configuration needed for most plugins.

## Supported Plugins

### File Explorers

| Plugin        | Status        |
| ------------- | ------------- |
| neo-tree.nvim | Auto-detected |
| nvim-tree.lua | Auto-detected |

### Fuzzy Finders

| Plugin         | Status        |
| -------------- | ------------- |
| telescope.nvim | Auto-detected |

### Git Integration

| Plugin        | Status        |
| ------------- | ------------- |
| gitsigns.nvim | Auto-detected |
| neogit        | Auto-detected |
| octo.nvim     | Auto-detected |

### LSP & Completion

| Plugin         | Status        |
| -------------- | ------------- |
| nvim-lspconfig | Auto-detected |
| nvim-cmp       | Auto-detected |
| mason.nvim     | Auto-detected |

### UI Components

| Plugin                | Status        |
| --------------------- | ------------- |
| lualine.nvim          | Auto-detected |
| bufferline.nvim       | Auto-detected |
| nvim-notify           | Auto-detected |
| noice.nvim            | Auto-detected |
| indent-blankline.nvim | Auto-detected |
| which-key.nvim        | Auto-detected |
| alpha-nvim            | Auto-detected |

### Editing

| Plugin                  | Status        |
| ----------------------- | ------------- |
| nvim-treesitter         | Auto-detected |
| flash.nvim              | Auto-detected |
| mini.nvim               | Auto-detected |
| harpoon                 | Auto-detected |
| rainbow-delimiters.nvim | Auto-detected |

### Debugging

| Plugin      | Status        |
| ----------- | ------------- |
| nvim-dap    | Auto-detected |
| nvim-dap-ui | Auto-detected |

### Other

| Plugin               | Status        |
| -------------------- | ------------- |
| aerial.nvim          | Auto-detected |
| avante.nvim          | Auto-detected |
| snacks.nvim          | Auto-detected |
| nvim-ufo             | Auto-detected |
| nvim-window-picker   | Auto-detected |
| render-markdown.nvim | Auto-detected |

## Check Integrations

See which integrations are active:

```vim
:SilkCircuitIntegrations
```

## Manual Configuration

Disable specific integrations:

```lua
require("silkcircuit").setup({
  integrations = {
    telescope = false,  -- Disable telescope styling
    neotree = true,     -- Keep neo-tree styling
  },
})
```

## Custom Plugin Styling

Add custom highlight groups:

```lua
require("silkcircuit").setup({
  on_highlights = function(hl, colors)
    -- Custom plugin highlights
    hl.MyPluginNormal = { fg = colors.cyan }
    hl.MyPluginBorder = { fg = colors.purple }
  end,
})
```

## Lualine Theme

SilkCircuit provides a built-in Lualine theme:

```lua
require("lualine").setup({
  options = {
    theme = "silkcircuit",
  },
})
```

## Bufferline Theme

Bufferline automatically uses SilkCircuit colors when the theme is active.

## Telescope Theme

Telescope gains SilkCircuit styling:

- **Border**: Cyan accents
- **Selection**: Purple highlight
- **Prompt**: Pink prefix
- **Matches**: Yellow highlight

## Troubleshooting

### Plugin not styled

1. Check if plugin is supported: `:SilkCircuitIntegrations`
2. Verify plugin is installed and loaded
3. Try `:colorscheme silkcircuit` to reload

### Conflicts with plugin themes

Some plugins have their own themes. Disable them:

```lua
-- Example: disable bufferline's built-in theme
require("bufferline").setup({
  options = {
    themable = true,
  },
})
```

### Missing highlight groups

Report missing highlights on GitHub:
<https://github.com/hyperb1iss/silkcircuit/issues>
