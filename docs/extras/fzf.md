# fzf

Colors for [fzf](https://github.com/junegunn/fzf), shipped as a shell snippet
that exports `FZF_DEFAULT_OPTS`, plus a PowerShell equivalent.

## Install

```bash
mkdir -p ~/.config/fzf
cp extras/fzf/silkcircuit-*.sh ~/.config/fzf/
```

Then in `.zshrc`, `.bashrc`, or whichever rc file you use:

```bash
source ~/.config/fzf/silkcircuit-neon.sh
```

On PowerShell, copy the `.ps1` files instead and dot-source one from your
profile:

```powershell
. "$env:APPDATA\silkcircuit\fzf\silkcircuit-neon.ps1"
```

The installer does either one: `./install.sh --variant neon` or
`.\install.ps1 -Variant neon`.

## Requires fzf 0.52

The files set `selected-fg`, `selected-bg`, `selected-hl`, and `border`.
Older releases do not know those names.

## Setting your own options

The snippet assigns `FZF_DEFAULT_OPTS` rather than appending to it, so source
it first and add your own flags after:

```bash
source ~/.config/fzf/silkcircuit-neon.sh
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height=40% --layout=reverse"
```

## Files

<!-- extras:start target=fzf -->

| Variant | File                                |
| ------- | ----------------------------------- |
| neon    | `extras/fzf/silkcircuit-neon.sh`    |
| vibrant | `extras/fzf/silkcircuit-vibrant.sh` |
| soft    | `extras/fzf/silkcircuit-soft.sh`    |
| glow    | `extras/fzf/silkcircuit-glow.sh`    |
| dawn    | `extras/fzf/silkcircuit-dawn.sh`    |

<!-- extras:end -->

<!-- extras:start target=fzf-ps1 -->

| Variant | File                                 |
| ------- | ------------------------------------ |
| neon    | `extras/fzf/silkcircuit-neon.ps1`    |
| vibrant | `extras/fzf/silkcircuit-vibrant.ps1` |
| soft    | `extras/fzf/silkcircuit-soft.ps1`    |
| glow    | `extras/fzf/silkcircuit-glow.ps1`    |
| dawn    | `extras/fzf/silkcircuit-dawn.ps1`    |

<!-- extras:end -->
