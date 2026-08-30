# Soft Variant

Gentle colors for marathon coding sessions and late-night work.

## Overview

**Soft** reduces intensity to 70%, still distinctly SilkCircuit but gentle enough for all-day coding without eye strain. Perfect for extended sessions.

| Property   | Value     |
| ---------- | --------- |
| Background | `#1a1626` |
| Foreground | `#f8f8f2` |
| Intensity  | 70%       |
| Type       | Dark      |

## Color Palette

### Primary Colors

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#e892ff` | Keywords, control flow |
| Cyan      | `#99ffee` | Functions, methods     |
| Pink      | `#ff99ff` | Tags, booleans         |
| Pink Soft | `#ffc2ff` | Strings                |
| Coral     | `#ff99dd` | Numbers, constants     |
| Yellow    | `#ffe699` | Classes, types         |

### Supporting Colors

| Color | Hex       | Usage                  |
| ----- | --------- | ---------------------- |
| Green | `#66ff99` | Success, git additions |
| Red   | `#ff6677` | Errors, git deletions  |
| Blue  | `#92aaff` | Links, info            |
| Gray  | `#7e9494` | Comments, muted text   |

## Terminal Colors

```yaml
# ANSI Colors
black: "#141220"
red: "#ff6677"
green: "#66ff99"
yellow: "#ffe699"
blue: "#92aaff"
magenta: "#ff99ff"
cyan: "#99ffee"
white: "#f8f8f2"

# Bright variants
bright_black: "#6272a4"
bright_red: "#ff7788"
bright_green: "#80ffb3"
bright_yellow: "#ffffa5"
bright_blue: "#a2bbff"
bright_magenta: "#ffb3ff"
bright_cyan: "#b3ffea"
bright_white: "#ffffff"
```

## When to Use

- **Long coding sessions** where comfort matters
- Working **late at night** with reduced light
- Prefer **gentler visuals** without losing the theme aesthetic
- Sensitive to **highly saturated colors**

## Configuration

```lua
require("silkcircuit").setup({
  variant = "soft",
})
vim.cmd.colorscheme("silkcircuit")
```

Or switch at runtime:

```vim
:SilkCircuit soft
```

## Comparison

Soft prioritizes comfort over intensity:

| vs Neon    | Lower saturation, warmer background     |
| ---------- | --------------------------------------- |
| vs Vibrant | Even gentler on the eyes                |
| vs Glow    | Much lighter backgrounds, softer colors |
| vs Dawn    | Dark theme alternative for extended use |
