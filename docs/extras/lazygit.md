# lazygit

The `gui.theme` block for [lazygit](https://github.com/jesseduffield/lazygit):
border colors, the selected line, cherry-picked and marked commits, and the
options text.

## Install

lazygit has no theme directory, so the block gets merged into your config or
loaded beside it:

```bash
mkdir -p ~/.config/lazygit
cp extras/lazygit/silkcircuit-*.yml ~/.config/lazygit/
```

Then either paste the `gui.theme` block into `~/.config/lazygit/config.yml`, or
load both files at once:

```bash
lazygit --use-config-file ~/.config/lazygit/config.yml,~/.config/lazygit/silkcircuit-neon.yml
```

The environment variable `LG_CONFIG_FILE` takes the same comma-separated list,
so this works as an alias or an export too.

The installer copies the files and prints that command: `./install.sh`.

## Colors only

Layout and font settings such as `gui.nerdFontsVersion`, `gui.showBottomLine`,
`gui.showPanelJumps`, and `gui.border` are preferences rather than colors, so
they stay in your own config.

## Files

<!-- extras:start target=lazygit -->

| Variant | File                                     |
| ------- | ---------------------------------------- |
| neon    | `extras/lazygit/silkcircuit-neon.yml`    |
| vibrant | `extras/lazygit/silkcircuit-vibrant.yml` |
| soft    | `extras/lazygit/silkcircuit-soft.yml`    |
| glow    | `extras/lazygit/silkcircuit-glow.yml`    |
| dawn    | `extras/lazygit/silkcircuit-dawn.yml`    |

<!-- extras:end -->
