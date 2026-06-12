# Terminal Themes

SilkCircuit themes for popular terminal emulators.

## Alacritty

Fast, GPU-accelerated terminal emulator.

### Installation

```bash
# Dark variant
cp extras/alacritty.yml ~/.config/alacritty/themes/silkcircuit.yml

# Dawn (light) variant
cp extras/alacritty-dawn.yml ~/.config/alacritty/themes/silkcircuit-dawn.yml
```

### Configuration

Add to your `alacritty.yml`:

```yaml
import:
  - ~/.config/alacritty/themes/silkcircuit.yml

# Or for dawn:
import:
  - ~/.config/alacritty/themes/silkcircuit-dawn.yml
```

### Colors

| Color      | Dark      | Dawn      |
| ---------- | --------- | --------- |
| Background | `#12101a` | `#faf8ff` |
| Foreground | `#f8f8f2` | `#2b2540` |
| Cursor     | `#80ffea` | `#7e2bd5` |
| Selection  | `#44475a` | `#d4c8f0` |

---

## Kitty

Feature-rich terminal emulator with GPU rendering.

### Installation

```bash
# Dark variant
cp extras/kitty.conf ~/.config/kitty/themes/silkcircuit.conf

# Dawn (light) variant
cp extras/kitty-dawn.conf ~/.config/kitty/themes/silkcircuit-dawn.conf
```

### Configuration

Add to your `kitty.conf`:

```conf
include themes/silkcircuit.conf

# Or for dawn:
include themes/silkcircuit-dawn.conf
```

### Switch at Runtime

```bash
# Use kitty's built-in theme switcher
kitty +kitten themes SilkCircuit
```

---

## Warp

Modern terminal with AI features.

### Installation

```bash
# Dark variant
cp extras/warp.yaml ~/.warp/themes/silkcircuit.yaml

# Dawn (light) variant
cp extras/warp-dawn.yaml ~/.warp/themes/silkcircuit-dawn.yaml
```

### Activation

1. Open Warp Settings
2. Go to Appearance → Themes
3. Select "SilkCircuit" or "SilkCircuit Dawn"

---

## Windows Terminal

Windows integrated terminal.

### Installation

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Yes
```

The installer stages the scheme at
`%APPDATA%\silkcircuit\windows-terminal.json`.

### Manual Import

1. Open Windows Terminal Settings (`Ctrl+,`)
2. Click "Open JSON file"
3. Add the scheme from `extras/windows-terminal.json`
4. Set as default scheme

### JSON Scheme

```json
{
  "name": "SilkCircuit",
  "background": "#12101a",
  "foreground": "#f8f8f2",
  "cursorColor": "#80ffea",
  "selectionBackground": "#44475a",
  "black": "#12101a",
  "red": "#ff79c6",
  "green": "#50fa7b",
  "yellow": "#f1fa8c",
  "blue": "#e135ff",
  "purple": "#ff00ff",
  "cyan": "#80ffea",
  "white": "#f8f8f2",
  "brightBlack": "#637777",
  "brightRed": "#ff6363",
  "brightGreen": "#50fa7b",
  "brightYellow": "#ffffa5",
  "brightBlue": "#82b1ff",
  "brightPurple": "#ff69ff",
  "brightCyan": "#5fffff",
  "brightWhite": "#ffffff"
}
```

---

## ANSI Color Reference

All terminal themes use these ANSI mappings:

| ANSI        | Color         | Neon Hex  | Dawn Hex  |
| ----------- | ------------- | --------- | --------- |
| 0 (Black)   | Background    | `#12101a` | `#2b2540` |
| 1 (Red)     | Error/Delete  | `#ff79c6` | `#c1272d` |
| 2 (Green)   | Success/Add   | `#50fa7b` | `#2d8659` |
| 3 (Yellow)  | Warning       | `#f1fa8c` | `#a88600` |
| 4 (Blue)    | Purple accent | `#e135ff` | `#2563eb` |
| 5 (Magenta) | Pink          | `#ff00ff` | `#b40077` |
| 6 (Cyan)    | Functions     | `#80ffea` | `#007f8e` |
| 7 (White)   | Foreground    | `#f8f8f2` | `#faf8ff` |

## True Color Support

For the best experience, enable true color in your terminal:

### Alacritty

True color enabled by default.

### Kitty

True color enabled by default.

### Warp

True color enabled by default.

### tmux

Add to `.tmux.conf`:

```bash
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
```

### SSH

Ensure `TERM` is set correctly:

```bash
export TERM=xterm-256color
```

## Troubleshooting

### Colors look wrong

1. Verify true color support: `echo $COLORTERM` should show `truecolor`
2. Check terminal settings for color support
3. Try a different terminal emulator

### Cursor not visible

Some themes need cursor color adjustment. Override in your config:

```yaml
# Alacritty example
colors:
  cursor:
    cursor: "#80ffea"
    text: "#12101a"
```
