# SilkCircuit for bat

[bat](https://github.com/sharkdp/bat) compiles themes into a binary cache, so a
`.tmTheme` has to be copied in and the cache rebuilt before bat can see it.

```bash
mkdir -p "$(bat --config-dir)/themes"
cp silkcircuit-*.tmTheme "$(bat --config-dir)/themes/"
bat cache --build
```

Then pick one:

```bash
bat --theme=silkcircuit-neon file.lua
```

Or make it the default in `$(bat --config-dir)/config`:

```
--theme=silkcircuit-neon
--italic-text=always
--map-syntax="*.conf:INI"
--map-syntax="*.service:INI"
--map-syntax="*.zsh:Bourne Again Shell (bash)"
--map-syntax=".zshrc:Bourne Again Shell (bash)"
--map-syntax=".zprofile:Bourne Again Shell (bash)"
```

`--italic-text=always` matters here: comments, strings, function names and
inherited classes all carry italics in this theme, and bat drops them otherwise.

## The theme name is the file name

bat identifies a theme by the stem of its file, not by the `name` inside the
plist, so these are `silkcircuit-neon` through `silkcircuit-dawn` even though
each plist calls itself "SilkCircuit Neon" for other TextMate consumers. Run
`bat --list-themes` if you are ever unsure which spelling is live.

The same name is what [delta](https://dandavison.github.io/delta/) wants for its
`syntax-theme`, and the git configs in `extras/git` already point at it.
