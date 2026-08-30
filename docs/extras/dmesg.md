# dmesg

Kernel log colors for `dmesg`, through util-linux's
[terminal-colors.d](https://www.man7.org/linux/man-pages/man5/terminal-colors.d.5.html).

## Install

terminal-colors.d keys a scheme by the name of the utility it colors, so the
file lands as `dmesg.scheme` no matter which variant it came from:

```bash
mkdir -p ~/.config/terminal-colors.d
cp extras/dmesg/silkcircuit-neon.scheme ~/.config/terminal-colors.d/dmesg.scheme
```

For every user on the machine, use `/etc/terminal-colors.d/` instead.

```bash
dmesg --color=always | less -R
```

The installer does the same thing: `./install.sh --variant neon`.

## Linux only

terminal-colors.d is util-linux. The `dmesg` on macOS and the BSDs ignores it.

## Files

<!-- extras:start target=dmesg -->

| Variant | File                                      |
| ------- | ----------------------------------------- |
| neon    | `extras/dmesg/silkcircuit-neon.scheme`    |
| vibrant | `extras/dmesg/silkcircuit-vibrant.scheme` |
| soft    | `extras/dmesg/silkcircuit-soft.scheme`    |
| glow    | `extras/dmesg/silkcircuit-glow.scheme`    |
| dawn    | `extras/dmesg/silkcircuit-dawn.scheme`    |

<!-- extras:end -->
