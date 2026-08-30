# SilkCircuit for COSMIC Desktop

Theme files for the [COSMIC Desktop Environment](https://system76.com/cosmic) by System76.

## Variants

| File                      | Description                                      |
| ------------------------- | ------------------------------------------------ |
| `silkcircuit-neon.ron`    | Maximum neon intensity - the original experience |
| `silkcircuit-vibrant.ron` | Slightly toned down - easier on the eyes         |
| `silkcircuit-soft.ron`    | Softer colors - comfortable for extended use     |
| `silkcircuit-glow.ron`    | Ultra-dark with pure neon - maximum contrast     |
| `silkcircuit-dawn.ron`    | Light theme for daytime use                      |

## Installation

### Via COSMIC Settings (recommended)

1. Open **Settings** > **Desktop** > **Appearance**
2. Click **Import** under the theme section
3. Select the desired `.ron` file
4. The theme will be applied immediately

### Manual installation

Copy the `.ron` file contents to your COSMIC theme config:

```sh
# For dark themes
mkdir -p ~/.config/cosmic/com.system76.CosmicTheme.Dark.Builder/v1
cp silkcircuit-neon.ron ~/.config/cosmic/com.system76.CosmicTheme.Dark.Builder/v1/

# For the dawn (light) theme
mkdir -p ~/.config/cosmic/com.system76.CosmicTheme.Light.Builder/v1
cp silkcircuit-dawn.ron ~/.config/cosmic/com.system76.CosmicTheme.Light.Builder/v1/
```

### Via cosmic-themes.org

Visit [cosmic-themes.org](https://cosmic-themes.org/) to browse and install community themes.

## Customization

These files are generated from the palette by `scripts/build`, so edits to them
are overwritten on the next build. Change the mapping in
`lua/silkcircuit/extra/cosmic.lua` and run `make build`.

## Theme Preview Colors

### Neon (Dark)

- Background: `#12101a` | Accent: `#e135ff` | Cyan: `#80ffea`

### Vibrant (Dark)

- Background: `#0f0c1a` | Accent: `#ff00ff` | Cyan: `#00ffcc`

### Soft (Dark)

- Background: `#1a1626` | Accent: `#e892ff` | Cyan: `#99ffee`

### Glow (Dark)

- Background: `#0a0816` | Accent: `#d633ff` | Cyan: `#00ffff`

### Dawn (Light)

- Background: `#faf8ff` | Accent: `#7e2bd5` | Cyan: `#006e72`
