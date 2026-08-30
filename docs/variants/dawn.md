# Dawn Variant

A beautiful light theme for daytime coding with electric accents.

## Overview

**Dawn** inverts the SilkCircuit palette for bright environments: soft purple-tinted backgrounds with deep, saturated accent colors. Perfect for well-lit rooms and daytime work.

| Property   | Value     |
| ---------- | --------- |
| Background | `#faf8ff` |
| Foreground | `#2b2540` |
| Intensity  | Light     |
| Type       | Light     |

## Color Palette

### Primary Colors

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#7e2bd5` | Keywords, control flow |
| Cyan      | `#007f8e` | Functions, methods     |
| Pink      | `#b40077` | Tags, booleans         |
| Pink Soft | `#9c4a88` | Strings                |
| Coral     | `#c74a8c` | Numbers, constants     |
| Yellow    | `#a88600` | Classes, types         |

### Supporting Colors

| Color | Hex       | Usage                  |
| ----- | --------- | ---------------------- |
| Green | `#2d8659` | Success, git additions |
| Red   | `#c1272d` | Errors, git deletions  |
| Blue  | `#2563eb` | Links, info            |
| Gray  | `#8e84a8` | Comments, muted text   |

### Background Spectrum

| Element      | Hex       | Usage                  |
| ------------ | --------- | ---------------------- |
| bg           | `#faf8ff` | Main editor background |
| bg_dark      | `#f1ecff` | Sidebar, panels        |
| bg_highlight | `#e8e0ff` | Popups, highlights     |
| bg_visual    | `#d4c8f0` | Selection              |

## Terminal Colors

```yaml
# ANSI Colors
black: "#2b2540"
red: "#c1272d"
green: "#2d8659"
yellow: "#a88600"
blue: "#2563eb"
magenta: "#b40077"
cyan: "#007f8e"
white: "#faf8ff"

# Bright variants
bright_black: "#5a4d6e"
bright_red: "#dc2626"
bright_green: "#38a169"
bright_yellow: "#d69e00"
bright_blue: "#3b82f6"
bright_magenta: "#c04a8f"
bright_cyan: "#009fae"
bright_white: "#ffffff"
```

## When to Use

- **Daytime coding** with natural light
- Working in **well-lit rooms**
- **Outdoor coding** on laptops
- Prefer **light themes** while keeping the SilkCircuit aesthetic
- Reducing **eye strain** in bright environments

## Configuration

```lua
require("silkcircuit").setup({
  variant = "dawn",
})
vim.cmd.colorscheme("silkcircuit")
```

Or switch at runtime:

```vim
:SilkCircuit dawn
```

## Design Philosophy

Dawn maintains SilkCircuit's semantic color system while adapting for light backgrounds:

- **Deeper accents**: Colors are more saturated to maintain contrast
- **Purple-tinted backgrounds**: Keeps the signature aesthetic
- **Same semantic meanings**: Keywords are still purple, functions still cyan
- **WCAG AA compliant**: All combinations meet accessibility standards

## Comparison

| vs Neon/Vibrant/Soft | Light theme vs. dark          |
| -------------------- | ----------------------------- |
| vs Glow              | Opposite ends of the spectrum |

Dawn is the only light variant, designed for those who prefer or need light themes while maintaining the SilkCircuit identity.
