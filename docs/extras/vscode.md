# VS Code

SilkCircuit for Visual Studio Code, all five variants in one extension.

## Install from the Marketplace

1. Extensions, `Ctrl+Shift+X` or `Cmd+Shift+X`.
2. Search for SilkCircuit and install it.
3. `Ctrl+K Ctrl+T`, then pick a variant.

## Install from source

```bash
git clone https://github.com/hyperb1iss/silkcircuit.git
cd silkcircuit/extras/vscode

npm install -g @vscode/vsce

# The theme has no runtime dependencies, and without this flag vsce fails
# looking for a lockfile.
vsce package --no-dependencies
code --install-extension silkcircuit-theme-*.vsix
```

The installer copies the extension directory straight into
`~/.vscode/extensions/`, which skips the packaging step: `./install.sh`. The
extension is one package carrying all five themes, so `--variant` does not
narrow it; pick a theme in the editor.

## Available themes

| Theme               | Type  | Description                      |
| ------------------- | ----- | -------------------------------- |
| SilkCircuit Neon    | Dark  | The original electric experience |
| SilkCircuit Vibrant | Dark  | Pure saturation, darker canvas   |
| SilkCircuit Soft    | Dark  | Gentler, for long sessions       |
| SilkCircuit Glow    | Dark  | Near-black with pure neon        |
| SilkCircuit Dawn    | Light | Bright rooms, same accents       |

## Color tokens

| Syntax element | Scope                  | Color        |
| -------------- | ---------------------- | ------------ |
| Keywords       | `keyword`              | Purple       |
| Functions      | `entity.name.function` | Cyan         |
| Strings        | `string`               | Pink soft    |
| Numbers        | `constant.numeric`     | Coral        |
| Booleans       | `constant.language`    | Pink         |
| Types          | `entity.name.type`     | Yellow       |
| Comments       | `comment`              | Purple muted |

Override any of them per theme in `settings.json`:

```json
{
  "editor.tokenColorCustomizations": {
    "[SilkCircuit Neon]": {
      "textMateRules": [
        {
          "scope": "comment",
          "settings": { "foreground": "#6272a4", "fontStyle": "italic" }
        }
      ]
    }
  }
}
```

## Contributing

The theme JSON is generated from `lua/silkcircuit/variants.lua`, so a color
change belongs in the palette or in `lua/silkcircuit/extra/vscode.lua`, then
`make build`. Editing the JSON directly gets overwritten on the next build.
Package with `make vscode-package`.

## Files

The extension manifest, icon, LICENSE, and README are hand-maintained in
`extras/vscode/`. The themes underneath are generated.

<!-- extras:start target=vscode -->

| Variant | File                                            |
| ------- | ----------------------------------------------- |
| neon    | `extras/vscode/themes/silkcircuit-neon.json`    |
| vibrant | `extras/vscode/themes/silkcircuit-vibrant.json` |
| soft    | `extras/vscode/themes/silkcircuit-soft.json`    |
| glow    | `extras/vscode/themes/silkcircuit-glow.json`    |
| dawn    | `extras/vscode/themes/silkcircuit-dawn.json`    |

<!-- extras:end -->
