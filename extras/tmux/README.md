# SilkCircuit for tmux

Five generated themes, one per variant. Each file is a pure theme: status bar,
window list, pane borders, messages, copy mode, clock, popups, and menus. No
key bindings, no plugin manager, no options that change how tmux behaves.

## Setup

Copy the variant you want, then source it from your `tmux.conf`:

```bash
mkdir -p ~/.config/tmux
cp extras/tmux/silkcircuit-neon.conf ~/.config/tmux/
```

```tmux
source-file ~/.config/tmux/silkcircuit-neon.conf
```

Reload with `tmux source-file ~/.tmux.conf`, or start a fresh server.

Requires tmux 3.4 or newer. `copy-mode-match-style` arrived in 3.2 and
`popup-style` in 3.3, but `menu-style` and `menu-border-style` only landed in
3.4, and tmux aborts a `source-file` on the first option it does not know.

## What happened to the old tmux.conf

`extras/tmux.conf` used to ship a full configuration: prefix bindings, vi copy
mode, pane navigation, TPM plugin declarations, and a hardcoded palette that had
drifted away from the theme (it carried a stray gruvbox grey). Dropping into
someone's tmux setup and rebinding their keys is not what a colour scheme is
for, so it is gone. Only the colours survive, and they now come from
`lua/silkcircuit/variants.lua` like every other target.

If you want the old bindings back, they are in the git history:

```bash
git log --all --diff-filter=D -- extras/tmux.conf
```
