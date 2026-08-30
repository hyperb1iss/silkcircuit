# Extras & Integrations

Extend SilkCircuit across your entire development environment.

## Overview

SilkCircuit is a complete visual identity system for your workflow. These extras bring consistent neon energy to terminals, VS Code, system monitors, and more.

## Available Extras

### Code Editors

| Extra                             | Variants | Description                         |
| --------------------------------- | -------- | ----------------------------------- |
| [VS Code](/extras/vscode)         | 5        | Full VSCode theme with all variants |
| [Neovim Plugins](/extras/plugins) | All      | 25+ plugin integrations             |

### Terminals

Generated from the palette by `make build`, five variants each. See the
[terminal guide](/extras/terminals) for install steps.

<!-- extras:start -->

| Target             | Format                                                                | Generated files                                                   |
| ------------------ | --------------------------------------------------------------------- | ----------------------------------------------------------------- |
| Alacritty          | [reference](https://alacritty.org/config-alacritty.html#colors)       | `extras/alacritty/silkcircuit-{neon,vibrant,soft,glow,dawn}.toml` |
| Ghostty            | [reference](https://ghostty.org/docs/config/reference#theme)          | `extras/ghostty/silkcircuit-{neon,vibrant,soft,glow,dawn}`        |
| Ghostty GTK chrome | [reference](https://ghostty.org/docs/config/reference#gtk-custom-css) | `extras/ghostty/silkcircuit-{neon,vibrant,soft,glow,dawn}.css`    |
| Kitty              | [reference](https://sw.kovidgoyal.net/kitty/conf/#color-scheme)       | `extras/kitty/silkcircuit-{neon,vibrant,soft,glow,dawn}.conf`     |

<!-- extras:end -->

### System Tools

| Extra                | Variants | Description                        |
| -------------------- | -------- | ---------------------------------- |
| [btop](/extras/btop) | 5        | System monitor theme               |
| [K9s](/extras/k9s)   | 5        | Kubernetes dashboard               |
| [Git](/extras/git)   | 1        | Git config with SilkCircuit colors |
| [FZF](/extras/fzf)   | 1        | Fuzzy finder integration           |

### CLI and Desktop

Each of these ships a single config in `extras/` that the universal installer
picks up automatically.

| Extra     | Variants | Description                     |
| --------- | -------- | ------------------------------- |
| Starship  | 1        | Prompt segments and symbols     |
| tmux      | 1        | Status line, panes, and windows |
| lazygit   | 1        | Git TUI colors                  |
| bat       | 1        | `bat` syntax highlighting theme |
| lsd       | 1        | Directory listing colors        |
| atuin     | 1        | Shell history search            |
| procs     | 1        | Process viewer columns          |
| fastfetch | 1        | System info readout             |
| dmesg     | 5        | Kernel log colors               |
| COSMIC    | 5        | COSMIC Desktop theme            |

### Applications

| Extra                    | Variants | Description              |
| ------------------------ | -------- | ------------------------ |
| [Chrome](/extras/chrome) | 5        | Browser theme + DevTools |
| [Slack](/extras/slack)   | 1        | Workspace theme          |

### Neovim Distributions

| Extra                          | Description                      |
| ------------------------------ | -------------------------------- |
| [AstroNvim](/extras/astronvim) | Complete AstroNvim configuration |

## Quick Setup

Get the full SilkCircuit experience:

```bash
# Clone the repository
git clone https://github.com/hyperb1iss/silkcircuit.git
cd silkcircuit

# Install git colors
cat extras/gitconfig >> ~/.gitconfig

# Copy terminal theme (choose your terminal)
cp extras/kitty.conf ~/.config/kitty/themes/silkcircuit.conf
# OR
cp extras/alacritty.yml ~/.config/alacritty/themes/silkcircuit.yml

# For AstroNvim users
cp -r extras/astronvim/community.lua extras/astronvim/plugins ~/.config/nvim/lua/
```

## Color Consistency

All extras use the same color palette for a cohesive experience:

| Color           | Hex       | Usage              |
| --------------- | --------- | ------------------ |
| Electric Purple | `#e135ff` | Primary accents    |
| Neon Cyan       | `#80ffea` | Metadata, links    |
| Hot Pink        | `#ff79c6` | Secondary elements |
| Bright Yellow   | `#ffdd00` | Highlights         |
| Neon Green      | `#50fa7b` | Success states     |
| Error Red       | `#ff5555` | Errors, deletions  |

## Variant Support

Most extras support multiple variants:

| Variant | Available In                  |
| ------- | ----------------------------- |
| Neon    | VS Code, btop, K9s, Terminals |
| Vibrant | VS Code, btop, K9s            |
| Soft    | VS Code, btop, K9s            |
| Glow    | VS Code, btop, K9s            |
| Dawn    | VS Code, btop, K9s, Terminals |

## Pro Tips

1. **Enable true colors** in your terminal for best results
2. **Use consistent variants** across tools for cohesive aesthetic
3. **Check variant support** when switching themes
4. **Test in your environment**: some terminals render colors differently
