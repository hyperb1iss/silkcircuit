# Typography

SilkCircuit uses carefully selected font stacks for optimal readability.

## Font Stacks

### Primary (UI Text)

```css
font-family:
  "Inter",
  -apple-system,
  BlinkMacSystemFont,
  "Segoe UI",
  "Helvetica Neue",
  Arial,
  sans-serif;
```

Clean, modern sans-serif for interface elements, documentation, and general text.

### Code/Monospace

```css
font-family:
  "JetBrains Mono", "Fira Code", "SF Mono", "Cascadia Code", "Monaco", "Menlo", "Roboto Mono",
  monospace;
```

Optimized for code readability with ligature support.

### Display (Headlines)

```css
font-family:
  "Inter",
  -apple-system,
  BlinkMacSystemFont,
  sans-serif;
```

Same as primary for consistency, with adjusted weights.

## Type Scale

### Mobile (320px+)

| Token            | Size     | Pixels |
| ---------------- | -------- | ------ |
| `--sc-text-xs`   | 0.75rem  | 12px   |
| `--sc-text-sm`   | 0.875rem | 14px   |
| `--sc-text-base` | 1rem     | 16px   |
| `--sc-text-lg`   | 1.125rem | 18px   |
| `--sc-text-xl`   | 1.25rem  | 20px   |
| `--sc-text-2xl`  | 1.5rem   | 24px   |
| `--sc-text-3xl`  | 1.875rem | 30px   |
| `--sc-text-4xl`  | 2.25rem  | 36px   |

### Desktop (1024px+)

| Token            | Size     | Pixels |
| ---------------- | -------- | ------ |
| `--sc-text-xs`   | 0.75rem  | 12px   |
| `--sc-text-sm`   | 0.875rem | 14px   |
| `--sc-text-base` | 1rem     | 16px   |
| `--sc-text-lg`   | 1.125rem | 18px   |
| `--sc-text-xl`   | 1.25rem  | 20px   |
| `--sc-text-2xl`  | 1.5rem   | 24px   |
| `--sc-text-3xl`  | 2rem     | 32px   |
| `--sc-text-4xl`  | 2.5rem   | 40px   |
| `--sc-text-5xl`  | 3rem     | 48px   |

## Code Syntax Styling

Each syntax element has specific typographic treatment:

### Keywords

```css
.sc-keyword {
  font-weight: 700;
  color: var(--sc-purple);
}
```

Bold purple. Commands attention for control flow.

### Functions

```css
.sc-function {
  font-weight: 700;
  font-style: italic;
  color: var(--sc-cyan);
}
```

Bold italic cyan. Distinguishes callable elements.

### Strings

```css
.sc-string {
  font-style: italic;
  color: var(--sc-pink-soft);
}
```

Italic pink. Clearly identifies text content.

### Comments

```css
.sc-comment {
  font-style: italic;
  color: var(--sc-purple-muted);
  opacity: 0.8;
}
```

Muted italic. Readable but receded.

### Variables

```css
.sc-variable {
  color: var(--sc-fg);
}
```

Standard weight foreground. Clean and neutral.

## Neovim Configuration

```lua
require("silkcircuit").setup({
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true, italic = true },
    variables = {},
    strings = { italic = true },
  },
})
```

## Line Height

| Context    | Line Height |
| ---------- | ----------- |
| Code       | 1.5         |
| Body text  | 1.6         |
| Headlines  | 1.1 to 1.2  |
| Compact UI | 1.25        |

## Letter Spacing

| Context   | Letter Spacing |
| --------- | -------------- |
| Headlines | -0.02em        |
| Body text | 0              |
| All caps  | 0.05em         |
| Code      | 0              |
