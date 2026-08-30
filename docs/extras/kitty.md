# Kitty

Colors for [Kitty](https://sw.kovidgoyal.net/kitty/): the sixteen ANSI slots,
cursor, selection, URL underline, window borders, and the tab bar.

## Install

```bash
mkdir -p ~/.config/kitty/themes
cp extras/kitty/silkcircuit-*.conf ~/.config/kitty/themes/
```

Then in `~/.config/kitty/kitty.conf`:

```ini
include themes/silkcircuit-neon.conf
```

Kitty resolves `include` against the directory holding the config file, so the
path stays relative. `ctrl+shift+f5` reloads without a restart.

The installer does the same thing: `./install.sh --variant neon`.

## Files

<!-- extras:start target=kitty -->

| Variant | File                                    |
| ------- | --------------------------------------- |
| neon    | `extras/kitty/silkcircuit-neon.conf`    |
| vibrant | `extras/kitty/silkcircuit-vibrant.conf` |
| soft    | `extras/kitty/silkcircuit-soft.conf`    |
| glow    | `extras/kitty/silkcircuit-glow.conf`    |
| dawn    | `extras/kitty/silkcircuit-dawn.conf`    |

<!-- extras:end -->
