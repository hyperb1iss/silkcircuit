# Warp

Themes for [Warp](https://www.warp.dev/), one YAML file per variant.

## Install

```bash
mkdir -p ~/.warp/themes
cp extras/warp/silkcircuit-*.yaml ~/.warp/themes/
```

Then pick the theme in Settings, Appearance, Themes. Each file declares its own
`details` key, so Warp knows dawn is a light theme and the rest are dark, and
sorts them into the right list.

The installer does the same thing: `./install.sh`, or
`./install.sh --variant neon` for just that one.

## Files

<!-- extras:start target=warp -->

| Variant | File                                   |
| ------- | -------------------------------------- |
| neon    | `extras/warp/silkcircuit-neon.yaml`    |
| vibrant | `extras/warp/silkcircuit-vibrant.yaml` |
| soft    | `extras/warp/silkcircuit-soft.yaml`    |
| glow    | `extras/warp/silkcircuit-glow.yaml`    |
| dawn    | `extras/warp/silkcircuit-dawn.yaml`    |

<!-- extras:end -->
