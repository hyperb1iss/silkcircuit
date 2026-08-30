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
# Option 1: Include in your existing .gitconfig
echo "[include]" >> ~/.gitconfig
echo "    path = $(pwd)/extras/gitconfig" >> ~/.gitconfig

# Option 2: Copy the relevant sections manually
cat extras/gitconfig >> ~/.gitconfig
```

### 🖥️ Terminal Themes

Native theme files for popular terminal emulators (dark + dawn light variants):

- **Alacritty** (`alacritty.yml`, `alacritty-dawn.yml`) - Fast GPU-accelerated terminal
- **Kitty** (`kitty.conf`, `kitty-dawn.conf`) - Feature-rich terminal emulator
- **Warp** (`warp.yaml`, `warp-dawn.yaml`) - Modern terminal with AI features
- **Windows Terminal** (`windows-terminal.json`) - Windows integrated terminal

**Setup:**

```bash
# Alacritty (dark)
cp extras/alacritty.yml ~/.config/alacritty/themes/silkcircuit.yml
# Alacritty (dawn/light)
cp extras/alacritty-dawn.yml ~/.config/alacritty/themes/silkcircuit-dawn.yml

# Kitty (dark)
cp extras/kitty.conf ~/.config/kitty/themes/silkcircuit.conf
# Kitty (dawn/light)
cp extras/kitty-dawn.conf ~/.config/kitty/themes/silkcircuit-dawn.conf

# Warp (dark)
cp extras/warp.yaml ~/.warp/themes/silkcircuit.yaml
# Warp (dawn/light)
cp extras/warp-dawn.yaml ~/.warp/themes/silkcircuit-dawn.yaml

# Windows Terminal - import JSON manually in settings
```

```powershell
# Windows Terminal - stage JSON for import
New-Item -ItemType Directory -Force "$env:APPDATA\silkcircuit"
Copy-Item extras\windows-terminal.json "$env:APPDATA\silkcircuit\windows-terminal.json"

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

- **Starship** (`starship/starship.toml`) - Prompt with SilkCircuit segments
- **tmux** (`tmux.conf`) - Status line, panes, and window styling
- **lazygit** (`lazygit/config.yml`) - Git TUI colors
- **bat** (`bat/SilkCircuit.tmTheme`, `bat/config`) - Syntax highlighting for `bat`
- **lsd** (`lsd/colors.yaml`, `lsd/config.yaml`) - Directory listing colors
- **atuin** (`atuin/silkcircuit.toml`) - Shell history search
- **procs** (`procs/config.toml`) - Process viewer columns
- **fastfetch** (`fastfetch/config.jsonc`) - System info readout
- **dmesg** (`dmesg/*.scheme`) - Kernel log colors, all five variants
- **COSMIC Desktop** (`cosmic/*.ron`) - Desktop theme, all five variants

**Setup:**

```bash
cp extras/starship/starship.toml ~/.config/starship.toml
cp extras/lazygit/config.yml ~/.config/lazygit/config.yml
cp extras/bat/SilkCircuit.tmTheme "$(bat --config-dir)/themes/" && bat cache --build
cp extras/lsd/*.yaml ~/.config/lsd/
cp extras/atuin/silkcircuit.toml ~/.config/atuin/themes/
cp extras/procs/config.toml ~/.config/procs/config.toml
cp extras/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
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
cat extras/gitconfig >> ~/.gitconfig

# Copy terminal theme (choose your terminal)
cp extras/kitty.conf ~/.config/kitty/themes/silkcircuit.conf
# OR
cp extras/alacritty.yml ~/.config/alacritty/themes/silkcircuit.yml

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
