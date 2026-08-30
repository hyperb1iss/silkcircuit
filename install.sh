#!/usr/bin/env bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# SilkCircuit Universal Installer
# Detect installed apps and theme everything in neon
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -euo pipefail

# ─── Color codes ─────────────────────────────────────────────────────────────
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
PURPLE='\033[38;2;225;53;255m'
CYAN='\033[38;2;128;255;234m'
PINK='\033[38;2;255;0;255m'
GREEN='\033[38;2;80;250;123m'
YELLOW='\033[38;2;241;250;140m'
RED='\033[38;2;255;99;99m'
CORAL='\033[38;2;255;106;193m'
BLUE='\033[38;2;130;170;255m'
WHITE='\033[38;2;248;248;242m'
GRAY='\033[38;2;99;119;119m'
BG_DARK='\033[48;2;18;16;26m'
BG_PURPLE='\033[48;2;40;20;60m'

# ─── Globals ─────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTRAS_DIR="${SCRIPT_DIR}/extras"
DETECTED=()
INSTALLED=()
SKIPPED=()
FAILED=()
DRY_RUN=false
INTERACTIVE=true

# ─── Neon UI primitives ─────────────────────────────────────────────────────
glow() { printf "${PURPLE}${BOLD}%s${RESET}" "$*"; }
spark() { printf "${CYAN}%s${RESET}" "$*"; }
flash() { printf "${PINK}${BOLD}%s${RESET}" "$*"; }
success() { printf "${GREEN}${BOLD}  %s${RESET}\n" "$*"; }
warn() { printf "${YELLOW}  ! %s${RESET}\n" "$*"; }
fail() { printf "${RED}  x %s${RESET}\n" "$*"; }
info() { printf "${WHITE}  %s${RESET}\n" "$*"; }
diminfo() { printf "${GRAY}    %s${RESET}\n" "$*"; }

neon_line() {
    printf "${PURPLE}"
    printf '  %.0s' {1..2}
    local i
    for i in $(seq 1 "$1"); do
        local r=$((225 - i * 2))
        local g=$((53 + i * 3))
        local b=255
        printf '\033[38;2;%d;%d;%dm━' "$r" "$g" "$b"
    done
    printf "${RESET}\n"
}

pulse_dot() {
    local label="$1"
    local status="$2"
    if [[ "$status" == "found" ]]; then
        printf "${GREEN}${BOLD}  [+]${RESET} ${WHITE}%s${RESET}\n" "$label"
    else
        printf "${GRAY}  [ ] %s${RESET}\n" "$label"
    fi
}

# ─── The banner ─────────────────────────────────────────────────────────────
banner() {
    printf '\n'
    printf '              \033[1;38;2;225;53;255mS \033[1;38;2;222;58;254mI \033[1;38;2;214;74;252mL \033[1;38;2;204;96;250mK \033[1;38;2;190;124;247mC \033[1;38;2;176;154;244mI \033[1;38;2;162;183;241mR \033[1;38;2;148;211;238mC \033[1;38;2;138;233;236mU \033[1;38;2;130;249;234mI \033[1;38;2;128;255;234mT\033[0m\n'
    printf '          \033[38;2;225;53;255m━\033[38;2;224;53;254m━\033[38;2;223;55;254m━\033[38;2;221;59;254m━\033[38;2;219;64;253m━\033[38;2;216;70;253m━\033[38;2;213;76;252m━\033[38;2;209;84;251m━\033[38;2;205;93;250m━\033[38;2;201;102;249m━\033[38;2;196;111;248m━\033[38;2;191;122;247m━\033[38;2;186;132;246m━\033[38;2;181;143;245m━\033[38;2;176;154;244m━\033[38;2;171;164;243m━\033[38;2;166;175;242m━\033[38;2;161;185;241m━\033[38;2;156;196;240m━\033[38;2;151;205;239m━\033[38;2;147;214;238m━\033[38;2;143;223;237m━\033[38;2;139;231;236m━\033[38;2;136;237;235m━\033[38;2;133;243;235m━\033[38;2;131;248;234m━\033[38;2;129;252;234m━\033[38;2;128;254;234m━\033[38;2;128;255;234m━\033[0m\n'
    printf '             \033[2;3;38;2;155;110;255mElectric meets elegant.\033[0m\n'
    printf '\n'
    printf '             \033[2;38;2;99;119;119mhyperbliss technologies\033[0m\n'
    printf '     \033[2;38;2;255;106;193mhttps://github.com/sponsors/hyperb1iss\033[0m\n'
    printf '\n'
}




# ─── Detection engine ───────────────────────────────────────────────────────

cmd_exists() { command -v "$1" &>/dev/null; }
dir_exists() { [[ -d "$1" ]]; }

detect_all() {
    printf '\n'

    # Ghostty
    if cmd_exists ghostty || dir_exists "$HOME/.config/ghostty"; then
        DETECTED+=("ghostty")
        pulse_dot "Ghostty" "found"
    else
        pulse_dot "Ghostty" "missing"
    fi

    # Alacritty
    if cmd_exists alacritty || dir_exists "$HOME/.config/alacritty"; then
        DETECTED+=("alacritty")
        pulse_dot "Alacritty" "found"
    else
        pulse_dot "Alacritty" "missing"
    fi

    # Kitty
    if cmd_exists kitty || dir_exists "$HOME/.config/kitty"; then
        DETECTED+=("kitty")
        pulse_dot "Kitty" "found"
    else
        pulse_dot "Kitty" "missing"
    fi

    # Warp
    if cmd_exists warp-terminal || dir_exists "$HOME/.warp"; then
        DETECTED+=("warp")
        pulse_dot "Warp" "found"
    else
        pulse_dot "Warp" "missing"
    fi

    # btop
    if cmd_exists btop || dir_exists "$HOME/.config/btop"; then
        DETECTED+=("btop")
        pulse_dot "btop" "found"
    else
        pulse_dot "btop" "missing"
    fi

    # k9s (macOS uses ~/Library/Application Support/k9s, Linux uses ~/.config/k9s)
    if cmd_exists k9s || dir_exists "$HOME/.config/k9s" || dir_exists "$HOME/Library/Application Support/k9s"; then
        DETECTED+=("k9s")
        pulse_dot "k9s" "found"
    else
        pulse_dot "k9s" "missing"
    fi

    # fzf
    if cmd_exists fzf; then
        DETECTED+=("fzf")
        pulse_dot "fzf" "found"
    else
        pulse_dot "fzf" "missing"
    fi

    # fastfetch
    if cmd_exists fastfetch || dir_exists "$HOME/.config/fastfetch"; then
        DETECTED+=("fastfetch")
        pulse_dot "fastfetch" "found"
    else
        pulse_dot "fastfetch" "missing"
    fi

    # starship
    if cmd_exists starship || [[ -f "$HOME/.config/starship.toml" ]]; then
        DETECTED+=("starship")
        pulse_dot "Starship" "found"
    else
        pulse_dot "Starship" "missing"
    fi

    # tmux
    if cmd_exists tmux; then
        DETECTED+=("tmux")
        pulse_dot "tmux" "found"
    else
        pulse_dot "tmux" "missing"
    fi

    # bat
    if cmd_exists bat; then
        DETECTED+=("bat")
        pulse_dot "bat" "found"
    else
        pulse_dot "bat" "missing"
    fi

    # lsd
    if cmd_exists lsd; then
        DETECTED+=("lsd")
        pulse_dot "lsd" "found"
    else
        pulse_dot "lsd" "missing"
    fi

    # procs
    if cmd_exists procs; then
        DETECTED+=("procs")
        pulse_dot "procs" "found"
    else
        pulse_dot "procs" "missing"
    fi

    # atuin
    if cmd_exists atuin || dir_exists "$HOME/.config/atuin"; then
        DETECTED+=("atuin")
        pulse_dot "Atuin" "found"
    else
        pulse_dot "Atuin" "missing"
    fi

    # lazygit
    if cmd_exists lazygit || dir_exists "$HOME/.config/lazygit"; then
        DETECTED+=("lazygit")
        pulse_dot "lazygit" "found"
    else
        pulse_dot "lazygit" "missing"
    fi

    # Git (with delta)
    if cmd_exists git; then
        DETECTED+=("git")
        pulse_dot "Git" "found"
        if cmd_exists delta; then
            pulse_dot "  delta (git pager)" "found"
        fi
    else
        pulse_dot "Git" "missing"
    fi

    # COSMIC Desktop
    if dir_exists "$HOME/.config/cosmic" || cmd_exists cosmic-comp; then
        DETECTED+=("cosmic")
        pulse_dot "COSMIC Desktop" "found"
    else
        pulse_dot "COSMIC Desktop" "missing"
    fi

    # Neovim
    if cmd_exists nvim; then
        DETECTED+=("neovim")
        pulse_dot "Neovim" "found"
        # Check for AstroNvim
        if [[ -f "$HOME/.config/nvim/lua/astronvim/init.lua" ]] || \
           grep -rql "AstroNvim" "$HOME/.config/nvim/" 2>/dev/null; then
            DETECTED+=("astronvim")
            pulse_dot "  AstroNvim" "found"
        fi
    else
        pulse_dot "Neovim" "missing"
    fi

    # VSCode
    if cmd_exists code || cmd_exists code-insiders; then
        DETECTED+=("vscode")
        pulse_dot "VS Code" "found"
    else
        pulse_dot "VS Code" "missing"
    fi

    # Slack
    if cmd_exists slack || \
       [[ -d "/Applications/Slack.app" ]] || \
       cmd_exists flatpak && flatpak list 2>/dev/null | grep -qi slack; then
        DETECTED+=("slack")
        pulse_dot "Slack" "found"
    else
        pulse_dot "Slack" "missing"
    fi

    # Windows Terminal (WSL)
    if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
        DETECTED+=("windows-terminal")
        pulse_dot "Windows Terminal (WSL)" "found"
    else
        pulse_dot "Windows Terminal" "missing"
    fi

    printf '\n'
    printf "${GREEN}${BOLD}  %d${RESET}${WHITE} apps detected${RESET}\n\n" "${#DETECTED[@]}"
}

# ─── Install functions ───────────────────────────────────────────────────────

safe_copy() {
    local src="$1"
    local dst="$2"
    local label="$3"

    if [[ ! -f "$src" ]]; then
        fail "${label}: source not found"
        FAILED+=("$label")
        return 1
    fi

    # Resolve the real path to detect symlinks into git repos (e.g. dotfiles)
    local real_dst real_dir in_ext_git=false
    real_dst="$(cd "$(dirname "$dst")" 2>/dev/null && pwd -P)/$(basename "$dst")" 2>/dev/null || real_dst="$dst"
    real_dir="$(dirname "$real_dst")"

    if [[ -d "${real_dir}" ]] && git -C "$real_dir" rev-parse --is-inside-work-tree &>/dev/null; then
        local repo_root
        repo_root="$(git -C "$real_dir" rev-parse --show-toplevel 2>/dev/null)"
        # Check if target is in a different git repo than the installer
        if [[ "$repo_root" != "$(git -C "$(dirname "$src")" rev-parse --show-toplevel 2>/dev/null)" ]]; then
            in_ext_git=true
            # Skip new files — don't introduce untracked files into external repos
            if [[ ! -f "$dst" ]]; then
                diminfo "${label}: skipped new file in git repo (${repo_root})"
                SKIPPED+=("$label")
                return 1
            fi
        fi
    fi

    mkdir -p "$(dirname "$dst")"

    if [[ "$DRY_RUN" == true ]]; then
        diminfo "dry-run: $src -> $dst"
        INSTALLED+=("$label")
        return 0
    fi

    if [[ -f "$dst" ]]; then
        # Skip .bak files inside external git repos — git itself is the backup
        if [[ "$in_ext_git" == false ]]; then
            cp "$dst" "${dst}.silkcircuit.bak" 2>/dev/null || true
        fi
    fi

    if cp "$src" "$dst" 2>/dev/null; then
        INSTALLED+=("$label")
        return 0
    else
        FAILED+=("$label")
        return 1
    fi
}

install_ghostty() {
    local theme_dir="$HOME/.config/ghostty/themes"
    printf "${PURPLE}${BOLD}  >> Ghostty${RESET}\n"

    # Install all variants so they can switch
    local count=0
    for f in "${EXTRAS_DIR}/ghostty/silkcircuit-"*; do
        local name
        name=$(basename "$f")
        if safe_copy "$f" "${theme_dir}/${name}" "ghostty:${name}"; then
            count=$((count + 1))
        fi
    done
    success "Installed ${count} Ghostty themes"
    diminfo "Activate: theme = silkcircuit-neon (or vibrant/soft/glow/dawn)"
}

install_alacritty() {
    local theme_dir="$HOME/.config/alacritty/themes"
    printf "${PURPLE}${BOLD}  >> Alacritty${RESET}\n"

    local count=0
    for f in "${EXTRAS_DIR}/alacritty/silkcircuit-"*.toml; do
        local name
        name=$(basename "$f")
        if safe_copy "$f" "${theme_dir}/${name}" "alacritty:${name}"; then
            count=$((count + 1))
        fi
    done
    success "Installed ${count} Alacritty themes"
    diminfo "Import in alacritty.toml: [general] import = [\"~/.config/alacritty/themes/silkcircuit-neon.toml\"]"
}

install_kitty() {
    local theme_dir="$HOME/.config/kitty/themes"
    printf "${PURPLE}${BOLD}  >> Kitty${RESET}\n"

    local count=0
    for f in "${EXTRAS_DIR}/kitty/silkcircuit-"*.conf; do
        local name
        name=$(basename "$f")
        if safe_copy "$f" "${theme_dir}/${name}" "kitty:${name}"; then
            count=$((count + 1))
        fi
    done
    success "Installed ${count} Kitty themes"
    diminfo "Activate: include themes/silkcircuit-neon.conf"
}

install_warp() {
    local theme_dir="$HOME/.warp/themes"
    printf "${PURPLE}${BOLD}  >> Warp${RESET}\n"

    safe_copy "${EXTRAS_DIR}/warp.yaml" "${theme_dir}/silkcircuit.yaml" "warp:dark"
    if [[ -f "${EXTRAS_DIR}/warp-dawn.yaml" ]]; then
        safe_copy "${EXTRAS_DIR}/warp-dawn.yaml" "${theme_dir}/silkcircuit-dawn.yaml" "warp:dawn"
    fi
    success "Installed Warp themes"
}

install_btop() {
    local theme_dir="$HOME/.config/btop/themes"
    printf "${PURPLE}${BOLD}  >> btop${RESET}\n"

    local count=0
    for f in "${EXTRAS_DIR}/btop/silkcircuit_"*.theme; do
        local name
        name=$(basename "$f")
        if safe_copy "$f" "${theme_dir}/${name}" "btop:${name}"; then
            count=$((count + 1))
        fi
    done
    success "Installed ${count} btop themes"
    diminfo "Select in btop: Esc -> Options -> Color theme"
}

install_k9s() {
    printf "${PURPLE}${BOLD}  >> k9s${RESET}\n"

    # Resolve k9s config dir: use `k9s info` if available, else platform default
    local k9s_dir
    if cmd_exists k9s; then
        local k9s_cfg
        k9s_cfg="$(k9s info 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' | grep -i '^Config:' | sed 's/^[^:]*:[[:space:]]*//')"
        [[ -n "${k9s_cfg:-}" ]] && k9s_dir="$(dirname "$k9s_cfg")" || true
    fi
    if [[ -z "${k9s_dir:-}" ]]; then
        if [[ "$(uname)" == "Darwin" ]]; then
            k9s_dir="$HOME/Library/Application Support/k9s"
        else
            k9s_dir="$HOME/.config/k9s"
        fi
    fi

    local skin_dir="${k9s_dir}/skins"
    local count=0
    for f in "${EXTRAS_DIR}/k9s/silkcircuit"*.yaml; do
        local name
        name=$(basename "$f")
        if safe_copy "$f" "${skin_dir}/${name}" "k9s:${name}"; then
            count=$((count + 1))
        fi
    done

    # Activate the skin in k9s config
    local config="${k9s_dir}/config.yaml"
    if [[ "$DRY_RUN" == true ]]; then
        diminfo "dry-run: would set skin to silkcircuit in ${config}"
    elif [[ -f "$config" ]]; then
        if grep -q 'skin:' "$config" 2>/dev/null; then
            sed -i.silkcircuit.bak 's/skin:.*/skin: silkcircuit/' "$config"
        elif grep -q 'ui:' "$config" 2>/dev/null; then
            sed -i.silkcircuit.bak '/ui:/a\
    skin: silkcircuit' "$config"
        else
            printf '\nk9s:\n  ui:\n    skin: silkcircuit\n' >> "$config"
        fi
    else
        mkdir -p "$k9s_dir"
        printf 'k9s:\n  ui:\n    skin: silkcircuit\n' > "$config"
    fi

    success "Installed ${count} k9s skins"
    diminfo "Active skin: silkcircuit"
}

install_fzf() {
    printf "${PURPLE}${BOLD}  >> fzf${RESET}\n"

    local target="$HOME/.config/silkcircuit/fzf.sh"
    if safe_copy "${EXTRAS_DIR}/fzf.sh" "$target" "fzf"; then
        success "Installed fzf theme"
        diminfo "Add to shell rc: source ~/.config/silkcircuit/fzf.sh"
    fi
}

install_git() {
    printf "${PURPLE}${BOLD}  >> Git${RESET}\n"

    local target="$HOME/.config/silkcircuit/gitconfig"
    if safe_copy "${EXTRAS_DIR}/gitconfig" "$target" "git"; then
        # Check if already included
        if git config --global --get-all include.path 2>/dev/null | grep -q "silkcircuit/gitconfig"; then
            success "Git theme already configured"
        else
            if [[ "$DRY_RUN" == false ]]; then
                git config --global --add include.path "$target"
                success "Installed Git theme (added include to .gitconfig)"
            else
                success "Git theme (dry-run: would add include to .gitconfig)"
            fi
        fi
        if ! cmd_exists delta; then
            diminfo "Tip: install delta for enhanced git diffs"
        fi
    fi
}

install_starship() {
    printf "${PURPLE}${BOLD}  >> Starship${RESET}\n"

    local target="$HOME/.config/starship.toml"
    if safe_copy "${EXTRAS_DIR}/starship/starship.toml" "$target" "starship"; then
        success "Installed Starship config"
    fi
}

install_tmux() {
    printf "${PURPLE}${BOLD}  >> tmux${RESET}\n"

    local target="$HOME/.tmux.conf"
    if [[ -f "$target" ]] && grep -qi "silkcircuit" "$target" 2>/dev/null; then
        success "tmux already has SilkCircuit theme"
        INSTALLED+=("tmux")
    else
        if safe_copy "${EXTRAS_DIR}/tmux.conf" "$target" "tmux"; then
            success "Installed tmux config"
            diminfo "Reload: tmux source-file ~/.tmux.conf"
        fi
    fi
}

install_bat() {
    printf "${PURPLE}${BOLD}  >> bat${RESET}\n"

    local theme_dir
    theme_dir="$(bat --config-dir 2>/dev/null)/themes"
    local config_dir
    config_dir="$(bat --config-dir 2>/dev/null)"

    if [[ -n "$theme_dir" ]]; then
        mkdir -p "$theme_dir"
        if safe_copy "${EXTRAS_DIR}/bat/SilkCircuit.tmTheme" "${theme_dir}/SilkCircuit.tmTheme" "bat:theme"; then
            safe_copy "${EXTRAS_DIR}/bat/config" "${config_dir}/config" "bat:config"
            if [[ "$DRY_RUN" == false ]]; then
                bat cache --build &>/dev/null || true
            fi
            success "Installed bat theme"
        fi
    else
        warn "Could not determine bat config directory"
        SKIPPED+=("bat")
    fi
}

install_lsd() {
    printf "${PURPLE}${BOLD}  >> lsd${RESET}\n"

    local config_dir="$HOME/.config/lsd"
    safe_copy "${EXTRAS_DIR}/lsd/colors.yaml" "${config_dir}/colors.yaml" "lsd:colors"
    safe_copy "${EXTRAS_DIR}/lsd/config.yaml" "${config_dir}/config.yaml" "lsd:config"
    success "Installed lsd theme"
}

install_procs() {
    printf "${PURPLE}${BOLD}  >> procs${RESET}\n"

    local target="$HOME/.config/procs/config.toml"
    if safe_copy "${EXTRAS_DIR}/procs/config.toml" "$target" "procs"; then
        success "Installed procs config"
    fi
}

install_atuin() {
    printf "${PURPLE}${BOLD}  >> Atuin${RESET}\n"

    local theme_dir="$HOME/.config/atuin/themes"
    if safe_copy "${EXTRAS_DIR}/atuin/silkcircuit.toml" "${theme_dir}/silkcircuit.toml" "atuin"; then
        success "Installed Atuin theme"
        diminfo "Add to atuin config.toml: theme = \"silkcircuit\""
    fi
}

install_lazygit() {
    printf "${PURPLE}${BOLD}  >> lazygit${RESET}\n"

    local config_dir="$HOME/.config/lazygit"
    local target="${config_dir}/config.yml"

    # If config exists, check if themed already
    if [[ -f "$target" ]] && grep -qi "silkcircuit\|neonPurple\|#e135ff" "$target" 2>/dev/null; then
        success "lazygit already has SilkCircuit theme"
        INSTALLED+=("lazygit")
        return
    fi

    mkdir -p "$config_dir"

    if [[ "$DRY_RUN" == true ]]; then
        diminfo "dry-run: would write lazygit theme to ${target}"
        INSTALLED+=("lazygit")
        return
    fi

    # Merge theme into existing config or create new
    if [[ -f "$target" ]] && grep -q "gui:" "$target" 2>/dev/null; then
        warn "Existing lazygit config found - theme file saved separately"
        safe_copy "${EXTRAS_DIR}/lazygit/config.yml" "${config_dir}/silkcircuit-theme.yml" "lazygit:theme-ref"
        diminfo "Merge theme settings from: ${config_dir}/silkcircuit-theme.yml"
    else
        safe_copy "${EXTRAS_DIR}/lazygit/config.yml" "$target" "lazygit"
        success "Installed lazygit theme"
    fi
}

install_fastfetch() {
    printf "${PURPLE}${BOLD}  >> fastfetch${RESET}\n"

    local target="$HOME/.config/fastfetch/config.jsonc"
    if safe_copy "${EXTRAS_DIR}/fastfetch/config.jsonc" "$target" "fastfetch"; then
        success "Installed fastfetch config"
    fi
}

install_cosmic() {
    printf "${PURPLE}${BOLD}  >> COSMIC Desktop${RESET}\n"

    # Copy all variants to a central location
    local cosmic_dir="$HOME/.config/silkcircuit/cosmic"
    local count=0
    for f in "${EXTRAS_DIR}/cosmic/silkcircuit-"*.ron; do
        local name
        name=$(basename "$f")
        if safe_copy "$f" "${cosmic_dir}/${name}" "cosmic:${name}"; then
            count=$((count + 1))
        fi
    done

    success "Installed ${count} COSMIC themes"
    diminfo "Import via: Settings -> Desktop -> Appearance -> Import"
    diminfo "Theme files: ~/.config/silkcircuit/cosmic/"
}

install_vscode() {
    printf "${PURPLE}${BOLD}  >> VS Code${RESET}\n"

    # Find VS Code extensions directory
    local ext_dir=""
    if [[ -d "$HOME/.vscode/extensions" ]]; then
        ext_dir="$HOME/.vscode/extensions"
    elif [[ -d "$HOME/.vscode-insiders/extensions" ]]; then
        ext_dir="$HOME/.vscode-insiders/extensions"
    fi

    if [[ -z "$ext_dir" ]]; then
        warn "VS Code extensions directory not found"
        diminfo "Install from VS Code marketplace or manually copy extras/vscode/"
        SKIPPED+=("vscode")
        return
    fi

    local dest="${ext_dir}/silkcircuit-theme"
    mkdir -p "$dest"

    if [[ "$DRY_RUN" == false ]]; then
        cp -r "${EXTRAS_DIR}/vscode/"* "$dest/" 2>/dev/null
        INSTALLED+=("vscode")
        success "Installed VS Code theme"
        diminfo "Restart VS Code and select: SilkCircuit Neon"
    else
        diminfo "dry-run: would copy to ${dest}/"
        INSTALLED+=("vscode")
    fi
}

install_slack() {
    printf "${PURPLE}${BOLD}  >> Slack${RESET}\n"

    local target="$HOME/.config/silkcircuit/slack-theme.txt"
    if safe_copy "${EXTRAS_DIR}/slack-theme.txt" "$target" "slack"; then
        success "Slack theme reference installed"
        diminfo "Open: Preferences -> Themes -> paste colors from:"
        diminfo "$target"
    fi
}

install_windows_terminal() {
    printf "${PURPLE}${BOLD}  >> Windows Terminal${RESET}\n"

    local target="$HOME/.config/silkcircuit/windows-terminal.json"
    if safe_copy "${EXTRAS_DIR}/windows-terminal.json" "$target" "windows-terminal"; then
        success "Windows Terminal theme installed"
        diminfo "Import into Windows Terminal settings.json"
    fi
}

install_neovim() {
    printf "${PURPLE}${BOLD}  >> Neovim${RESET}\n"

    # Check if silkcircuit is already installed as a plugin
    local found=false
    for d in "$HOME/.local/share/nvim" "$HOME/.config/nvim"; do
        if find "$d" -path "*/silkcircuit*" -name "*.lua" 2>/dev/null | head -1 | grep -q .; then
            found=true
            break
        fi
    done

    if [[ "$found" == true ]]; then
        success "SilkCircuit already installed in Neovim"
    else
        info "Add to your plugin manager:"
        diminfo "{ \"hyperb1iss/silkcircuit\", lazy = false, priority = 1000 }"
        SKIPPED+=("neovim")
    fi
}

install_astronvim() {
    printf "${PURPLE}${BOLD}  >> AstroNvim${RESET}\n"

    local dest="$HOME/.config/nvim/lua/plugins"
    if [[ -d "$dest" ]]; then
        local count=0
        for f in "${EXTRAS_DIR}/astronvim/plugins/"*.lua; do
            local name
            name=$(basename "$f")
            if safe_copy "$f" "${dest}/${name}" "astronvim:${name}"; then
                count=$((count + 1))
            fi
        done
        success "Installed ${count} AstroNvim plugin configs"
    else
        warn "AstroNvim plugins directory not found"
        SKIPPED+=("astronvim")
    fi
}

# ─── Main install orchestrator ───────────────────────────────────────────────

run_installs() {
    printf "${PURPLE}${BOLD}  INSTALLING${RESET}${CYAN} >> all variants${RESET}\n"
    neon_line 40
    printf '\n'

    for app in "${DETECTED[@]}"; do
        case "$app" in
            ghostty)          install_ghostty ;;
            alacritty)        install_alacritty ;;
            kitty)            install_kitty ;;
            warp)             install_warp ;;
            btop)             install_btop ;;
            k9s)              install_k9s ;;
            fzf)              install_fzf ;;
            fastfetch)        install_fastfetch ;;
            starship)         install_starship ;;
            tmux)             install_tmux ;;
            bat)              install_bat ;;
            lsd)              install_lsd ;;
            procs)            install_procs ;;
            atuin)            install_atuin ;;
            lazygit)          install_lazygit ;;
            git)              install_git ;;
            cosmic)           install_cosmic ;;
            vscode)           install_vscode ;;
            slack)            install_slack ;;
            windows-terminal) install_windows_terminal ;;
            neovim)           install_neovim ;;
            astronvim)        install_astronvim ;;
        esac
        printf '\n'
    done
}

# ─── Summary ─────────────────────────────────────────────────────────────────

summary() {
    neon_line 50
    printf "${PURPLE}${BOLD}  TRANSMISSION COMPLETE${RESET}\n"
    neon_line 50
    printf '\n'

    if [[ ${#INSTALLED[@]} -gt 0 ]]; then
        printf "${GREEN}${BOLD}  Installed (${#INSTALLED[@]})${RESET}\n"
        for item in "${INSTALLED[@]}"; do
            printf "${GREEN}    + %s${RESET}\n" "$item"
        done
        printf '\n'
    fi

    if [[ ${#SKIPPED[@]} -gt 0 ]]; then
        printf "${YELLOW}  Skipped (${#SKIPPED[@]})${RESET}\n"
        for item in "${SKIPPED[@]}"; do
            printf "${YELLOW}    ~ %s${RESET}\n" "$item"
        done
        printf '\n'
    fi

    if [[ ${#FAILED[@]} -gt 0 ]]; then
        printf "${RED}  Failed (${#FAILED[@]})${RESET}\n"
        for item in "${FAILED[@]}"; do
            printf "${RED}    x %s${RESET}\n" "$item"
        done
        printf '\n'
    fi

    printf "${CYAN}  Your environment is now running on SilkCircuit.${RESET}\n"
    printf "${GRAY}  Backups saved as *.silkcircuit.bak where applicable.${RESET}\n"
    printf '\n'
}

# ─── CLI interface ───────────────────────────────────────────────────────────

usage() {
    printf "${PURPLE}${BOLD}SilkCircuit Installer${RESET}\n\n"
    printf "${WHITE}Usage:${RESET} %s [options]\n\n" "$(basename "$0")"
    printf "${WHITE}Options:${RESET}\n"
    printf "  ${CYAN}-n, --dry-run${RESET}          Show what would be installed\n"
    printf "  ${CYAN}-y, --yes${RESET}              Skip confirmation prompts\n"
    printf "  ${CYAN}-h, --help${RESET}             Show this help\n"
    printf '\n'
}

confirm_install() {
    if [[ "$INTERACTIVE" == false ]]; then
        return 0
    fi

    printf "${WHITE}  Install SilkCircuit for ${#DETECTED[@]} detected apps? ${RESET}"
    printf "${GRAY}[Y/n]${RESET} "
    read -r answer
    case "$answer" in
        [nN]*) printf "\n${GRAY}  Aborted.${RESET}\n"; exit 0 ;;
    esac
    printf '\n'
}

main() {
    # Parse args
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -n|--dry-run) DRY_RUN=true; shift ;;
            -y|--yes)     INTERACTIVE=false; shift ;;
            -h|--help)    usage; exit 0 ;;
            *)            warn "Unknown option: $1"; shift ;;
        esac
    done

    banner
    detect_all
    confirm_install

    if [[ ${#DETECTED[@]} -eq 0 ]]; then
        warn "No supported apps detected"
        exit 0
    fi

    if [[ "$DRY_RUN" == true ]]; then
        printf "${YELLOW}${BOLD}  DRY RUN MODE${RESET}${GRAY} - no files will be modified${RESET}\n\n"
    fi

    run_installs
    summary
}

main "$@"
