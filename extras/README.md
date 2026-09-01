# 🌈 SilkCircuit Extras

Everything in this directory is generated from `lua/silkcircuit/variants.lua`
by `make build`, in all five variants, so a color you change in the palette
changes here too on the next build. Files are named
`<target>/silkcircuit-<variant>.<ext>`, where the variant is one of `neon`,
`vibrant`, `soft`, `glow`, or `dawn`. Dawn is light, the rest are dark.

Do not hand-edit a generated file. The next build overwrites it. The colors
live in `lua/silkcircuit/variants.lua` and the mapping to each format lives in
`lua/silkcircuit/extra/<target>.lua`.

The `README.md` inside a target directory is hand-written and survives the
build. Those, and the [per-tool pages](../docs/extras/index.md) on the docs
site, are the authoritative install instructions.

## 🪄 The installer

From the repository root, this detects what you have installed, drops each
theme where its tool looks for it, and prints the line that turns it on:

```bash
./install.sh --dry-run     # see what it would touch
./install.sh               # all five variants, side by side
./install.sh --variant glow
```

```powershell
.\install.ps1 -Variant neon
```

Tools that hold a directory of themes get every selected variant. Tools that
read a single file (lsd, procs, Starship, fastfetch, dircolors, dmesg) get neon
unless `--variant` says otherwise. Anything replaced is copied to
`*.silkcircuit.bak` first.

## 📁 Generated targets

<!-- extras:start -->

| Target                          | Format                                                                                             | Generated files                                                                                                                                                                                                                                          |
| ------------------------------- | -------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Alacritty                       | [reference](https://alacritty.org/config-alacritty.html#colors)                                    | [neon](alacritty/silkcircuit-neon.toml) · [vibrant](alacritty/silkcircuit-vibrant.toml) · [soft](alacritty/silkcircuit-soft.toml) · [glow](alacritty/silkcircuit-glow.toml) · [dawn](alacritty/silkcircuit-dawn.toml)                                    |
| Atuin                           | [reference](https://github.com/atuinsh/atuin/blob/main/crates/atuin-client/src/theme.rs)           | [neon](atuin/silkcircuit-neon.toml) · [vibrant](atuin/silkcircuit-vibrant.toml) · [soft](atuin/silkcircuit-soft.toml) · [glow](atuin/silkcircuit-glow.toml) · [dawn](atuin/silkcircuit-dawn.toml)                                                        |
| bat                             | [reference](https://github.com/sharkdp/bat#adding-new-themes)                                      | [neon](bat/silkcircuit-neon.tmTheme) · [vibrant](bat/silkcircuit-vibrant.tmTheme) · [soft](bat/silkcircuit-soft.tmTheme) · [glow](bat/silkcircuit-glow.tmTheme) · [dawn](bat/silkcircuit-dawn.tmTheme)                                                   |
| btop                            | [reference](https://github.com/aristocratos/btop#themes)                                           | [neon](btop/silkcircuit-neon.theme) · [vibrant](btop/silkcircuit-vibrant.theme) · [soft](btop/silkcircuit-soft.theme) · [glow](btop/silkcircuit-glow.theme) · [dawn](btop/silkcircuit-dawn.theme)                                                        |
| COSMIC Desktop                  | [reference](https://github.com/pop-os/cosmic-theme)                                                | [neon](cosmic/silkcircuit-neon.ron) · [vibrant](cosmic/silkcircuit-vibrant.ron) · [soft](cosmic/silkcircuit-soft.ron) · [glow](cosmic/silkcircuit-glow.ron) · [dawn](cosmic/silkcircuit-dawn.ron)                                                        |
| GNU dircolors                   | [reference](https://man7.org/linux/man-pages/man1/dircolors.1.html)                                | [neon](dircolors/silkcircuit-neon.dircolors) · [vibrant](dircolors/silkcircuit-vibrant.dircolors) · [soft](dircolors/silkcircuit-soft.dircolors) · [glow](dircolors/silkcircuit-glow.dircolors) · [dawn](dircolors/silkcircuit-dawn.dircolors)           |
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
| Slack                           | [reference](https://slack.com/help/articles/205166337-Change-your-Slack-theme)                     | [neon](slack/silkcircuit-neon.txt) · [vibrant](slack/silkcircuit-vibrant.txt) · [soft](slack/silkcircuit-soft.txt) · [glow](slack/silkcircuit-glow.txt) · [dawn](slack/silkcircuit-dawn.txt)                                                             |
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

## 🔮 Setup by hand

The [extras guide](../docs/extras/index.md) carries a page per tool with the
install path, the enable line, and the version floor where one matters. The
short version:

```bash
# Terminals: a directory of themes each
cp kitty/silkcircuit-*.conf ~/.config/kitty/themes/          # include themes/silkcircuit-neon.conf
cp alacritty/silkcircuit-*.toml ~/.config/alacritty/themes/  # [general] import = [...]
cp ghostty/silkcircuit-neon ~/.config/ghostty/themes/        # theme = silkcircuit-neon
cp wezterm/silkcircuit-*.toml ~/.config/wezterm/colors/      # config.color_scheme = "SilkCircuit Neon"
cp warp/silkcircuit-*.yaml ~/.warp/themes/                   # Settings, Appearance, Themes
cp foot/silkcircuit-*.ini ~/.config/foot/                    # include=~/.config/foot/silkcircuit-neon.ini

# Multiplexers
cp tmux/silkcircuit-*.conf ~/.config/tmux/                   # source-file ~/.config/tmux/silkcircuit-neon.conf
cp zellij/silkcircuit-*.kdl ~/.config/zellij/themes/         # theme "silkcircuit-neon"

# Editors and TUIs
cp helix/silkcircuit-*.toml ~/.config/helix/themes/          # theme = "silkcircuit-neon"
cp btop/silkcircuit-*.theme ~/.config/btop/themes/           # Esc, Options, Color theme
cp k9s/silkcircuit-*.yaml ~/.config/k9s/skins/               # k9s.ui.skin: silkcircuit-neon
cp atuin/silkcircuit-*.toml ~/.config/atuin/themes/          # [theme] name = "silkcircuit-neon"
cp lazygit/silkcircuit-*.yml ~/.config/lazygit/              # merge the gui.theme block
cp fzf/silkcircuit-*.sh ~/.config/fzf/                       # source ~/.config/fzf/silkcircuit-neon.sh
cp bat/silkcircuit-*.tmTheme "$(bat --config-dir)/themes/" && bat cache --build

# One config slot each, so pick a variant
cp lsd/silkcircuit-neon.yaml ~/.config/lsd/colors.yaml       # plus color: theme: custom
cp procs/silkcircuit-neon.toml ~/.config/procs/config.toml
cp starship/silkcircuit-neon.toml ~/.config/starship.toml
cp fastfetch/silkcircuit-neon.jsonc ~/.config/fastfetch/config.jsonc
cp dircolors/silkcircuit-neon.dircolors ~/.dircolors
cp dmesg/silkcircuit-neon.scheme ~/.config/terminal-colors.d/dmesg.scheme

# Git: copy and include, so your own .gitconfig stays yours
mkdir -p ~/.config/git
cp git/silkcircuit-neon.gitconfig ~/.config/git/
git config --global --add include.path ~/.config/git/silkcircuit-neon.gitconfig
```

### 🖥️ Imported rather than copied

iTerm2, COSMIC Desktop, and Windows Terminal have no drop-in directory, so
their files get imported or pasted. Slack takes one comma-separated line, which
is the last line of `slack/silkcircuit-<variant>.txt`. See
[iTerm2](../docs/extras/iterm2.md), [COSMIC](../docs/extras/cosmic.md),
[Windows Terminal](../docs/extras/windows-terminal.md), and
[Slack](../docs/extras/slack.md).

### 🌐 Chrome

`chrome-theme/` is generated separately by `make chrome`, which reads the JSON
in `palette/`. Load a variant unpacked from
`chrome-theme/silkcircuit-<variant>/` at `chrome://extensions/` with Developer
mode on. Full details in [chrome-theme/README.md](chrome-theme/README.md).

### 🛸 AstroNvim and the Neovim helpers

```bash
cp -r astronvim/community.lua astronvim/plugins ~/.config/nvim/lua/
```

`lualine-config.lua` and `avante-config.lua` are hand-written examples rather
than generated targets: a standalone lualine setup and a themed avante.nvim
sidebar. Copy the parts you want into your own config.

## 🎨 Color reference

`palette/silkcircuit-<variant>.json` is the authoritative list: every color as
hex, RGB, and HSL, with the sixteen ANSI slots under the `terminal` key. The
same directory carries base16 and base24 scheme files for
[tinted-theming](https://github.com/tinted-theming/home) builders such as tinty
and stylix.

---

_Experience the full SilkCircuit aesthetic across your entire development workflow._
