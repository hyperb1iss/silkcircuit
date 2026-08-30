# Highlight Groups

Complete reference for SilkCircuit highlight group mappings.

## Syntax Highlights

### Core Groups

| Group        | Color      | Style        | Description            |
| ------------ | ---------- | ------------ | ---------------------- |
| `Keyword`    | Purple     | Bold         | Control flow, keywords |
| `Function`   | Cyan       | Bold, Italic | Function names         |
| `String`     | Pink Soft  | Italic       | String literals        |
| `Number`     | Coral      | None         | Numeric values         |
| `Boolean`    | Pink       | None         | true/false             |
| `Type`       | Yellow     | None         | Type names             |
| `Comment`    | Comment    | Italic       | Comments               |
| `Operator`   | Foreground | None         | Operators              |
| `Identifier` | Foreground | None         | Variables              |

### Extended Syntax

| Group            | Color       | Description          |
| ---------------- | ----------- | -------------------- |
| `@keyword`       | Purple      | Treesitter keywords  |
| `@function`      | Cyan        | Treesitter functions |
| `@function.call` | Cyan        | Function calls       |
| `@method`        | Cyan        | Method names         |
| `@parameter`     | Foreground  | Function parameters  |
| `@variable`      | Foreground  | Variables            |
| `@property`      | Cyan Bright | Properties           |
| `@field`         | Cyan Bright | Fields               |
| `@constant`      | Coral       | Constants            |
| `@string`        | Pink Soft   | Strings              |
| `@number`        | Coral       | Numbers              |
| `@boolean`       | Pink        | Booleans             |
| `@type`          | Yellow      | Types                |
| `@namespace`     | Yellow      | Namespaces           |
| `@tag`           | Pink        | HTML/XML tags        |
| `@attribute`     | Purple      | Attributes           |
| `@punctuation`   | Foreground  | Punctuation          |
| `@comment`       | Comment     | Comments             |

## Editor Highlights

### General

| Group          | Description         |
| -------------- | ------------------- |
| `Normal`       | Default text        |
| `NormalFloat`  | Floating windows    |
| `NormalNC`     | Non-current windows |
| `Visual`       | Visual selection    |
| `Search`       | Search matches      |
| `IncSearch`    | Incremental search  |
| `CursorLine`   | Current line        |
| `CursorColumn` | Current column      |
| `LineNr`       | Line numbers        |
| `CursorLineNr` | Current line number |
| `SignColumn`   | Sign column         |

### Popups & Windows

| Group          | Description            |
| -------------- | ---------------------- |
| `Pmenu`        | Popup menu             |
| `PmenuSel`     | Selected popup item    |
| `PmenuSbar`    | Scrollbar              |
| `PmenuThumb`   | Scrollbar thumb        |
| `FloatBorder`  | Floating window border |
| `WinSeparator` | Window separators      |

### Diff

| Group        | Color  | Description   |
| ------------ | ------ | ------------- |
| `DiffAdd`    | Green  | Added lines   |
| `DiffChange` | Blue   | Changed lines |
| `DiffDelete` | Red    | Deleted lines |
| `DiffText`   | Yellow | Changed text  |

### Diagnostics

| Group                      | Color            | Description       |
| -------------------------- | ---------------- | ----------------- |
| `DiagnosticError`          | Red              | Errors            |
| `DiagnosticWarn`           | Yellow           | Warnings          |
| `DiagnosticInfo`           | Blue             | Info              |
| `DiagnosticHint`           | Cyan             | Hints             |
| `DiagnosticUnderlineError` | Red underline    | Error underline   |
| `DiagnosticUnderlineWarn`  | Yellow underline | Warning underline |
| `DiagnosticUnderlineInfo`  | Blue underline   | Info underline    |
| `DiagnosticUnderlineHint`  | Cyan underline   | Hint underline    |

## Git Highlights

| Group            | Color | Description   |
| ---------------- | ----- | ------------- |
| `GitSignsAdd`    | Green | Added lines   |
| `GitSignsChange` | Blue  | Changed lines |
| `GitSignsDelete` | Red   | Deleted lines |
| `diffAdded`      | Green | Diff added    |
| `diffChanged`    | Blue  | Diff changed  |
| `diffRemoved`    | Red   | Diff removed  |

## LSP Highlights

| Group                         | Description      |
| ----------------------------- | ---------------- |
| `LspReferenceRead`            | Read references  |
| `LspReferenceWrite`           | Write references |
| `LspReferenceText`            | Text references  |
| `LspSignatureActiveParameter` | Active parameter |
| `LspCodeLens`                 | Code lens        |

## Plugin Highlights

### Telescope

| Group                    | Description        |
| ------------------------ | ------------------ |
| `TelescopeBorder`        | Border             |
| `TelescopePromptBorder`  | Prompt border      |
| `TelescopeResultsBorder` | Results border     |
| `TelescopePreviewBorder` | Preview border     |
| `TelescopeSelection`     | Selected item      |
| `TelescopeMatching`      | Matched characters |

### Neo-tree

| Group                  | Description     |
| ---------------------- | --------------- |
| `NeoTreeNormal`        | Normal text     |
| `NeoTreeDirectoryIcon` | Directory icons |
| `NeoTreeDirectoryName` | Directory names |
| `NeoTreeFileName`      | File names      |
| `NeoTreeGitAdded`      | Git added       |
| `NeoTreeGitModified`   | Git modified    |
| `NeoTreeGitDeleted`    | Git deleted     |

### nvim-cmp

| Group                   | Description   |
| ----------------------- | ------------- |
| `CmpItemAbbrMatch`      | Matched text  |
| `CmpItemAbbrMatchFuzzy` | Fuzzy matches |
| `CmpItemKindFunction`   | Function kind |
| `CmpItemKindMethod`     | Method kind   |
| `CmpItemKindVariable`   | Variable kind |
| `CmpItemKindKeyword`    | Keyword kind  |

## Customizing Highlights

### Override Specific Groups

```lua
require("silkcircuit").setup({
  on_highlights = function(hl, colors)
    hl.Function = { fg = colors.cyan, bold = true, italic = true }
    hl.Comment = { fg = colors.comment, italic = true }
  end,
})
```

### Add New Groups

```lua
require("silkcircuit").setup({
  on_highlights = function(hl, colors)
    hl.MyCustomGroup = { fg = "#ff00ff", bg = "#000000" }
  end,
})
```

### Query Current Highlights

```vim
:hi Function
:hi Comment
```

### View All Highlights

```vim
:so $VIMRUNTIME/syntax/hitest.vim
```
