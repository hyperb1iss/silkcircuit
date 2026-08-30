# btop

Themes for [btop](https://github.com/aristocratos/btop): box borders, the CPU,
memory, network, and process gradients, meters, and the selected row.

## Install

```bash
mkdir -p ~/.config/btop/themes
cp extras/btop/silkcircuit-*.theme ~/.config/btop/themes/
```

Then pick one inside btop: `Esc`, Options, Color theme, silkcircuit-neon.
btop writes the choice back to `~/.config/btop/btop.conf`:

```ini
color_theme = "silkcircuit-neon"
truecolor = True
```

The installer does the same thing: `./install.sh --variant neon`.

## Color mapping

| Box          | Gradient                       |
| ------------ | ------------------------------ |
| CPU          | purple through pink to magenta |
| Memory       | cyan                           |
| Network      | pink and cyan                  |
| Process list | foreground with a purple title |

## Colors look washed out

btop falls back to 256 colors when it cannot tell that the terminal does
24-bit. Set `truecolor = True` in `btop.conf` and check that `$COLORTERM`
reads `truecolor`.

## Files

<!-- extras:start target=btop -->

| Variant | File                                    |
| ------- | --------------------------------------- |
| neon    | `extras/btop/silkcircuit-neon.theme`    |
| vibrant | `extras/btop/silkcircuit-vibrant.theme` |
| soft    | `extras/btop/silkcircuit-soft.theme`    |
| glow    | `extras/btop/silkcircuit-glow.theme`    |
| dawn    | `extras/btop/silkcircuit-dawn.theme`    |

<!-- extras:end -->
