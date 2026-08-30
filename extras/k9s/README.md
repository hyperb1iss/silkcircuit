# SilkCircuit K9s Theme

Vibrant neon theme for K9s featuring electric purples, hot pinks, and glowing cyans.

## Installation

1. Copy your preferred theme variant to your K9s skins directory:

```bash
# Create the skins directory if it doesn't exist
mkdir -p ~/.config/k9s/skins

# Copy every variant, or just the one you want
cp silkcircuit-*.yaml ~/.config/k9s/skins/
```

2. Configure K9s to use the theme by editing `~/.config/k9s/config.yaml`:

```yaml
k9s:
  ui:
    skin: silkcircuit-neon # Or -vibrant, -soft, -glow, -dawn
```

3. Alternatively, set the theme via environment variable:

```bash
export K9S_SKIN="silkcircuit-neon"
```

## Variants

### Neon (Default)

Maximum neon intensity - the original SilkCircuit experience with electric purples and glowing cyans.

### Vibrant

Ultra-vibrant with pure electric colors and ultra-dark backgrounds for maximum pop.

### Soft

Softer, more comfortable colors for extended Kubernetes debugging sessions.

### Glow

Ultra-dark backgrounds with pure neon colors - maximum contrast for that cyberpunk aesthetic.

### Dawn

Daylight-optimized light background with electric accents - perfect for bright environments.

## Color Palette

The theme uses the SilkCircuit signature colors:

- **Purple**: `#e135ff` - Keywords, sections, highlights
- **Cyan**: `#80ffea` - Functions, info, borders
- **Pink**: `#ff00ff` - Focus states, menu keys
- **Coral**: `#ff6ac1` - Numbers, counters
- **Yellow**: `#f1fa8c` - Filters, sorting
- **Green**: `#50fa7b` - Success, new resources
- **Red**: `#ff6363` - Errors, deletions

## Customization

These skins are generated from the palette by `scripts/build`, so edits to them
are overwritten on the next build. Change the mapping in
`lua/silkcircuit/extra/k9s.lua` and run `make build`. The sections are:

- **body**: Main background and foreground colors
- **frame**: UI chrome (borders, menus, crumbs, status)
- **views**: Content areas (tables, YAML viewer, logs)

## Tips

- The theme works best with a terminal that supports true color (24-bit color)
- For the best experience, use a Nerd Font for proper icon rendering
- The glow variant looks amazing on OLED displays

## License

Same as the main SilkCircuit project - MIT
