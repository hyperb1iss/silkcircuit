# Theme Variants

SilkCircuit offers five distinct variants, each crafted for different environments and preferences.

## At a Glance

| Variant     | Background | Intensity | Best For                           |
| ----------- | ---------- | --------- | ---------------------------------- |
| **Neon**    | `#12101a`  | 100%      | Maximum vibrancy, dark rooms       |
| **Vibrant** | `#0f0c1a`  | 85%       | Balanced energy, everyday use      |
| **Soft**    | `#1a1626`  | 70%       | Extended coding sessions           |
| **Glow**    | `#0a0816`  | 100%+     | Ultra-dark, low-light environments |
| **Dawn**    | `#faf8ff`  | Light     | Daytime, bright rooms              |

## Switching Variants

### Via Configuration

```lua
require("silkcircuit").setup({
  variant = "dawn",  -- "neon", "vibrant", "soft", "glow", "dawn"
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

Your preference is automatically saved and persisted across sessions.

## Dark Variants

All dark variants share the same semantic color mappings. Only the intensity and backgrounds differ:

- **[Neon](/variants/neon)**: Pure, saturated colors at maximum intensity
- **[Vibrant](/variants/vibrant)**: Slightly reduced saturation, easier on the eyes
- **[Soft](/variants/soft)**: Gentler colors for marathon coding sessions
- **[Glow](/variants/glow)**: Ultra-dark backgrounds with pure neon for maximum contrast

## Light Variant

**[Dawn](/variants/dawn)** is a complete light theme with inverted colors optimized for bright environments:

- Light purple-tinted backgrounds
- Deep, saturated accent colors for contrast
- Same semantic meanings (purple = keywords, cyan = functions)

## Choosing Your Variant

::: tip When to Use Each

**Neon**: Maximum visual impact in dark rooms

**Vibrant**: Everyday use with balanced energy and comfort

**Soft**: Long coding sessions, especially late at night

**Glow**: Very dark environments or high-contrast monitors

**Dawn**: Daytime, well-lit rooms, or outdoor coding
:::

## Consistency Across Variants

All variants maintain:

- **Semantic consistency**: Keywords are always purple, functions are always cyan
- **WCAG AA compliance**: 4.5:1 minimum contrast ratios
- **Plugin compatibility**: Full support for all 39 integrations
- **Terminal integration**: Matching ANSI colors
