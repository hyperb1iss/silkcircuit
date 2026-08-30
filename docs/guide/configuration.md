# Configuration

SilkCircuit is highly customizable while providing sensible defaults.

## Basic Setup

```lua
require("silkcircuit").setup({
  transparent = false,     -- Enable transparent background
  terminal_colors = true,  -- Configure terminal colors
  dim_inactive = false,    -- Dim inactive windows
  variant = "neon",        -- Theme variant
})
```

## Configuration Options

### `variant`

Choose your theme variant:

```lua
variant = "neon"     -- 100% intensity (default)
variant = "vibrant"  -- 85% intensity
variant = "soft"     -- 70% intensity
variant = "glow"     -- Ultra-dark backgrounds
variant = "dawn"     -- Light theme
```

You can also switch variants at runtime:

```vim
:SilkCircuit dawn
```

### `transparent`

Enable transparent backgrounds for terminal transparency:

```lua
transparent = true
```

::: tip
When using transparency, you may want to adjust your terminal's background blur settings for best results.
:::

### `terminal_colors`

Configure Neovim's built-in terminal colors:

```lua
terminal_colors = true  -- Apply theme to :terminal
```

### `dim_inactive`

Dim unfocused windows:

```lua
dim_inactive = true  -- Reduce brightness of inactive splits
```

## Styling Options

Customize syntax highlighting styles:

```lua
require("silkcircuit").setup({
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true, italic = true },
    variables = {},
    strings = { italic = true },
  },
})
```

Available style options:

- `italic`: Render in italic
- `bold`: Render in bold
- `underline`: Add underline
- `strikethrough`: Add strikethrough

## Plugin Integrations

Enable or disable specific plugin integrations:

```lua
require("silkcircuit").setup({
  integrations = {
    telescope = true,    -- Telescope
    neotree = true,      -- Neo-tree
    notify = true,       -- nvim-notify
    cmp = true,          -- nvim-cmp
    mini = true,         -- mini.nvim
    -- See :h silkcircuit-integrations for full list
  },
})
```

All 39 integrations ship enabled and their highlights load whether or not the plugin is installed, so the only reason to touch this table is to turn one off. The newer keys are `blink_cmp`, `fzf_lua`, `oil`, `trouble`, `lazy`, `grug_far`, `treesitter_context`, `fidget`, `neotest`, and `dropbar`; see `:h silkcircuit-integrations` for the full list.

## Custom Highlights

Override any highlight group:

```lua
require("silkcircuit").setup({
  on_highlights = function(highlights, colors)
    -- Use theme colors
    highlights.Function = { fg = colors.cyan, bold = true }
    highlights.Comment = { fg = colors.comment, italic = true }

    -- Or custom colors
    highlights.MyCustomGroup = { fg = "#ff00ff", bg = "#000000" }
  end,
})
```

### Available Colors

The `colors` table includes:

| Color       | Description            |
| ----------- | ---------------------- |
| `purple`    | Keywords, control flow |
| `cyan`      | Functions, methods     |
| `pink`      | Tags, booleans         |
| `pink_soft` | Strings                |
| `coral`     | Numbers, constants     |
| `yellow`    | Classes, types         |
| `green`     | Success, git add       |
| `red`       | Errors, git delete     |
| `gray`      | Line numbers, glyphs   |
| `comment`   | Comments (purple)      |
| `bg`        | Background             |
| `fg`        | Foreground             |

## Persistent Preferences

SilkCircuit automatically saves your variant preference. When you switch variants with `:SilkCircuit dawn`, it will remember your choice for future sessions.

Preferences are stored in `~/.local/share/nvim/silkcircuit_preferences.json`.

## Example Configurations

### Minimal Setup

```lua
require("silkcircuit").setup({})
vim.cmd.colorscheme("silkcircuit")
```

### Light Theme User

```lua
require("silkcircuit").setup({
  variant = "dawn",
  styles = {
    comments = { italic = true },
  },
})
```

### Maximum Effect

```lua
require("silkcircuit").setup({
  variant = "glow",
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true, italic = true },
    strings = { italic = true },
  },
})
```
