# Git

Color slots for every command git colorizes, plus a named log format and a
[delta](https://dandavison.github.io/delta/) feature block.

## Install

Copy a variant and include it, so your own `.gitconfig` stays yours:

```bash
mkdir -p ~/.config/git
cp extras/git/silkcircuit-neon.gitconfig ~/.config/git/
git config --global --add include.path ~/.config/git/silkcircuit-neon.gitconfig
```

The installer does the same thing, include and all:
`./install.sh --variant neon`.

## What it sets

Colors only, in the `[color]`, `[color "branch"]`, `[color "decorate"]`,
`[color "diff"]`, `[color "status"]`, `[color "interactive"]`, and
`[color "grep"]` sections. Git takes 24-bit hex values in every one of them, so
these are the same hex codes the editor uses rather than the nearest ANSI slot.

## The opt-ins at the bottom

Three things in the file do nothing until you ask for them, because switching
someone's pager or log format is not a color scheme's business:

```ini
[core]
	pager = delta
[interactive]
	diffFilter = delta --color-only
[delta]
	features = silkcircuit-neon
```

The delta feature expects the matching [bat theme](/extras/bat), since delta
takes its syntax highlighting from bat's theme cache.

The log format is named rather than default, so reach for it with
`git log --pretty=silkcircuit`, or make it the default:

```ini
[format]
	pretty = silkcircuit
```

## Files

<!-- extras:start target=git -->

| Variant | File                                       |
| ------- | ------------------------------------------ |
| neon    | `extras/git/silkcircuit-neon.gitconfig`    |
| vibrant | `extras/git/silkcircuit-vibrant.gitconfig` |
| soft    | `extras/git/silkcircuit-soft.gitconfig`    |
| glow    | `extras/git/silkcircuit-glow.gitconfig`    |
| dawn    | `extras/git/silkcircuit-dawn.gitconfig`    |

<!-- extras:end -->
