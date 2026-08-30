#!/usr/bin/env bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# SilkCircuit Universal Installer
# Detect installed apps and drop the generated themes where they belong
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
XDG_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
# Where files land when the app has no drop-in directory of its own and the
# colors have to be pasted or imported by hand.
STAGING="${XDG_CONFIG}/silkcircuit"

ALL_VARIANTS=(neon vibrant soft glow dawn)
VARIANT="all"
SELECTED=()
# The variant every printed "turn it on" line names, and the one single-slot
# tools receive.
PRIMARY="neon"

DETECTED=()
INSTALLED=()
SKIPPED=()
FAILED=()
COPIED=0
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
section() { printf "${PURPLE}${BOLD}  >> %s${RESET}\n" "$*"; }

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

# ─── Variant selection ───────────────────────────────────────────────────────

resolve_variants() {
    if [[ "$VARIANT" == "all" ]]; then
        SELECTED=("${ALL_VARIANTS[@]}")
        PRIMARY="neon"
        return 0
    fi

    local candidate
    for candidate in "${ALL_VARIANTS[@]}"; do
        if [[ "$candidate" == "$VARIANT" ]]; then
            SELECTED=("$candidate")
            PRIMARY="$candidate"
            return 0
        fi
    done

    fail "Unknown variant: ${VARIANT}"
    info "Pick one of: ${ALL_VARIANTS[*]} all"
    exit 2
}

# "neon" -> "Neon", for the formats that name their themes in title case.
variant_label() {
    printf '%s%s' "$(printf '%s' "${1:0:1}" | tr '[:lower:]' '[:upper:]')" "${1:1}"
}

# Tools that read exactly one file cannot hold five themes at once, so `all`
# gives them neon and says as much rather than silently picking for you.
single_slot_note() {
    if [[ "$VARIANT" == "all" ]]; then
        diminfo "$1 reads one file, so --variant all installs neon here"
    fi
}

# ─── Detection engine ───────────────────────────────────────────────────────

cmd_exists() { command -v "$1" &>/dev/null; }
dir_exists() { [[ -d "$1" ]]; }

detect() {
    local id="$1"
    local label="$2"
    local found="$3"

    if [[ "$found" == true ]]; then
        DETECTED+=("$id")
        pulse_dot "$label" "found"
    else
        pulse_dot "$label" "missing"
    fi
}

detect_if() {
    local id="$1"
    local label="$2"
    shift 2
    if "$@"; then
        detect "$id" "$label" true
    else
        detect "$id" "$label" false
    fi
}

have_ghostty() { cmd_exists ghostty || dir_exists "${XDG_CONFIG}/ghostty"; }
have_alacritty() { cmd_exists alacritty || dir_exists "${XDG_CONFIG}/alacritty"; }
have_kitty() { cmd_exists kitty || dir_exists "${XDG_CONFIG}/kitty"; }
have_warp() { cmd_exists warp-terminal || dir_exists "$HOME/.warp"; }
have_wezterm() { cmd_exists wezterm || dir_exists "${XDG_CONFIG}/wezterm"; }
have_foot() { cmd_exists foot || dir_exists "${XDG_CONFIG}/foot"; }
have_zellij() { cmd_exists zellij || dir_exists "${XDG_CONFIG}/zellij"; }
have_helix() { cmd_exists hx || cmd_exists helix || dir_exists "${XDG_CONFIG}/helix"; }
have_btop() { cmd_exists btop || dir_exists "${XDG_CONFIG}/btop"; }
have_fzf() { cmd_exists fzf || dir_exists "${XDG_CONFIG}/fzf"; }
have_fastfetch() { cmd_exists fastfetch || dir_exists "${XDG_CONFIG}/fastfetch"; }
have_tmux() { cmd_exists tmux || dir_exists "${XDG_CONFIG}/tmux" || [[ -f "$HOME/.tmux.conf" ]]; }
have_bat() { cmd_exists bat || dir_exists "${XDG_CONFIG}/bat"; }
have_lsd() { cmd_exists lsd || dir_exists "${XDG_CONFIG}/lsd"; }
have_procs() { cmd_exists procs || dir_exists "${XDG_CONFIG}/procs"; }
have_atuin() { cmd_exists atuin || dir_exists "${XDG_CONFIG}/atuin"; }
have_lazygit() { cmd_exists lazygit || dir_exists "${XDG_CONFIG}/lazygit"; }
have_cosmic() { cmd_exists cosmic-comp || dir_exists "${XDG_CONFIG}/cosmic"; }

have_starship() {
    cmd_exists starship || [[ -f "${STARSHIP_CONFIG:-${XDG_CONFIG}/starship.toml}" ]]
}

have_k9s() {
    cmd_exists k9s || dir_exists "${XDG_CONFIG}/k9s" ||
        dir_exists "$HOME/Library/Application Support/k9s"
}

have_iterm2() {
    [[ -d "/Applications/iTerm.app" ]] ||
        dir_exists "$HOME/Library/Application Support/iTerm2" ||
        [[ "${LC_TERMINAL:-}" == "iTerm2" ]]
}

# terminal-colors.d is util-linux territory. macOS ships a dmesg that ignores it.
have_dmesg() { [[ "$(uname)" == "Linux" ]] && cmd_exists dmesg; }

have_vscode() {
    cmd_exists code || cmd_exists code-insiders ||
        dir_exists "$HOME/.vscode/extensions" ||
        dir_exists "$HOME/.vscode-insiders/extensions"
}

have_slack() {
    cmd_exists slack || [[ -d "/Applications/Slack.app" ]] ||
        { cmd_exists flatpak && flatpak list 2>/dev/null | grep -qi slack; }
}

detect_all() {
    printf '\n'

    detect_if ghostty "Ghostty" have_ghostty
    detect_if alacritty "Alacritty" have_alacritty
    detect_if kitty "Kitty" have_kitty
    detect_if warp "Warp" have_warp
    detect_if wezterm "WezTerm" have_wezterm
    detect_if foot "foot" have_foot
    detect_if iterm2 "iTerm2" have_iterm2
    detect_if tmux "tmux" have_tmux
    detect_if zellij "Zellij" have_zellij
    detect_if helix "Helix" have_helix
    detect_if btop "btop" have_btop
    detect_if k9s "k9s" have_k9s
    detect_if fzf "fzf" have_fzf
    detect_if fastfetch "fastfetch" have_fastfetch
    detect_if starship "Starship" have_starship
    detect_if bat "bat" have_bat
    detect_if lsd "lsd" have_lsd
    detect_if procs "procs" have_procs
    detect_if atuin "Atuin" have_atuin
    detect_if lazygit "lazygit" have_lazygit
    detect_if dmesg "dmesg" have_dmesg
    detect_if cosmic "COSMIC Desktop" have_cosmic

    if cmd_exists git; then
        detect git "Git" true
        if cmd_exists delta; then
            pulse_dot "  delta (git pager)" "found"
        fi
    else
        detect git "Git" false
    fi

    if cmd_exists nvim; then
        detect neovim "Neovim" true
        if [[ -f "${XDG_CONFIG}/nvim/lua/astronvim/init.lua" ]] ||
            grep -rql "AstroNvim" "${XDG_CONFIG}/nvim/" 2>/dev/null; then
            DETECTED+=("astronvim")
            pulse_dot "  AstroNvim" "found"
        fi
    else
        detect neovim "Neovim" false
    fi

    detect_if vscode "VS Code" have_vscode
    detect_if slack "Slack" have_slack

    if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
        detect windows-terminal "Windows Terminal (WSL)" true
    else
        detect windows-terminal "Windows Terminal" false
    fi

    printf '\n'
    printf "${GREEN}${BOLD}  %d${RESET}${WHITE} apps detected${RESET}\n\n" "${#DETECTED[@]}"
}

# ─── Copy primitives ─────────────────────────────────────────────────────────

safe_copy() {
    local src="$1"
    local dst="$2"
    local label="$3"

    # A source that is not there is a skip, never a stop. One missing file used
    # to abort the whole run under `set -e` and silently strand every tool
    # after it.
    if [[ ! -f "$src" ]]; then
        warn "${label}: ${src#"${SCRIPT_DIR}/"} not found, skipping"
        SKIPPED+=("$label")
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
            # Skip new files, so we never introduce untracked files into
            # someone's dotfiles repo
            if [[ ! -f "$dst" ]]; then
                diminfo "${label}: skipped new file in git repo (${repo_root})"
                SKIPPED+=("$label")
                return 1
            fi
        fi
    fi

    if [[ "$DRY_RUN" == true ]]; then
        diminfo "dry-run: $src -> $dst"
        INSTALLED+=("$label")
        return 0
    fi

    mkdir -p "$(dirname "$dst")" 2>/dev/null || true

    if [[ -f "$dst" ]]; then
        # Skip .bak files inside external git repos, git itself is the backup
        if [[ "$in_ext_git" == false ]]; then
            cp "$dst" "${dst}.silkcircuit.bak" 2>/dev/null || true
        fi
    fi

    if cp "$src" "$dst" 2>/dev/null; then
        INSTALLED+=("$label")
        return 0
    else
        fail "${label}: copy failed"
        FAILED+=("$label")
        return 1
    fi
}

# Copy one file per selected variant. `pattern` is the file name with `@` where
# the variant goes. Sets COPIED to the number that landed.
copy_variants() {
    local src_dir="$1"
    local dst_dir="$2"
    local label="$3"
    local pattern="$4"

    COPIED=0
    local variant name
    for variant in "${SELECTED[@]}"; do
        name="${pattern//@/$variant}"
        if safe_copy "${src_dir}/${name}" "${dst_dir}/${name}" "${label}:${variant}"; then
            COPIED=$((COPIED + 1))
        fi
    done
}

# ─── Terminals ───────────────────────────────────────────────────────────────

install_ghostty() {
    section "Ghostty"

    copy_variants "${EXTRAS_DIR}/ghostty" "${XDG_CONFIG}/ghostty/themes" "ghostty" "silkcircuit-@"
    local themes=$COPIED

    # The .css files style the GTK window chrome on Linux. They are not themes,
    # so they sit beside the config rather than inside themes/.
    copy_variants "${EXTRAS_DIR}/ghostty" "${XDG_CONFIG}/ghostty" "ghostty-css" "silkcircuit-@.css"

    success "Installed ${themes} Ghostty themes and ${COPIED} GTK stylesheets"
    diminfo "In ~/.config/ghostty/config: theme = silkcircuit-${PRIMARY}"
    # Only worth suggesting when both halves of the pair actually landed.
    if [[ "$VARIANT" == "all" ]]; then
        diminfo "Follow the system: theme = dark:silkcircuit-neon,light:silkcircuit-dawn"
    fi
    diminfo "Linux chrome (Ghostty 1.1+): gtk-custom-css = ~/.config/ghostty/silkcircuit-${PRIMARY}.css"
}

install_alacritty() {
    section "Alacritty"

    copy_variants "${EXTRAS_DIR}/alacritty" "${XDG_CONFIG}/alacritty/themes" "alacritty" "silkcircuit-@.toml"
    success "Installed ${COPIED} Alacritty themes"
    diminfo "In ~/.config/alacritty/alacritty.toml, under [general]:"
    diminfo "import = [\"~/.config/alacritty/themes/silkcircuit-${PRIMARY}.toml\"]"
    diminfo "Needs Alacritty 0.13 or newer for TOML config"
}

install_kitty() {
    section "Kitty"

    copy_variants "${EXTRAS_DIR}/kitty" "${XDG_CONFIG}/kitty/themes" "kitty" "silkcircuit-@.conf"
    success "Installed ${COPIED} Kitty themes"
    diminfo "In ~/.config/kitty/kitty.conf: include themes/silkcircuit-${PRIMARY}.conf"
}

install_warp() {
    section "Warp"

    copy_variants "${EXTRAS_DIR}/warp" "$HOME/.warp/themes" "warp" "silkcircuit-@.yaml"
    success "Installed ${COPIED} Warp themes"
    diminfo "Settings -> Appearance -> Themes -> SilkCircuit $(variant_label "$PRIMARY")"
}

install_wezterm() {
    section "WezTerm"

    copy_variants "${EXTRAS_DIR}/wezterm" "${XDG_CONFIG}/wezterm/colors" "wezterm" "silkcircuit-@.toml"
    success "Installed ${COPIED} WezTerm color schemes"
    diminfo "In ~/.config/wezterm/wezterm.lua:"
    diminfo "config.color_scheme = \"SilkCircuit $(variant_label "$PRIMARY")\""
}

install_foot() {
    section "foot"

    copy_variants "${EXTRAS_DIR}/foot" "${XDG_CONFIG}/foot" "foot" "silkcircuit-@.ini"
    success "Installed ${COPIED} foot themes"
    diminfo "In ~/.config/foot/foot.ini: include=~/.config/foot/silkcircuit-${PRIMARY}.ini"
    diminfo "Needs foot 1.26 or newer. Each file carries colors-dark and colors-light."
}

install_iterm2() {
    section "iTerm2"

    copy_variants "${EXTRAS_DIR}/iterm2" "${STAGING}/iterm2" "iterm2" "silkcircuit-@.itermcolors"
    success "Staged ${COPIED} iTerm2 color presets"
    diminfo "Settings -> Profiles -> Colors -> Color Presets -> Import, then pick:"
    diminfo "${STAGING}/iterm2/silkcircuit-${PRIMARY}.itermcolors"
}

install_tmux() {
    section "tmux"

    copy_variants "${EXTRAS_DIR}/tmux" "${XDG_CONFIG}/tmux" "tmux" "silkcircuit-@.conf"
    success "Installed ${COPIED} tmux themes"
    diminfo "In tmux.conf: source-file ~/.config/tmux/silkcircuit-${PRIMARY}.conf"
    diminfo "Needs tmux 3.4 or newer. These are colors only, no key bindings."
}

install_zellij() {
    section "Zellij"

    local theme_dir="${XDG_CONFIG}/zellij/themes"
    copy_variants "${EXTRAS_DIR}/zellij" "$theme_dir" "zellij" "silkcircuit-@.kdl"
    # silkcircuit.kdl carries all five in one file, for anyone who would rather
    # keep a single theme file than five.
    safe_copy "${EXTRAS_DIR}/zellij/silkcircuit.kdl" \
        "${theme_dir}/silkcircuit.kdl" "zellij:combined" || true
    success "Installed ${COPIED} Zellij themes"
    diminfo "In ~/.config/zellij/config.kdl: theme \"silkcircuit-${PRIMARY}\""
    diminfo "Needs Zellij 0.42 or newer"
}

install_windows_terminal() {
    section "Windows Terminal"

    local dst="${STAGING}/windows-terminal"
    copy_variants "${EXTRAS_DIR}/windows-terminal" "$dst" "windows-terminal" "silkcircuit-@.json"
    safe_copy "${EXTRAS_DIR}/windows-terminal/silkcircuit.json" \
        "${dst}/silkcircuit.json" "windows-terminal:combined" || true

    success "Staged ${COPIED} Windows Terminal schemes"
    diminfo "Settings -> Open JSON file, then paste into the top-level schemes array from:"
    diminfo "${dst}/silkcircuit.json"
    diminfo "Then set \"colorScheme\": \"SilkCircuit $(variant_label "$PRIMARY")\" on a profile"
}

# ─── Editors ─────────────────────────────────────────────────────────────────

install_helix() {
    section "Helix"

    copy_variants "${EXTRAS_DIR}/helix" "${XDG_CONFIG}/helix/themes" "helix" "silkcircuit-@.toml"
    success "Installed ${COPIED} Helix themes"
    diminfo "In ~/.config/helix/config.toml: theme = \"silkcircuit-${PRIMARY}\""
}

install_vscode() {
    section "VS Code"

    local ext_dir=""
    if [[ -d "$HOME/.vscode/extensions" ]]; then
        ext_dir="$HOME/.vscode/extensions"
    elif [[ -d "$HOME/.vscode-insiders/extensions" ]]; then
        ext_dir="$HOME/.vscode-insiders/extensions"
    fi

    if [[ -z "$ext_dir" ]]; then
        warn "VS Code extensions directory not found"
        diminfo "Install from the Marketplace, or copy extras/vscode/ in by hand"
        SKIPPED+=("vscode")
        return
    fi

    local dest="${ext_dir}/silkcircuit-theme"

    if [[ "$DRY_RUN" == true ]]; then
        diminfo "dry-run: ${EXTRAS_DIR}/vscode/ -> ${dest}/"
        INSTALLED+=("vscode")
        return
    fi

    mkdir -p "$dest"
    if cp -r "${EXTRAS_DIR}/vscode/." "$dest/" 2>/dev/null; then
        INSTALLED+=("vscode")
        success "Installed the VS Code extension"
        diminfo "The extension is one package carrying all five themes, so --variant"
        diminfo "does not narrow it. Pick one in the editor instead:"
        diminfo "Restart VS Code, then Ctrl+K Ctrl+T -> SilkCircuit $(variant_label "$PRIMARY")"
    else
        fail "vscode: copy failed"
        FAILED+=("vscode")
    fi
}

install_neovim() {
    section "Neovim"

    local found=false d
    for d in "$HOME/.local/share/nvim" "${XDG_CONFIG}/nvim"; do
        if find "$d" -path "*/silkcircuit*" -name "*.lua" 2>/dev/null | head -1 | grep -q .; then
            found=true
            break
        fi
    done

    if [[ "$found" == true ]]; then
        success "SilkCircuit already installed in Neovim"
        INSTALLED+=("neovim")
    else
        info "Add to your plugin manager:"
        diminfo "{ \"hyperb1iss/silkcircuit\", lazy = false, priority = 1000 }"
        SKIPPED+=("neovim")
    fi
}

install_astronvim() {
    section "AstroNvim"

    local dest="${XDG_CONFIG}/nvim/lua/plugins"
    if [[ ! -d "$dest" ]]; then
        warn "AstroNvim plugins directory not found"
        SKIPPED+=("astronvim")
        return
    fi

    local count=0 f name
    for f in "${EXTRAS_DIR}/astronvim/plugins/"*.lua; do
        name=$(basename "$f")
        if safe_copy "$f" "${dest}/${name}" "astronvim:${name}"; then
            count=$((count + 1))
        fi
    done
    success "Installed ${count} AstroNvim plugin configs"
}

# ─── Shell, prompt, and pagers ───────────────────────────────────────────────

install_fzf() {
    section "fzf"

    copy_variants "${EXTRAS_DIR}/fzf" "${XDG_CONFIG}/fzf" "fzf" "silkcircuit-@.sh"
    success "Installed ${COPIED} fzf color sets"
    diminfo "In your shell rc: source ~/.config/fzf/silkcircuit-${PRIMARY}.sh"
    diminfo "Needs fzf 0.52 or newer for the selected-* and border color names"
}

install_starship() {
    section "Starship"

    local target="${STARSHIP_CONFIG:-${XDG_CONFIG}/starship.toml}"
    if safe_copy "${EXTRAS_DIR}/starship/silkcircuit-${PRIMARY}.toml" "$target" "starship"; then
        success "Installed the Starship prompt"
        diminfo "Config: ${target}"
        single_slot_note "Starship"
    fi
}

install_bat() {
    section "bat"

    local config_dir=""
    if cmd_exists bat; then
        config_dir="$(bat --config-dir 2>/dev/null || true)"
    fi
    [[ -n "$config_dir" ]] || config_dir="${XDG_CONFIG}/bat"

    copy_variants "${EXTRAS_DIR}/bat" "${config_dir}/themes" "bat" "silkcircuit-@.tmTheme"

    if [[ "$DRY_RUN" == false ]] && cmd_exists bat; then
        bat cache --build &>/dev/null || warn "bat cache --build failed, run it by hand"
    fi

    success "Installed ${COPIED} bat themes"
    diminfo "Use it: bat --theme=silkcircuit-${PRIMARY} file.lua"
    diminfo "Or add --theme=silkcircuit-${PRIMARY} to ${config_dir}/config"
    diminfo "Add --italic-text=always too, the theme leans on italics"
}

install_lsd() {
    section "lsd"

    local config_dir="${XDG_CONFIG}/lsd"
    # lsd reads exactly one file, and it has to be called colors.yaml.
    if safe_copy "${EXTRAS_DIR}/lsd/silkcircuit-${PRIMARY}.yaml" "${config_dir}/colors.yaml" "lsd"; then
        local config="${config_dir}/config.yaml"
        if [[ "$DRY_RUN" == true ]]; then
            diminfo "dry-run: would set color.theme to custom in ${config}"
        elif [[ -f "$config" ]]; then
            if ! grep -q "theme:[[:space:]]*custom" "$config" 2>/dev/null; then
                diminfo "Add to ${config}:"
                diminfo "color:"
                diminfo "  theme: custom"
            fi
        else
            printf 'color:\n  theme: custom\n' > "$config"
        fi
        success "Installed the lsd color file"
        single_slot_note "lsd"
    fi
}

install_procs() {
    section "procs"

    if safe_copy "${EXTRAS_DIR}/procs/silkcircuit-${PRIMARY}.toml" \
        "${XDG_CONFIG}/procs/config.toml" "procs"; then
        success "Installed the procs config"
        single_slot_note "procs"
    fi
}

install_atuin() {
    section "Atuin"

    copy_variants "${EXTRAS_DIR}/atuin" "${XDG_CONFIG}/atuin/themes" "atuin" "silkcircuit-@.toml"
    success "Installed ${COPIED} Atuin themes"
    diminfo "In ~/.config/atuin/config.toml, under [theme]: name = \"silkcircuit-${PRIMARY}\""
}

install_fastfetch() {
    section "fastfetch"

    if safe_copy "${EXTRAS_DIR}/fastfetch/silkcircuit-${PRIMARY}.jsonc" \
        "${XDG_CONFIG}/fastfetch/config.jsonc" "fastfetch"; then
        success "Installed the fastfetch config"
        single_slot_note "fastfetch"
    fi
}

# ─── Git ─────────────────────────────────────────────────────────────────────

install_git() {
    section "Git"

    local config_dir="${XDG_CONFIG}/git"
    copy_variants "${EXTRAS_DIR}/git" "$config_dir" "git" "silkcircuit-@.gitconfig"

    local include="${config_dir}/silkcircuit-${PRIMARY}.gitconfig"
    if git config --global --get-all include.path 2>/dev/null | grep -qF "silkcircuit-${PRIMARY}.gitconfig"; then
        success "Installed ${COPIED} Git color configs, include already in place"
    elif [[ "$DRY_RUN" == true ]]; then
        success "Installed ${COPIED} Git color configs (dry-run: would add the include)"
    else
        git config --global --add include.path "$include"
        success "Installed ${COPIED} Git color configs and added the include"
    fi

    diminfo "Include: git config --global --add include.path ${include}"
    if ! cmd_exists delta; then
        diminfo "Tip: install delta for diffs that use the matching bat theme"
    fi
}

install_lazygit() {
    section "lazygit"

    local config_dir="${XDG_CONFIG}/lazygit"
    copy_variants "${EXTRAS_DIR}/lazygit" "$config_dir" "lazygit" "silkcircuit-@.yml"

    success "Installed ${COPIED} lazygit themes"
    diminfo "Merge the gui.theme block into ~/.config/lazygit/config.yml, or load both:"
    diminfo "lazygit --use-config-file ~/.config/lazygit/config.yml,${config_dir}/silkcircuit-${PRIMARY}.yml"
}

# ─── System ──────────────────────────────────────────────────────────────────

install_btop() {
    section "btop"

    copy_variants "${EXTRAS_DIR}/btop" "${XDG_CONFIG}/btop/themes" "btop" "silkcircuit-@.theme"
    success "Installed ${COPIED} btop themes"
    diminfo "In btop: Esc -> Options -> Color theme -> silkcircuit-${PRIMARY}"
}

# Point an existing k9s config at a skin, without ever writing a second
# top-level `k9s:` mapping. k9s parses with gopkg.in/yaml.v3, which rejects a
# duplicate key outright ("mapping key already defined"), so appending a sibling
# block does not merely look untidy: it stops k9s reading its config at all.
# More permissive parsers keep only the last mapping and silently drop whatever
# else the user had configured.
#
# Every lookup anchors on direct children: the `ui:` we want is the one exactly
# one level under `k9s:`, and the `skin:` we want is one level under that. A
# `ui:` nested deeper (k9s has a real `views:` key) belongs to something else,
# and editing it would set a skin k9s never reads while quietly rewriting a
# block we were not asked to touch.
#
# Returns 3 when the config uses a shape we will not edit blind, 4 when we
# cannot write it, and 5 when we cannot read it, so the caller reports the real
# reason rather than guessing.
set_k9s_skin() {
    local config="$1"
    local skin="$2"
    local rc=0

    # Only ever rewrite a regular file. Something else sitting at that path (a
    # directory, most likely) is a problem to report, not to write around: `mv`
    # would happily drop the rewritten file inside it and we would report
    # success.
    if [[ -e "$config" && ! -f "$config" ]]; then
        return 4
    fi

    if [[ ! -w "$(dirname "$config")" ]]; then
        return 4
    fi

    if [[ -f "$config" && ! -r "$config" ]]; then
        return 5
    fi

    local work
    work="$(mktemp "${config}.silkcircuit.XXXXXX" 2>/dev/null)" || return 4

    awk -v skin="$skin" -v q="'" '
        function indent_of(text) {
            match(text, /^[[:space:]]*/)
            return RLENGTH
        }

        function pad(width,   out) {
            out = ""
            while (length(out) < width) out = out " "
            return out
        }

        function emit_all(   i) {
            for (i = 1; i <= NR; i++) print out_line(i)
        }

        # A key, bare or quoted either way, followed by its colon.
        function key_pattern(name) {
            return "^[[:space:]]*(" q name q "|\"" name "\"|" name ")[[:space:]]*:"
        }

        # Indentation of the first real child of the block opened at `at`. Read
        # it off the file rather than assuming two spaces, so a config written
        # with four keeps its shape and stays parseable.
        function child_indent(at, own, stop,   i, width) {
            for (i = at + 1; i <= stop; i++) {
                if (line[i] ~ /^[[:space:]]*$/) continue
                if (line[i] ~ /^[[:space:]]*#/) continue
                width = indent_of(line[i])
                if (width > own) return width
                break
            }
            return own + 2
        }

        # Last line belonging to the block opened at `at`, whose children sit at
        # `inner`. Blank and comment lines never close a block.
        function block_extent(at, inner, stop,   i) {
            for (i = at + 1; i <= stop; i++) {
                if (line[i] ~ /^[[:space:]]*$/) continue
                if (line[i] ~ /^[[:space:]]*#/) continue
                if (indent_of(line[i]) < inner) return i - 1
            }
            return stop
        }

        # First direct child of `at` matching `pattern`, ignoring anything
        # nested deeper.
        function find_child(at, stop, inner, pattern,   i) {
            for (i = at + 1; i <= stop; i++) {
                if (indent_of(line[i]) != inner) continue
                if (line[i] ~ pattern) return i
            }
            return 0
        }

        { line[NR] = $0 }

        # A byte order mark sits ahead of the first key and would hide it from
        # every pattern here. Strip it for matching, put it back on output.
        function out_line(i) {
            return (i == 1 ? bom line[i] : line[i])
        }

        END {
            # awk splits on the newline only, so a CRLF file keeps its carriage
            # returns at the end of each stored line. Inserted lines have to
            # carry one too, or the file comes back with mixed endings and a
            # noisy diff.
            cr = (NR > 0 && line[1] ~ /\r$/) ? "\r" : ""

            bom = ""
            if (NR > 0 && substr(line[1], 1, 3) == "\357\273\277") {
                bom = substr(line[1], 1, 3)
                line[1] = substr(line[1], 4)
            }

            root_pattern = key_pattern("k9s")
            root_at = 0
            for (i = 1; i <= NR; i++) {
                if (indent_of(line[i]) == 0 && line[i] ~ root_pattern) { root_at = i; break }
            }

            # No k9s mapping yet, so a fresh one cannot be a duplicate, unless
            # the document is a sequence, where appending one is invalid.
            if (root_at == 0) {
                for (i = 1; i <= NR; i++) {
                    if (line[i] ~ /^[[:space:]]*$/) continue
                    if (line[i] ~ /^[[:space:]]*#/) continue
                    if (line[i] ~ /^-[[:space:]]/) { emit_all(); exit 3 }
                    break
                }
                emit_all()
                if (NR > 0) print cr
                print "k9s:" cr
                print "  ui:" cr
                print "    skin: " skin cr
                exit 0
            }

            # Anything but a comment after the colon means a flow mapping, an
            # anchor, or a scalar. Splicing block-style children under any of
            # those produces nonsense, so decline and leave the file alone.
            rest = line[root_at]
            sub(root_pattern, "", rest)
            if (rest !~ /^[[:space:]]*(#.*)?$/) {
                emit_all()
                exit 3
            }

            root_inner = child_indent(root_at, 0, NR)
            block_end = block_extent(root_at, root_inner, NR)

            ui_pattern = key_pattern("ui")
            ui_at = find_child(root_at, block_end, root_inner, ui_pattern)

            # Same rule as the root: anything but a comment after the colon is a
            # flow mapping or a scalar, and block-style children cannot be
            # spliced under either.
            if (ui_at) {
                rest = line[ui_at]
                sub(ui_pattern, "", rest)
                if (rest !~ /^[[:space:]]*(#.*)?$/) {
                    emit_all()
                    exit 3
                }
            }

            if (ui_at) {
                ui_inner = child_indent(ui_at, root_inner, block_end)
                ui_end = block_extent(ui_at, ui_inner, block_end)
                skin_at = find_child(ui_at, ui_end, ui_inner, key_pattern("skin"))

                if (skin_at) {
                    line[skin_at] = pad(ui_inner) "skin: " skin cr
                    emit_all()
                } else {
                    for (i = 1; i <= NR; i++) {
                        print out_line(i)
                        if (i == ui_at) print pad(ui_inner) "skin: " skin cr
                    }
                }
            } else {
                for (i = 1; i <= NR; i++) {
                    print out_line(i)
                    if (i == root_at) {
                        print pad(root_inner) "ui:" cr
                        print pad(2 * root_inner) "skin: " skin cr
                    }
                }
            }
        }
    ' "$config" > "$work" 2>/dev/null || rc=$?

    if [[ $rc -ne 0 ]]; then
        rm -f "$work"
        # awk failing on the file itself (invalid bytes, unreadable mid-stream)
        # is not a shape we recognise either.
        [[ $rc -eq 3 ]] || rc=6
        return "$rc"
    fi

    # Back up only once we know we are going to write, so a declined config is
    # left with no stray .bak beside it.
    cp "$config" "${config}.silkcircuit.bak" 2>/dev/null || true

    # Never write through a symlink. It usually points into a dotfiles repo,
    # and rewriting the file inside it is exactly what this installer refuses
    # to do elsewhere. Dropping the link leaves a real file here instead.
    rm -f "$config"

    if ! mv "$work" "$config" 2>/dev/null; then
        rm -f "$work"
        return 4
    fi
    return 0
}

install_k9s() {
    section "k9s"

    # Ask k9s where its config lives, since the answer moved between releases
    # and differs per platform.
    local k9s_dir=""
    if cmd_exists k9s; then
        local k9s_cfg
        k9s_cfg="$(k9s info 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' | grep -i '^Config:' | sed 's/^[^:]*:[[:space:]]*//')" || true
        [[ -n "${k9s_cfg:-}" ]] && k9s_dir="$(dirname "$k9s_cfg")"
    fi
    if [[ -z "$k9s_dir" ]]; then
        if [[ "$(uname)" == "Darwin" ]] && [[ ! -d "${XDG_CONFIG}/k9s" ]]; then
            k9s_dir="$HOME/Library/Application Support/k9s"
        else
            k9s_dir="${XDG_CONFIG}/k9s"
        fi
    fi

    copy_variants "${EXTRAS_DIR}/k9s" "${k9s_dir}/skins" "k9s" "silkcircuit-@.yaml"

    local skin="silkcircuit-${PRIMARY}"
    local config="${k9s_dir}/config.yaml"
    local skin_set=true

    # A link whose target is gone reads as "no config" to -e and -f, so the
    # create below would follow it and write into whatever repo it points at.
    # Drop it, exactly as safe_copy drops a link before copying.
    if [[ -L "$config" && ! -e "$config" ]]; then
        rm -f "$config"
    fi
    if [[ "$DRY_RUN" == true ]]; then
        diminfo "dry-run: would set the skin to ${skin} in ${config}"
    elif [[ -e "$config" && ! -f "$config" ]]; then
        # A directory, a socket, anything that is not a regular file. Writing to
        # it would fail and abort the run.
        warn "k9s: ${config} is not a file"
        diminfo "Set k9s.ui.skin to ${skin} yourself"
        skin_set=false
    elif [[ -f "$config" ]]; then
        local k9s_rc=0
        set_k9s_skin "$config" "$skin" || k9s_rc=$?
        if [[ $k9s_rc -ne 0 ]]; then
            case "$k9s_rc" in
                3) warn "k9s: ${config} uses a shape this installer will not edit blind" ;;
                5) warn "k9s: cannot read ${config}" ;;
                6) warn "k9s: could not parse ${config}, leaving it alone" ;;
                *) warn "k9s: cannot write ${config}" ;;
            esac
            diminfo "Set k9s.ui.skin to ${skin} yourself"
            skin_set=false
        fi
    else
        mkdir -p "$k9s_dir" 2>/dev/null || true
        if ! printf 'k9s:\n  ui:\n    skin: %s\n' "$skin" > "$config" 2>/dev/null; then
            warn "k9s: cannot write ${config}"
            diminfo "Set k9s.ui.skin to ${skin} yourself"
            skin_set=false
        fi
    fi

    success "Installed ${COPIED} k9s skins"
    # Only claim the skin is live if we actually managed to set it.
    if [[ "$skin_set" == true ]]; then
        diminfo "Active skin: ${skin}"
    fi
}

install_dmesg() {
    section "dmesg"

    # terminal-colors.d keys a scheme by the utility name, so the file has to
    # land as dmesg.scheme no matter which variant it came from.
    if safe_copy "${EXTRAS_DIR}/dmesg/silkcircuit-${PRIMARY}.scheme" \
        "${XDG_CONFIG}/terminal-colors.d/dmesg.scheme" "dmesg"; then
        success "Installed the dmesg color scheme"
        diminfo "Colors show up with: dmesg --color=always"
        diminfo "System-wide instead: /etc/terminal-colors.d/dmesg.scheme"
        single_slot_note "terminal-colors.d"
    fi
}

install_cosmic() {
    section "COSMIC Desktop"

    copy_variants "${EXTRAS_DIR}/cosmic" "${STAGING}/cosmic" "cosmic" "silkcircuit-@.ron"
    success "Staged ${COPIED} COSMIC themes"
    diminfo "Settings -> Desktop -> Appearance -> Import, then pick:"
    diminfo "${STAGING}/cosmic/silkcircuit-${PRIMARY}.ron"
    diminfo "By hand: dark variants go in com.system76.CosmicTheme.Dark.Builder/v1,"
    diminfo "dawn goes in com.system76.CosmicTheme.Light.Builder/v1"
}

install_slack() {
    section "Slack"

    copy_variants "${EXTRAS_DIR}/slack" "${STAGING}/slack" "slack" "silkcircuit-@.txt"
    success "Staged ${COPIED} Slack themes"
    diminfo "Preferences -> Themes -> Create a custom theme, then paste this line:"

    # The line to paste is ten hex colours, so it starts with '#' exactly like
    # the comments above it. Match its shape rather than filtering comments out.
    local source_file="${EXTRAS_DIR}/slack/silkcircuit-${PRIMARY}.txt"
    local colors=""
    if [[ -f "$source_file" ]]; then
        colors="$(grep -oE '^#[0-9a-fA-F]{6}(,#[0-9a-fA-F]{6}){9}$' "$source_file" | tail -1)"
    fi
    if [[ -n "$colors" ]]; then
        diminfo "$colors"
    else
        diminfo "Could not read the colours from ${source_file}"
    fi
}

# ─── Main install orchestrator ───────────────────────────────────────────────

run_installs() {
    printf "${PURPLE}${BOLD}  INSTALLING${RESET}${CYAN} >> %s${RESET}\n" \
        "$([[ "$VARIANT" == "all" ]] && echo "all five variants" || echo "the ${VARIANT} variant")"
    neon_line 40
    printf '\n'

    local app
    for app in "${DETECTED[@]}"; do
        case "$app" in
            ghostty)          install_ghostty ;;
            alacritty)        install_alacritty ;;
            kitty)            install_kitty ;;
            warp)             install_warp ;;
            wezterm)          install_wezterm ;;
            foot)             install_foot ;;
            iterm2)           install_iterm2 ;;
            tmux)             install_tmux ;;
            zellij)           install_zellij ;;
            helix)            install_helix ;;
            btop)             install_btop ;;
            k9s)              install_k9s ;;
            fzf)              install_fzf ;;
            fastfetch)        install_fastfetch ;;
            starship)         install_starship ;;
            bat)              install_bat ;;
            lsd)              install_lsd ;;
            procs)            install_procs ;;
            atuin)            install_atuin ;;
            lazygit)          install_lazygit ;;
            git)              install_git ;;
            dmesg)            install_dmesg ;;
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
    printf "  ${CYAN}-V, --variant <name>${RESET}   neon, vibrant, soft, glow, dawn, or all (default: all)\n"
    printf "  ${CYAN}-n, --dry-run${RESET}          Show what would be installed\n"
    printf "  ${CYAN}-y, --yes${RESET}              Skip confirmation prompts\n"
    printf "  ${CYAN}-h, --help${RESET}             Show this help\n"
    printf '\n'
    printf "${GRAY}  Tools that hold a directory of themes get every selected variant.\n"
    printf "  Tools that read a single file get neon unless --variant says otherwise.${RESET}\n"
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
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -V|--variant)
                if [[ $# -lt 2 ]]; then
                    fail "--variant needs a name"
                    exit 2
                fi
                VARIANT="$2"; shift 2 ;;
            --variant=*)  VARIANT="${1#*=}"; shift ;;
            -n|--dry-run) DRY_RUN=true; shift ;;
            -y|--yes)     INTERACTIVE=false; shift ;;
            -h|--help)    usage; exit 0 ;;
            *)            warn "Unknown option: $1"; shift ;;
        esac
    done

    resolve_variants

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
