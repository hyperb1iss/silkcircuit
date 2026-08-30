# SilkCircuit K9s Theme

Vibrant neon theme for K9s featuring electric purples, hot pinks, and glowing cyans.

## Installation

1. Copy your preferred theme variant to your K9s skins directory:

```bash
# Create the skins directory if it doesn't exist
mkdir -p ~/.config/k9s/skins

# Copy the theme file (choose your variant)
cp silkcircuit.yaml ~/.config/k9s/skins/       # Default neon variant
cp silkcircuit-vibrant.yaml ~/.config/k9s/skins/  # Ultra-vibrant
cp silkcircuit-soft.yaml ~/.config/k9s/skins/     # Softer colors
cp silkcircuit-glow.yaml ~/.config/k9s/skins/     # Pure neon glow
cp silkcircuit-dawn.yaml ~/.config/k9s/skins/     # Light theme
```

2. Configure K9s to use the theme by editing `~/.config/k9s/config.yaml`:

```yaml
k9s:
  ui:
    skin: silkcircuit # Or silkcircuit-vibrant, silkcircuit-soft, etc.
```

3. Alternatively, set the theme via environment variable:

```bash
export K9S_SKIN="silkcircuit"
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

You can customize any color by editing the YAML file. The main sections are:

- **body**: Main background and foreground colors
- **frame**: UI chrome (borders, menus, crumbs, status)
- **views**: Content areas (tables, YAML viewer, logs)

## Tips

- The theme works best with a terminal that supports true color (24-bit color)
- For the best experience, use a Nerd Font for proper icon rendering
- The glow variant looks amazing on OLED displays

## Screenshots

## License

Same as the main SilkCircuit project - MIT
