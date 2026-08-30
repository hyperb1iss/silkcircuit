# Terminal Themes

Every terminal theme is generated from `lua/silkcircuit/variants.lua` by
`make build`, in all five variants. The colors your terminal draws are the same
values Neovim draws, down to the hex, and CI fails if a generated file drifts
from the palette.

Files live under `extras/<terminal>/silkcircuit-<variant>.<ext>`, where
`<variant>` is one of `neon`, `vibrant`, `soft`, `glow`, or `dawn`. Dawn is the
light variant; everything else is dark.

## Kitty

```bash
mkdir -p ~/.config/kitty/themes
cp extras/kitty/silkcircuit-*.conf ~/.config/kitty/themes/
```

Then in `~/.config/kitty/kitty.conf`:

```conf
include themes/silkcircuit-neon.conf
```

## Alacritty

Alacritty 0.13 and newer reads TOML, so these ship as `.toml`.

```bash
mkdir -p ~/.config/alacritty/themes
cp extras/alacritty/silkcircuit-*.toml ~/.config/alacritty/themes/
```

Then in `~/.config/alacritty/alacritty.toml`:

```toml
[general]
import = ["~/.config/alacritty/themes/silkcircuit-neon.toml"]
```

## Ghostty

The theme files carry no extension, which is what Ghostty's theme directory
expects.

```bash
mkdir -p ~/.config/ghostty/themes
cp extras/ghostty/silkcircuit-neon ~/.config/ghostty/themes/
```

Then in `~/.config/ghostty/config`:

```
theme = silkcircuit-neon
```

Ghostty can follow the system appearance, which is what the dawn variant is for:

```
theme = dark:silkcircuit-neon,light:silkcircuit-dawn
```

### GTK window chrome (Linux)

Each variant also ships a `.css` file that styles Ghostty's headerbar, tabs,
split dividers, and overlays. It applies on Linux, where Ghostty renders its
chrome with GTK.

```bash
cp extras/ghostty/silkcircuit-neon.css ~/.config/ghostty/silkcircuit.css
```

```
gtk-custom-css = ~/.config/ghostty/silkcircuit.css
```

## WezTerm

```bash
mkdir -p ~/.config/wezterm/colors
cp extras/wezterm/silkcircuit-*.toml ~/.config/wezterm/colors/
```

WezTerm reads every scheme in that directory and refers to them by the name in
their `[metadata]` block, so in `~/.config/wezterm/wezterm.lua`:

```lua
config.color_scheme = "SilkCircuit Neon"
```

## Warp

```bash
mkdir -p ~/.warp/themes
cp extras/warp/silkcircuit-*.yaml ~/.warp/themes/
```

Then pick the theme in Settings → Appearance → Themes. Each file declares its
own `details`, so Warp knows dawn is a light theme and the rest are dark.

## Windows Terminal

Windows Terminal has no include mechanism, so the schemes get pasted into your
settings. `extras/windows-terminal/silkcircuit.json` holds all five in one
`schemes` array; the per-variant files hold one scheme each.

1. Open Settings with `Ctrl+,` and click "Open JSON file".
2. Copy the objects out of `silkcircuit.json` into the top-level `schemes` array.
3. Set `"colorScheme": "SilkCircuit Neon"` in the profile you want.

The installer stages the combined file at
`%APPDATA%\silkcircuit\windows-terminal.json` so you do not have to find it in
the repository.

## ANSI colors

All six targets carry the same 16 ANSI slots, taken verbatim from the
`terminal_*` keys of the variant. Nothing is retuned per terminal, so a
`ls --color` in Kitty and the same command in WezTerm produce identical pixels.

The authoritative values are in `palette/silkcircuit-<variant>.json` under the
`terminal` key, alongside every other palette color as hex, RGB, and HSL. The
same directory carries base16 and base24 scheme files for
[tinted-theming](https://github.com/tinted-theming/home) builders such as tinty
and stylix.

## True color

Every terminal here enables true color by default. Inside tmux it needs help:

```bash
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
```

Over SSH, make sure `TERM` survives the hop:

```bash
export TERM=xterm-256color
```

If colors still look flat, check that `$COLORTERM` reads `truecolor`.
