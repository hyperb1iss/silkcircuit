#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = ["pillow>=11"]
# ///
"""Generate SilkCircuit Chrome theme variants.

Creates complete Chrome theme extensions for all 5 SilkCircuit variants:
neon, vibrant, soft, glow, dawn. Each variant gets its own loadable
Chrome extension directory with manifest.json, NTP background images,
DevTools theme CSS, and Chrome pages CSS.
"""

import json
import math
from pathlib import Path

# ---------------------------------------------------------------------------
# Palette
# ---------------------------------------------------------------------------

PALETTE_DIR = Path(__file__).parent.parent / "palette"

VARIANTS = ["neon", "vibrant", "soft", "glow", "dawn"]

# Chrome Web Store copy. The palette ships its own one-line blurb for a reader
# who already knows SilkCircuit; a store listing has to sell the theme, so this
# text is the one thing here that is not a palette fact.
DESCRIPTIONS = {
    "neon": (
        "Electric meets elegant. Neon purple gradients, cyan accents, and "
        "circuit-trace patterns for Chrome."
    ),
    "vibrant": (
        "Electric meets elegant. Ultra-dark with maximum neon saturation — pure "
        "magenta and cyan on void-black."
    ),
    "soft": (
        "Electric meets elegant. Softened neon colors for comfortable browsing — "
        "gentle purples and pastel cyan."
    ),
    "glow": (
        "Electric meets elegant. Pure neon on void-black — maximum contrast for the "
        "ultimate dark experience."
    ),
    "dawn": (
        "Electric meets elegant. Light theme with electric purple accents on soft "
        "lavender backgrounds."
    ),
}

# The generator inherited one role name the palette does not use.
ROLE_ALIASES = {"fg_muted": "purple_muted"}


def load_variant(variant):
    """Read one variant's palette export.

    Hex strings feed the CSS templates and the color maths; the rgb integers
    go straight into the manifest, which is the format Chrome wants.
    """
    data = json.loads((PALETTE_DIR / f"silkcircuit-{variant}.json").read_text())

    v = {name: entry["hex"] for name, entry in data["colors"].items()}
    v["rgb"] = {name: list(entry["rgb"]) for name, entry in data["colors"].items()}
    for alias, role in ROLE_ALIASES.items():
        v[alias] = v[role]
        v["rgb"][alias] = v["rgb"][role]

    v["name"] = data["name"]
    v["description"] = DESCRIPTIONS[variant]
    v["is_dark"] = data["appearance"] == "dark"
    return v


# ---------------------------------------------------------------------------
# Color utilities
# ---------------------------------------------------------------------------


def hex_to_rgb(h):
    """Convert hex color string to [r, g, b] list."""
    h = h.lstrip("#")
    if len(h) == 8:  # RGBA
        h = h[:6]
    return [int(h[i : i + 2], 16) for i in (0, 2, 4)]


def rgb_to_hex(r, g, b):
    """Convert RGB values to hex string."""
    return f"#{r:02x}{g:02x}{b:02x}"


def darken(hex_color, amount):
    """Darken a hex color by amount (0-1)."""
    rgb = hex_to_rgb(hex_color)
    return [max(0, int(c * (1 - amount))) for c in rgb]


def lighten(hex_color, amount):
    """Lighten a hex color by amount (0-1)."""
    rgb = hex_to_rgb(hex_color)
    return [min(255, int(c + (255 - c) * amount)) for c in rgb]


def blend(hex1, hex2, ratio):
    """Blend two hex colors. ratio=1.0 is all hex1, ratio=0.0 is all hex2."""
    r1, r2 = hex_to_rgb(hex1), hex_to_rgb(hex2)
    return [int(r1[i] * ratio + r2[i] * (1 - ratio)) for i in range(3)]


def with_alpha(hex_color, alpha):
    """Return [r, g, b, alpha] for Chrome's RGBA format."""
    rgb = hex_to_rgb(hex_color)
    return [rgb[0], rgb[1], rgb[2], alpha]


# ---------------------------------------------------------------------------
# Manifest generation
# ---------------------------------------------------------------------------


def generate_manifest(variant_key, v):
    """Generate a complete Chrome theme manifest.json."""
    is_dark = v["is_dark"]

    # Frame: match toolbar exactly to prevent separator lines
    frame = lighten(v["bg_highlight"], 0.06) if is_dark else v["rgb"]["bg_dark"]
    frame_inactive = darken(v["bg_highlight"], 0.05) if is_dark else lighten(v["bg_dark"], 0.05)

    # Incognito: subtle purple tint on the frame
    if is_dark:
        incognito_frame = blend(v["bg_dark"], v["purple"], 0.88)
        incognito_frame_inactive = darken(rgb_to_hex(*blend(v["bg_dark"], v["purple"], 0.88)), 0.15)
    else:
        incognito_frame = blend(v["bg_dark"], v["purple"], 0.92)
        incognito_frame_inactive = blend(v["bg_dark"], v["purple"], 0.95)

    # Toolbar = active tab bg (Chrome hardcoded). Slight lighten so Chrome's
    # derived tab stroke blends into the gradient instead of reading as black.
    toolbar = lighten(v["bg_highlight"], 0.06) if is_dark else v["rgb"]["bg"]

    # Tab text colors — bright active vs muted-purple inactive.
    tab_text = [255, 255, 255] if is_dark else v["rgb"]["fg"]
    tab_bg_text = v["rgb"]["fg_muted"] if is_dark else v["rgb"]["fg_dark"]
    tab_bg_text_inactive = (
        blend(v["fg_muted"], v["bg"], 0.55) if is_dark else blend(v["fg_dark"], v["bg"], 0.5)
    )
    tab_bg_text_incognito = tab_bg_text
    tab_bg_text_incognito_inactive = tab_bg_text_inactive

    # Background tabs — match frame exactly to prevent any separator lines
    bg_tab = frame
    bg_tab_inactive = frame_inactive
    bg_tab_incognito = incognito_frame
    bg_tab_incognito_inactive = incognito_frame_inactive

    # Omnibox — slightly distinct from toolbar
    omnibox_bg = blend(v["bg"], v["bg_highlight"], 0.5) if is_dark else v["rgb"]["bg_highlight"]

    # Button — subtle accent with transparency
    button_alpha = 0.15 if is_dark else 0.08

    manifest = {
        "manifest_version": 3,
        "version": "2.0.0",
        "name": v["name"],
        "description": v["description"],
        "theme": {
            "colors": {
                # Frame
                "frame": frame,
                "frame_inactive": frame_inactive,
                "frame_incognito": incognito_frame,
                "frame_incognito_inactive": incognito_frame_inactive,
                # Toolbar
                "toolbar": toolbar,
                "toolbar_text": v["rgb"]["fg"],
                "toolbar_button_icon": v["rgb"]["coral"],
                # Active tab
                "tab_text": tab_text,
                # Inactive tabs
                "tab_background_text": tab_bg_text,
                "tab_background_text_inactive": tab_bg_text_inactive,
                "tab_background_text_incognito": tab_bg_text_incognito,
                "tab_background_text_incognito_inactive": tab_bg_text_incognito_inactive,
                # Background tabs
                "background_tab": bg_tab,
                "background_tab_inactive": bg_tab_inactive,
                "background_tab_incognito": bg_tab_incognito,
                "background_tab_incognito_inactive": bg_tab_incognito_inactive,
                # Bookmark bar
                "bookmark_text": v["rgb"]["coral"],
                # Buttons
                "button_background": with_alpha(v["purple"], button_alpha),
                # Omnibox / address bar
                "omnibox_background": omnibox_bg,
                "omnibox_text": v["rgb"]["fg"],
                # New Tab Page
                "ntp_background": v["rgb"]["bg"],
                "ntp_text": v["rgb"]["fg"],
                "ntp_link": v["rgb"]["cyan"],
                "ntp_header": v["rgb"]["purple_dark"],
            },
            "tints": {
                # Buttons tint: shift toolbar/tab buttons toward pink/coral
                # [hue 0-1, saturation 0-1, lightness 0-1], -1 = no change
                "buttons": [0.92, 0.7, 0.7] if is_dark else [0.83, 0.6, 0.4],
                "frame": [-1, -1, -1],
                "frame_inactive": [-1, -1, -1],
                "frame_incognito": [-1, -1, -1],
                "frame_incognito_inactive": [-1, -1, -1],
                "background_tab": [-1, -1, -1],
            },
            "properties": {
                "ntp_background_alignment": "center",
                "ntp_background_repeat": "no-repeat",
                # White logo for dark themes, colorful for dawn
                "ntp_logo_alternate": 1 if is_dark else 0,
            },
            "images": {
                "theme_ntp_background": "images/ntp_background.png",
                "theme_toolbar": "images/toolbar.png",
            },
            # Tab group colors — SilkCircuit-branded
            "tab_group_color_palette": {
                "grey_override": v["rgb"]["gray"],
                "blue_override": v["rgb"]["blue"],
                "red_override": v["rgb"]["red"],
                "yellow_override": v["rgb"]["yellow"],
                "green_override": v["rgb"]["green"],
                "pink_override": v["rgb"]["coral"],
                "purple_override": v["rgb"]["purple"],
                "cyan_override": v["rgb"]["cyan"],
                "orange_override": v["rgb"]["orange"],
            },
        },
    }

    return manifest


# ---------------------------------------------------------------------------
# DevTools CSS generation — targets modern Chrome (CM6 + --sys-color-*)
# ---------------------------------------------------------------------------


def generate_devtools_css(variant_key, v):
    """Generate DevTools theme CSS using modern Chrome custom properties."""
    is_dark = v["is_dark"]

    return f"""/* SilkCircuit {variant_key.title()} — DevTools Theme
 *
 * Targets Chrome DevTools (2025+) using modern CSS custom properties.
 * Uses --sys-color-* tokens and .token-* classes (CodeMirror 6).
 *
 * Setup: DevTools > Settings > Experiments > "Allow extensions to load
 * custom stylesheets", then load via a DevTools theme extension.
 */

/* ── Core surfaces ──────────────────────────────────────────────────── */

:root,
body,
.theme-with-dark-background,
.-theme-with-dark-background {{
  /* Base surfaces */
  --sys-color-base: {v["bg"]} !important;
  --sys-color-base-container: {v["bg_dark"]} !important;
  --sys-color-base-container-elevated: {v["bg_highlight"]} !important;
  --sys-color-cdt-base: {v["bg"]} !important;
  --sys-color-cdt-base-container: {v["bg_dark"]} !important;

  /* Elevation surfaces */
  --sys-color-surface: {v["bg"]} !important;
  --sys-color-surface1: {v["bg"]} !important;
  --sys-color-surface2: {v["bg_highlight"]} !important;
  --sys-color-surface3: {v["bg_highlight"]} !important;
  --sys-color-surface4: {v["bg_highlight"]} !important;
  --sys-color-surface5: {v["bg_highlight"]} !important;
  --sys-color-surface-variant: {v["bg_highlight"]} !important;

  /* Status surfaces */
  --sys-color-surface-error: {"rgba(255, 99, 99, 0.08)" if is_dark else "rgba(193, 39, 45, 0.08)"} !important;
  --sys-color-surface-green: {"rgba(80, 250, 123, 0.08)" if is_dark else "rgba(45, 134, 89, 0.08)"} !important;
  --sys-color-surface-yellow: {"rgba(241, 250, 140, 0.08)" if is_dark else "rgba(168, 134, 0, 0.08)"} !important;
  --sys-color-surface-yellow-high: {"rgba(241, 250, 140, 0.15)" if is_dark else "rgba(168, 134, 0, 0.15)"} !important;

  /* ── Text colors ────────────────────────────────────────────────── */

  --sys-color-on-base: {v["fg"]} !important;
  --sys-color-on-surface: {v["fg"]} !important;
  --sys-color-on-surface-subtle: {v["fg_muted"]} !important;
  --sys-color-on-surface-secondary: {v["gray"]} !important;
  --sys-color-on-surface-primary: {v["fg"]} !important;

  /* ── Primary / accent ───────────────────────────────────────────── */

  --sys-color-primary: {v["purple"]} !important;
  --sys-color-primary-bright: {v["purple"]} !important;
  --sys-color-on-primary: {v["bg"]} !important;
  --sys-color-secondary: {v["cyan"]} !important;
  --sys-color-on-secondary: {v["bg"]} !important;
  --sys-color-tertiary: {v["pink"]} !important;
  --sys-color-on-tertiary: {v["bg"]} !important;
  --sys-color-tertiary-container: {v["bg_highlight"]} !important;
  --sys-color-on-tertiary-container: {v["pink_soft"]} !important;

  /* Containers */
  --sys-color-tonal-container: {v["bg_highlight"]} !important;
  --sys-color-on-tonal-container: {v["fg"]} !important;
  --sys-color-tonal-outline: {v["purple_dark"]} !important;
  --sys-color-header-container: {v["bg_dark"]} !important;
  --sys-color-omnibox-container: {v["bg_highlight"]} !important;
  --sys-color-neutral-container: {v["bg_visual"]} !important;
  --sys-color-neutral-bright: {v["fg_dark"]} !important;
  --sys-color-neutral-outline: {v["gray"]} !important;

  /* ── Named semantic colors ──────────────────────────────────────── */

  --sys-color-blue: {v["blue"]} !important;
  --sys-color-blue-bright: {v["blue"]} !important;
  --sys-color-cyan: {v["cyan"]} !important;
  --sys-color-cyan-bright: {v["cyan_bright"]} !important;
  --sys-color-green: {v["green"]} !important;
  --sys-color-green-bright: {v["green"]} !important;
  --sys-color-orange: {v["orange"]} !important;
  --sys-color-orange-bright: {v["coral"]} !important;
  --sys-color-pink: {v["pink"]} !important;
  --sys-color-pink-bright: {v["pink_soft"]} !important;
  --sys-color-purple: {v["purple"]} !important;
  --sys-color-purple-bright: {v["purple"]} !important;
  --sys-color-yellow: {v["yellow"]} !important;
  --sys-color-yellow-bright: {v["yellow"]} !important;
  --sys-color-yellow-container: {"rgba(241, 250, 140, 0.15)" if is_dark else "rgba(168, 134, 0, 0.12)"} !important;
  --sys-color-yellow-outline: {v["yellow"]} !important;

  /* Error / status */
  --sys-color-error: {v["red"]} !important;
  --sys-color-error-bright: {v["red"]} !important;
  --sys-color-error-container: {"rgba(255, 99, 99, 0.12)" if is_dark else "rgba(193, 39, 45, 0.12)"} !important;
  --sys-color-error-outline: {v["red"]} !important;
  --sys-color-on-error: {v["bg"]} !important;
  --sys-color-on-error-container: {v["red"]} !important;
  --sys-color-on-surface-error: {v["red"]} !important;
  --sys-color-on-surface-green: {v["green"]} !important;
  --sys-color-on-surface-yellow: {v["yellow"]} !important;

  /* ── Dividers & outlines ────────────────────────────────────────── */

  --sys-color-divider: {"rgba(149, 128, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.12)"} !important;
  --sys-color-divider-prominent: {"rgba(225, 53, 255, 0.3)" if is_dark else "rgba(126, 43, 213, 0.25)"} !important;
  --sys-color-outline: {v["gray"]} !important;

  /* ── Gradients ──────────────────────────────────────────────────── */

  --sys-color-gradient-primary: {v["purple"]} !important;
  --sys-color-gradient-tertiary: {v["cyan"]} !important;

  /* ── Interactive states ─────────────────────────────────────────── */

  --sys-color-state-hover-on-subtle: {"rgba(225, 53, 255, 0.08)" if is_dark else "rgba(126, 43, 213, 0.06)"} !important;
  --sys-color-state-hover-on-prominent: {"rgba(225, 53, 255, 0.12)" if is_dark else "rgba(126, 43, 213, 0.10)"} !important;
  --sys-color-state-focus-highlight: {v["purple"]} !important;
  --sys-color-state-focus-ring: {v["cyan"]} !important;
  --sys-color-state-ripple-primary: {"rgba(225, 53, 255, 0.2)" if is_dark else "rgba(126, 43, 213, 0.15)"} !important;
  --sys-color-state-ripple-neutral-on-subtle: {"rgba(248, 248, 242, 0.08)" if is_dark else "rgba(43, 37, 64, 0.06)"} !important;
  --sys-color-state-text-highlight: {"rgba(225, 53, 255, 0.25)" if is_dark else "rgba(126, 43, 213, 0.18)"} !important;

  /* ── Syntax token colors (CodeMirror 6) ─────────────────────────── */

  --sys-color-token-keyword: {v["purple"]} !important;
  --sys-color-token-variable: {v["fg"]} !important;
  --sys-color-token-definition: {v["cyan"]} !important;
  --sys-color-token-property: {v["cyan_bright"]} !important;
  --sys-color-token-property-special: {v["coral"]} !important;
  --sys-color-token-type: {v["yellow"]} !important;
  --sys-color-token-variable-special: {v["coral"]} !important;
  --sys-color-token-builtin: {v["cyan_bright"]} !important;
  --sys-color-token-number: {v["coral"]} !important;
  --sys-color-token-string: {v["pink_soft"]} !important;
  --sys-color-token-string-special: {v["cyan_bright"]} !important;
  --sys-color-token-atom: {v["purple"]} !important;
  --sys-color-token-comment: {v["purple_dark"]} !important;
  --sys-color-token-meta: {v["gray"]} !important;
  --sys-color-token-tag: {v["pink"]} !important;
  --sys-color-token-attribute: {v["purple"]} !important;
  --sys-color-token-attribute-value: {v["pink_soft"]} !important;
  --sys-color-token-inserted: {v["green"]} !important;
  --sys-color-token-deleted: {v["red"]} !important;
  --sys-color-token-subtle: {v["gray"]} !important;
  --sys-color-token-pseudo-element: {v["purple_dark"]} !important;

  /* ── UI chrome overrides ────────────────────────────────────────── */

  --override-toolbar-background-color: {v["bg_dark"]} !important;
  --override-current-search-result-background-color: {"rgba(241, 250, 140, 0.3)" if is_dark else "rgba(168, 134, 0, 0.2)"} !important;
  --app-color-toolbar-background: {v["bg_dark"]} !important;

  /* Links */
  --text-link: {v["cyan"]} !important;

  /* Console ANSI colors */
  --console-color-red: {v["red"]} !important;
  --console-color-green: {v["green"]} !important;
  --console-color-yellow: {v["yellow"]} !important;
  --console-color-blue: {v["blue"]} !important;
  --console-color-magenta: {v["pink"]} !important;
  --console-color-cyan: {v["cyan"]} !important;
  --console-color-bright-red: {v["red"]} !important;
  --console-color-bright-green: {v["green"]} !important;
  --console-color-bright-yellow: {v["yellow"]} !important;
  --console-color-bright-blue: {v["blue"]} !important;
  --console-color-bright-magenta: {v["pink_soft"]} !important;
  --console-color-bright-cyan: {v["cyan_bright"]} !important;
}}

/* ── CM6 token classes (direct styling fallback) ────────────────────── */

.token-keyword {{ color: {v["purple"]} !important; }}
.token-variable {{ color: {v["fg"]} !important; }}
.token-definition {{ color: {v["cyan"]} !important; }}
.token-property {{ color: {v["cyan_bright"]} !important; }}
.token-type {{ color: {v["yellow"]} !important; }}
.token-variable-special {{ color: {v["coral"]} !important; }}
.token-builtin {{ color: {v["cyan_bright"]} !important; }}
.token-number {{ color: {v["coral"]} !important; }}
.token-string {{ color: {v["pink_soft"]} !important; }}
.token-string-special {{ color: {v["cyan_bright"]} !important; }}
.token-atom {{ color: {v["purple"]} !important; }}
.token-comment {{ color: {v["purple_dark"]} !important; font-style: italic; }}
.token-meta {{ color: {v["gray"]} !important; }}
.token-tag {{ color: {v["pink"]} !important; }}
.token-attribute {{ color: {v["purple"]} !important; }}
.token-attribute-value {{ color: {v["pink_soft"]} !important; }}
.token-inserted {{ color: {v["green"]} !important; }}
.token-deleted {{ color: {v["red"]} !important; text-decoration: line-through; }}

/* ── CM5 fallback (older Chrome versions) ───────────────────────────── */

.cm-keyword {{ color: {v["purple"]} !important; }}
.cm-string {{ color: {v["pink_soft"]} !important; }}
.cm-number {{ color: {v["coral"]} !important; }}
.cm-property {{ color: {v["cyan_bright"]} !important; }}
.cm-variable {{ color: {v["fg"]} !important; }}
.cm-comment {{ color: {v["purple_dark"]} !important; font-style: italic; }}
.cm-tag {{ color: {v["pink"]} !important; }}
.cm-attribute {{ color: {v["purple"]} !important; }}

/* ── Editor chrome ──────────────────────────────────────────────────── */

.cm-editor {{
  background-color: {v["bg"]} !important;
}}

.cm-content {{
  caret-color: {v["cyan"]} !important;
}}

.cm-cursor {{
  border-left-color: {v["cyan"]} !important;
}}

.cm-selectionBackground,
.cm-selection {{
  background-color: {v["bg_visual"]} !important;
}}

.cm-selectionMatch {{
  background-color: {"rgba(241, 250, 140, 0.15)" if is_dark else "rgba(168, 134, 0, 0.12)"} !important;
}}

.cm-matchingBracket {{
  background-color: {"rgba(128, 255, 234, 0.2)" if is_dark else "rgba(0, 127, 142, 0.15)"} !important;
  outline: 1px solid {v["cyan"]} !important;
}}

.cm-gutters {{
  background-color: {v["bg_dark"]} !important;
  border-right: 1px solid {"rgba(149, 128, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
}}

.cm-lineNumbers {{
  color: {v["gray"]} !important;
}}

.cm-foldPlaceholder {{
  color: {v["purple_dark"]} !important;
}}

.cm-highlightedLine {{
  background-color: {"rgba(225, 53, 255, 0.06)" if is_dark else "rgba(126, 43, 213, 0.05)"} !important;
}}

/* ── Console panel ──────────────────────────────────────────────────── */

.console-message-wrapper.console-error-level {{
  background-color: {"rgba(255, 99, 99, 0.08)" if is_dark else "rgba(193, 39, 45, 0.06)"} !important;
  border-left-color: {v["red"]} !important;
}}

.console-message-wrapper.console-warning-level {{
  background-color: {"rgba(241, 250, 140, 0.08)" if is_dark else "rgba(168, 134, 0, 0.06)"} !important;
  border-left-color: {v["yellow"]} !important;
}}

#console-prompt .console-prompt-icon {{
  color: {v["cyan"]} !important;
}}

.console-eager-inner-preview {{
  color: {v["gray"]} !important;
}}

/* ── Network panel ──────────────────────────────────────────────────── */

.network-log-grid.data-grid thead {{
  background-color: {v["bg_highlight"]} !important;
}}

.network-error-row {{
  color: {v["red"]} !important;
}}

.network-warning-row {{
  color: {v["yellow"]} !important;
}}

.network-summary-bar {{
  background-color: {v["bg_dark"]} !important;
  border-top: 1px solid {"rgba(149, 128, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
}}

/* ── Elements panel ─────────────────────────────────────────────────── */

.elements-disclosure li.selected .selection {{
  background-color: {"rgba(225, 53, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
}}

.webkit-css-property {{
  color: {v["cyan"]} !important;
}}

/* ── Sources panel ──────────────────────────────────────────────────── */

.breakpoint-item.hit {{
  background-color: {"rgba(241, 250, 140, 0.15)" if is_dark else "rgba(168, 134, 0, 0.1)"} !important;
}}

.paused-message {{
  background-color: {"rgba(241, 250, 140, 0.1)" if is_dark else "rgba(168, 134, 0, 0.08)"} !important;
  color: {v["yellow"]} !important;
}}

/* ── Shared data grid ───────────────────────────────────────────────── */

.data-grid tbody tr.selected {{
  background-color: {"rgba(225, 53, 255, 0.12)" if is_dark else "rgba(126, 43, 213, 0.08)"} !important;
}}

.data-grid th {{
  background-color: {v["bg_highlight"]} !important;
  border-bottom: 1px solid {"rgba(149, 128, 255, 0.2)" if is_dark else "rgba(126, 43, 213, 0.15)"} !important;
}}

.striped-data-grid .data-grid-data-grid-node:nth-child(even) {{
  background-color: {v["bg_dark"]} !important;
}}

/* ── Tabs ───────────────────────────────────────────────────────────── */

.tabbed-pane-header {{
  background-color: {v["bg_dark"]} !important;
  border-bottom: 1px solid {"rgba(149, 128, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
}}

.tabbed-pane-header-tab.selected {{
  background-color: {v["bg"]} !important;
}}

.tab-slider {{
  background-color: {v["purple"]} !important;
}}

/* ── Toolbar ────────────────────────────────────────────────────────── */

.toolbar {{
  background-color: {v["bg_dark"]} !important;
  border-bottom: 1px solid {"rgba(149, 128, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
}}

.toolbar-button {{
  color: {v["cyan"]} !important;
}}

.toolbar-button:hover {{
  background-color: {v["bg_highlight"]} !important;
}}

/* ── Status bar ─────────────────────────────────────────────────────── */

.status-bar {{
  background-color: {v["bg_dark"]} !important;
  border-top: 1px solid {"rgba(149, 128, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
}}

/* ── Scrollbars ─────────────────────────────────────────────────────── */

::-webkit-scrollbar {{
  width: 10px;
  height: 10px;
}}

::-webkit-scrollbar-track {{
  background: {v["bg_dark"]} !important;
}}

::-webkit-scrollbar-thumb {{
  background: {v["purple_dark"]} !important;
  border-radius: 5px;
}}

::-webkit-scrollbar-thumb:hover {{
  background: {v["purple"]} !important;
}}

/* ── Selection ──────────────────────────────────────────────────────── */

::selection {{
  background-color: {v["purple"]} !important;
  color: {v["bg"]} !important;
}}

/* ── Links ──────────────────────────────────────────────────────────── */

a {{
  color: {v["cyan"]} !important;
}}

a:hover {{
  color: {v["cyan_bright"]} !important;
}}

/* ── Search highlights ──────────────────────────────────────────────── */

.highlighted-search-result {{
  background-color: {v["yellow"]} !important;
  color: {v["bg"]} !important;
}}
"""


# ---------------------------------------------------------------------------
# Chrome internal pages CSS
# ---------------------------------------------------------------------------


def generate_chrome_pages_css(variant_key, v):
    """Generate CSS for theming Chrome's internal pages (chrome://* via Stylus)."""
    is_dark = v["is_dark"]

    return f"""/* SilkCircuit {variant_key.title()} — Chrome Internal Pages Theme
 *
 * Themes chrome://settings, extensions, downloads, history, bookmarks, flags.
 * Install via Stylus extension with URL pattern: chrome://*
 *
 * Targets Chrome's --cr-* custom properties which cascade into Shadow DOM
 * components (cr-button, cr-toggle, cr-input, cr-toolbar, etc).
 */

@-moz-document regexp("chrome://.*"), regexp("chrome-extension://.*") {{

  /* ── Root variable overrides ────────────────────────────────────── */

  :root {{
    /* Page backgrounds */
    --md-background-color: {v["bg"]} !important;
    --cr-card-background-color: {v["bg_highlight"]} !important;
    --cr-card-border-radius: 12px !important;
    --cr-dialog-background-color: {v["bg_highlight"]} !important;
    --cr-menu-background-color: {v["bg_dark"]} !important;
    --cr-menu-background-focus-color: {v["bg_highlight"]} !important;

    /* Text */
    --cr-primary-text-color: {v["fg"]} !important;
    --cr-secondary-text-color: {v["fg_muted"]} !important;
    --cr-title-text-color: {v["purple"]} !important;
    --cr-form-field-label-color: {v["cyan"]} !important;
    --cr-link-color: {v["cyan"]} !important;

    /* Fallback surface colors */
    --cr-fallback-color-surface: {v["bg"]} !important;
    --cr-fallback-color-surface1: {v["bg"]} !important;
    --cr-fallback-color-surface2: {v["bg_highlight"]} !important;
    --cr-fallback-color-surface3: {v["bg_highlight"]} !important;
    --cr-fallback-color-surface-variant: {v["bg_highlight"]} !important;
    --cr-fallback-color-on-surface-rgb: {", ".join(str(c) for c in v["rgb"]["fg"])} !important;
    --cr-fallback-color-on-surface-variant: {v["fg_muted"]} !important;
    --cr-fallback-color-on-surface-subtle: {v["gray"]} !important;
    --cr-fallback-color-primary: {v["purple"]} !important;
    --cr-fallback-color-inverse-surface: {v["fg"]} !important;
    --cr-fallback-color-inverse-on-surface: {v["bg"]} !important;
    --cr-fallback-color-inverse-primary: {v["cyan"]} !important;

    /* Buttons */
    --cr-button-background-color: {v["bg_highlight"]} !important;
    --cr-button-border-color: {v["purple"]} !important;
    --cr-button-text-color: {v["fg"]} !important;
    --cr-button-hover-background-color: {"rgba(225, 53, 255, 0.12)" if is_dark else "rgba(126, 43, 213, 0.08)"} !important;
    --cr-button-ripple-color: {v["purple"]} !important;
    --cr-button-ripple-opacity: 0.15 !important;

    /* Toggle / switch */
    --cr-toggle-color: {v["purple_dark"]} !important;
    --cr-toggle-checked-bar-color: {v["purple"]} !important;
    --cr-toggle-checked-button-color: {v["fg"] if is_dark else v["purple"]} !important;
    --cr-toggle-checked-ripple-color: {"rgba(225, 53, 255, 0.25)" if is_dark else "rgba(126, 43, 213, 0.2)"} !important;
    --cr-toggle-unchecked-bar-color: {v["gray"]} !important;
    --cr-toggle-unchecked-button-color: {v["fg_muted"]} !important;
    --cr-toggle-unchecked-ripple-color: {"rgba(248, 248, 242, 0.1)" if is_dark else "rgba(43, 37, 64, 0.08)"} !important;

    /* Input fields */
    --cr-input-border: 1px solid {v["gray"]} !important;
    --cr-input-error-color: {v["red"]} !important;
    --cr-input-placeholder-color: {v["gray"]} !important;

    /* Separators & borders */
    --cr-separator-color: {"rgba(149, 128, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
    --cr-separator-line: 1px solid {"rgba(149, 128, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
    --cr-hairline: 1px solid {"rgba(149, 128, 255, 0.1)" if is_dark else "rgba(126, 43, 213, 0.06)"} !important;

    /* Shadows — purple-tinted */
    --cr-elevation-1: 0 1px 2px {"rgba(225, 53, 255, 0.08)" if is_dark else "rgba(126, 43, 213, 0.06)"} !important;
    --cr-elevation-2: 0 2px 6px {"rgba(225, 53, 255, 0.12)" if is_dark else "rgba(126, 43, 213, 0.08)"} !important;
    --cr-elevation-3: 0 4px 12px {"rgba(225, 53, 255, 0.16)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
    --cr-card-shadow: var(--cr-elevation-2) !important;
    --cr-menu-shadow: var(--cr-elevation-3) !important;

    /* Interaction states */
    --cr-hover-background-color: {"rgba(225, 53, 255, 0.08)" if is_dark else "rgba(126, 43, 213, 0.06)"} !important;
    --cr-active-background-color: {"rgba(225, 53, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
    --cr-focus-outline-color: {v["cyan"]} !important;
    --cr-focused-item-color: {"rgba(225, 53, 255, 0.12)" if is_dark else "rgba(126, 43, 213, 0.08)"} !important;
    --cr-selected-background-color: {"rgba(225, 53, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
    --cr-checked-color: {v["purple"]} !important;

    /* Checkbox */
    --cr-checkbox-checked-box-color: {v["purple"]} !important;
    --cr-checkbox-mark-color: {v["bg"]} !important;
    --cr-checkbox-ripple-checked-color: {v["purple"]} !important;
    --cr-checkbox-unchecked-box-color: {v["gray"]} !important;

    /* Tabs */
    --cr-tabs-selected-color: {v["purple"]} !important;
    --cr-tabs-unselected-color: {v["fg_muted"]} !important;

    /* Toast notifications */
    --cr-toast-background: {v["bg_highlight"]} !important;
    --cr-toast-text-color: {v["fg"]} !important;
    --cr-toast-button-color: {v["cyan"]} !important;

    /* Slider */
    --cr-slider-active-color: {v["purple"]} !important;
    --cr-slider-container-color: {v["gray"]} !important;
    --cr-slider-knob-color-rgb: {", ".join(str(c) for c in v["rgb"]["purple"])} !important;

    /* Progress */
    --cr-progress-active-color: {v["purple"]} !important;
    --cr-progress-container-color: {v["gray"]} !important;

    /* Search field */
    --cr-search-field-search-icon-fill: {v["cyan"]} !important;
    --cr-search-field-clear-icon-fill: {v["fg_muted"]} !important;
    --cr-search-field-placeholder-color: {v["gray"]} !important;

    /* Icon colors */
    --iron-icon-fill-color: {v["fg_muted"]} !important;

    /* Toolbar */
    --cr-toolbar-background-color: {v["bg_dark"]} !important;
  }}

  /* ── Base styles ────────────────────────────────────────────────── */

  body {{
    background-color: {v["bg"]} !important;
    color: {v["fg"]} !important;
  }}

  /* ── Cards ──────────────────────────────────────────────────────── */

  .cr-card,
  extensions-item {{
    background-color: {v["bg_highlight"]} !important;
    border: 1px solid {"rgba(225, 53, 255, 0.15)" if is_dark else "rgba(126, 43, 213, 0.1)"} !important;
    border-radius: 12px !important;
  }}

  /* ── Settings page ──────────────────────────────────────────────── */

  settings-ui::part(container) {{
    background-color: {v["bg"]} !important;
  }}

  /* ── Extensions page ────────────────────────────────────────────── */

  extensions-manager {{
    background-color: {v["bg"]} !important;
  }}

  /* ── Downloads ──────────────────────────────────────────────────── */

  downloads-manager {{
    background-color: {v["bg"]} !important;
  }}

  downloads-item {{
    background-color: {v["bg_highlight"]} !important;
    border-bottom: 1px solid {"rgba(225, 53, 255, 0.12)" if is_dark else "rgba(126, 43, 213, 0.08)"} !important;
  }}

  /* ── History ────────────────────────────────────────────────────── */

  history-app {{
    background-color: {v["bg"]} !important;
  }}

  /* ── Bookmarks ──────────────────────────────────────────────────── */

  bookmarks-folder-node,
  bookmarks-item {{
    background-color: {v["bg_highlight"]} !important;
  }}

  /* ── Search boxes ───────────────────────────────────────────────── */

  cr-toolbar-search-field {{
    background-color: {v["bg_highlight"]} !important;
    border: 1px solid {v["gray"]} !important;
    border-radius: 8px !important;
  }}

  cr-toolbar-search-field:focus-within {{
    border-color: {v["purple"]} !important;
    box-shadow: 0 0 0 1px {v["purple"]}40 !important;
  }}

  /* ── Hover effects ──────────────────────────────────────────────── */

  .cr-button:hover,
  .cr-icon-button:hover,
  .cr-link-button:hover {{
    background-color: {"rgba(225, 53, 255, 0.08)" if is_dark else "rgba(126, 43, 213, 0.06)"} !important;
  }}

  /* ── Scrollbars ─────────────────────────────────────────────────── */

  ::-webkit-scrollbar {{
    width: 10px;
    height: 10px;
  }}

  ::-webkit-scrollbar-track {{
    background: {v["bg_dark"]} !important;
  }}

  ::-webkit-scrollbar-thumb {{
    background: {v["purple_dark"]} !important;
    border-radius: 5px;
  }}

  ::-webkit-scrollbar-thumb:hover {{
    background: {v["purple"]} !important;
  }}

  /* ── Selection ──────────────────────────────────────────────────── */

  ::selection {{
    background-color: {v["purple"]} !important;
    color: {v["bg"]} !important;
  }}

  /* ── Links ──────────────────────────────────────────────────────── */

  a {{
    color: {v["cyan"]} !important;
  }}

  a:hover {{
    color: {v["cyan_bright"]} !important;
  }}

  /* ── Code blocks ────────────────────────────────────────────────── */

  code, pre {{
    background-color: {v["bg_dark"]} !important;
    color: {v["pink_soft"]} !important;
    border: 1px solid {"rgba(225, 53, 255, 0.2)" if is_dark else "rgba(126, 43, 213, 0.15)"} !important;
    border-radius: 6px !important;
  }}

  /* ── Flags page ─────────────────────────────────────────────────── */

  .experiment {{
    background-color: {v["bg_highlight"]} !important;
    border: 1px solid {"rgba(225, 53, 255, 0.1)" if is_dark else "rgba(126, 43, 213, 0.06)"} !important;
    border-radius: 8px !important;
  }}

  .experiment-name {{
    color: {v["cyan"]} !important;
  }}

  .experiment select {{
    background-color: {v["bg_dark"]} !important;
    color: {v["fg"]} !important;
    border: 1px solid {v["gray"]} !important;
    border-radius: 6px !important;
  }}

  .experiment select:focus {{
    border-color: {v["purple"]} !important;
  }}
}}
"""


# ---------------------------------------------------------------------------
# Chrome UI images (toolbar, frame, tab backgrounds)
# ---------------------------------------------------------------------------


def generate_toolbar_image(v, width=200, height=160):
    """Generate toolbar image with full neon glow gradient.

    Chrome aligns from bottom. Bright accent at top fading to bg at bottom.
    Chrome draws a 1px separator at the toolbar/frame boundary — unavoidable
    on dark themes, but the gradient makes it blend in naturally.
    """
    try:
        from PIL import Image, ImageDraw
    except ImportError:
        return None

    is_dark = v["is_dark"]
    bg = tuple(lighten(v["bg_highlight"], 0.06)) if is_dark else tuple(v["rgb"]["bg"])
    accent = tuple(v["rgb"]["purple"])

    img = Image.new("RGB", (width, height), bg)
    draw = ImageDraw.Draw(img)

    for y in range(height):
        t = y / height
        blend = (1 - t) ** 1.5
        peak = 0.5 if is_dark else 0.3
        factor = blend * peak
        r = int(accent[0] * factor + bg[0] * (1 - factor))
        g = int(accent[1] * factor + bg[1] * (1 - factor))
        b = int(accent[2] * factor + bg[2] * (1 - factor))
        draw.line([(0, y), (width, y)], fill=(r, g, b))

    return img


def generate_frame_image(v):
    """Generate 1x1 frame image — matches toolbar base color."""
    try:
        from PIL import Image
    except ImportError:
        return None

    is_dark = v["is_dark"]
    bg = tuple(lighten(v["bg_highlight"], 0.06)) if is_dark else tuple(v["rgb"]["bg_dark"])
    return Image.new("RGB", (1, 1), bg)


def generate_tab_background_image(v):
    """Generate 1x1 RGBA inactive tab background.

    Using RGBA with slight transparency (matching Pink Triangles approach)
    lets the frame show through and may soften Chrome's tab stroke rendering.
    """
    try:
        from PIL import Image
    except ImportError:
        return None

    is_dark = v["is_dark"]
    bg = tuple(lighten(v["bg_highlight"], 0.06)) if is_dark else tuple(v["rgb"]["bg_dark"])
    return Image.new("RGBA", (1, 1), (*bg, 230))


# ---------------------------------------------------------------------------
# NTP background image generation (circuit-trace pattern)
# ---------------------------------------------------------------------------


def generate_ntp_background(variant_key, v, width=1920, height=1080):
    """Generate a subtle circuit-trace NTP background PNG using Pillow."""
    try:
        from PIL import Image, ImageDraw, ImageFilter
    except ImportError:
        print(f"  Pillow not available — skipping NTP background for {variant_key}")
        return None

    is_dark = v["is_dark"]
    bg_rgb = tuple(v["rgb"]["bg"])
    accent_rgb = tuple(v["rgb"]["purple"])
    secondary_rgb = tuple(v["rgb"]["cyan"])

    # Base opacity for traces
    trace_alpha = 35 if is_dark else 20

    img = Image.new("RGBA", (width, height), (*bg_rgb, 255))

    # Create trace layer with low opacity
    trace_layer = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    trace_draw = ImageDraw.Draw(trace_layer)

    import random

    # Fixed seeds per variant for deterministic output
    variant_seeds = {"neon": 1001, "vibrant": 2002, "soft": 3003, "glow": 4004, "dawn": 5005}
    random.seed(variant_seeds.get(variant_key, 9999))

    # Draw circuit traces — horizontal and vertical lines with nodes
    num_traces = 35
    for i in range(num_traces):
        # Alternate between accent and secondary colors
        color = accent_rgb if i % 3 != 0 else secondary_rgb
        alpha = trace_alpha + random.randint(-6, 15)
        line_color = (*color, max(8, min(55, alpha)))

        # Random start point
        x = random.randint(0, width)
        y = random.randint(0, height)

        # Draw a path of connected segments (horizontal/vertical only)
        segments = random.randint(3, 8)
        points = [(x, y)]
        for _ in range(segments):
            if random.random() > 0.5:
                # Horizontal segment
                dx = random.randint(40, 300) * random.choice([-1, 1])
                points.append((max(0, min(width, points[-1][0] + dx)), points[-1][1]))
            else:
                # Vertical segment
                dy = random.randint(40, 200) * random.choice([-1, 1])
                points.append((points[-1][0], max(0, min(height, points[-1][1] + dy))))

        # Draw line segments
        line_width = random.choice([1, 1, 1, 2])
        for j in range(len(points) - 1):
            trace_draw.line([points[j], points[j + 1]], fill=line_color, width=line_width)

        # Draw nodes at intersections
        node_color = (*color, max(12, min(65, alpha + 15)))
        for px, py in points:
            r = random.choice([2, 3, 3, 4])
            trace_draw.ellipse([px - r, py - r, px + r, py + r], fill=node_color)

    # Add a few larger "chip" rectangles
    for _ in range(6):
        cx = random.randint(100, width - 100)
        cy = random.randint(100, height - 100)
        cw = random.randint(20, 60)
        ch = random.randint(15, 40)
        chip_color = (*accent_rgb, max(10, trace_alpha + 5))
        trace_draw.rectangle(
            [cx - cw // 2, cy - ch // 2, cx + cw // 2, cy + ch // 2],
            outline=chip_color,
            width=1,
        )
        # Inner dot
        inner_color = (*secondary_rgb, max(15, trace_alpha + 8))
        trace_draw.ellipse([cx - 2, cy - 2, cx + 2, cy + 2], fill=inner_color)

    # Blur the trace layer slightly for a soft glow feel
    trace_layer = trace_layer.filter(ImageFilter.GaussianBlur(radius=0.8))

    # Composite traces onto base
    img = Image.alpha_composite(img, trace_layer)

    # Add a subtle radial vignette using numpy-free approach
    # Create vignette via radial gradient using Pillow's built-in ops

    cx, cy = width // 2, height // 2
    max_alpha = 35 if is_dark else 18

    # Build vignette at 1/4 resolution then scale up (fast)
    vw, vh = width // 4, height // 4
    vcx, vcy = vw // 2, vh // 2
    vignette_small = Image.new("L", (vw, vh), 0)
    vdata = []
    for y in range(vh):
        for x in range(vw):
            dx = abs(x - vcx) / vcx
            dy = abs(y - vcy) / vcy
            dist = min(1.0, math.sqrt(dx**2 + dy**2))
            if dist > 0.5:
                vdata.append(int((dist - 0.5) / 0.5 * max_alpha))
            else:
                vdata.append(0)
    vignette_small.putdata(vdata)
    vignette_mask = vignette_small.resize((width, height), Image.BILINEAR)

    # Apply vignette as a dark overlay
    dark_overlay = Image.new("RGBA", (width, height), (0, 0, 0, 255))
    dark_overlay.putalpha(vignette_mask)
    img = Image.alpha_composite(img, dark_overlay)

    # Convert to RGB (Chrome needs non-alpha PNG)
    final = Image.new("RGB", (width, height), bg_rgb)
    final.paste(img, mask=img.split()[3])

    return final


# ---------------------------------------------------------------------------
# Main generator
# ---------------------------------------------------------------------------

OUTPUT_DIR = Path(__file__).parent.parent / "extras" / "chrome-theme"


def dump_json(value, indent=0):
    """Serialize a manifest the way Prettier would.

    .prettierignore skips extras/chrome-theme, so `make chrome` cannot lean on
    the formatter to tidy up afterwards; a short array of numbers has to come
    out on one line here or every run rewrites the file.
    """
    pad = "  " * indent
    if isinstance(value, dict):
        if not value:
            return "{}"
        body = ",\n".join(
            f"{pad}  {json.dumps(key)}: {dump_json(item, indent + 1)}"
            for key, item in value.items()
        )
        return "{\n" + body + "\n" + pad + "}"
    if isinstance(value, list):
        flat = "[" + ", ".join(json.dumps(item) for item in value) + "]"
        if all(isinstance(item, (int, float)) for item in value) and len(pad) + len(flat) <= 100:
            return flat
        body = ",\n".join(f"{pad}  {dump_json(item, indent + 1)}" for item in value)
        return "[\n" + body + "\n" + pad + "]"
    return json.dumps(value)


def generate_variant(variant_key, v):
    """Generate all files for a single variant."""
    variant_dir = OUTPUT_DIR / f"silkcircuit-{variant_key}"
    images_dir = variant_dir / "images"
    images_dir.mkdir(parents=True, exist_ok=True)

    # Manifest
    manifest = generate_manifest(variant_key, v)
    manifest_path = variant_dir / "manifest.json"
    manifest_path.write_text(dump_json(manifest) + "\n")
    print(f"  {variant_key}: manifest.json")

    # DevTools CSS
    devtools_css = generate_devtools_css(variant_key, v)
    devtools_path = variant_dir / "devtools-theme.css"
    with open(devtools_path, "w") as f:
        f.write(devtools_css)
    print(f"  {variant_key}: devtools-theme.css")

    # Chrome pages CSS
    pages_css = generate_chrome_pages_css(variant_key, v)
    pages_path = variant_dir / "chrome-pages.css"
    with open(pages_path, "w") as f:
        f.write(pages_css)
    print(f"  {variant_key}: chrome-pages.css")

    # Chrome UI images
    for name, generator in [
        ("toolbar.png", lambda: generate_toolbar_image(v)),
        ("frame.png", lambda: generate_frame_image(v)),
        ("tab_background.png", lambda: generate_tab_background_image(v)),
        ("ntp_background.png", lambda: generate_ntp_background(variant_key, v)),
    ]:
        img = generator()
        if img:
            img.save(images_dir / name, "PNG", optimize=True)
            print(f"  {variant_key}: images/{name}")


def main():
    print()
    print("  SilkCircuit Chrome Theme Generator")
    print("  " + "─" * 38)
    print()

    # Generate each variant
    for variant_key in VARIANTS:
        generate_variant(variant_key, load_variant(variant_key))
        print()

    # Clean up old single-variant files (but keep the directory)
    old_files = ["manifest.json", "devtools-theme.css", "chrome-pages.css", "Cached Theme.pak"]
    cleaned = False
    for f in old_files:
        old_path = OUTPUT_DIR / f
        if old_path.exists():
            old_path.unlink()
            if not cleaned:
                print("  Cleaned up old single-variant files")
                cleaned = True

    print("  All 5 variants generated!")
    print()


if __name__ == "__main__":
    main()
