# iTerm2

Color presets for [iTerm2](https://iterm2.com/), one `.itermcolors` file per
variant.

## Install

iTerm2 has no drop-in theme directory, so a preset gets imported through the
UI:

1. Settings, Profiles, Colors.
2. Open the Color Presets dropdown and choose Import.
3. Pick `extras/iterm2/silkcircuit-neon.itermcolors`.
4. Open the dropdown again and select SilkCircuit Neon.

The installer stages the files at `~/.config/silkcircuit/iterm2/` so the import
dialog has somewhere stable to point at: `./install.sh --variant neon`.

Presets are per profile, so repeat step 4 for any other profile you use.

## Files

<!-- extras:start target=iterm2 -->

| Variant | File                                            |
| ------- | ----------------------------------------------- |
| neon    | `extras/iterm2/silkcircuit-neon.itermcolors`    |
| vibrant | `extras/iterm2/silkcircuit-vibrant.itermcolors` |
| soft    | `extras/iterm2/silkcircuit-soft.itermcolors`    |
| glow    | `extras/iterm2/silkcircuit-glow.itermcolors`    |
| dawn    | `extras/iterm2/silkcircuit-dawn.itermcolors`    |

<!-- extras:end -->
