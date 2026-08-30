# Zellij

Themes for [Zellij](https://zellij.dev/), covering the tab bar, status bar,
pane frames, the ribbon and text emphasis slots, and the exit codes.

## Install

```bash
mkdir -p ~/.config/zellij/themes
cp extras/zellij/silkcircuit-*.kdl ~/.config/zellij/themes/
```

Then in `~/.config/zellij/config.kdl`:

```text
theme "silkcircuit-neon"
```

`extras/zellij/silkcircuit.kdl` holds all five themes in one file, for anyone
who would rather drop in a single theme file than five.

Needs Zellij 0.42 or newer. Older releases do not understand the
`text_unselected` and ribbon slots these themes are written against.

The installer does the same thing: `./install.sh --variant neon`.

## Files

<!-- extras:start target=zellij -->

| Variant | File                                    |
| ------- | --------------------------------------- |
| neon    | `extras/zellij/silkcircuit-neon.kdl`    |
| vibrant | `extras/zellij/silkcircuit-vibrant.kdl` |
| soft    | `extras/zellij/silkcircuit-soft.kdl`    |
| glow    | `extras/zellij/silkcircuit-glow.kdl`    |
| dawn    | `extras/zellij/silkcircuit-dawn.kdl`    |

<!-- extras:end -->

<!-- extras:start target=zellij-all -->

| Variant       | File                            |
| ------------- | ------------------------------- |
| every variant | `extras/zellij/silkcircuit.kdl` |

<!-- extras:end -->
