# Claude Code

A status line for [Claude Code](https://code.claude.com/docs/en/statusline):
a powerline drawn on the same six-step ramp as the Starship prompt, so the
prompt above the input box and the status line below it read as one
instrument.

Left to right, the line carries the session badge (vim mode, agent name, and
session name, when any of them is set), the directory, and the git branch with
its dirty flags, upstream distance, the lines added and removed this session,
and the open pull request as a clickable link coloured by its review state. A
linked worktree gets its own glyph. The node version and Kubernetes context follow.
On the right sit the model with its fast mode and effort level, context usage
as tokens and a percentage, the session cost, the five-hour and seven-day rate
limit windows, the output style, and the clock.

A reading that reaches 80 percent (context or a rate limit window) turns into a
warning pill, and at 90 a danger pill, in the variant's own warning and danger
colours. A snowflake after the context reading means the prompt cache has gone
cold and the next request re-reads the whole prefix.

When the terminal is narrower than the line, readings drop in order: the tech
probes, then output style, cost, and rate limits, then the git details, the
session badge, and last the clock. The model and the context reading never
drop.

## Install

Claude Code reads one script, so pick a variant and copy it:

```bash
cp extras/claude/silkcircuit-neon.sh ~/.claude/statusline.sh
```

Then point Claude Code at it in `~/.claude/settings.json` and restart:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh",
    "refreshInterval": 30
  }
}
```

`refreshInterval` is optional. Without it the line redraws on every message,
which is enough for everything except the clock.

The installer does the copy and prints that block: `./install.sh --variant
neon`. It leaves `settings.json` alone, because Claude Code owns that file and
rewrites it as hooks, plugins, and permissions change.

## Needs a Nerd Font

The powerline separators and the segment glyphs come from a
[Nerd Font](https://www.nerdfonts.com/), so the terminal running Claude Code
has to use one.

## Fast by design

The script needs no jq. The payload is read with bash regex matches, which
keeps it linear on the two kilobytes Claude Code sends; a prefix strip would
be quadratic on the bash 3.2 macOS ships. One `git status` call per render
carries the branch, upstream distance, and every flag, and the node and
kubectl probes are cached for a minute per directory. A render lands in about
twenty milliseconds on a stock Mac, most of it git.

## Files

<!-- extras:start target=claude -->

| Variant | File |
| ------- | ---- |
| neon | `extras/claude/silkcircuit-neon.sh` |
| vibrant | `extras/claude/silkcircuit-vibrant.sh` |
| soft | `extras/claude/silkcircuit-soft.sh` |
| glow | `extras/claude/silkcircuit-glow.sh` |
| dawn | `extras/claude/silkcircuit-dawn.sh` |

<!-- extras:end -->
