# Introduction

SilkCircuit is a unified color system for your entire development environment. One palette, consistent semantics, and WCAG AA contrast, from Neovim to VS Code to your terminal to your browser.

## Why SilkCircuit?

### Electric Meets Elegant

SilkCircuit themes 20+ tools with the same palette and semantic mappings. Keywords are always purple, functions are always cyan, strings are always pink, whether you're in Neovim, VS Code, or reading a diff in your terminal.

### Performance First

The Neovim theme loads in about 5ms with every integration defined up front. There is no cache to regenerate and nothing to warm: instant electric energy on every start.

### Accessibility Built-In

All color combinations meet WCAG AA standards (4.5:1 contrast ratio minimum). Code longer without eye strain.

### 5 Variants for Every Mood

| Variant     | Style          | Best For               |
| ----------- | -------------- | ---------------------- |
| **Neon**    | 100% intensity | Maximum vibrancy       |
| **Vibrant** | 85% intensity  | Balanced energy        |
| **Soft**    | 70% intensity  | Extended sessions      |
| **Glow**    | Ultra-dark     | Low-light coding       |
| **Dawn**    | Light theme    | Daytime & bright rooms |

## Features at a Glance

- 🎨 **25+ Plugin Integrations**: Auto-detected and themed
- 🏎️ **~5ms Load Time**: No cache, nothing to regenerate
- 👁️ **WCAG AA Compliant**: Validated contrast ratios
- 💾 **Persistent Preferences**: Settings survive across sessions
- 🔮 **Semantic Colors**: Consistent meanings everywhere

## Quick Start

```lua
-- lazy.nvim
{
  "hyperb1iss/silkcircuit",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("silkcircuit")
  end,
}
```

Then switch variants with `:SilkCircuit dawn` or any other variant name.

## Next Steps

- [Installation Guide](/guide/installation): Get SilkCircuit running
- [Configuration](/guide/configuration): Customize your experience
- [Theme Variants](/variants/): Explore all 5 variants
- [Design System](/design/): Understand the color philosophy
