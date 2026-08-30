# SilkCircuit Chrome Theme

Electric meets elegant. The full SilkCircuit experience for Chrome and Chromium-based browsers.

## Variants

| Variant     | Description                                                           |
| ----------- | --------------------------------------------------------------------- |
| **Neon**    | The original, neon purples and glowing cyan on deep dark canvas       |
| **Vibrant** | Pure electric intensity, maximum saturation on ultra-dark backgrounds |
| **Soft**    | Gentle glow, softer colors for extended sessions                      |
| **Glow**    | Maximum contrast, pure neon on void-black                             |
| **Dawn**    | Light theme, electric accents on soft lavender backgrounds            |

Each variant is a standalone Chrome extension in its own directory.

## Installation

### Browser Theme

1. Open `chrome://extensions/`
2. Enable **Developer mode** (toggle in top right)
3. Click **Load unpacked**
4. Select the variant directory you want (e.g., `silkcircuit-neon/`)
5. The theme applies immediately

To switch variants, remove the current theme and load a different one.

### DevTools Theme

Each variant includes a `devtools-theme.css` targeting modern Chrome DevTools (CM6 + `--sys-color-*` tokens).

1. Install a DevTools theme extension (e.g., [DevTools Author](https://chromewebstore.google.com/detail/devtools-author/))
2. Open DevTools → Settings → Experiments
3. Enable "Allow extensions to load custom stylesheets"
4. Load the `devtools-theme.css` from your chosen variant

### Chrome Internal Pages

Each variant includes a `chrome-pages.css` for theming `chrome://settings`, `chrome://extensions`, and other internal pages.

1. Install [Stylus](https://chromewebstore.google.com/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne)
2. Click the Stylus icon → "Manage"
3. Create new style → import `chrome-pages.css` from your variant
4. Set URL pattern to `chrome://*`

## What's Themed

### Browser Chrome (manifest.json)

Every available Chrome theme API surface is covered:

- Frame and toolbar colors (active, inactive, incognito states)
- Address bar (omnibox) background and text
- Tab text and background colors (all states)
- Toolbar button icon tinting
- Bookmark bar text
- New Tab Page background, text, links, and header
- Custom NTP background image (circuit-trace pattern)
- Tab group color palette (all 9 color slots)
- White/alternate Google logo for dark variants

### DevTools (devtools-theme.css)

Modern selectors targeting Chrome 2025+:

- `--sys-color-*` custom properties for complete UI theming
- `.token-*` classes for CodeMirror 6 syntax highlighting
- Panel-specific styling (Console, Network, Elements, Sources)
- Console ANSI color overrides
- Custom scrollbars and selection colors
- CM5 fallback selectors for older Chrome versions

### Chrome Pages (chrome-pages.css)

Full `--cr-*` variable overrides:

- Buttons, toggles, checkboxes, sliders, inputs
- Cards, dialogs, toasts, menus
- Search fields, tabs, toolbars
- Shadows, separators, scrollbars
- Settings, Extensions, Downloads, History, Bookmarks, Flags pages

## Regenerating

Themes are generated from the canonical SilkCircuit palette:

```bash
make chrome
# or
python3 scripts/generate_chrome_themes.py
```

## Compatibility

- Chrome 88+
- Chromium-based browsers (Edge, Brave, Arc, Vivaldi, etc.)

## License

MIT, the same license as the SilkCircuit Neovim theme.
