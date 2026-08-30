# Chrome Theme

SilkCircuit for Google Chrome. All five variants ship with full browser theming.

## Variants

- **Neon**: The original SilkCircuit experience
- **Vibrant**: Maximum saturation on ultra-dark canvas
- **Soft**: Gentle glow for extended sessions
- **Glow**: Pure neon on void-black, maximum contrast
- **Dawn**: Light theme with electric accents on lavender

## Installation

1. Open `chrome://extensions/`
2. Enable **Developer mode**
3. Click **Load unpacked**
4. Select a variant directory: `extras/chrome-theme/silkcircuit-{variant}/`

To switch variants, remove the current theme and load a different one.

## What's Included

Each variant directory contains:

```
silkcircuit-{variant}/
├── manifest.json           # Chrome theme (24 colors, 9 tab groups, NTP image)
├── images/
│   └── ntp_background.png  # Circuit-trace pattern (1920x1080)
├── devtools-theme.css      # Modern DevTools theme (CM6 + --sys-color-*)
└── chrome-pages.css        # Chrome internal pages (--cr-* overrides)
```

### Manifest Coverage

All 24 Chrome theme color keys, including:

- Frame (active, inactive, incognito, incognito inactive)
- Toolbar text and button icons
- Omnibox background and text
- Tab text (active, inactive, and incognito, covering every window state)
- Background tab colors (all states)
- NTP background, text, links, header
- Tab group color palette (all 9 slots)

### DevTools Theme

Targets Chrome DevTools 2025+ with:

- `--sys-color-*` custom properties for full UI theming
- `.token-*` classes for CodeMirror 6 syntax highlighting
- Console ANSI color overrides
- Panel-specific styling (Console, Network, Elements, Sources)
- CM5 fallback selectors for compatibility

Setup: Install a DevTools theme extension, enable "Allow extensions to load custom stylesheets" in DevTools experiments.

### Chrome Pages

Themes `chrome://settings`, extensions, downloads, history, bookmarks, and flags via `--cr-*` custom property overrides.

Setup: Install [Stylus](https://chromewebstore.google.com/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne), create a new style with `chrome://*` pattern, import the CSS.

## Regenerating

```bash
make chrome
```

Generates all 5 variants from the canonical palette defined in `scripts/generate_chrome_themes.py`.

## Compatibility

Chrome 88+ and Chromium-based browsers (Edge, Brave, Arc, Vivaldi).
