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

These ship as TOML, which Alacritty has read since 0.13 replaced the YAML
config. Where `import` lives has moved since: it sits under `[general]` in
current releases, and if your Alacritty rejects it there, move the key to the
top level.

The installer does the same thing: `./install.sh`, or
`./install.sh --variant neon` for just that one.

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
