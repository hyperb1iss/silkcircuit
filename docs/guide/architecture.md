# How It's Built

One palette wearing thirty formats. This page is the machine behind that
sentence: where colors live, how a kitty config and a VS Code theme end up
byte-identical in intent, and why nothing under `extras/` is ever edited by
hand.

## The one file that matters

Every color in the project is written in exactly one place:
`lua/silkcircuit/variants.lua`. Five variants, each a table of about eighty
named roles: `bg`, `fg`, `purple`, `pink_soft`, the sixteen `terminal_*` ANSI
slots, the diagnostic and git roles, the surface ladder. The Neovim theme
reads it directly at load time. Everything else is rendered from it.

## The render

```
lua/silkcircuit/variants.lua          the only hand-written colors
        |
        |  scripts/build (headless Neovim)
        v
lua/silkcircuit/extra/<target>.lua    one small template per tool
        |
        v
extras/<target>/silkcircuit-<variant>.<ext>    committed output
palette/silkcircuit-<variant>.json             hex, rgb, hsl per role
palette/base16-*.yaml, base24-*.yaml           tinted-theming schemes
```

A target template is a fill-in-the-blanks version of that tool's config
format. Kitty's says `foreground ${fg}`; btop's says
`theme[main_bg]="${bg}"`. Running `make build` starts a headless Neovim,
resolves every `${role}` against each variant's table, and writes all five
files per target with a provenance header. `make docs` regenerates the file
tables in the READMEs from the same registry, so the docs cannot list a file
that does not exist.

The generated files are committed, which is what makes installation a plain
copy with no toolchain. CI regenerates everything on every pull request and
fails if the committed output differs from what the palette renders. Editing
a file under `extras/` by hand therefore cannot survive review; the change
belongs in `variants.lua` or in the target's template under
`lua/silkcircuit/extra/`.

## The JSON seam

Not everything speaks Lua. The build also writes
`palette/silkcircuit-<variant>.json` with hex, rgb, and hsl for every role,
plus base16 and base24 scheme files. The Chrome generator reads the JSON
rather than the Lua, and so can anything else: a [tinty](https://github.com/tinted-theming/tinty)
or stylix user gets the scheme files, and a third-party port gets a stable
contract without touching Neovim.

That seam is also the escape hatch. Neovim is involved in exactly one place,
as the build tool, because the palette is a Lua table and Neovim is the Lua
runtime the test suite already requires. Users of a generated theme never
need it, and if the project ever wanted a JSON-first palette instead, the
arrow flips mechanically: the JSON already exists, and `variants.lua` would
become one more rendered output.

## Adding a target

A new tool is one registry entry and one template module, both in
`lua/silkcircuit/extra/`, then `make build && make docs`. The whole recipe,
including the rule that a target ships all five variants or it is not done,
lives in [CONTRIBUTING.md](https://github.com/hyperb1iss/silkcircuit/blob/main/CONTRIBUTING.md).
