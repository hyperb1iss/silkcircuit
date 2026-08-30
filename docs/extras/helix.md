# Helix

Themes for [Helix](https://helix-editor.com/): syntax, markup, diffs,
diagnostics, and the interface chrome.

## Install

```bash
mkdir -p ~/.config/helix/themes
cp extras/helix/silkcircuit-*.toml ~/.config/helix/themes/
```

Then in `~/.config/helix/config.toml`:

```toml
theme = "silkcircuit-neon"
```

Helix reloads a theme with `:config-reload`, and `:theme silkcircuit-dawn`
switches without editing the config.

The installer does the same thing: `./install.sh`, or
`./install.sh --variant neon` for just that one.

## Files

<!-- extras:start target=helix -->

| Variant | File                                    |
| ------- | --------------------------------------- |
| neon    | `extras/helix/silkcircuit-neon.toml`    |
| vibrant | `extras/helix/silkcircuit-vibrant.toml` |
| soft    | `extras/helix/silkcircuit-soft.toml`    |
| glow    | `extras/helix/silkcircuit-glow.toml`    |
| dawn    | `extras/helix/silkcircuit-dawn.toml`    |

<!-- extras:end -->
