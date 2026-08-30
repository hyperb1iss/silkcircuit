# VS Code Theme

SilkCircuit for Visual Studio Code with all five variants.

## Installation

### From VS Code Marketplace

1. Open VS Code
2. Go to Extensions (`Ctrl+Shift+X` / `Cmd+Shift+X`)
3. Search for "SilkCircuit"
4. Click Install
5. Select theme: `Ctrl+K Ctrl+T` → SilkCircuit

### From Source

```bash
# Clone the repository
git clone https://github.com/hyperb1iss/silkcircuit.git
cd silkcircuit/extras/vscode

# Install vsce if needed
npm install -g @vscode/vsce

# Package and install
vsce package
code --install-extension silkcircuit-*.vsix
```

## Available Themes

| Theme               | Type  | Description                      |
| ------------------- | ----- | -------------------------------- |
| SilkCircuit Neon    | Dark  | 100% intensity, maximum vibrancy |
| SilkCircuit Vibrant | Dark  | 85% intensity, balanced energy   |
| SilkCircuit Soft    | Dark  | 70% intensity, gentle on eyes    |
| SilkCircuit Glow    | Dark  | Ultra-dark with pure neon        |
| SilkCircuit Dawn    | Light | Bright theme for daytime         |

## Switching Themes

1. Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
2. Type "Preferences: Color Theme"
3. Select your preferred SilkCircuit variant

## Screenshots

Each variant provides a unique visual experience:

- **Neon**: The original electric experience
- **Vibrant**: Slightly toned for everyday use
- **Soft**: Comfortable for long sessions
- **Glow**: Maximum contrast on ultra-dark backgrounds
- **Dawn**: Clean light theme for bright environments

## Color Tokens

The VS Code theme maps SilkCircuit's semantic colors:

| Syntax Element | Token                  | Color        |
| -------------- | ---------------------- | ------------ |
| Keywords       | `keyword`              | Purple       |
| Functions      | `entity.name.function` | Cyan         |
| Strings        | `string`               | Pink Soft    |
| Numbers        | `constant.numeric`     | Coral        |
| Booleans       | `constant.language`    | Pink         |
| Types          | `entity.name.type`     | Yellow       |
| Comments       | `comment`              | Purple Muted |

## Customization

Adjust colors in your `settings.json`:

```json
{
  "editor.tokenColorCustomizations": {
    "[SilkCircuit Neon]": {
      "textMateRules": [
        {
          "scope": "comment",
          "settings": {
            "foreground": "#6272a4",
            "fontStyle": "italic"
          }
        }
      ]
    }
  }
}
```

## Workbench Colors

The theme styles the entire VS Code interface:

| Element           | Color                   |
| ----------------- | ----------------------- |
| Editor background | Variant-specific        |
| Sidebar           | Slightly darker         |
| Activity bar      | Dark with accent icons  |
| Status bar        | Purple accent           |
| Tabs              | Highlighted active tab  |
| Terminal          | Full ANSI color support |

## Files

```
extras/vscode/
├── package.json           # Extension manifest
├── silkcircuit-neon.json  # Neon theme
├── silkcircuit-vibrant.json
├── silkcircuit-soft.json
├── silkcircuit-glow.json
├── silkcircuit-dawn.json  # Light theme
└── assets/               # Screenshots
```

## Contributing

To modify the VS Code theme:

1. Edit the appropriate JSON file
2. Test locally with `F5` in VS Code
3. Package with `vsce package`
4. Submit a pull request
