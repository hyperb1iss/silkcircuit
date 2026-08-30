# SilkCircuit btop Theme

Electric system monitoring with vibrant purples, blazing pinks, and neon accents.

## Installation

1. Copy theme files to btop config directory:

```bash
# Linux/macOS
mkdir -p ~/.config/btop/themes
cp silkcircuit-*.theme ~/.config/btop/themes/
```

2. Open btop and press `Esc` to open menu
3. Select `Options` → `Color theme`
4. Choose your preferred SilkCircuit variant

## Variants

### Neon (Default)

The original SilkCircuit experience with vibrant electric colors.

### Vibrant

Pure, saturated neon colors for maximum visual impact.

### Soft

Muted tones for comfortable extended monitoring sessions.

### Glow

Ultra-dark backgrounds with pure neon accents for OLED displays.

### Dawn

A light background for bright rooms, with the same electric accents.

## Color Scheme

- **CPU Box**: Electric purple
- **Memory Box**: Neon cyan
- **Network Box**: Hot pink
- **Process Box**: Bright green
- **Graphs**: Smooth gradients between theme colors
- **Selected Items**: High contrast with pink/purple highlighting

## Customization

These files are generated from the palette by `scripts/build`, so edits to them
are overwritten on the next build. Change the colors in
`lua/silkcircuit/extra/btop.lua` (or in the palette itself) and rebuild:

```bash
make build
```

## Screenshots

The themes are designed to make system monitoring visually engaging while maintaining readability. CPU graphs flow from purple through pink to cyan, while network activity pulses with pink and cyan gradients.

## License

MIT - Same as SilkCircuit Neovim theme
