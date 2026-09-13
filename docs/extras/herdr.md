# Herdr

The UI palette for [Herdr](https://herdr.dev/), the terminal workspace manager
for coding agents: the sidebar, the tab bar, overlays and menus, the agent
state dots, and the Navigate and Resize mode bars.

## Install

Herdr has no theme directory. Its palette is the `[theme]` table in
`~/.config/herdr/config.toml`, so the tables get merged into your config:

```bash
mkdir -p ~/.config/herdr
cp extras/herdr/silkcircuit-*.toml ~/.config/herdr/
```

Paste the `[theme]` and `[theme.custom]` tables from
`~/.config/herdr/silkcircuit-neon.toml` into `~/.config/herdr/config.toml`,
replacing any `[theme]` table already there, then reload:

```bash
herdr server reload-config
```

Prefix then Shift+R does the same from inside Herdr, and `herdr config check`
validates the result.

The installer copies the files and prints these steps: `./install.sh`, or
`./install.sh --variant neon` for just that one.

Needs Herdr 0.8.2 or newer, where the sidebar and cursor row tokens landed.

## Light and dark together

`extras/herdr/silkcircuit.toml` pairs Neon with Dawn under Herdr's
`auto_switch`, so Herdr follows the terminal's light or dark appearance the way
a terminal that flips with the OS does. Merge it in place of the single-variant
tables. To pair a different dark variant, replace its `[theme.custom.dark]`
table with the `[theme.custom]` table from that variant's file.

## What is set

Every one of Herdr's nineteen color tokens, so the built-in base has nothing
left to paint. The base is `terminal` all the same: if a newer Herdr adds a
token, it takes the color from your terminal's ANSI palette rather than from
another theme.

Purple is the accent, so the focused tab, the mode bar, and active borders wear
the same color as the Neovim theme's popup selection. Pink marks branch names
and the Resize mode bar. Agent states use the semantic set: green for done and
idle, yellow for working, red for blocked, coral for interrupted, and cyan and
blue for notifications.

Every foreground clears WCAG AA against the panel, sidebar, active row, and
tab surfaces in all five variants. The Navigate-mode cursor row and the
dragged row use the Visual selection color, a mid tone: main text clears
Herdr's 3:1 floor there, and the accents do not reach 4.5:1, as in the Neovim
theme.

## Files

<!-- extras:start target=herdr -->

| Variant | File                                    |
| ------- | --------------------------------------- |
| neon    | `extras/herdr/silkcircuit-neon.toml`    |
| vibrant | `extras/herdr/silkcircuit-vibrant.toml` |
| soft    | `extras/herdr/silkcircuit-soft.toml`    |
| glow    | `extras/herdr/silkcircuit-glow.toml`    |
| dawn    | `extras/herdr/silkcircuit-dawn.toml`    |

<!-- extras:end -->

<!-- extras:start target=herdr-auto -->

| Variant       | File                            |
| ------------- | ------------------------------- |
| every variant | `extras/herdr/silkcircuit.toml` |

<!-- extras:end -->
