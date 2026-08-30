# SilkCircuit for Ghostty

Terminal color themes and GTK chrome styling for [Ghostty](https://ghostty.org/).

## Variants

| Theme File            | GTK CSS                   | Description                                      |
| --------------------- | ------------------------- | ------------------------------------------------ |
| `silkcircuit-neon`    | `silkcircuit-neon.css`    | Maximum neon intensity - the original experience |
| `silkcircuit-vibrant` | `silkcircuit-vibrant.css` | Slightly toned down - easier on the eyes         |
| `silkcircuit-soft`    | `silkcircuit-soft.css`    | Softer colors - comfortable for extended use     |
| `silkcircuit-glow`    | `silkcircuit-glow.css`    | Ultra-dark with pure neon - maximum contrast     |
| `silkcircuit-dawn`    | `silkcircuit-dawn.css`    | Light theme for daytime use                      |

## Installation

### Terminal Colors

Copy the desired theme file to your Ghostty themes directory:

```sh
mkdir -p ~/.config/ghostty/themes
cp silkcircuit-neon ~/.config/ghostty/themes/
```

Then activate it in `~/.config/ghostty/config`:

```
theme = silkcircuit-neon
```

For automatic light/dark switching:

```
theme = dark:silkcircuit-neon,light:silkcircuit-dawn
```

### GTK Chrome (Linux)

The CSS files style Ghostty's window chrome: headerbar, tabs, split dividers,
overlays, and command palette. Copy the matching CSS variant:

```sh
cp silkcircuit-neon.css ~/.config/ghostty/
```

Then add to your Ghostty config (or a platform-specific config file):

```
gtk-custom-css = ~/.config/ghostty/silkcircuit-neon.css
```

`gtk-custom-css` needs Ghostty 1.1 or newer.

### What the CSS Styles

- **Headerbar** - Dark background matching the terminal, accent bottom border
- **Tabs** - Active tab connects to terminal with accent top-edge indicator
- **Split dividers** - Accent-colored separator between panes
- **URL overlay** - Cyan link text on themed background
- **Search bar** - Themed with accent outline
- **Resize overlay** - Accent text with subtle border
- **Command palette** - Themed search input with accent icons
- **Bell overlay** - Accent border flash
- **Exit overlays** - Green (clean exit) / red (error) tints
- **Clipboard confirmation** - Themed dialog with blur effect
