# Atuin

Themes for [Atuin](https://atuin.sh/), the shell history search.

## Install

```bash
mkdir -p ~/.config/atuin/themes
cp extras/atuin/silkcircuit-*.toml ~/.config/atuin/themes/
```

Then in `~/.config/atuin/config.toml`:

```toml
[theme]
name = "silkcircuit-neon"
```

The installer does the same thing: `./install.sh --variant neon`.

## Files

<!-- extras:start target=atuin -->

| Variant | File                                    |
| ------- | --------------------------------------- |
| neon    | `extras/atuin/silkcircuit-neon.toml`    |
| vibrant | `extras/atuin/silkcircuit-vibrant.toml` |
| soft    | `extras/atuin/silkcircuit-soft.toml`    |
| glow    | `extras/atuin/silkcircuit-glow.toml`    |
| dawn    | `extras/atuin/silkcircuit-dawn.toml`    |

<!-- extras:end -->
