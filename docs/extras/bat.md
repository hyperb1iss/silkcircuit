# bat

Syntax themes for [bat](https://github.com/sharkdp/bat), which
[delta](https://dandavison.github.io/delta/) also uses for diff highlighting.

## Install

bat compiles themes into a binary cache, so the file has to be copied in and
the cache rebuilt before bat can see it:

```bash
mkdir -p "$(bat --config-dir)/themes"
cp extras/bat/silkcircuit-*.tmTheme "$(bat --config-dir)/themes/"
bat cache --build
```

Then use it per invocation:

```bash
bat --theme=silkcircuit-neon file.lua
```

Or make it the default in `$(bat --config-dir)/config`:

```
--theme=silkcircuit-neon
--italic-text=always
```

That last flag matters. Comments, strings, function names, and
inherited classes all carry italics in this theme, and bat drops them
otherwise.

The installer does all of it, cache rebuild included: `./install.sh`, or
`./install.sh --variant neon` for just that one.

## The theme name is the file name

bat identifies a theme by the stem of its file, not by the `name` inside the
plist, so these are `silkcircuit-neon` through `silkcircuit-dawn` even though
each plist calls itself "SilkCircuit Neon" for other TextMate consumers. Run
`bat --list-themes` if you are unsure which spelling is live.

The same name is what delta wants for its `syntax-theme`, and the [Git
configs](/extras/git) already point at it.

## Files

<!-- extras:start target=bat -->

| Variant | File                                     |
| ------- | ---------------------------------------- |
| neon    | `extras/bat/silkcircuit-neon.tmTheme`    |
| vibrant | `extras/bat/silkcircuit-vibrant.tmTheme` |
| soft    | `extras/bat/silkcircuit-soft.tmTheme`    |
| glow    | `extras/bat/silkcircuit-glow.tmTheme`    |
| dawn    | `extras/bat/silkcircuit-dawn.tmTheme`    |

<!-- extras:end -->
