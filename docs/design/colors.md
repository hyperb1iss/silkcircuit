# Color System

SilkCircuit's color system provides consistent, accessible colors across all five variants.

## Variant Color Palettes

### Neon (100% intensity)

**Backgrounds:**

| Element   | Hex       | Usage             |
| --------- | --------- | ----------------- |
| Base      | `#12101a` | Editor background |
| Dark      | `#0a0812` | Sidebar, panels   |
| Highlight | `#1a162a` | Cursorline        |
| Statusbar | `#1d1a2d` | Statusline, tabs  |
| Float     | `#221e32` | Popups, menus     |
| Divider   | `#39305c` | Separators, edges |

**Primary Colors:**

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#e135ff` | Keywords, control flow |
| Cyan      | `#80ffea` | Functions, methods     |
| Pink      | `#ff00ff` | Tags, booleans         |
| Pink Soft | `#ff99ff` | Strings                |
| Coral     | `#ff6ac1` | Numbers, constants     |
| Yellow    | `#f1fa8c` | Classes, types         |

### Vibrant (85% intensity)

**Backgrounds:**

| Element   | Hex       | Usage             |
| --------- | --------- | ----------------- |
| Base      | `#0f0c1a` | Editor background |
| Dark      | `#08060f` | Sidebar, panels   |
| Highlight | `#151026` | Cursorline        |
| Statusbar | `#1a142d` | Statusline, tabs  |
| Float     | `#1e1834` | Popups, menus     |
| Divider   | `#3b2d6a` | Separators, edges |

**Primary Colors:**

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#ff00ff` | Keywords, control flow |
| Cyan      | `#00ffcc` | Functions, methods     |
| Pink      | `#ff00cc` | Tags, booleans         |
| Pink Soft | `#ff99ff` | Strings                |
| Coral     | `#ff5fa8` | Numbers, constants     |
| Yellow    | `#ffcc00` | Classes, types         |

### Soft (70% intensity)

**Backgrounds:**

| Element   | Hex       | Usage             |
| --------- | --------- | ----------------- |
| Base      | `#1a1626` | Editor background |
| Dark      | `#141220` | Sidebar, panels   |
| Highlight | `#201b30` | Cursorline        |
| Statusbar | `#252036` | Statusline, tabs  |
| Float     | `#2b253d` | Popups, menus     |
| Divider   | `#403660` | Separators, edges |

**Primary Colors:**

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#e892ff` | Keywords, control flow |
| Cyan      | `#99ffee` | Functions, methods     |
| Pink      | `#ff99ff` | Tags, booleans         |
| Pink Soft | `#ffc2ff` | Strings                |
| Coral     | `#ff99dd` | Numbers, constants     |
| Yellow    | `#ffe699` | Classes, types         |

### Glow (Maximum contrast)

**Backgrounds:**

| Element   | Hex       | Usage             |
| --------- | --------- | ----------------- |
| Base      | `#0a0816` | Editor background |
| Dark      | `#000000` | Sidebar, panels   |
| Highlight | `#1a0033` | Cursorline        |
| Statusbar | `#20003d` | Statusline, tabs  |
| Float     | `#250047` | Popups, menus     |
| Divider   | `#49008f` | Separators, edges |

**Primary Colors:**

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#d633ff` | Keywords, control flow |
| Cyan      | `#00ffff` | Functions, methods     |
| Pink      | `#ff00ff` | Tags, booleans         |
| Pink Soft | `#ff99ff` | Strings                |
| Coral     | `#ff66ff` | Numbers, constants     |
| Yellow    | `#ffff00` | Classes, types         |

### Dawn (Light theme)

**Backgrounds:**

| Element   | Hex       | Usage             |
| --------- | --------- | ----------------- |
| Base      | `#faf8ff` | Editor background |
| Dark      | `#f4f0ff` | Sidebar, panels   |
| Highlight | `#f7f4ff` | Cursorline        |
| Float     | `#e8dffd` | Popups, menus     |
| Divider   | `#cfc2ee` | Separators, edges |
| Statusbar | `#ded3f8` | Statusline, tabs  |

**Primary Colors:**

| Color     | Hex       | Usage                  |
| --------- | --------- | ---------------------- |
| Purple    | `#7e2bd5` | Keywords, control flow |
| Cyan      | `#006e72` | Functions, methods     |
| Pink      | `#b40077` | Tags, booleans         |
| Pink Soft | `#9e4087` | Strings                |
| Coral     | `#b42a74` | Numbers, constants     |
| Yellow    | `#796100` | Classes, types         |

## Universal Supporting Colors

These colors maintain semantic meaning across all variants:

### Success

| Variant | Hex       | Usage                   |
| ------- | --------- | ----------------------- |
| Neon    | `#50fa7b` | Git add, success states |
| Vibrant | `#00ff66` | Git add, success states |
| Soft    | `#66ff99` | Git add, success states |
| Glow    | `#00ff00` | Git add, success states |
| Dawn    | `#1d6e46` | Git add, success states |

### Warning

| Variant | Hex       | Usage             |
| ------- | --------- | ----------------- |
| Neon    | `#f1fa8c` | Caution, modified |
| Vibrant | `#ffcc00` | Caution, modified |
| Soft    | `#ffe699` | Caution, modified |
| Glow    | `#ffff00` | Caution, modified |
| Dawn    | `#796100` | Caution, modified |

### Error

| Variant | Hex       | Usage             |
| ------- | --------- | ----------------- |
| Neon    | `#ff6363` | Errors, deletions |
| Vibrant | `#ff3366` | Errors, deletions |
| Soft    | `#ff6677` | Errors, deletions |
| Glow    | `#ff2244` | Errors, deletions |
| Dawn    | `#c1272d` | Errors, deletions |

## Interactive States

| State         | Behavior                              |
| ------------- | ------------------------------------- |
| **Hover**     | Add 10% brightness to base color      |
| **Active**    | Invert foreground/background          |
| **Focus**     | Add cyan glow (`0 0 0 2px #80ffea40`) |
| **Disabled**  | 50% opacity                           |
| **Selection** | Variant-specific with transparency    |

## CSS Variables

```css
/* Dark theme (Neon variant) */
:root {
  --sc-purple: #e135ff;
  --sc-cyan: #80ffea;
  --sc-pink: #ff00ff;
  --sc-pink-soft: #ff99ff;
  --sc-coral: #ff6ac1;
  --sc-yellow: #f1fa8c;
  --sc-green: #50fa7b;
  --sc-red: #ff6363;
  --sc-bg: #12101a;
  --sc-bg-dark: #0a0812;
  --sc-bg-highlight: #1a162a;
  --sc-fg: #f8f8f2;
}

/* Light theme (Dawn variant) */
:root.dawn {
  --sc-purple: #7e2bd5;
  --sc-cyan: #006e72;
  --sc-pink: #b40077;
  --sc-pink-soft: #9e4087;
  --sc-coral: #b42a74;
  --sc-yellow: #796100;
  --sc-green: #1d6e46;
  --sc-red: #c1272d;
  --sc-bg: #faf8ff;
  --sc-bg-dark: #f4f0ff;
  --sc-bg-highlight: #f7f4ff;
  --sc-fg: #2b2540;
}
```
