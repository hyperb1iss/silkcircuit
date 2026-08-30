# Vibrant Variant

Balanced energy with slightly toned-down saturation for everyday coding.

## Overview

**Vibrant** offers 85% intensity: still electric, but easier on the eyes for longer sessions. The perfect middle ground between Neon's intensity and Soft's gentleness.

| Property   | Value     |
| ---------- | --------- |
| Background | `#0f0c1a` |
| Foreground | `#f8f8f2` |
| Intensity  | 85%       |
| Type       | Dark      |

## Color Palette

### Primary Colors

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#ff00ff` | Keywords, control flow |
| Cyan      | `#00ffcc` | Functions, methods     |
| Pink      | `#ff00cc` | Tags, booleans         |
| Pink Soft | `#ff99ff` | Strings                |
| Coral     | `#ff5fa8` | Numbers, constants     |
| Yellow    | `#ffcc00` | Classes, types         |

### Supporting Colors

| Color   | Hex       | Usage                         |
| ------- | --------- | ----------------------------- |
| Green   | `#00ff66` | Success, git additions        |
| Red     | `#ff3366` | Errors, git deletions         |
| Blue    | `#6699ff` | Links, info                   |
| Gray    | `#728989` | Line numbers, non-text glyphs |
| Comment | `#b366ff` | Comments                      |

## Terminal Colors

```yaml
# ANSI Colors
black: "#0f0c1a"
red: "#ff3366"
green: "#00ff66"
yellow: "#ffcc00"
blue: "#6699ff"
magenta: "#ff00cc"
cyan: "#00ffcc"
white: "#f8f8f2"

# Bright variants
bright_black: "#728989"
bright_red: "#ff6677"
bright_green: "#66ff99"
bright_yellow: "#ffff66"
bright_blue: "#88aaff"
bright_magenta: "#ff66ff"
bright_cyan: "#00ffff"
bright_white: "#ffffff"
```

## When to Use

- **Everyday coding** with balanced energy
- Want electric colors without overwhelming intensity
- Working for **medium-length sessions**
- Prefer a **slightly deeper** background

## Configuration

```lua
require("silkcircuit").setup({
  variant = "vibrant",
})
vim.cmd.colorscheme("silkcircuit")
```

Or switch at runtime:

```vim
:SilkCircuit vibrant
```

## Comparison

Vibrant sits between Neon and Soft:

| vs Neon | Slightly less saturated, deeper background |
| ------- | ------------------------------------------ |
| vs Soft | More energy and contrast                   |
| vs Glow | Lighter backgrounds, less intense glow     |
