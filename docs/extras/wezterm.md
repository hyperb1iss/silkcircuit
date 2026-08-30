# WezTerm

Color schemes for [WezTerm](https://wezterm.org/), one TOML file per variant.

## Install

```bash
mkdir -p ~/.config/wezterm/colors
cp extras/wezterm/silkcircuit-*.toml ~/.config/wezterm/colors/
```

WezTerm reads every scheme in that directory and refers to them by the name in
their `[metadata]` block, not by file name. In `~/.config/wezterm/wezterm.lua`:

```lua
config.color_scheme = "SilkCircuit Neon"
```

The other names are `SilkCircuit Vibrant`, `Soft`, `Glow`, and `Dawn`.

The installer does the same thing: `./install.sh`, or
`./install.sh --variant neon` for just that one.

## Files

<!-- extras:start target=wezterm -->

| Variant | File                                      |
| ------- | ----------------------------------------- |
| neon    | `extras/wezterm/silkcircuit-neon.toml`    |
| vibrant | `extras/wezterm/silkcircuit-vibrant.toml` |
| soft    | `extras/wezterm/silkcircuit-soft.toml`    |
| glow    | `extras/wezterm/silkcircuit-glow.toml`    |
| dawn    | `extras/wezterm/silkcircuit-dawn.toml`    |

<!-- extras:end -->
