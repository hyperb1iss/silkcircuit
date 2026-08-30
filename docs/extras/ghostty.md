# Ghostty

Two things ship for [Ghostty](https://ghostty.org/): a terminal theme per
variant, and a GTK stylesheet per variant that colors the window chrome on
Linux.

## Terminal colors

The theme files carry no extension, which is what Ghostty's theme directory
expects.

```bash
mkdir -p ~/.config/ghostty/themes
cp extras/ghostty/silkcircuit-neon ~/.config/ghostty/themes/
```

Then in `~/.config/ghostty/config`:

```ini
theme = silkcircuit-neon
```

Ghostty can follow the system appearance, which is what the dawn variant is
for:

```ini
theme = dark:silkcircuit-neon,light:silkcircuit-dawn
```

The installer does the same thing: `./install.sh`, or
`./install.sh --variant neon` for just that one.

## GTK window chrome (Linux)

The stylesheets cover the headerbar, tabs, split dividers, the URL and resize
overlays, the search bar, the command palette, the bell flash, and the
clipboard confirmation. They apply on Linux, where Ghostty draws its chrome
with GTK, and need Ghostty 1.1 or newer for `gtk-custom-css`.

```bash
cp extras/ghostty/silkcircuit-neon.css ~/.config/ghostty/
```

```ini
gtk-custom-css = ~/.config/ghostty/silkcircuit-neon.css
```

## Files

<!-- extras:start target=ghostty -->

| Variant | File                                 |
| ------- | ------------------------------------ |
| neon    | `extras/ghostty/silkcircuit-neon`    |
| vibrant | `extras/ghostty/silkcircuit-vibrant` |
| soft    | `extras/ghostty/silkcircuit-soft`    |
| glow    | `extras/ghostty/silkcircuit-glow`    |
| dawn    | `extras/ghostty/silkcircuit-dawn`    |

<!-- extras:end -->

<!-- extras:start target=ghostty-css -->

| Variant | File                                     |
| ------- | ---------------------------------------- |
| neon    | `extras/ghostty/silkcircuit-neon.css`    |
| vibrant | `extras/ghostty/silkcircuit-vibrant.css` |
| soft    | `extras/ghostty/silkcircuit-soft.css`    |
| glow    | `extras/ghostty/silkcircuit-glow.css`    |
| dawn    | `extras/ghostty/silkcircuit-dawn.css`    |

<!-- extras:end -->
