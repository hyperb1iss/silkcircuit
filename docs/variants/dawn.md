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
| Cyan      | `#006e72` | Functions, methods     |
| Pink      | `#b40077` | Tags, booleans         |
| Pink Soft | `#9e4087` | Strings                |
| Coral     | `#b42a74` | Numbers, constants     |
| Yellow    | `#796100` | Classes, types         |

### Supporting Colors

| Color | Hex       | Usage                  |
| ----- | --------- | ---------------------- |
| Green | `#1d6e46` | Success, git additions |
| Red   | `#c1272d` | Errors, git deletions  |
| Blue  | `#1454dc` | Links, info            |
| Gray  | `#686177` | Comments, muted text   |

### Background Spectrum

| Element      | Hex       | Usage                  |
| ------------ | --------- | ---------------------- |
| bg           | `#faf8ff` | Main editor background |
| bg_dark      | `#f4f0ff` | Sidebar, panels        |
| bg_highlight | `#f7f4ff` | Popups, highlights     |
| bg_visual    | `#d4c8f0` | Selection              |

## Terminal Colors

```yaml
# ANSI Colors
black: "#2b2540"
red: "#c1272d"
green: "#1d6e46"
yellow: "#796100"
blue: "#1454dc"
magenta: "#b40077"
cyan: "#006e72"
white: "#faf8ff"

# Bright variants
bright_black: "#5a4d6e"
bright_red: "#dc2626"
bright_green: "#288855"
bright_yellow: "#7f5f00"
bright_blue: "#2572ef"
bright_magenta: "#d92a99"
bright_cyan: "#048397"
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
