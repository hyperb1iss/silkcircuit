# tmux

A theme for [tmux](https://github.com/tmux/tmux): status bar, window list, pane
borders, messages, copy mode, the clock, popups, and menus. It styles the status
line and fills it with the session name, host, time and date. No key bindings,
no plugin manager, nothing that changes how tmux behaves.

## Install

```bash
mkdir -p ~/.config/tmux
cp extras/tmux/silkcircuit-*.conf ~/.config/tmux/
```

Then in your `tmux.conf`:

```bash
source-file ~/.config/tmux/silkcircuit-neon.conf
```

Reload with `tmux source-file ~/.tmux.conf`, or start a fresh server.

The installer does the same thing: `./install.sh`, or
`./install.sh --variant neon` for just that one.

## Requires tmux 3.4

Two of the options this theme sets are the reason. `copy-mode-match-style`
arrived in 3.2 and `popup-style` in 3.3, but `menu-style` and
`menu-border-style` only landed in 3.4, and tmux aborts a
`source-file` on the first option it does not recognise.

## True color inside tmux

Nothing renders correctly until tmux knows the outer terminal can do 24-bit
color:

```bash
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
```

## Files

<!-- extras:start target=tmux -->

| Variant | File                                   |
| ------- | -------------------------------------- |
| neon    | `extras/tmux/silkcircuit-neon.conf`    |
| vibrant | `extras/tmux/silkcircuit-vibrant.conf` |
| soft    | `extras/tmux/silkcircuit-soft.conf`    |
| glow    | `extras/tmux/silkcircuit-glow.conf`    |
| dawn    | `extras/tmux/silkcircuit-dawn.conf`    |

<!-- extras:end -->
