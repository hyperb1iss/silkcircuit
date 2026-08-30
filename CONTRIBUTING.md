# Contributing to SilkCircuit

Thanks for being here. SilkCircuit is a design system that happens to ship as a
Neovim colorscheme first, so most changes touch color, and color changes ripple
further than they look. This page covers the parts that are easy to get wrong.

## Setup

The toolchain is pinned in `mise.toml`. Install [mise](https://mise.jdx.dev), then:

```bash
make setup
```

That installs every linter, formatter, and the Neovim the test suite runs
against, all at the exact versions CI uses, and wires up the git hooks. It takes
about ten seconds because everything is a prebuilt binary. If you skip mise, the
Makefile falls back to whatever is on your `PATH`, and you get to explain the
formatting diffs yourself.

`make` on its own lists everything available.

## The loop

```bash
make check                  # lint, formatting, and tests: what CI runs
make test                   # just the tests
make fmt                    # fix formatting instead of complaining about it
make preview VARIANT=glow   # open Neovim wearing the theme
```

`make check` is the whole gate. If it passes locally it passes in CI, because
both run the same pinned binaries against the same targets. When something in
`make fmt-check` fails, run `make fmt` and commit the result.

To narrow the suite while you iterate:

```bash
scripts/test --filter palette
```

## Where the colors live

`lua/silkcircuit/variants.lua` is the source of truth. Every other target,
Chrome, VS Code, the terminal configs under `extras/`, renders from it.

So **do not hand-edit generated files.** Anything under
`extras/chrome-theme/` comes out of `scripts/generate_chrome_themes.py` and gets
overwritten the next time someone runs `make chrome`. If a generated file is
wrong, the generator or the palette is wrong. Fix it there.

## A change ships all five variants or it does not ship

There are five: `neon`, `vibrant`, `soft`, `glow`, and `dawn`. They are not
presets layered over one real theme, they are five themes, and `dawn` is light
while the rest are dark. A highlight that only reads well in `neon` is a
half-finished highlight.

The usual failure is contrast. A color with enough punch against the near-black
`glow` background can vanish against `dawn`. Check the variant you are least
likely to use before you open the PR.

## The terminal contract

`theme.set_terminal_colors()` maps the `terminal_*` keys onto Neovim's
`vim.g.terminal_color_0` through `terminal_color_15`. Those sixteen slots have
fixed meanings that predate this theme by decades, and things that shell out to
a terminal buffer depend on them: `0` is black, `1` red, `2` green, `3` yellow,
`4` blue, `5` magenta, `6` cyan, `7` white, and `8` through `15` are the bright
versions in the same order.

Keep the hue. Push the saturation as far as the variant wants, but a `terminal_red`
that reads as pink means every diff, every test runner, and every log tailed in a
terminal buffer starts lying to the reader.

## Commits

[Conventional Commits](https://www.conventionalcommits.org), and every commit
gets a body explaining why. The subject is the contract that changelog tooling
parses, and the body is what someone reads two years from now during a bisect.

Releases are automated. release-please watches `main`, keeps a release PR open
with the generated changelog, and tags when that PR merges, so you never touch a
version number by hand. To force a specific version, put a footer on the commit:

```
Release-As: 2.0.0
```

## Asking

Open an issue for bugs and a discussion for anything shaped like "should this
color be different," which is most of them. Screenshots help more than hex codes,
and a screenshot of the variant you think is broken next to one you think is fine
helps most of all.

`AGENTS.md` is the guide for AI assistants working in this repo. If you are one,
read that first.
