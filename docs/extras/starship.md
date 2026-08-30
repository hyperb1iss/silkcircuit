# Starship

A full [Starship](https://starship.rs/) prompt: a powerline of segments for OS,
user, directory, git branch and status, language versions, and Kubernetes
context, on a named `silkcircuit` palette.

The `format` string names every segment explicitly, so a module stays out of
the prompt until it appears there, disabled or not. The clock, command
duration, battery, package version, and shell all ship configured but unused.
Bringing one in means adding it to `format`, and clearing `disabled` too for
the clock and the shell, which are the two switched off.

## Install

Starship reads one config file, so pick a variant and copy it under that name:

```bash
cp extras/starship/silkcircuit-neon.toml ~/.config/starship.toml
```

If `STARSHIP_CONFIG` is set, that path wins.

The installer respects it: `./install.sh --variant neon`.

## Needs a Nerd Font

The prompt draws powerline separators and per-OS glyphs, so the terminal font
has to carry them. Any [Nerd Font](https://www.nerdfonts.com/) build works.

## Reusing the palette

Colors are declared once under `[palettes.silkcircuit]` and referenced by name
everywhere else, so a local tweak reaches for `purple` or `cyan` rather than
pasting a hex. Every accent role is in there, including the ones the default
segments do not use.

## Files

<!-- extras:start target=starship -->

| Variant | File                                       |
| ------- | ------------------------------------------ |
| neon    | `extras/starship/silkcircuit-neon.toml`    |
| vibrant | `extras/starship/silkcircuit-vibrant.toml` |
| soft    | `extras/starship/silkcircuit-soft.toml`    |
| glow    | `extras/starship/silkcircuit-glow.toml`    |
| dawn    | `extras/starship/silkcircuit-dawn.toml`    |

<!-- extras:end -->
