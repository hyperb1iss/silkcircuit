# SilkCircuit tests

A self-contained harness that loads the real colorscheme in a headless Neovim
and inspects what it actually did to the highlight table. No plugin
dependency, no vendored framework.

```bash
scripts/test                      # everything
scripts/test --filter isolation   # one spec file, by name
```

The runner exits non-zero when anything fails, so `make test` and CI can gate
on it. Output is TAP: `ok N - name` per case, `# ...` for diagnostics, a
summary at the end.

## How it runs

`scripts/test` starts Neovim as `nvim --clean -u tests/minimal_init.lua -l
tests/run.lua`. `-l` implies `--headless` and still honours `-u`, so the
minimal config is sourced before the runner starts.

- **`tests/minimal_init.lua`** puts the repository on the runtimepath, turns
  `termguicolors` on (the theme refuses to load without it) and redirects every
  XDG directory into a throwaway sandbox, so saved preferences and caches never
  touch a real Neovim setup.
- **`tests/run.lua`** discovers `tests/spec/*_spec.lua`, runs the cases each
  file registers, prints the report and sets the exit code.
- **`tests/helpers.lua`** holds everything the specs share: fresh-state resets,
  highlight capture, WCAG maths and assertions.

The global `assert` is left alone. Specs assert through the helpers, which
raise with a message the runner prints under the failing case.

## The specs

| File               | What it holds the theme to                                               |
| ------------------ | ------------------------------------------------------------------------ |
| `palette_spec`     | Every variant exposes 6-digit hex, the keys the theme reads, one key set |
| `highlights_spec`  | Nothing is rejected by `nvim_set_hl`, required groups carry attributes   |
| `snapshot_spec`    | No group silently stops being defined                                    |
| `isolation_spec`   | Loading the colorscheme requires no plugin module                        |
| `config_spec`      | Defaults, styles, `on_highlights`, transparency, disabled integrations   |
| `preferences_spec` | A saved variant is in force on the first load, not the second            |
| `commands_spec`    | Every user command runs, `checkhealth` reports no errors                 |
| `contrast_spec`    | Body text meets WCAG, with the full terminal table printed               |
| `utils_spec`       | The colour maths the palette is built on                                 |

## Adding a spec

Drop a file in `tests/spec/` named `<something>_spec.lua`:

```lua
local H = require("helpers")
local describe, it = H.describe, H.it

describe("thing", function()
  it("does what it says", function()
    local record = H.load_full("neon")
    H.empty(record.errors, "no highlight was rejected")
  end)
end)
```

`H.load_full(variant, opts)` resets all state, loads that variant with every
integration on, and returns a record of what the theme handed to `nvim_set_hl`:
`errors` (rejected), `invalid` (colours Neovim cannot parse), `applied` (groups
that landed) and `opts` (the table passed per group). That record is the only
place a rejected highlight is visible, because `lua/silkcircuit/util.lua` wraps
the API call in a `pcall`.

Assertions: `H.ok`, `H.eq`, `H.empty`, `H.at_least`, `H.fail`. Diagnostics:
`H.note`.

## Snapshots

`tests/snapshots/<variant>.txt` lists the highlight groups each variant defines
without error. A group that disappears fails the spec; a new one passes and is
reported. Only groups the theme itself sets are recorded, so Neovim's own
defaults never make the snapshot drift between versions.

Refresh after an intentional change:

```bash
SILKCIRCUIT_UPDATE_SNAPSHOTS=1 scripts/test --filter snapshot
```

Read the diff before committing it. A shrinking snapshot means the theme stopped
styling something.
