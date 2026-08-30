# Alacritty

Colors for [Alacritty](https://alacritty.org/), including the sixteen ANSI
slots, cursor, selection, and search highlights.

## Install

```bash
mkdir -p ~/.config/alacritty/themes
cp extras/alacritty/silkcircuit-*.toml ~/.config/alacritty/themes/
```

Then in `~/.config/alacritty/alacritty.toml`:

```toml
[general]
import = ["~/.config/alacritty/themes/silkcircuit-neon.toml"]
```

Alacritty 0.13 moved the config from YAML to TOML and moved `import` under
`[general]`. On older releases the key sits at the top level instead.

The installer does the same thing: `./install.sh --variant neon`.

## Files

<!-- extras:start target=alacritty -->

| Variant | File                                        |
| ------- | ------------------------------------------- |
| neon    | `extras/alacritty/silkcircuit-neon.toml`    |
| vibrant | `extras/alacritty/silkcircuit-vibrant.toml` |
| soft    | `extras/alacritty/silkcircuit-soft.toml`    |
| glow    | `extras/alacritty/silkcircuit-glow.toml`    |
| dawn    | `extras/alacritty/silkcircuit-dawn.toml`    |

<!-- extras:end -->
