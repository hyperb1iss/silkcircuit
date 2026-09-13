# GNU dircolors

An `LS_COLORS` database for GNU `dircolors`, covering file types, permissions,
archives, media, source files, and the metadata `ls` draws around them.

## Install

Copy one variant into the standard user-level slot:

```bash
cp extras/dircolors/silkcircuit-neon.dircolors ~/.dircolors
```

Load it in the current shell:

```bash
eval "$(dircolors -b ~/.dircolors)"
```

Add that `eval` line to `.bashrc` or `.zshrc` to keep the colors across new
shells. The installer copies the selected variant and prints the same enable
line: `./install.sh --variant neon`.

## GNU coreutils

The database targets GNU `dircolors`. The installer activates this extra when
either `dircolors` or `gdircolors` is on `PATH`. The second name is what
Homebrew's coreutils installs on macOS, so the load line there is:

```bash
eval "$(gdircolors -b ~/.dircolors)"
```

Tools that read `LS_COLORS` directly, such as `lsd`, `fd`, and zsh's
completion listings, pick the colors up from the same `eval`, so the
dircolors extra is what themes their file and extension colors.

## Files

<!-- extras:start target=dircolors -->

| Variant | File                                             |
| ------- | ------------------------------------------------ |
| neon    | `extras/dircolors/silkcircuit-neon.dircolors`    |
| vibrant | `extras/dircolors/silkcircuit-vibrant.dircolors` |
| soft    | `extras/dircolors/silkcircuit-soft.dircolors`    |
| glow    | `extras/dircolors/silkcircuit-glow.dircolors`    |
| dawn    | `extras/dircolors/silkcircuit-dawn.dircolors`    |

<!-- extras:end -->
