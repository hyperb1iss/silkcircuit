# fastfetch

A [fastfetch](https://github.com/fastfetch-cli/fastfetch) config: key and
separator colors, plus a module list covering OS, host, kernel, uptime,
packages, shell, terminal, window manager, CPU, GPU, memory, disk, display, and
battery.

## Install

fastfetch reads one config file, so pick a variant and copy it under that name:

```bash
mkdir -p ~/.config/fastfetch
cp extras/fastfetch/silkcircuit-neon.jsonc ~/.config/fastfetch/config.jsonc
```

The installer does the same thing: `./install.sh --variant neon`.

## Files

<!-- extras:start target=fastfetch -->

| Variant | File                                         |
| ------- | -------------------------------------------- |
| neon    | `extras/fastfetch/silkcircuit-neon.jsonc`    |
| vibrant | `extras/fastfetch/silkcircuit-vibrant.jsonc` |
| soft    | `extras/fastfetch/silkcircuit-soft.jsonc`    |
| glow    | `extras/fastfetch/silkcircuit-glow.jsonc`    |
| dawn    | `extras/fastfetch/silkcircuit-dawn.jsonc`    |

<!-- extras:end -->
