# foot

Colors for [foot](https://codeberg.org/dnkl/foot), the Wayland terminal.

## Install

```bash
mkdir -p ~/.config/foot
cp extras/foot/silkcircuit-*.ini ~/.config/foot/
```

Then in `~/.config/foot/foot.ini`:

```ini
include=~/.config/foot/silkcircuit-neon.ini
```

Every file carries both a `[colors-dark]` and a `[colors-light]` section, which
foot 1.26 and newer switch between when it follows the system appearance
setting. On an older foot, only the dark section applies.

The installer does the same thing: `./install.sh --variant neon`.

## Files

<!-- extras:start target=foot -->

| Variant | File                                  |
| ------- | ------------------------------------- |
| neon    | `extras/foot/silkcircuit-neon.ini`    |
| vibrant | `extras/foot/silkcircuit-vibrant.ini` |
| soft    | `extras/foot/silkcircuit-soft.ini`    |
| glow    | `extras/foot/silkcircuit-glow.ini`    |
| dawn    | `extras/foot/silkcircuit-dawn.ini`    |

<!-- extras:end -->
