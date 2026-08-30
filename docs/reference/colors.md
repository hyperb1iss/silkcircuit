# Color Reference

Complete color palette for all SilkCircuit variants.

## Quick Reference

### Primary Colors by Variant

| Color     | Neon      | Vibrant   | Soft      | Glow      | Dawn      |
| --------- | --------- | --------- | --------- | --------- | --------- |
| Purple    | `#e135ff` | `#ff00ff` | `#e892ff` | `#d633ff` | `#7e2bd5` |
| Cyan      | `#80ffea` | `#00ffcc` | `#99ffee` | `#00ffff` | `#006e72` |
| Pink      | `#ff00ff` | `#ff00cc` | `#ff99ff` | `#ff00ff` | `#b40077` |
| Pink Soft | `#ff99ff` | `#ff99ff` | `#ffc2ff` | `#ff99ff` | `#9e4087` |
| Coral     | `#ff6ac1` | `#ff5fa8` | `#ff99dd` | `#ff66ff` | `#b42a74` |
| Yellow    | `#f1fa8c` | `#ffcc00` | `#ffe699` | `#ffff00` | `#796100` |

### Background Colors

| Element   | Neon      | Vibrant   | Soft      | Glow        | Dawn      |
| --------- | --------- | --------- | --------- | ----------- | --------- |
| Base      | `#12101a` | `#0f0c1a` | `#1a1626` | `#0a0816`   | `#faf8ff` |
| Dark      | `#0a0812` | `#08060f` | `#141220` | `#000000`   | `#f4f0ff` |
| Highlight | `#1a162a` | `#151026` | `#201b30` | `#1a0033`   | `#f7f4ff` |
| Statusbar | `#1d1a2d` | `#1a142d` | `#252036` | `#20003d`   | `#ded3f8` |
| Float     | `#221e32` | `#1e1834` | `#2b253d` | `#250047`   | `#e8dffd` |
| Visual    | `#44475a` | `#3a2e5a` | `#44475a` | `#ff00ff44` | `#d4c8f0` |

### Status Colors

| Status  | Neon      | Vibrant   | Soft      | Glow      | Dawn      |
| ------- | --------- | --------- | --------- | --------- | --------- |
| Success | `#50fa7b` | `#00ff66` | `#66ff99` | `#00ff00` | `#1d6e46` |
| Warning | `#f1fa8c` | `#ffcc00` | `#ffe699` | `#ffff00` | `#796100` |
| Error   | `#ff6363` | `#ff3366` | `#ff6677` | `#ff2244` | `#c1272d` |
| Info    | `#82aaff` | `#6699ff` | `#92aaff` | `#0099ff` | `#1454dc` |

## Neon Palette

```lua
-- Backgrounds
bg = "#12101a"
bg_dark = "#0a0812"
bg_highlight = "#1a162a"
bg_statusline = "#1d1a2d"
bg_float = "#221e32"
bg_visual = "#44475a"

-- Foregrounds
fg = "#f8f8f2"
fg_dark = "#e9d5ff"
fg_light = "#ffffff"

-- Primary
purple = "#e135ff"
cyan = "#80ffea"
pink = "#ff00ff"
pink_soft = "#ff99ff"
coral = "#ff6ac1"
yellow = "#f1fa8c"

-- Supporting
green = "#50fa7b"
red = "#ff6363"
blue = "#82aaff"
gray = "#768d8d"
```

## Vibrant Palette

```lua
-- Backgrounds
bg = "#0f0c1a"
bg_dark = "#08060f"
bg_highlight = "#151026"
bg_statusline = "#1a142d"
bg_float = "#1e1834"
bg_visual = "#3a2e5a"

-- Foregrounds
fg = "#f8f8f2"
fg_dark = "#e9d5ff"
fg_light = "#ffffff"

-- Primary
purple = "#ff00ff"
cyan = "#00ffcc"
pink = "#ff00cc"
pink_soft = "#ff99ff"
coral = "#ff5fa8"
yellow = "#ffcc00"

-- Supporting
green = "#00ff66"
red = "#ff3366"
blue = "#6699ff"
gray = "#728989"
```

## Soft Palette

```lua
-- Backgrounds
bg = "#1a1626"
bg_dark = "#141220"
bg_highlight = "#201b30"
bg_statusline = "#252036"
bg_float = "#2b253d"
bg_visual = "#44475a"

-- Foregrounds
fg = "#f8f8f2"
fg_dark = "#e9d5ff"
fg_light = "#ffffff"

-- Primary
purple = "#e892ff"
cyan = "#99ffee"
pink = "#ff99ff"
pink_soft = "#ffc2ff"
coral = "#ff99dd"
yellow = "#ffe699"

-- Supporting
green = "#66ff99"
red = "#ff6677"
blue = "#92aaff"
gray = "#7e9494"
```

## Glow Palette

```lua
-- Backgrounds
bg = "#0a0816"
bg_dark = "#000000"
bg_highlight = "#1a0033"
bg_statusline = "#20003d"
bg_float = "#250047"
bg_visual = "#ff00ff44"

-- Foregrounds
fg = "#ffffff"
fg_dark = "#cc66ff"
fg_light = "#ffffff"

-- Primary
purple = "#d633ff"
cyan = "#00ffff"
pink = "#ff00ff"
pink_soft = "#ff99ff"
coral = "#ff66ff"
yellow = "#ffff00"

-- Supporting
green = "#00ff00"
red = "#ff2244"
blue = "#0099ff"
gray = "#818181"
```

## Dawn Palette

```lua
-- Backgrounds
bg = "#faf8ff"
bg_dark = "#f4f0ff"
bg_highlight = "#f7f4ff"
bg_statusline = "#ded3f8"
bg_float = "#e8dffd"
bg_visual = "#d4c8f0"

-- Foregrounds
fg = "#2b2540"
fg_dark = "#5a4d6e"
fg_light = "#1a1318"

-- Primary
purple = "#7e2bd5"
cyan = "#006e72"
pink = "#b40077"
pink_soft = "#9e4087"
coral = "#b42a74"
yellow = "#796100"

-- Supporting
green = "#1d6e46"
red = "#c1272d"
blue = "#1454dc"
gray = "#686177"
```

## Terminal Colors (Neon)

```lua
terminal_black = "#12101a"
terminal_red = "#ff6363"
terminal_green = "#50fa7b"
terminal_yellow = "#f1fa8c"
terminal_blue = "#82aaff"
terminal_magenta = "#ff00ff"
terminal_cyan = "#80ffea"
terminal_white = "#f8f8f2"

terminal_bright_black = "#768d8d"
terminal_bright_red = "#ff8787"
terminal_bright_green = "#86fba8"
terminal_bright_yellow = "#ffffa5"
terminal_bright_blue = "#82b1ff"
terminal_bright_magenta = "#ff69ff"
terminal_bright_cyan = "#5fffff"
terminal_bright_white = "#ffffff"
```

## CSS Variables

```css
:root {
  /* Neon variant */
  --sc-purple: #e135ff;
  --sc-cyan: #80ffea;
  --sc-pink: #ff00ff;
  --sc-pink-soft: #ff99ff;
  --sc-coral: #ff6ac1;
  --sc-yellow: #f1fa8c;
  --sc-green: #50fa7b;
  --sc-red: #ff6363;
  --sc-blue: #82aaff;
  --sc-gray: #768d8d;
  --sc-bg: #12101a;
  --sc-bg-dark: #0a0812;
  --sc-bg-highlight: #1a162a;
  --sc-fg: #f8f8f2;
}
```

## Accessing Colors in Lua

```lua
-- Get colors for current variant
local colors = require("silkcircuit.variants").get_colors()

-- Get colors for specific variant
local dawn_colors = require("silkcircuit.variants").get_colors("dawn")

-- Use in custom highlights
require("silkcircuit").setup({
  on_highlights = function(hl, colors)
    hl.MyHighlight = { fg = colors.cyan, bg = colors.bg }
  end,
})
```
