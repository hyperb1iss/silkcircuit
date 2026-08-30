# Neon Variant

The original SilkCircuit experience. Maximum vibrancy and electric energy.

## Overview

**Neon** delivers 100% color intensity with the signature SilkCircuit palette. Perfect for dark rooms where you want maximum visual impact.

| Property   | Value     |
| ---------- | --------- |
| Background | `#12101a` |
| Foreground | `#f8f8f2` |
| Intensity  | 100%      |
| Type       | Dark      |

## Color Palette

### Primary Colors

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#e135ff` | Keywords, control flow |
| Cyan      | `#80ffea` | Functions, methods     |
| Pink      | `#ff00ff` | Tags, booleans         |
| Pink Soft | `#ff99ff` | Strings                |
| Coral     | `#ff6ac1` | Numbers, constants     |
| Yellow    | `#f1fa8c` | Classes, types         |

### Supporting Colors

| Color | Hex       | Usage                  |
| ----- | --------- | ---------------------- |
| Green | `#50fa7b` | Success, git additions |
| Red   | `#ff6363` | Errors, git deletions  |
| Blue  | `#82aaff` | Links, info            |
| Gray  | `#768d8d` | Comments, muted text   |

## Terminal Colors

```yaml
# ANSI Colors
black: "#12101a"
red: "#ff6363"
green: "#50fa7b"
yellow: "#f1fa8c"
blue: "#82aaff"
magenta: "#ff00ff"
cyan: "#80ffea"
white: "#f8f8f2"

# Bright variants
bright_black: "#768d8d"
bright_red: "#ff8787"
bright_green: "#86fba8"
bright_yellow: "#ffffa5"
bright_blue: "#82b1ff"
bright_magenta: "#ff69ff"
bright_cyan: "#5fffff"
bright_white: "#ffffff"
```

## When to Use

- Working in **dark environments**
- Want **maximum visual energy**
- Prefer **high-contrast** highlighting
- Streaming or **presenting code**

## Configuration

```lua
require("silkcircuit").setup({
  variant = "neon",
})
vim.cmd.colorscheme("silkcircuit")
```

Or switch at runtime:

```vim
:SilkCircuit neon
```

## Comparison

Neon is the most vibrant of the dark variants:

| vs Vibrant | Neon has more saturated colors         |
| ---------- | -------------------------------------- |
| vs Soft    | Neon has higher intensity              |
| vs Glow    | Similar intensity, lighter backgrounds |
