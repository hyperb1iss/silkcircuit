# Terminal Themes

Every terminal theme is generated from `lua/silkcircuit/variants.lua` by
`make build`, in all five variants. The colors your terminal draws are the same
values Neovim draws, down to the hex, and CI fails if a generated file drifts
from the palette.

Files live under `extras/<terminal>/silkcircuit-<variant>.<ext>`, where
`<variant>` is one of `neon`, `vibrant`, `soft`, `glow`, or `dawn`. Dawn is the
light variant, everything else is dark.

## Pick your terminal

| Terminal                                     | Install path                  | Turn it on                                    |
| -------------------------------------------- | ----------------------------- | --------------------------------------------- |
| [Kitty](/extras/kitty)                       | `~/.config/kitty/themes/`     | `include themes/silkcircuit-neon.conf`        |
| [Alacritty](/extras/alacritty)               | `~/.config/alacritty/themes/` | `import = [".../silkcircuit-neon.toml"]`      |
| [Ghostty](/extras/ghostty)                   | `~/.config/ghostty/themes/`   | `theme = silkcircuit-neon`                    |
| [WezTerm](/extras/wezterm)                   | `~/.config/wezterm/colors/`   | `config.color_scheme = "SilkCircuit Neon"`    |
| [Warp](/extras/warp)                         | `~/.warp/themes/`             | Settings, Appearance, Themes                  |
| [foot](/extras/foot)                         | `~/.config/foot/`             | `include=~/.config/foot/silkcircuit-neon.ini` |
| [iTerm2](/extras/iterm2)                     | imported through Settings     | Profiles, Colors, Color Presets               |
| [Windows Terminal](/extras/windows-terminal) | Fragments directory           | `"colorScheme": "SilkCircuit Neon"`           |

Multiplexers get their own pages: [tmux](/extras/tmux) and
[Zellij](/extras/zellij).

Or run the installer, which detects what you have and themes all of it:

```bash
./install.sh              # every variant, side by side
./install.sh --variant glow
```

## ANSI colors

Every target carries the same 16 ANSI slots, taken verbatim from the
`terminal_*` keys of the variant. Nothing is retuned per terminal, so
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
