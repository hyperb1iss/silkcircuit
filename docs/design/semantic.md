# Semantic Colors

Every color in SilkCircuit carries consistent meaning across all contexts.

## Code Syntax Mapping

| Element       | Color           | Style         |
| ------------- | --------------- | ------------- |
| Keywords      | Purple          | Bold          |
| Functions     | Cyan            | Bold + Italic |
| Strings       | Pink Soft       | Italic        |
| Numbers       | Coral           | Normal        |
| Booleans      | Pink            | Normal        |
| Types/Classes | Yellow          | Normal        |
| Comments      | Purple Muted    | Italic        |
| Operators     | Foreground Dark | Normal        |
| Properties    | Cyan Bright     | Normal        |

## Why Semantic Colors Matter

When colors have consistent meanings, you can read any codebase faster:

- See purple? That's a **keyword** or control flow.
- See cyan? That's a **function** or method call.
- See pink? That's a **string** or boolean value.
- See yellow? That's a **type** or class name.

This consistency reduces cognitive load and accelerates comprehension.

## Language Examples

### JavaScript

```javascript
// Purple: const, if, return, function
const greeting = "Hello" // Pink soft: string

// Cyan: function name
function sayHello(name) {
  // Yellow: template literal type expression
  return `Hello, ${name}!`
}

// Pink: true/false
const isValid = true

// Coral: numbers
const count = 42
```

### Python

```python
# Purple: def, class, import, if, for
def calculate_total(items):
    # Coral: number
    total = 0

    # Purple: for, in
    for item in items:
        total += item.price

    # Purple: return
    return total

# Yellow: class name
class Product:
    # Cyan: method
    def __init__(self, name, price):
        # Pink soft: string
        self.name = name
```

### Lua

```lua
-- Purple: local, function, if, then, end
local function setup(opts)
  -- Purple muted: comment
  -- Merge with defaults

  -- Cyan: function calls
  local config = vim.tbl_deep_extend("force", defaults, opts)

  -- Pink: boolean
  if config.transparent == true then
    -- Cyan: apply_transparency function
    apply_transparency()
  end
end
```

## UI Color Mapping

### Status Colors

| Status  | Color  | Usage                                      |
| ------- | ------ | ------------------------------------------ |
| Success | Green  | Confirmations, git additions, valid states |
| Warning | Yellow | Caution, modifications, pending actions    |
| Error   | Red    | Errors, deletions, invalid states          |
| Info    | Cyan   | Informational, links, interactive          |

### Git Colors

| Action   | Color     | Meaning                 |
| -------- | --------- | ----------------------- |
| Added    | Green     | New content, insertions |
| Modified | Blue/Cyan | Changed content         |
| Deleted  | Red       | Removed content         |
| Renamed  | Yellow    | Moved/renamed files     |

### Diagnostic Colors

| Level   | Color  | Usage                          |
| ------- | ------ | ------------------------------ |
| Error   | Red    | Compilation errors, crashes    |
| Warning | Yellow | Potential issues, deprecations |
| Info    | Blue   | Informational notes            |
| Hint    | Cyan   | Suggestions, improvements      |

## Consistency Rules

1. **Never change semantic meaning**: Keywords are always purple, functions always cyan.

2. **Maintain across variants**: The meaning stays constant; only intensity changes.

3. **Apply to plugins**: All 35+ integrations follow the same color semantics.

4. **Extend thoughtfully**: New elements should map to existing semantic colors.

## Neovim Highlight Groups

```lua
-- Access semantic colors in custom highlights
require("silkcircuit").setup({
  on_highlights = function(hl, colors)
    -- Use semantic colors
    hl.Function = { fg = colors.cyan, bold = true, italic = true }
    hl.Keyword = { fg = colors.purple, bold = true }
    hl.String = { fg = colors.pink_soft, italic = true }
    hl.Number = { fg = colors.coral }
    hl.Boolean = { fg = colors.pink }
    hl.Type = { fg = colors.yellow }
    hl.Comment = { fg = colors.gray, italic = true }
  end,
})
```
