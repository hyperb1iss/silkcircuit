# SilkCircuit for lsd

[lsd](https://github.com/lsd-rs/lsd) reads exactly one custom colour file, and it
has to be called `colors.yaml`, so pick a variant and copy it under that name.

```bash
mkdir -p ~/.config/lsd
cp silkcircuit-neon.yaml ~/.config/lsd/colors.yaml
```

Then tell lsd to use it, in `~/.config/lsd/config.yaml`:

```yaml
color:
  theme: custom
```

lsd searches `$HOME/.config/lsd` before `$XDG_CONFIG_HOME`, and a colour file it
cannot parse is discarded without a word, so if the output still looks stock,
check that path first.

## What the theme covers

Permissions, ownership, sizes, dates, inodes, link validity, the tree edges, and
the git status column. File and extension colours are not part of it: lsd takes
those from `LS_COLORS`, and any `file:` or `extension:` key in `colors.yaml` is
rejected outright as an unknown field.

Colours are written as `[r, g, b]` triples, which lsd accepts alongside palette
indices. That keeps the file on the exact same hex values as the Neovim theme
rather than on the nearest of 256 approximations.
