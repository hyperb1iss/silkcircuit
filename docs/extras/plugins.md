# Neovim Plugin Integrations

SilkCircuit ships 39 Neovim plugin integrations.

## No Detection Required

Every enabled integration's highlight groups are defined whether or not the plugin is installed. Defining a group for a plugin you do not have costs nothing, and it means the theme never has to load a plugin to decide what to style. Detection still runs, but only so `:SilkCircuitIntegrations` and `:checkhealth silkcircuit` can report what you have.

The config key is in the last column of each table below. Set one to `false` to skip that integration's groups entirely.

## Supported Plugins

### File Explorers

| Plugin        | Config key |
| ------------- | ---------- |
| neo-tree.nvim | `neotree`  |
| nvim-tree.lua | `nvimtree` |
| oil.nvim      | `oil`      |

### Pickers and Fuzzy Finders

| Plugin         | Config key  |
| -------------- | ----------- |
| telescope.nvim | `telescope` |
| fzf-lua        | `fzf_lua`   |
| snacks.nvim    | `snacks`    |

### Git Integration

| Plugin        | Config key |
| ------------- | ---------- |
| gitsigns.nvim | `gitsigns` |
| neogit        | `neogit`   |
| octo.nvim     | `octo`     |
| grug-far.nvim | `grug_far` |

### LSP and Completion

| Plugin           | Config key           |
| ---------------- | -------------------- |
| Neovim's own LSP | `lsp` (`native_lsp`) |
| nvim-cmp         | `cmp`                |
| blink.cmp        | `blink_cmp`          |
| mason.nvim       | `mason`              |
| fidget.nvim      | `fidget`             |
| trouble.nvim     | `trouble`            |

### UI Components

| Plugin                | Config key         |
| --------------------- | ------------------ |
| lualine.nvim          | `lualine`          |
| bufferline.nvim       | `bufferline`       |
| dropbar.nvim          | `dropbar`          |
| lazy.nvim             | `lazy`             |
| nvim-notify           | `notify`           |
| noice.nvim            | `noice`            |
| indent-blankline.nvim | `indent_blankline` |
| which-key.nvim        | `which_key`        |
| alpha-nvim            | `alpha`            |

### Editing

| Plugin                  | Config key           |
| ----------------------- | -------------------- |
| nvim-treesitter         | `treesitter`         |
| nvim-treesitter-context | `treesitter_context` |
| flash.nvim              | `flash`              |
| mini.nvim               | `mini`               |
| harpoon                 | `harpoon`            |
| rainbow-delimiters.nvim | `rainbow_delimiters` |

### Testing and Debugging

| Plugin      | Config key         |
| ----------- | ------------------ |
| nvim-dap    | `dap` (`nvim_dap`) |
| nvim-dap-ui | `dap` (`nvim_dap`) |
| neotest     | `neotest`          |

### Other

| Plugin               | Config key        |
| -------------------- | ----------------- |
| aerial.nvim          | `aerial`          |
| avante.nvim          | `avante`          |
| nvim-ufo             | `ufo`             |
| nvim-window-picker   | `window_picker`   |
| render-markdown.nvim | `render-markdown` |
| Markdown syntax      | `markdown`        |

## Check Integrations

See which integrations are themed, which of their plugins are installed, and which are switched off:

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

1. Check the integration name with `:SilkCircuitIntegrations`
2. Confirm its config key is not set to `false`
3. Reload with `:colorscheme silkcircuit`

If the plugin has no integration at all, `on_highlights` below is the escape hatch.

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
