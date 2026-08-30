# 🌈 SilkCircuit Extras

Complete your neon-lit development environment with these additional configurations that perfectly complement the SilkCircuit theme.

## 📁 What's Included

### 🛸 AstroNvim Integration (`astronvim/`)

Complete AstroNvim setup with SilkCircuit styling:

- **Full AstroUI configuration** with neon-enhanced components
- **Custom Lualine theme** with electric visual elements
- **Neo-tree styling** with vibrant file icons
- **Community integration** setup files
- **Maximum effect mode** for the boldest experience

**Setup:**

```bash
# Copy all AstroNvim configs
cp -r extras/astronvim/community.lua extras/astronvim/plugins ~/.config/nvim/lua/
```

### ⚡ Git Configuration (`gitconfig`)

Transform your git experience with electric colors:

- **Neon magenta** commit hashes and important elements
- **Electric cyan** for dates and metadata
- **Bright yellow** for branch information
- **Matching colors** across `git log`, `git status`, and `git diff`
- **Delta integration** with SilkCircuit color palette

**Setup:**

```bash
# Pick a variant and include it, so your own .gitconfig stays yours
mkdir -p ~/.config/git
cp extras/git/silkcircuit-neon.gitconfig ~/.config/git/
git config --global --add include.path ~/.config/git/silkcircuit-neon.gitconfig
```

The file sets colours and nothing else. Delta, the pager, and the log format
are commented opt-ins at the bottom of it; the delta feature block expects the
matching bat theme, which `extras/bat/README.md` covers.

### 🖥️ Terminal Themes

Every terminal theme is rendered from `lua/silkcircuit/variants.lua` by
`make build`, so the colors in your terminal are the colors in your editor.
All five variants ship for every target. The
[terminal guide](../docs/extras/terminals.md) has the install line for each one,
and `palette/` carries the same colors as JSON and base16/base24 schemes.

<!-- extras:start -->

| Target                          | Format                                                                                             | Generated files                                                                                                                                                                                                                                          |
| ------------------------------- | -------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Alacritty                       | [reference](https://alacritty.org/config-alacritty.html#colors)                                    | [neon](alacritty/silkcircuit-neon.toml) · [vibrant](alacritty/silkcircuit-vibrant.toml) · [soft](alacritty/silkcircuit-soft.toml) · [glow](alacritty/silkcircuit-glow.toml) · [dawn](alacritty/silkcircuit-dawn.toml)                                    |
| Atuin                           | [reference](https://github.com/atuinsh/atuin/blob/main/crates/atuin-client/src/theme.rs)           | [neon](atuin/silkcircuit-neon.toml) · [vibrant](atuin/silkcircuit-vibrant.toml) · [soft](atuin/silkcircuit-soft.toml) · [glow](atuin/silkcircuit-glow.toml) · [dawn](atuin/silkcircuit-dawn.toml)                                                        |
| bat                             | [reference](https://github.com/sharkdp/bat#adding-new-themes)                                      | [neon](bat/silkcircuit-neon.tmTheme) · [vibrant](bat/silkcircuit-vibrant.tmTheme) · [soft](bat/silkcircuit-soft.tmTheme) · [glow](bat/silkcircuit-glow.tmTheme) · [dawn](bat/silkcircuit-dawn.tmTheme)                                                   |
| btop                            | [reference](https://github.com/aristocratos/btop#themes)                                           | [neon](btop/silkcircuit-neon.theme) · [vibrant](btop/silkcircuit-vibrant.theme) · [soft](btop/silkcircuit-soft.theme) · [glow](btop/silkcircuit-glow.theme) · [dawn](btop/silkcircuit-dawn.theme)                                                        |
| COSMIC Desktop                  | [reference](https://github.com/pop-os/cosmic-theme)                                                | [neon](cosmic/silkcircuit-neon.ron) · [vibrant](cosmic/silkcircuit-vibrant.ron) · [soft](cosmic/silkcircuit-soft.ron) · [glow](cosmic/silkcircuit-glow.ron) · [dawn](cosmic/silkcircuit-dawn.ron)                                                        |
| dmesg                           | [reference](https://www.man7.org/linux/man-pages/man5/terminal-colors.d.5.html)                    | [neon](dmesg/silkcircuit-neon.scheme) · [vibrant](dmesg/silkcircuit-vibrant.scheme) · [soft](dmesg/silkcircuit-soft.scheme) · [glow](dmesg/silkcircuit-glow.scheme) · [dawn](dmesg/silkcircuit-dawn.scheme)                                              |
| fastfetch                       | [reference](https://github.com/fastfetch-cli/fastfetch/wiki/Configuration)                         | [neon](fastfetch/silkcircuit-neon.jsonc) · [vibrant](fastfetch/silkcircuit-vibrant.jsonc) · [soft](fastfetch/silkcircuit-soft.jsonc) · [glow](fastfetch/silkcircuit-glow.jsonc) · [dawn](fastfetch/silkcircuit-dawn.jsonc)                               |
| foot                            | [reference](https://codeberg.org/dnkl/foot/src/branch/master/doc/foot.ini.5.scd)                   | [neon](foot/silkcircuit-neon.ini) · [vibrant](foot/silkcircuit-vibrant.ini) · [soft](foot/silkcircuit-soft.ini) · [glow](foot/silkcircuit-glow.ini) · [dawn](foot/silkcircuit-dawn.ini)                                                                  |
| fzf                             | [reference](https://github.com/junegunn/fzf/blob/master/man/man1/fzf.1)                            | [neon](fzf/silkcircuit-neon.sh) · [vibrant](fzf/silkcircuit-vibrant.sh) · [soft](fzf/silkcircuit-soft.sh) · [glow](fzf/silkcircuit-glow.sh) · [dawn](fzf/silkcircuit-dawn.sh)                                                                            |
| fzf (PowerShell)                | [reference](https://github.com/junegunn/fzf/blob/master/man/man1/fzf.1)                            | [neon](fzf/silkcircuit-neon.ps1) · [vibrant](fzf/silkcircuit-vibrant.ps1) · [soft](fzf/silkcircuit-soft.ps1) · [glow](fzf/silkcircuit-glow.ps1) · [dawn](fzf/silkcircuit-dawn.ps1)                                                                       |
| Ghostty                         | [reference](https://ghostty.org/docs/config/reference#theme)                                       | [neon](ghostty/silkcircuit-neon) · [vibrant](ghostty/silkcircuit-vibrant) · [soft](ghostty/silkcircuit-soft) · [glow](ghostty/silkcircuit-glow) · [dawn](ghostty/silkcircuit-dawn)                                                                       |
| Ghostty GTK chrome              | [reference](https://ghostty.org/docs/config/reference#gtk-custom-css)                              | [neon](ghostty/silkcircuit-neon.css) · [vibrant](ghostty/silkcircuit-vibrant.css) · [soft](ghostty/silkcircuit-soft.css) · [glow](ghostty/silkcircuit-glow.css) · [dawn](ghostty/silkcircuit-dawn.css)                                                   |
| Git                             | [reference](https://git-scm.com/docs/git-config#Documentation/git-config.txt-color)                | [neon](git/silkcircuit-neon.gitconfig) · [vibrant](git/silkcircuit-vibrant.gitconfig) · [soft](git/silkcircuit-soft.gitconfig) · [glow](git/silkcircuit-glow.gitconfig) · [dawn](git/silkcircuit-dawn.gitconfig)                                         |
| Helix                           | [reference](https://docs.helix-editor.com/themes.html)                                             | [neon](helix/silkcircuit-neon.toml) · [vibrant](helix/silkcircuit-vibrant.toml) · [soft](helix/silkcircuit-soft.toml) · [glow](helix/silkcircuit-glow.toml) · [dawn](helix/silkcircuit-dawn.toml)                                                        |
| iTerm2                          | [reference](https://iterm2.com/documentation-preferences-profiles-colors.html)                     | [neon](iterm2/silkcircuit-neon.itermcolors) · [vibrant](iterm2/silkcircuit-vibrant.itermcolors) · [soft](iterm2/silkcircuit-soft.itermcolors) · [glow](iterm2/silkcircuit-glow.itermcolors) · [dawn](iterm2/silkcircuit-dawn.itermcolors)                |
| k9s                             | [reference](https://k9scli.io/topics/skins/)                                                       | [neon](k9s/silkcircuit-neon.yaml) · [vibrant](k9s/silkcircuit-vibrant.yaml) · [soft](k9s/silkcircuit-soft.yaml) · [glow](k9s/silkcircuit-glow.yaml) · [dawn](k9s/silkcircuit-dawn.yaml)                                                                  |
| Kitty                           | [reference](https://sw.kovidgoyal.net/kitty/conf/#color-scheme)                                    | [neon](kitty/silkcircuit-neon.conf) · [vibrant](kitty/silkcircuit-vibrant.conf) · [soft](kitty/silkcircuit-soft.conf) · [glow](kitty/silkcircuit-glow.conf) · [dawn](kitty/silkcircuit-dawn.conf)                                                        |
| lazygit                         | [reference](https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md#color-attributes)  | [neon](lazygit/silkcircuit-neon.yml) · [vibrant](lazygit/silkcircuit-vibrant.yml) · [soft](lazygit/silkcircuit-soft.yml) · [glow](lazygit/silkcircuit-glow.yml) · [dawn](lazygit/silkcircuit-dawn.yml)                                                   |
| lsd                             | [reference](https://github.com/lsd-rs/lsd/blob/master/doc/colors.md)                               | [neon](lsd/silkcircuit-neon.yaml) · [vibrant](lsd/silkcircuit-vibrant.yaml) · [soft](lsd/silkcircuit-soft.yaml) · [glow](lsd/silkcircuit-glow.yaml) · [dawn](lsd/silkcircuit-dawn.yaml)                                                                  |
| procs                           | [reference](https://github.com/dalance/procs#configuration)                                        | [neon](procs/silkcircuit-neon.toml) · [vibrant](procs/silkcircuit-vibrant.toml) · [soft](procs/silkcircuit-soft.toml) · [glow](procs/silkcircuit-glow.toml) · [dawn](procs/silkcircuit-dawn.toml)                                                        |
| Slack                           | [reference](https://slack.com/help/articles/205166057-Change-your-Slack-theme)                     | [neon](slack/silkcircuit-neon.txt) · [vibrant](slack/silkcircuit-vibrant.txt) · [soft](slack/silkcircuit-soft.txt) · [glow](slack/silkcircuit-glow.txt) · [dawn](slack/silkcircuit-dawn.txt)                                                             |
| Starship                        | [reference](https://starship.rs/config/#color-palettes)                                            | [neon](starship/silkcircuit-neon.toml) · [vibrant](starship/silkcircuit-vibrant.toml) · [soft](starship/silkcircuit-soft.toml) · [glow](starship/silkcircuit-glow.toml) · [dawn](starship/silkcircuit-dawn.toml)                                         |
| tmux                            | [reference](https://man.openbsd.org/tmux#STYLES)                                                   | [neon](tmux/silkcircuit-neon.conf) · [vibrant](tmux/silkcircuit-vibrant.conf) · [soft](tmux/silkcircuit-soft.conf) · [glow](tmux/silkcircuit-glow.conf) · [dawn](tmux/silkcircuit-dawn.conf)                                                             |
| VS Code                         | [reference](https://code.visualstudio.com/api/extension-guides/color-theme)                        | [neon](vscode/themes/silkcircuit-neon.json) · [vibrant](vscode/themes/silkcircuit-vibrant.json) · [soft](vscode/themes/silkcircuit-soft.json) · [glow](vscode/themes/silkcircuit-glow.json) · [dawn](vscode/themes/silkcircuit-dawn.json)                |
| Warp                            | [reference](https://docs.warp.dev/terminal/appearance/custom-themes)                               | [neon](warp/silkcircuit-neon.yaml) · [vibrant](warp/silkcircuit-vibrant.yaml) · [soft](warp/silkcircuit-soft.yaml) · [glow](warp/silkcircuit-glow.yaml) · [dawn](warp/silkcircuit-dawn.yaml)                                                             |
| WezTerm                         | [reference](https://wezterm.org/config/appearance.html#defining-a-color-scheme-in-a-separate-file) | [neon](wezterm/silkcircuit-neon.toml) · [vibrant](wezterm/silkcircuit-vibrant.toml) · [soft](wezterm/silkcircuit-soft.toml) · [glow](wezterm/silkcircuit-glow.toml) · [dawn](wezterm/silkcircuit-dawn.toml)                                              |
| Windows Terminal                | [reference](https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes)   | [neon](windows-terminal/silkcircuit-neon.json) · [vibrant](windows-terminal/silkcircuit-vibrant.json) · [soft](windows-terminal/silkcircuit-soft.json) · [glow](windows-terminal/silkcircuit-glow.json) · [dawn](windows-terminal/silkcircuit-dawn.json) |
| Windows Terminal (every scheme) | [reference](https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes)   | [every variant](windows-terminal/silkcircuit.json)                                                                                                                                                                                                       |
| Zellij                          | [reference](https://zellij.dev/documentation/themes)                                               | [neon](zellij/silkcircuit-neon.kdl) · [vibrant](zellij/silkcircuit-vibrant.kdl) · [soft](zellij/silkcircuit-soft.kdl) · [glow](zellij/silkcircuit-glow.kdl) · [dawn](zellij/silkcircuit-dawn.kdl)                                                        |
| Zellij (every theme)            | [reference](https://zellij.dev/documentation/themes)                                               | [every variant](zellij/silkcircuit.kdl)                                                                                                                                                                                                                  |

<!-- extras:end -->

```powershell
# fzf for PowerShell
. .\extras\fzf.ps1
```

### 🌐 Chrome Theme (`chrome-theme/`)

Full SilkCircuit browser theming across all five variants.

- **5 variants**: Neon, Vibrant, Soft, Glow, Dawn
- **24 theme color keys**: frame, toolbar, omnibox, tabs, NTP, tab groups
- **Circuit-trace NTP backgrounds**: unique per variant
- **DevTools CSS**: modern CM6 + `--sys-color-*` tokens
- **Chrome pages CSS**: `--cr-*` overrides for internal pages

**Setup:**

```bash
# Generate all variants
make chrome

# Install: chrome://extensions/ → Developer mode → Load unpacked
# Select: extras/chrome-theme/silkcircuit-{neon,vibrant,soft,glow,dawn}/
```

### 💬 Slack Theme (`slack-theme.txt`)

Transform your Slack workspace with SilkCircuit's 4-color themes:

- **Deep purple** navigation (#2E1B7A)
- **Electric purple** for selected items (#E135FF)
- **Neon green** presence indicators (#50FA7B)
- **Hot pink** notifications (#FF79C6)

**Setup:**

```bash
# Open Slack → Preferences → Themes
# Copy hex values from extras/slack-theme.txt
# Click each color circle and paste the corresponding hex value
# Enable "Window gradient" for best effect
```

### 📊 btop Theme (`btop/`)

System monitoring with SilkCircuit style:

- **Electric purple** CPU graphs
- **Neon cyan** memory meters
- **Hot pink** network activity
- **All 5 variants** (Neon, Vibrant, Soft, Glow, Dawn) for different vibes

**Setup:**

```bash
# Copy to btop themes directory
cp extras/btop/silkcircuit_*.theme ~/.config/btop/themes/

# In btop: Esc → Options → Color theme → Select variant
```

### ☸️ K9s Skins (`k9s/`)

Kubernetes dashboard skins in all five variants (`silkcircuit.yaml` plus
`silkcircuit-{vibrant,soft,glow,dawn}.yaml`).

**Setup:**

```bash
cp extras/k9s/silkcircuit*.yaml ~/.config/k9s/skins/
# Then set k9s.ui.skin in ~/.config/k9s/config.yaml, or press :skin in K9s
```

### 🖥️ Ghostty (`ghostty/`)

Native Ghostty themes in all five variants. Each theme has a matching `.css`
file that styles Ghostty's GTK window chrome, meaning the headerbar, tabs, split
dividers, and overlays. The CSS applies on Linux only, where Ghostty uses GTK.

**Setup:**

```bash
mkdir -p ~/.config/ghostty/themes
cp extras/ghostty/silkcircuit-{neon,vibrant,soft,glow,dawn} ~/.config/ghostty/themes/
# Then in ~/.config/ghostty/config:
#   theme = dark:silkcircuit-neon,light:silkcircuit-dawn

# Linux only, for the GTK window chrome:
cp extras/ghostty/silkcircuit-neon.css ~/.config/ghostty/silkcircuit.css
# Then add: gtk-custom-css = ~/.config/ghostty/silkcircuit.css
```

### 🛠️ CLI and System Tools

One config per tool, all drawing on the same palette:

- **Starship** (`starship/silkcircuit-*.toml`) - Prompt with SilkCircuit segments
- **tmux** (`tmux.conf`) - Status line, panes, and window styling
- **lazygit** (`lazygit/config.yml`) - Git TUI colors
- **bat** (`bat/silkcircuit-*.tmTheme`) - Syntax highlighting for `bat` and `delta`
- **Git** (`git/silkcircuit-*.gitconfig`) - Colour slots plus a delta feature block
- **lsd** (`lsd/silkcircuit-*.yaml`) - Directory listing colors
- **atuin** (`atuin/silkcircuit.toml`) - Shell history search
- **procs** (`procs/silkcircuit-*.toml`) - Process viewer columns
- **fastfetch** (`fastfetch/silkcircuit-*.jsonc`) - System info readout
- **dmesg** (`dmesg/*.scheme`) - Kernel log colors, all five variants
- **COSMIC Desktop** (`cosmic/*.ron`) - Desktop theme, all five variants

**Setup:**

```bash
cp extras/starship/silkcircuit-neon.toml ~/.config/starship.toml
cp extras/lazygit/config.yml ~/.config/lazygit/config.yml
cp extras/bat/silkcircuit-neon.tmTheme "$(bat --config-dir)/themes/" && bat cache --build
cp extras/lsd/silkcircuit-neon.yaml ~/.config/lsd/colors.yaml
cp extras/atuin/silkcircuit.toml ~/.config/atuin/themes/
cp extras/procs/silkcircuit-neon.toml ~/.config/procs/config.toml
cp extras/fastfetch/silkcircuit-neon.jsonc ~/.config/fastfetch/config.jsonc
```

### 🎨 Enhanced Tools

Additional tool configurations for the complete experience:

- **Lualine config** (`lualine-config.lua`) - Standalone statusline setup
- **Avante config** (`avante-config.lua`) - Themed avante.nvim AI sidebar
- **FZF integration** (`fzf.sh`, `fzf.ps1`) - Fuzzy finder with SilkCircuit colors

## 🎨 Color Palette Reference

All configurations use these colors to maintain consistency:

| ANSI  | Hex       | Usage                               |
| ----- | --------- | ----------------------------------- |
| `201` | `#ff00ff` | Neon magenta - Primary accents      |
| `213` | `#ff79c6` | Bright magenta - Secondary elements |
| `51`  | `#00ffff` | Electric cyan - Metadata            |
| `220` | `#ffdd00` | Bright yellow - Branch info         |
| `149` | `#50fa7b` | Green - Success/additions           |
| `197` | `#ff5555` | Red - Errors/deletions              |

## 🎯 Quick Setup

Get the full SilkCircuit experience instantly:

```bash
# Clone the theme
git clone https://github.com/hyperb1iss/silkcircuit.git
cd silkcircuit

# Install git colors
mkdir -p ~/.config/git
cp extras/git/silkcircuit-neon.gitconfig ~/.config/git/
git config --global --add include.path ~/.config/git/silkcircuit-neon.gitconfig

# Copy terminal theme (choose your terminal and variant)
cp extras/kitty/silkcircuit-neon.conf ~/.config/kitty/themes/
# OR
cp extras/alacritty/silkcircuit-neon.toml ~/.config/alacritty/themes/

# For AstroNvim users
cp -r extras/astronvim/community.lua extras/astronvim/plugins ~/.config/nvim/lua/
```

## 🌟 Pro Tips

1. **Terminal Setup**: Enable true color support in your terminal for best results
2. **Git Aliases**: Use `git lg` for the beautiful one-line log format
3. **AstroNvim**: Try both default and "maximum effect" Lualine configs
4. **Consistency**: Use matching colors across all tools for cohesive aesthetic

---

_Experience the full SilkCircuit aesthetic across your entire development workflow._
