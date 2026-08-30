# procs

Column colors for [procs](https://github.com/dalance/procs), the modern `ps`.

## Install

procs reads one config file, so pick a variant and copy it under that name:

```bash
mkdir -p ~/.config/procs
cp extras/procs/silkcircuit-neon.toml ~/.config/procs/config.toml
```

The installer does the same thing: `./install.sh --variant neon`.

## Palette indices, not hex

procs takes an xterm-256 index per column rather than a hex value, so the
palette is quantized at build time to the nearest entry in the 6x6x6 color cube
or the grey ramp. The first sixteen slots are deliberately never used: those
are whatever the terminal decided they are, and picking one would hand the
theme back to the terminal.

## Files

<!-- extras:start target=procs -->

| Variant | File                                    |
| ------- | --------------------------------------- |
| neon    | `extras/procs/silkcircuit-neon.toml`    |
| vibrant | `extras/procs/silkcircuit-vibrant.toml` |
| soft    | `extras/procs/silkcircuit-soft.toml`    |
| glow    | `extras/procs/silkcircuit-glow.toml`    |
| dawn    | `extras/procs/silkcircuit-dawn.toml`    |

<!-- extras:end -->
