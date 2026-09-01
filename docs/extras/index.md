# Extras and Integrations

SilkCircuit is one palette wearing thirty different formats. The themes under
`extras/` are generated from `lua/silkcircuit/variants.lua` by `make build`, in
all five variants, so the hex your terminal draws is the hex your editor draws
and CI fails if the two drift apart. The Chrome themes come from `make chrome`,
which reads the same palette as JSON, and each target's `README.md` is written
by hand. The full pipeline, and why it works this way, is on
[How It's Built](/guide/architecture).

Dawn is the light variant. Neon, vibrant, soft, and glow are dark.

## Install everything at once

The installer detects what you have, drops each theme where its tool looks for
it, and prints the one line that turns it on.

```bash
git clone https://github.com/hyperb1iss/silkcircuit.git
cd silkcircuit

./install.sh --dry-run     # see what it would touch
./install.sh               # all five variants, side by side
./install.sh --variant glow
```

```powershell
.\install.ps1 -Variant neon
```

Anything it overwrites is copied to `*.silkcircuit.bak` first, and it refuses
to add untracked files to a dotfiles repo it does not own. Tools that read a
single file rather than a directory of themes (lsd, procs, Starship,
fastfetch, dmesg) take neon unless `--variant` says otherwise.

## Editors

| Extra                             | What it covers                                |
| --------------------------------- | --------------------------------------------- |
| [VS Code](/extras/vscode)         | Five themes in one extension                  |
| [Helix](/extras/helix)            | Syntax, markup, diffs, diagnostics, interface |
| [AstroNvim](/extras/astronvim)    | A complete AstroNvim configuration            |
| [Neovim Plugins](/extras/plugins) | The flagship theme's plugin integrations      |

## Terminals

The [terminal guide](/extras/terminals) has the install path and enable line
for all eight in one table, plus the ANSI contract they share.

[Kitty](/extras/kitty) · [Alacritty](/extras/alacritty) ·
[Ghostty](/extras/ghostty) · [WezTerm](/extras/wezterm) ·
[Warp](/extras/warp) · [foot](/extras/foot) · [iTerm2](/extras/iterm2) ·
[Windows Terminal](/extras/windows-terminal)

## Multiplexers

| Extra                    | Turn it on                                         |
| ------------------------ | -------------------------------------------------- |
| [tmux](/extras/tmux)     | `source-file ~/.config/tmux/silkcircuit-neon.conf` |
| [Zellij](/extras/zellij) | `theme "silkcircuit-neon"`                         |

## Shell and CLI

| Extra                          | Turn it on                                           |
| ------------------------------ | ---------------------------------------------------- |
| [Starship](/extras/starship)   | Copy to `~/.config/starship.toml`                    |
| [fzf](/extras/fzf)             | `source ~/.config/fzf/silkcircuit-neon.sh`           |
| [bat](/extras/bat)             | `--theme=silkcircuit-neon`, then `bat cache --build` |
| [lsd](/extras/lsd)             | `color: theme: custom`                               |
| [procs](/extras/procs)         | Copy to `~/.config/procs/config.toml`                |
| [fastfetch](/extras/fastfetch) | Copy to `~/.config/fastfetch/config.jsonc`           |
| [Atuin](/extras/atuin)         | `[theme] name = "silkcircuit-neon"`                  |

## Git

| Extra                      | Turn it on                                      |
| -------------------------- | ----------------------------------------------- |
| [Git](/extras/git)         | `git config --global --add include.path <file>` |
| [lazygit](/extras/lazygit) | Merge the `gui.theme` block into your config    |

## System and desktop

| Extra                            | Turn it on                                 |
| -------------------------------- | ------------------------------------------ |
| [btop](/extras/btop)             | Esc, Options, Color theme                  |
| [k9s](/extras/k9s)               | `k9s.ui.skin: silkcircuit-neon`            |
| [dmesg](/extras/dmesg)           | `~/.config/terminal-colors.d/dmesg.scheme` |
| [COSMIC Desktop](/extras/cosmic) | Settings, Desktop, Appearance, Import      |

## Apps

| Extra                    | Turn it on                                                 |
| ------------------------ | ---------------------------------------------------------- |
| [Chrome](/extras/chrome) | Load unpacked from `extras/chrome-theme/silkcircuit-neon/` |
| [Slack](/extras/slack)   | Paste the line into a custom theme                         |

## Every generated file

Regenerate the lot with `make build`, and this table with `make docs`.

<!-- extras:start -->

| Target                          | Format                                                                                             | Generated files                                                          |
| ------------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| Alacritty                       | [reference](https://alacritty.org/config-alacritty.html#colors)                                    | `extras/alacritty/silkcircuit-{neon,vibrant,soft,glow,dawn}.toml`        |
| Atuin                           | [reference](https://github.com/atuinsh/atuin/blob/main/crates/atuin-client/src/theme.rs)           | `extras/atuin/silkcircuit-{neon,vibrant,soft,glow,dawn}.toml`            |
| bat                             | [reference](https://github.com/sharkdp/bat#adding-new-themes)                                      | `extras/bat/silkcircuit-{neon,vibrant,soft,glow,dawn}.tmTheme`           |
| btop                            | [reference](https://github.com/aristocratos/btop#themes)                                           | `extras/btop/silkcircuit-{neon,vibrant,soft,glow,dawn}.theme`            |
| COSMIC Desktop                  | [reference](https://github.com/pop-os/cosmic-theme)                                                | `extras/cosmic/silkcircuit-{neon,vibrant,soft,glow,dawn}.ron`            |
| GNU dircolors                   | [reference](https://www.gnu.org/software/coreutils/manual/html_node/dircolors-invocation.html)     | `extras/dircolors/silkcircuit-{neon,vibrant,soft,glow,dawn}.dircolors`   |
| dmesg                           | [reference](https://www.man7.org/linux/man-pages/man5/terminal-colors.d.5.html)                    | `extras/dmesg/silkcircuit-{neon,vibrant,soft,glow,dawn}.scheme`          |
| fastfetch                       | [reference](https://github.com/fastfetch-cli/fastfetch/wiki/Configuration)                         | `extras/fastfetch/silkcircuit-{neon,vibrant,soft,glow,dawn}.jsonc`       |
| foot                            | [reference](https://codeberg.org/dnkl/foot/src/branch/master/doc/foot.ini.5.scd)                   | `extras/foot/silkcircuit-{neon,vibrant,soft,glow,dawn}.ini`              |
| fzf                             | [reference](https://github.com/junegunn/fzf/blob/master/man/man1/fzf.1)                            | `extras/fzf/silkcircuit-{neon,vibrant,soft,glow,dawn}.sh`                |
| fzf (PowerShell)                | [reference](https://github.com/junegunn/fzf/blob/master/man/man1/fzf.1)                            | `extras/fzf/silkcircuit-{neon,vibrant,soft,glow,dawn}.ps1`               |
| Ghostty                         | [reference](https://ghostty.org/docs/config/reference#theme)                                       | `extras/ghostty/silkcircuit-{neon,vibrant,soft,glow,dawn}`               |
| Ghostty GTK chrome              | [reference](https://ghostty.org/docs/config/reference#gtk-custom-css)                              | `extras/ghostty/silkcircuit-{neon,vibrant,soft,glow,dawn}.css`           |
| Git                             | [reference](https://git-scm.com/docs/git-config#Documentation/git-config.txt-color)                | `extras/git/silkcircuit-{neon,vibrant,soft,glow,dawn}.gitconfig`         |
| Helix                           | [reference](https://docs.helix-editor.com/themes.html)                                             | `extras/helix/silkcircuit-{neon,vibrant,soft,glow,dawn}.toml`            |
| iTerm2                          | [reference](https://iterm2.com/documentation-preferences-profiles-colors.html)                     | `extras/iterm2/silkcircuit-{neon,vibrant,soft,glow,dawn}.itermcolors`    |
| k9s                             | [reference](https://k9scli.io/topics/skins/)                                                       | `extras/k9s/silkcircuit-{neon,vibrant,soft,glow,dawn}.yaml`              |
| Kitty                           | [reference](https://sw.kovidgoyal.net/kitty/conf/#color-scheme)                                    | `extras/kitty/silkcircuit-{neon,vibrant,soft,glow,dawn}.conf`            |
| lazygit                         | [reference](https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md#color-attributes)  | `extras/lazygit/silkcircuit-{neon,vibrant,soft,glow,dawn}.yml`           |
| lsd                             | [reference](https://github.com/lsd-rs/lsd/blob/master/doc/colors.md)                               | `extras/lsd/silkcircuit-{neon,vibrant,soft,glow,dawn}.yaml`              |
| procs                           | [reference](https://github.com/dalance/procs#configuration)                                        | `extras/procs/silkcircuit-{neon,vibrant,soft,glow,dawn}.toml`            |
| Slack                           | [reference](https://slack.com/help/articles/205166337-Change-your-Slack-theme)                     | `extras/slack/silkcircuit-{neon,vibrant,soft,glow,dawn}.txt`             |
| Starship                        | [reference](https://starship.rs/config/#color-palettes)                                            | `extras/starship/silkcircuit-{neon,vibrant,soft,glow,dawn}.toml`         |
| tmux                            | [reference](https://man.openbsd.org/tmux#STYLES)                                                   | `extras/tmux/silkcircuit-{neon,vibrant,soft,glow,dawn}.conf`             |
| VS Code                         | [reference](https://code.visualstudio.com/api/extension-guides/color-theme)                        | `extras/vscode/themes/silkcircuit-{neon,vibrant,soft,glow,dawn}.json`    |
| Warp                            | [reference](https://docs.warp.dev/terminal/appearance/custom-themes)                               | `extras/warp/silkcircuit-{neon,vibrant,soft,glow,dawn}.yaml`             |
| WezTerm                         | [reference](https://wezterm.org/config/appearance.html#defining-a-color-scheme-in-a-separate-file) | `extras/wezterm/silkcircuit-{neon,vibrant,soft,glow,dawn}.toml`          |
| Windows Terminal                | [reference](https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes)   | `extras/windows-terminal/silkcircuit-{neon,vibrant,soft,glow,dawn}.json` |
| Windows Terminal (every scheme) | [reference](https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes)   | `extras/windows-terminal/silkcircuit.json`                               |
| Zellij                          | [reference](https://zellij.dev/documentation/themes)                                               | `extras/zellij/silkcircuit-{neon,vibrant,soft,glow,dawn}.kdl`            |
| Zellij (every theme)            | [reference](https://zellij.dev/documentation/themes)                                               | `extras/zellij/silkcircuit.kdl`                                          |

<!-- extras:end -->

## Color consistency

The palette files (`palette/silkcircuit-<variant>.json`) are the authoritative
list: every color as
hex, RGB, and HSL, with the sixteen ANSI slots under the `terminal` key. The
same directory carries base16 and base24 scheme files for
[tinted-theming](https://github.com/tinted-theming/home) builders such as tinty
and stylix, which covers targets SilkCircuit does not generate directly.

Nothing is retuned per tool. A color that reads as purple in Neovim reads as
the same purple in btop, and changing it in one place changes it everywhere on
the next `make build`.
