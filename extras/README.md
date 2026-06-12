# 🌈 SilkCircuit Extras

Complete your neon-lit development environment with these additional configurations that perfectly complement the SilkCircuit theme.

## 📁 What's Included

### 🚀 AstroNvim Integration (`astronvim/`)

Complete AstroNvim setup with SilkCircuit styling:

- **Full AstroUI configuration** with neon-enhanced components
- **Custom Lualine theme** with electric visual elements
- **Neo-tree styling** with vibrant file icons
- **Community integration** setup files
- **Maximum effect mode** for the boldest experience

**Setup:**

```bash
# Copy all AstroNvim configs
cp -r extras/astronvim/* ~/.config/nvim/lua/
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

Full SilkCircuit browser theming:all 5 variants:

- **5 variants**:Neon, Vibrant, Soft, Glow, Dawn
- **24 theme color keys**:frame, toolbar, omnibox, tabs, NTP, tab groups
- **Circuit-trace NTP backgrounds**:unique per variant
- **DevTools CSS**:modern CM6 + `--sys-color-*` tokens
- **Chrome pages CSS**:`--cr-*` overrides for internal pages

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
# Copy hex values from slack-theme-simple.txt
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
cp btop/silkcircuit_*.theme ~/.config/btop/themes/

# In btop: Esc → Options → Color theme → Select variant
```

### 🎨 Enhanced Tools

Additional tool configurations for the complete experience:

- **Lualine config** (`lualine-config.lua`) - Standalone statusline setup
- **FZF integration** (`fzf.sh`) - Fuzzy finder with SilkCircuit colors

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
cp -r extras/astronvim/* ~/.config/nvim/lua/
```

## 🌟 Pro Tips

1. **Terminal Setup**: Enable true color support in your terminal for best results
2. **Git Aliases**: Use `git lg` for the beautiful one-line log format
3. **AstroNvim**: Try both default and "maximum effect" Lualine configs
4. **Consistency**: Use matching colors across all tools for cohesive aesthetic

---

_Experience the full SilkCircuit aesthetic across your entire development workflow._
