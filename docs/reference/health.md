# Health Check

Diagnostics and troubleshooting for SilkCircuit.

## Running Health Check

```vim
:checkhealth silkcircuit
```

This command verifies your SilkCircuit installation and configuration.

## Check Categories

### Version Compatibility

Verifies Neovim version meets requirements:

- **Required:** Neovim 0.10.0+

```
✓ Neovim version: 0.10.0 (OK)
```

### True Color Support

Checks if your terminal supports 24-bit colors:

```
✓ True colors enabled ($COLORTERM=truecolor)
✓ termguicolors is set
```

If true colors aren't working:

1. Add `vim.opt.termguicolors = true` to your config
2. Verify terminal supports true colors
3. Check `$COLORTERM` environment variable

### Theme Status

Confirms SilkCircuit is properly loaded:

```
✓ SilkCircuit theme loaded
✓ Current variant: neon
```

### Plugin Integrations

Lists detected plugin integrations:

```
✓ telescope.nvim: themed
✓ neo-tree.nvim: themed
✓ nvim-cmp: themed
✓ gitsigns.nvim: themed
```

### WCAG Compliance

Validates contrast ratios meet accessibility standards:

```
✓ All highlight groups meet WCAG AA contrast (4.5:1)
```

### User Preferences

Shows whether a saved variant or glow setting is overriding the configured defaults:

```
✓ No saved preferences, using the configured values
```

## Common Issues

### Theme Not Loading

**Symptoms:**

- Colors look wrong
- Default Neovim colors showing

**Solutions:**

1. Verify installation:

```vim
:Lazy
" Check SilkCircuit is installed
```

2. Load colorscheme:

```lua
vim.cmd.colorscheme("silkcircuit")
```

3. Check for errors:

```vim
:messages
```

### Wrong Colors

**Symptoms:**

- Colors appear washed out
- Colors don't match screenshots

**Solutions:**

1. Enable true colors:

```lua
vim.opt.termguicolors = true
```

2. Check terminal settings:

```bash
echo $COLORTERM
# Should show "truecolor"
```

3. Try a different terminal emulator

### Slow Loading

**Symptoms:**

- Visible delay on startup that goes away when the colorscheme is disabled

**Solutions:**

1. Measure it. Set `vim.g.silkcircuit_debug = true` and restart; the theme prints its own load time, which is about 5ms on a laptop.
2. If the number is far higher, another plugin is probably reloading the colorscheme repeatedly. Check `:autocmd ColorScheme`.
3. Open an issue with the measured time and your plugin list.

### Plugin Not Themed

**Symptoms:**

- Specific plugin uses wrong colors
- Plugin highlights don't match

**Solutions:**

1. Check if plugin is supported:

```vim
:SilkCircuitIntegrations
```

2. Verify plugin is loaded before theme:

```lua
-- In lazy.nvim, set priority
{
  "hyperb1iss/silkcircuit",
  priority = 1000,
  lazy = false,
}
```

3. Report missing integrations on GitHub

### Contrast Issues

**Symptoms:**

- Text hard to read
- Health check shows contrast warnings

**Solutions:**

1. Try a different variant:

```vim
:SilkCircuit glow  " Maximum contrast
:SilkCircuit soft  " Gentler contrast
```

2. Override specific highlights:

```lua
require("silkcircuit").setup({
  on_highlights = function(hl, colors)
    hl.Comment = { fg = "#888888" }  -- Lighter comments
  end,
})
```

## Debug Mode

Enable debug logging:

```lua
vim.g.silkcircuit_debug = true
```

View debug output:

```vim
:messages
```

## Getting Help

1. Run `:checkhealth silkcircuit`
2. Check the [GitHub Issues](https://github.com/hyperb1iss/silkcircuit/issues)
3. Include health check output in bug reports

## Health Check Output Example

```
silkcircuit: require("silkcircuit.health").check()

SilkCircuit
- OK Neovim 0.12.5
- OK termguicolors is enabled
- OK SilkCircuit is the active colorscheme

Configuration
- OK Variant: neon
- OK Transparent: false
- OK Terminal colors: true
- OK Dim inactive: false

Plugin integrations
- OK 29 integrations available, 5 plugins detected
- OK Detected: cmp, gitsigns, lualine, telescope, treesitter

User preferences
- OK No saved preferences, using the configured values

WCAG contrast
- OK Checked 19 distinct text colors against the 'neon' background (#12101a)
- OK All 19 meet WCAG AA (4.5:1)

Commands
- OK :SilkCircuit [neon|vibrant|soft|glow|dawn] - switch variant
- OK :SilkCircuitGlow [on|off|toggle] - control glow mode
- OK :SilkCircuitContrast - check WCAG contrast
- OK :SilkCircuitIntegrations - show integration status
- OK :help |silkcircuit| - documentation
```
