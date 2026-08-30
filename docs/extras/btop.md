# btop Theme

System monitoring with SilkCircuit style.

## Overview

btop++ is a resource monitor with a beautiful interface. SilkCircuit provides themes for all five variants.

## Installation

```bash
# Copy all variants
cp extras/btop/silkcircuit_*.theme ~/.config/btop/themes/

# Or copy a specific variant
cp extras/btop/silkcircuit_neon.theme ~/.config/btop/themes/
```

## Available Themes

| File                        | Variant                 |
| --------------------------- | ----------------------- |
| `silkcircuit_neon.theme`    | Neon (100% intensity)   |
| `silkcircuit_vibrant.theme` | Vibrant (85% intensity) |
| `silkcircuit_soft.theme`    | Soft (70% intensity)    |
| `silkcircuit_glow.theme`    | Glow (maximum contrast) |
| `silkcircuit_dawn.theme`    | Dawn (light theme)      |

## Activation

1. Launch btop: `btop`
2. Press `Esc` to open menu
3. Select "Options"
4. Navigate to "Color theme"
5. Choose your SilkCircuit variant

## Color Mapping

| Element          | Color           |
| ---------------- | --------------- |
| CPU graphs       | Electric Purple |
| Memory meters    | Neon Cyan       |
| Network activity | Hot Pink        |
| Disk usage       | Yellow          |
| Process list     | Foreground      |
| Highlighted      | Selection color |

## Configuration

btop stores settings in `~/.config/btop/btop.conf`:

```conf
# Theme setting
color_theme = "silkcircuit_neon"

# Other recommended settings
theme_background = True
truecolor = True
```

## Screenshots

Each variant offers a unique monitoring experience:

- **Neon**: Maximum vibrancy for dark rooms
- **Vibrant**: Balanced colors for everyday use
- **Soft**: Easy on the eyes for extended monitoring
- **Glow**: Ultra-high contrast on dark backgrounds
- **Dawn**: Light theme for bright environments

## Customization

Theme files use INI format. Edit to customize:

```ini
[main]
theme[main_bg] = "#12101a"
theme[main_fg] = "#f8f8f2"

[cpu]
theme[cpu_start] = "#e135ff"
theme[cpu_mid] = "#ff79c6"
theme[cpu_end] = "#ff00ff"
```

## Files

```
extras/btop/
├── README.md
├── silkcircuit_neon.theme
├── silkcircuit_vibrant.theme
├── silkcircuit_soft.theme
├── silkcircuit_glow.theme
└── silkcircuit_dawn.theme
```

## Troubleshooting

### Colors look washed out

Enable true color in btop.conf:

```conf
truecolor = True
```

### Theme not appearing

Verify the theme is in the correct location:

```bash
ls ~/.config/btop/themes/silkcircuit*.theme
```
