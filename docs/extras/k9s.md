# k9s

Skins for [k9s](https://k9scli.io/): the body, the frame chrome (borders, menu,
crumbs, status), and the content views (tables, the YAML viewer, logs).

## Install

```bash
mkdir -p ~/.config/k9s/skins
cp extras/k9s/silkcircuit-*.yaml ~/.config/k9s/skins/
```

Then in `~/.config/k9s/config.yaml`:

```yaml
k9s:
  ui:
    skin: silkcircuit-neon
```

`export K9S_SKIN=silkcircuit-neon` works too, if you would rather not edit
the config.

The skins directory moves between platforms and k9s releases. `k9s info`
prints where yours is, and the installer asks it before copying: `./install.sh`.

## Files

<!-- extras:start target=k9s -->

| Variant | File                                  |
| ------- | ------------------------------------- |
| neon    | `extras/k9s/silkcircuit-neon.yaml`    |
| vibrant | `extras/k9s/silkcircuit-vibrant.yaml` |
| soft    | `extras/k9s/silkcircuit-soft.yaml`    |
| glow    | `extras/k9s/silkcircuit-glow.yaml`    |
| dawn    | `extras/k9s/silkcircuit-dawn.yaml`    |

<!-- extras:end -->
