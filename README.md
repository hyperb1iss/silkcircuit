# 💜⚡ SilkCircuit: Electric Meets Elegant

<div align="center">

[![Theme](https://img.shields.io/badge/Design_System-SilkCircuit-e135ff?style=for-the-badge&logo=paintbrush&logoColor=white)](https://github.com/hyperb1iss/silkcircuit)
[![Docs](https://img.shields.io/badge/Docs-silkcircuit-80ffea?style=for-the-badge&logo=readthedocs&logoColor=white)](https://hyperb1iss.github.io/silkcircuit/)
[![WCAG](https://img.shields.io/badge/WCAG%20AA-Compliant-50fa7b?style=for-the-badge&logo=accessibility&logoColor=white)](https://www.w3.org/WAI/WCAG21/quickref/)
[![License](https://img.shields.io/badge/License-MIT-ff79c6?style=for-the-badge&logo=opensourceinitiative&logoColor=white)](https://opensource.org/licenses/MIT)

[![Neovim](https://img.shields.io/badge/Neovim%200.10+-e135ff.svg?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![VSCode](https://img.shields.io/badge/VS_Code-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white)](https://marketplace.visualstudio.com/items?itemName=hyperb1iss.silkcircuit-theme)
[![Chrome](https://img.shields.io/badge/Chrome-4285F4?style=for-the-badge&logo=googlechrome&logoColor=white)](https://chromewebstore.google.com/)

🌌 _A vibrant cyberpunk color system for your entire dev environment._ 🎆

[⚡ Quick Start](#-quick-start) · [💜 Neovim](#-neovim) · [🎨 Variants](#-variants) · [🌃 Full Ecosystem](#-full-ecosystem) · [📖 Documentation](https://hyperb1iss.github.io/silkcircuit/)

</div>

<div align="center">
  <img src="assets/silkcircuit-lockup-banner.png" alt="SilkCircuit" width="80%">
</div>

<br>

<div align="center">
  <img src="assets/screenshots/nvim-neotree.png" alt="SilkCircuit in Neovim with Neo-tree" width="90%">
</div>

## 🎭 What Is SilkCircuit?

One palette, one semantic system, five intensity variants, every tool in your workflow. SilkCircuit themes editors, terminals, browsers, system monitors, and CLI tools with consistent colors and WCAG AA contrast ratios across the board.

### 🌐 Platforms

| Category         | Targets                                                            |
| ---------------- | ------------------------------------------------------------------ |
| 💻 **Editors**   | Neovim (25+ plugin integrations), VS Code (Marketplace), AstroNvim |
| 🖥️ **Terminals** | Ghostty, Kitty, Alacritty, Warp, Windows Terminal                  |
| 🌐 **Browsers**  | Chrome (Web Store, 5 variants + DevTools CSS)                      |
| 🔧 **CLI Tools** | btop, K9s, lazygit, bat, fzf, lsd, procs, atuin, Starship          |
| ⚙️ **System**    | COSMIC Desktop, fastfetch, dmesg, tmux                             |
| 🎯 **Other**     | Git (delta integration), Slack, Lualine                            |

### 🎛️ Variants

Five intensity levels, all using the same underlying palette:

| Variant        | Style                       | Best For               |
| -------------- | --------------------------- | ---------------------- |
| ⚡ **Neon**    | 100% saturated              | Maximum vibrancy       |
| 🔮 **Vibrant** | 85% intensity               | Balanced energy        |
| 🌸 **Soft**    | 70% intensity               | Extended sessions      |
| 🌌 **Glow**    | Ultra-dark bg, pure neon fg | Low-light / OLED       |
| 🌅 **Dawn**    | Light theme                 | Daytime & bright rooms |

## 🪄 Quick Start

### ⚡ Universal Installer

The fastest way to theme everything at once. Detects your installed tools and applies matching SilkCircuit configs with backups:

```bash
git clone https://github.com/hyperb1iss/silkcircuit.git
cd silkcircuit
./install.sh
```

```powershell
git clone https://github.com/hyperb1iss/silkcircuit.git
cd silkcircuit
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### 🎯 Individual Platforms

Pick what you need:

<details open>
<summary><b>🔮 Neovim</b> (lazy.nvim)</summary>

```lua
{
  "hyperb1iss/silkcircuit",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("silkcircuit")
  end,
}
```

</details>

<details>
<summary><b>📦 Neovim</b> (packer.nvim)</summary>

```lua
use {
  "hyperb1iss/silkcircuit",
  config = function()
    vim.cmd("colorscheme silkcircuit")
  end
}
```

</details>

<details>
<summary><b>🔌 Neovim</b> (vim-plug)</summary>

```vim
Plug 'hyperb1iss/silkcircuit'
colorscheme silkcircuit
```

</details>

<details>
<summary><b>💎 VS Code</b></summary>

Install from the [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=hyperb1iss.silkcircuit-theme), or:

```bash
code --install-extension hyperb1iss.silkcircuit-theme
```

</details>

<details>
<summary><b>🌐 Chrome</b></summary>

Available on the Chrome Web Store (all 5 variants), or load unpacked:

```bash
make chrome
# chrome://extensions/ → Developer mode → Load unpacked
# Select: extras/chrome-theme/silkcircuit-{variant}/
```

</details>

<details>
<summary><b>🖥️ Terminals</b></summary>

Every terminal ships all five variants, rendered from the same palette Neovim
uses. The [terminal guide](docs/extras/terminals.md) has the install line for
each one.

<!-- extras:start -->

| Target    | Format                                                          | Generated files                                                                                                                                                                                                                                          |
| --------- | --------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Alacritty | [reference](https://alacritty.org/config-alacritty.html#colors) | [neon](extras/alacritty/silkcircuit-neon.toml) · [vibrant](extras/alacritty/silkcircuit-vibrant.toml) · [soft](extras/alacritty/silkcircuit-soft.toml) · [glow](extras/alacritty/silkcircuit-glow.toml) · [dawn](extras/alacritty/silkcircuit-dawn.toml) |
| Kitty     | [reference](https://sw.kovidgoyal.net/kitty/conf/#color-scheme) | [neon](extras/kitty/silkcircuit-neon.conf) · [vibrant](extras/kitty/silkcircuit-vibrant.conf) · [soft](extras/kitty/silkcircuit-soft.conf) · [glow](extras/kitty/silkcircuit-glow.conf) · [dawn](extras/kitty/silkcircuit-dawn.conf)                     |

<!-- extras:end -->

</details>

<details>
<summary><b>🔧 CLI Tools</b></summary>

```bash
# btop (5 variants)
cp extras/btop/silkcircuit_*.theme ~/.config/btop/themes/

# K9s (5 variants)
cp extras/k9s/silkcircuit*.yaml ~/.config/k9s/skins/

# Git colors with delta integration
cat extras/gitconfig >> ~/.gitconfig

# fzf
source extras/fzf.sh  # or add to .zshrc/.bashrc

# Starship prompt
cp extras/starship/starship.toml ~/.config/starship.toml
```

```powershell
# fzf
. .\extras\fzf.ps1

# Starship prompt
New-Item -ItemType Directory -Force "$HOME\.config"
Copy-Item extras\starship\starship.toml "$HOME\.config\starship.toml"
```

</details>

## 💜 Neovim

The Neovim theme is the most feature-rich target: it loads in about 5ms with every one of its 29 plugin integrations defined up front, and it remembers your variant across sessions.

<div align="center">
  <img src="assets/screenshots/nvim-telescope.png" alt="Telescope integration" width="85%">
</div>

### 🎪 Configuration

```lua
require("silkcircuit").setup({
  transparent = false,
  terminal_colors = true,
  dim_inactive = false,
  variant = "neon",       -- "neon" | "vibrant" | "soft" | "glow" | "dawn"

  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true, italic = true },
    variables = {},
    strings = { italic = true },
  },

  integrations = {
    telescope = true,     -- all auto-detected by default
    neotree = true,
    notify = true,
    cmp = true,
    mini = true,
  },
})
```

### 🔮 Plugin Support

All integrations activate automatically when plugins are detected.

- 🎯 **Core**: Telescope, Neo-tree, LSP, Treesitter, nvim-cmp, Mason
- 🏃 **Navigation**: Flash, Harpoon, Which-Key, Mini.jump
- 🔧 **Git & Dev**: Gitsigns, Neogit, DAP
- 💎 **UI**: Lualine, BufferLine, Notify, Noice, Alpha, Indent Blankline, Rainbow Delimiters

### 🛸 AstroNvim

```lua
return {
  "AstroNvim/astrocommunity",
  { "hyperb1iss/silkcircuit", name = "silkcircuit" },
}
```

### 🎮 Commands

| Command                    | Description                                  |
| -------------------------- | -------------------------------------------- |
| `:SilkCircuit {variant}`   | Switch variant (neon/vibrant/soft/glow/dawn) |
| `:SilkCircuitContrast`     | Check WCAG contrast compliance               |
| `:SilkCircuitGlow`         | Toggle glow mode (on/off/toggle)             |
| `:SilkCircuitIntegrations` | Show detected plugin integrations            |
| `:checkhealth silkcircuit` | Run diagnostics                              |

## 🌃 Full Ecosystem

SilkCircuit extends far beyond your editor. See [extras/README.md](extras/README.md) for setup instructions for every supported tool.

### 🎨 Color Palette

| Color              | Hex       | Usage                                                                              |
| ------------------ | --------- | ---------------------------------------------------------------------------------- |
| Background         | `#0a0a0f` | ![#0a0a0f](https://placehold.co/20x20/0a0a0f/0a0a0f.png)                           |
| Foreground         | `#e0e0e0` | ![#e0e0e0](https://placehold.co/20x20/e0e0e0/e0e0e0.png)                           |
| 💜 Electric Purple | `#e135ff` | ![#e135ff](https://placehold.co/20x20/e135ff/e135ff.png) Keywords, primary accents |
| 🌸 Hot Pink        | `#ff79c6` | ![#ff79c6](https://placehold.co/20x20/ff79c6/ff79c6.png) Strings, secondary        |
| 💎 Neon Cyan       | `#80ffea` | ![#80ffea](https://placehold.co/20x20/80ffea/80ffea.png) Functions, links          |
| ✅ Success Green   | `#50fa7b` | ![#50fa7b](https://placehold.co/20x20/50fa7b/50fa7b.png) Success states            |
| ⚡ Electric Yellow | `#f1fa8c` | ![#f1fa8c](https://placehold.co/20x20/f1fa8c/f1fa8c.png) Warnings, variables       |
| 🧡 Warm Orange     | `#ffb86c` | ![#ffb86c](https://placehold.co/20x20/ffb86c/ffb86c.png) Numbers, constants        |

## 📸 Screenshot Gallery

<details open>
<summary><b>Neovim</b></summary>
<br>

|                                  Syntax Highlighting                                  |                                         Theme Highlights                                          |
| :-----------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------: |
| <img src="assets/screenshots/nvim-lua.png" alt="Lua syntax highlighting" width="400"> | <img src="assets/screenshots/nvim-theme-highlights.png" alt="Theme highlight groups" width="400"> |

</details>

<details open>
<summary><b>Terminal & CLI Tools</b></summary>
<br>

|                               lazygit                                |                                     btop                                      |
| :------------------------------------------------------------------: | :---------------------------------------------------------------------------: |
| <img src="assets/screenshots/lazygit.png" alt="lazygit" width="400"> | <img src="assets/screenshots/btop.png" alt="btop system monitor" width="400"> |

|                                    bat                                     |                                      fzf                                      |
| :------------------------------------------------------------------------: | :---------------------------------------------------------------------------: |
| <img src="assets/screenshots/bat.png" alt="bat syntax viewer" width="400"> | <img src="assets/screenshots/fzf.png" alt="fzf with bat preview" width="400"> |

|                               git log                                |                                    delta                                     |
| :------------------------------------------------------------------: | :--------------------------------------------------------------------------: |
| <img src="assets/screenshots/git-log.png" alt="git log" width="400"> | <img src="assets/screenshots/delta.png" alt="delta diff viewer" width="400"> |

|                                      lsd                                       |                                      procs                                      |
| :----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: |
| <img src="assets/screenshots/lsd.png" alt="lsd directory listing" width="400"> | <img src="assets/screenshots/procs.png" alt="procs process viewer" width="400"> |

|                                      fastfetch                                       |
| :----------------------------------------------------------------------------------: |
| <img src="assets/screenshots/fastfetch.png" alt="fastfetch system info" width="400"> |

</details>

## 🛠️ Troubleshooting

**🤔 Neovim theme not loading?** Requires Neovim 0.10+ with `vim.opt.termguicolors = true`. Run `:checkhealth silkcircuit`.

**🎭 Colors look wrong?** Your terminal must support true colors (24-bit). Try a different terminal emulator if unsure.

**🏎️ Performance issues?** Set `vim.g.silkcircuit_debug = true` and restart to print the measured load time. Anything well over 5ms is worth an issue with your plugin list.

**💭 Need help?** [Open an issue](https://github.com/hyperb1iss/silkcircuit/issues) with your config and error output.

## 💖 Contributing

```bash
git clone https://github.com/hyperb1iss/silkcircuit.git
cd silkcircuit
make setup    # install dev dependencies
make test     # run unit tests
make lint     # check code quality
```

See [STYLE_GUIDE.md](STYLE_GUIDE.md) for the entire SilkCircuit design language.

## 📜 License

MIT License. See [LICENSE](LICENSE) for details.

---

<div align="center">

If you love SilkCircuit, [buy me a Monster Ultra Violet ⚡](https://ko-fi.com/hyperb1iss)

✦ Built with obsession by <a href="https://hyperbliss.tech"><strong>Hyperbliss Technologies</strong></a> ✦

</div>
