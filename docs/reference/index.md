# Reference

Complete reference documentation for SilkCircuit.

## Quick Links

| Section                                   | Description                      |
| ----------------------------------------- | -------------------------------- |
| [Commands](/reference/commands)           | All available Vim commands       |
| [Colors](/reference/colors)               | Complete color palette reference |
| [Highlight Groups](/reference/highlights) | Neovim highlight group mappings  |
| [Health Check](/reference/health)         | Diagnostics and troubleshooting  |

## API Reference

### Setup Function

```lua
require("silkcircuit").setup({
  -- Options
})
```

### Configuration Options

| Option            | Type     | Default  | Description                |
| ----------------- | -------- | -------- | -------------------------- |
| `variant`         | string   | `"neon"` | Theme variant              |
| `transparent`     | boolean  | `false`  | Transparent background     |
| `terminal_colors` | boolean  | `true`   | Configure terminal colors  |
| `dim_inactive`    | boolean  | `false`  | Dim inactive windows       |
| `styles`          | table    | `{}`     | Syntax styling options     |
| `integrations`    | table    | `{}`     | Plugin integrations        |
| `on_highlights`   | function | `nil`    | Custom highlights callback |

### Styles Options

```lua
styles = {
  comments = { italic = true },
  keywords = { bold = true },
  functions = { bold = true, italic = true },
  variables = {},
  strings = { italic = true },
}
```

Available style attributes:

- `italic`: Render in italic
- `bold`: Render in bold
- `underline`: Add underline
- `strikethrough`: Add strikethrough

### Custom Highlights

```lua
on_highlights = function(highlights, colors)
  -- Access theme colors
  highlights.Function = { fg = colors.cyan, bold = true }

  -- Custom colors
  highlights.MyGroup = { fg = "#ff00ff", bg = "#000000" }
end
```

### Available Colors

The `colors` table in `on_highlights` includes:

| Color       | Description            |
| ----------- | ---------------------- |
| `purple`    | Keywords, control flow |
| `cyan`      | Functions, methods     |
| `pink`      | Tags, booleans         |
| `pink_soft` | Strings                |
| `coral`     | Numbers, constants     |
| `yellow`    | Classes, types         |
| `green`     | Success, additions     |
| `red`       | Errors, deletions      |
| `gray`      | Comments, muted        |
| `bg`        | Background             |
| `fg`        | Foreground             |

## Module Reference

### Core Modules

| Module                 | Purpose                  |
| ---------------------- | ------------------------ |
| `silkcircuit`          | Main entry point         |
| `silkcircuit.config`   | Configuration management |
| `silkcircuit.theme`    | Highlight definitions    |
| `silkcircuit.variants` | Variant system           |
| `silkcircuit.palette`  | Color definitions        |

### Utility Modules

| Module                    | Purpose             |
| ------------------------- | ------------------- |
| `silkcircuit.util`        | Helper functions    |
| `silkcircuit.commands`    | Vim commands        |
| `silkcircuit.health`      | Health checks       |
| `silkcircuit.preferences` | Persistent settings |

### Integration Modules

| Module                       | Purpose            |
| ---------------------------- | ------------------ |
| `silkcircuit.integrations`   | Plugin detection   |
| `silkcircuit.integrations.*` | Individual plugins |

## Files Reference

### Core Files

```
lua/silkcircuit/
├── init.lua           # Entry point
├── config.lua         # Configuration
├── theme.lua          # Highlight definitions
├── variants.lua       # Variant system
├── palette.lua        # Color palette
├── util.lua           # Utilities
├── commands.lua       # Vim commands
├── health.lua         # Health checks
├── preferences.lua    # Persistence
└── integrations/      # Plugin integrations
```

### User Files

| File                                               | Purpose           |
| -------------------------------------------------- | ----------------- |
| `~/.local/share/nvim/silkcircuit_preferences.json` | Saved preferences |
| `~/.cache/nvim/silkcircuit/`                       | Compiled cache    |
