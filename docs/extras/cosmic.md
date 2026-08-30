# COSMIC Desktop

Desktop themes for [COSMIC](https://system76.com/cosmic), System76's desktop
environment.

## Install through Settings

1. Settings, Desktop, Appearance.
2. Import, under the theme section.
3. Pick `extras/cosmic/silkcircuit-neon.ron`.

The theme applies immediately. The installer stages all five at
`~/.config/silkcircuit/cosmic/` so the import dialog has somewhere stable to
point at: `./install.sh`.

## Install by hand

The four dark variants and the light one go in different builder directories:

```bash
mkdir -p ~/.config/cosmic/com.system76.CosmicTheme.Dark.Builder/v1
cp extras/cosmic/silkcircuit-neon.ron ~/.config/cosmic/com.system76.CosmicTheme.Dark.Builder/v1/

mkdir -p ~/.config/cosmic/com.system76.CosmicTheme.Light.Builder/v1
cp extras/cosmic/silkcircuit-dawn.ron ~/.config/cosmic/com.system76.CosmicTheme.Light.Builder/v1/
```

## Files

<!-- extras:start target=cosmic -->

| Variant | File                                    |
| ------- | --------------------------------------- |
| neon    | `extras/cosmic/silkcircuit-neon.ron`    |
| vibrant | `extras/cosmic/silkcircuit-vibrant.ron` |
| soft    | `extras/cosmic/silkcircuit-soft.ron`    |
| glow    | `extras/cosmic/silkcircuit-glow.ron`    |
| dawn    | `extras/cosmic/silkcircuit-dawn.ron`    |

<!-- extras:end -->
