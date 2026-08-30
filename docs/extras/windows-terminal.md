# Windows Terminal

Color schemes for [Windows
Terminal](https://learn.microsoft.com/en-us/windows/terminal/), as five
single-scheme files plus one combined file holding all five.

## Install with a fragment

The combined `silkcircuit.json` is already shaped like a [fragment
extension](https://learn.microsoft.com/en-us/windows/terminal/json-fragment-extensions),
so dropping it in the Fragments directory registers every scheme without
touching `settings.json`:

```powershell
$dir = "$env:LOCALAPPDATA\Microsoft\Windows Terminal\Fragments\SilkCircuit"
New-Item -ItemType Directory -Force $dir
Copy-Item extras\windows-terminal\silkcircuit.json $dir
```

Restart Windows Terminal, then set a profile's Color scheme to SilkCircuit
Neon. `.\install.ps1` does this for you.

## Install by pasting

On a build without fragment support, paste instead:

1. Open Settings with `Ctrl+,` and click "Open JSON file".
2. Copy the objects out of `silkcircuit.json` into the top-level `schemes`
   array.
3. Set `"colorScheme": "SilkCircuit Neon"` on the profile you want.

The installer also stages a copy under `%APPDATA%\silkcircuit\` so you do not
have to find the repository again.

## Files

<!-- extras:start target=windows-terminal -->

| Variant | File                                               |
| ------- | -------------------------------------------------- |
| neon    | `extras/windows-terminal/silkcircuit-neon.json`    |
| vibrant | `extras/windows-terminal/silkcircuit-vibrant.json` |
| soft    | `extras/windows-terminal/silkcircuit-soft.json`    |
| glow    | `extras/windows-terminal/silkcircuit-glow.json`    |
| dawn    | `extras/windows-terminal/silkcircuit-dawn.json`    |

<!-- extras:end -->

<!-- extras:start target=windows-terminal-all -->

| Variant       | File                                       |
| ------------- | ------------------------------------------ |
| every variant | `extras/windows-terminal/silkcircuit.json` |

<!-- extras:end -->
