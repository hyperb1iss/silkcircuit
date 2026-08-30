# Coding Guidelines for SilkCircuit

> Instructions for AI assistants working on the SilkCircuit theme.
> `CLAUDE.md` is a symlink to this file.

## Project Overview

SilkCircuit is a unified design system featuring neon purples, electric pinks, and glowing cyan accents. It themes your entire dev environment: Neovim is the flagship, with 39 plugin integrations, and 30 generated extras targets cover VS Code, Chrome, terminals, editors, multiplexers, and CLI and system tools. The project prioritizes performance, WCAG AA accessibility, and a consistent visual identity across all targets.

## Core Principles

1. **Performance First** - Theme loads in a few milliseconds with every integration defined
2. **Accessibility** - All colors meet WCAG AA contrast standards
3. **Passive loading** - Every integration is defined up front; detection only informs `:SilkCircuitIntegrations` and `:checkhealth`
4. **User Choice** - Five variants (neon/vibrant/soft/glow/dawn) with persistent preferences

## Code Style Guidelines

### Lua Conventions

```lua
-- Module structure
local M = {}

-- Function definitions
function M.function_name(param1, param2)
  -- Implementation
end

return M
```

### Naming Conventions

- Files: `snake_case.lua`
- Functions: `snake_case`
- Local variables: `snake_case`
- Constants: `UPPER_SNAKE_CASE` (rare)
- Highlight groups: `PascalCase`

### Comments

- Avoid unnecessary comments
- Document complex logic only
- Use present tense ("Returns" not "Will return")
- No decorative comments

## Key Files and Their Purposes

### Core Files

- `init.lua` - Entry point, loads theme
- `palette.lua` - Color definitions and semantic mappings
- `theme.lua` - Core highlight group definitions
- `config.lua` - Configuration management
- `util.lua` - Highlight application and style merging
- `utils/colors.lua` - Color math: blending, contrast ratios, variant scaling
- `health.lua` - `:checkhealth silkcircuit` provider

### Integration System

- `integrations/init.lua` - The integration registry, plus loading and reporting
- `integrations/{plugin}.lua` - Individual plugin themes

### User Features

- `commands.lua` - User commands (`:SilkCircuit`, etc.)
- `preferences.lua` - Persistent settings
- `glow.lua` - Glow mode implementation
- `variants.lua` - Theme variant system, including the terminal\_\* ANSI contract

### Distribution Support

- `contrib/astronvim.lua` - AstroNvim integration helpers
- `lua/lualine/themes/silkcircuit.lua` - Lualine theme, loaded by lualine itself

## Adding New Features

### New Integration

1. Create `integrations/{plugin}.lua`
2. Add to the registry in `integrations/init.lua`, with the `modules` and `plugin` names detection reports on
3. Add its key to the `integrations` defaults in `config.lua`
4. Test with and without the plugin installed; the highlights load either way

Template:

```lua
local M = {}

function M.get(colors, opts)
  return {
    PluginElement = { fg = colors.purple },
    -- Map plugin UI to semantic colors
  }
end

return M
```

### New Command

1. Add to `commands.lua`
2. Follow naming pattern `:SilkCircuit{Feature}`
3. Add to `:checkhealth` documentation
4. Update help docs

## Development Commands

| Command                  | What it does                                     |
| ------------------------ | ------------------------------------------------ |
| `make setup`             | Install dev dependencies via mise                |
| `make check`             | Lint, format check, and tests. The pre-push gate |
| `make test`              | Unit tests only                                  |
| `make build`             | Regenerate every extras theme from the palette   |
| `make docs`              | Regenerate the generated tables in the READMEs   |
| `make preview VARIANT=x` | Launch nvim with the theme from the working tree |

Run `make check` before every commit. It is the same gate CI runs, so a
green local run means a green pipeline.

## Testing Guidelines

### Before Committing

1. Run `make check` - Must pass
2. Test all variants - `:SilkCircuit neon|vibrant|soft|glow|dawn`
3. Verify contrast - `:SilkCircuitContrast`
4. Run checkhealth - `:checkhealth silkcircuit`

### Manual Testing

- Open various file types (Lua, JS, YAML, Markdown)
- Test with neo-tree open
- Verify git status colors
- Check floating windows

## Performance Considerations

### Do

- Use `vim.tbl_deep_extend` for merging
- Cache expensive operations
- Compile regex patterns once
- Use early returns

### Don't

- Parse files repeatedly
- Create unnecessary tables
- Use global variables
- Block the main thread

## Color Usage

### Semantic Mapping

Always use semantic colors from `palette.lua`:

```lua
-- Good
{ fg = sem.keyword }

-- Bad
{ fg = colors.purple }
```

### Contrast

All foreground/background pairs must meet WCAG AA (4.5:1 ratio).

## User Communication

### Notifications

```lua
-- Use vim.notify with appropriate level
vim.notify("Message", vim.log.levels.INFO)
```

### Unicode Symbols

- `→` for arrows/flow
- `√` for success
- `!` for warnings
- `»` for tips
- Avoid emojis

## Common Tasks

### Update Existing Highlight

1. Find in `theme.lua` or relevant integration
2. Modify using semantic colors
3. Test in all variants

### Fix Contrast Issue

1. Run `:SilkCircuitContrast`
2. Identify failing pair
3. Adjust in `palette.lua`
4. Re-test

### Add Config Option

1. Add to defaults in `config.lua`
2. Document in README
3. Handle in relevant module
4. Add to `:checkhealth`

## Git Workflow

### Commit Messages

- Use conventional commits
- Be specific about changes
- Reference issues if applicable

Examples:

- `fix: correct YAML key highlighting`
- `feat: add mason.nvim integration`
- `perf: skip disabled integrations in the load loop`

### Pull Requests

- Run `make check`
- Include before/after screenshots for visual changes
- Read `CONTRIBUTING.md` before your first PR

Do not edit CHANGELOG.md by hand. release-please generates it from the
conventional commit subjects on main, so the subject you write is the
changelog entry users read.

## Debugging

### Common Issues

1. **Highlights not applying**: Check `:hi {GroupName}`
2. **Plugin looks unthemed**: Confirm its key is not set to `false` in `setup()`, then check `:SilkCircuitIntegrations`
3. **Colors look wrong**: Check terminal true color support

### Debug Mode

```lua
vim.g.silkcircuit_debug = true
```

## Don'ts

- × Don't add emojis to code
- × Don't create files unless necessary
- × Don't use hard-coded colors
- × Don't skip contrast validation
- × Don't add verbose comments
- × Don't break existing functionality

## Quick Reference

### Commands

- `:SilkCircuit {variant}` - Switch variant
- `:SilkCircuitGlow` - Toggle glow mode
- `:SilkCircuitContrast` - Check WCAG compliance
- `:SilkCircuitIntegrations` - Show integration status
- `:checkhealth silkcircuit` - Full diagnostics

### File Locations

- Colors: `lua/silkcircuit/palette.lua`
- Variants and ANSI: `lua/silkcircuit/variants.lua`
- Highlights: `lua/silkcircuit/theme.lua`
- Plugin themes: `lua/silkcircuit/integrations/`
- Other targets: `extras/` (generated, run `make build` instead of editing)
- User config: `~/.config/nvim/lua/plugins/silkcircuit.lua`

---

_When in doubt, prioritize user experience and maintain the vibrant aesthetic._
