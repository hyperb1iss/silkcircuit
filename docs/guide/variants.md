# Theme Variants

SilkCircuit offers five distinct variants, each tuned for different environments and preferences.

## Overview

| Variant     | Background | Intensity | Best For               |
| ----------- | ---------- | --------- | ---------------------- |
| **Neon**    | `#12101a`  | 100%      | Maximum vibrancy       |
| **Vibrant** | `#0f0c1a`  | 85%       | Balanced energy        |
| **Soft**    | `#1a1626`  | 70%       | Extended sessions      |
| **Glow**    | `#0a0816`  | 100%+     | Low-light environments |
| **Dawn**    | `#faf8ff`  | Light     | Bright rooms & daytime |

## Switching Variants

### Via Configuration

```lua
require("silkcircuit").setup({
  variant = "dawn",  -- or "neon", "vibrant", "soft", "glow"
})
```

### At Runtime

```vim
:SilkCircuit neon
:SilkCircuit vibrant
:SilkCircuit soft
:SilkCircuit glow
:SilkCircuit dawn
```

Your preference is automatically saved for future sessions.

## Variant Comparison

### Dark Variants

All dark variants share the same semantic color mappings. Only the intensity and backgrounds differ:

- **Neon**: Pure, saturated colors at maximum intensity
- **Vibrant**: Slightly reduced saturation, easier on the eyes
- **Soft**: Gentler colors for marathon coding sessions
- **Glow**: Ultra-dark backgrounds with pure neon colors for maximum contrast

### Light Variant

**Dawn** is a complete light theme with inverted colors optimized for bright environments:

- Light purple-tinted backgrounds
- Deep, saturated accent colors for contrast
- Same semantic color meanings (purple = keywords, cyan = functions)

## Choosing Your Variant

::: tip When to Use Each Variant

**Neon**: When you want maximum visual impact and are working in a dark room.

**Vibrant**: For everyday use with a good balance of energy and comfort.

**Soft**: For long coding sessions, especially late at night.

**Glow**: In very dark environments or when using high-contrast monitors.

**Dawn**: During daytime, in well-lit rooms, or when working outdoors.
:::

## Learn More

Explore each variant in detail:

- [Neon Variant](/variants/neon)
- [Vibrant Variant](/variants/vibrant)
- [Soft Variant](/variants/soft)
- [Glow Variant](/variants/glow)
- [Dawn Variant](/variants/dawn)
