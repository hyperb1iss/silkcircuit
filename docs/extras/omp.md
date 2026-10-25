# omp

The full color theme for [omp](https://github.com/can1357/oh-my-pi) (oh-my-pi),
the terminal coding agent: the transcript, markdown and code, tool cards and
diffs, the composer frame, and every status line segment.

## Install

omp reads custom themes from `~/.omp/agent/themes/`, one JSON file each:

```bash
mkdir -p ~/.omp/agent/themes
cp extras/omp/silkcircuit-*.json ~/.omp/agent/themes/
```

Pick one under `/settings`, Appearance, or set both slots in
`~/.omp/agent/config.yml` so omp follows the terminal's light or dark
background:

```yaml
theme:
  dark: silkcircuit-neon
  light: silkcircuit-dawn
```

omp watches the active theme file and reloads it on save. When
`PI_CODING_AGENT_DIR` is set, the themes go in its `themes/` directory instead.

The installer copies the files and prints the line above: `./install.sh`, or
`./install.sh --variant neon` for just that one.

## Session accent

omp tints the composer border, the brand glyph, and the model name with a hue
derived from the session name. It picks that hue to stay away from every
theme color, so with any palette it lands off the palette. Turn it off to keep
the chrome on SilkCircuit:

```yaml
statusLine:
  sessionAccent: false
```

## What is set

All 68 color tokens omp defines, including the optional `thinkingMax` and
`assistantMessageText`, so nothing falls back to a built-in theme. Prose and
your own messages keep the terminal's foreground.

Purple is the accent: headings, the composer frame, the model segment, and
keywords. Cyan carries links, functions, the path segment, and the focused
border. Code follows the semantic map in the style guide: pink-soft strings,
coral numbers and inline code, yellow types, and comments in purple muted.

User messages sit on a faint purple wash. A running tool gets a lighter one, a
finished tool sits on the cursorline step with no tint, and a failed tool gets
red. The status line uses the statusline background from the Neovim theme,
with green and yellow for clean and dirty git state, coral for cost, and pink
for context.

The thinking level climbs from the divider color at off through blue, cyan,
purple, and pink to coral at max.

The `terminal` block carries the variant's ANSI palette for hosts that paint
the terminal themselves; omp itself never changes your terminal's colors.

## Files

<!-- extras:start target=omp -->

| Variant | File                                  |
| ------- | ------------------------------------- |
| neon    | `extras/omp/silkcircuit-neon.json`    |
| vibrant | `extras/omp/silkcircuit-vibrant.json` |
| soft    | `extras/omp/silkcircuit-soft.json`    |
| glow    | `extras/omp/silkcircuit-glow.json`    |
| dawn    | `extras/omp/silkcircuit-dawn.json`    |

<!-- extras:end -->
