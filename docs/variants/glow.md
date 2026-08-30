# Glow Variant

Ultra-dark backgrounds with pure neon colors for maximum contrast.

## Overview

**Glow** pushes the limits with near-black backgrounds and pure neon accent colors. Every syntax element pops with electric intensity against the void.

| Property   | Value      |
| ---------- | ---------- |
| Background | `#0a0816`  |
| Foreground | `#ffffff`  |
| Intensity  | 100%+      |
| Type       | Ultra-Dark |

## Color Palette

### Primary Colors

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#ff00ff` | Keywords, control flow |
| Cyan      | `#00ffff` | Functions, methods     |
| Pink      | `#ff00ff` | Tags, booleans         |
| Pink Soft | `#ff99ff` | Strings                |
| Coral     | `#ff66ff` | Numbers, constants     |
| Yellow    | `#ffff00` | Classes, types         |

### Supporting Colors

| Color | Hex       | Usage                  |
| ----- | --------- | ---------------------- |
| Green | `#00ff00` | Success, git additions |
| Red   | `#ff0066` | Errors, git deletions  |
| Blue  | `#0099ff` | Links, info            |
| Gray  | `#666666` | Comments, muted text   |

## Terminal Colors

```yaml
# ANSI Colors
black: "#000000"
red: "#ff0066"
green: "#00ff00"
yellow: "#ffff00"
blue: "#0099ff"
magenta: "#ff00ff"
cyan: "#00ffff"
white: "#ffffff"

# Bright variants
bright_black: "#666666"
bright_red: "#ff6666"
bright_green: "#66ff66"
bright_yellow: "#ffff66"
bright_blue: "#66ccff"
bright_magenta: "#ff66ff"
bright_cyan: "#66ffff"
bright_white: "#ffffff"
```

## When to Use

- Working in **very dark environments**
- Using **high-contrast monitors**
- Want maximum **visual pop** for each element
- Streaming or **recording content**
- OLED displays where **true blacks** shine

## Configuration

```lua
require("silkcircuit").setup({
  variant = "glow",
})
vim.cmd.colorscheme("silkcircuit")
```

Or switch at runtime:

```vim
:SilkCircuit glow
```

## Comparison

Glow is the most extreme dark variant:

| vs Neon    | Darker backgrounds, pure neon colors |
| ---------- | ------------------------------------ |
| vs Vibrant | Much higher contrast                 |
| vs Soft    | Maximum intensity vs. gentle comfort |
| vs Dawn    | Opposite ends of the spectrum        |

## The Glow Effect

The "glow" aesthetic comes from the contrast between:

- **Ultra-dark background** (`#0a0816`): Nearly black
- **Pure neon accents**:`#ff00ff`, `#00ffff`, `#ffff00`
- **White foreground**: Maximum readability

This creates the illusion of code elements glowing against the darkness.
