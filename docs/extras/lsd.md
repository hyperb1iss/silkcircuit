# lsd

Directory listing colors for [lsd](https://github.com/lsd-rs/lsd).

## Install

lsd reads exactly one custom color file and it has to be called `colors.yaml`,
so pick a variant and copy it under that name:

```bash
mkdir -p ~/.config/lsd
cp extras/lsd/silkcircuit-neon.yaml ~/.config/lsd/colors.yaml
```

Then turn it on in `~/.config/lsd/config.yaml`:

```yaml
color:
  theme: custom
```

lsd searches `$HOME/.config/lsd` before `$XDG_CONFIG_HOME`, and a color file it
cannot parse is discarded without a word, so if the output still looks stock,
check that path first.

The installer writes the file and creates `config.yaml` when there is not one
already: `./install.sh --variant neon`.

## What the theme covers

Permissions, ownership, sizes, dates, inodes, link validity, the tree edges,
and the git status column. File and extension colors are not part of it: lsd
takes those from `LS_COLORS`, and any `file:` or `extension:` key in
`colors.yaml` is rejected as an unknown field.

Colors are written as `[r, g, b]` triples, which lsd accepts alongside palette
indices. That keeps the file on the same hex values as the Neovim theme rather
than on the nearest of 256 approximations.

## Files

<!-- extras:start target=lsd -->

| Variant | File                                  |
| ------- | ------------------------------------- |
| neon    | `extras/lsd/silkcircuit-neon.yaml`    |
| vibrant | `extras/lsd/silkcircuit-vibrant.yaml` |
| soft    | `extras/lsd/silkcircuit-soft.yaml`    |
| glow    | `extras/lsd/silkcircuit-glow.yaml`    |
| dawn    | `extras/lsd/silkcircuit-dawn.yaml`    |

<!-- extras:end -->
