-- Palette-driven generator for everything under extras/.
--
-- Every file in extras/ is rendered from lua/silkcircuit/variants.lua so the
-- terminal you look at and the editor you type in cannot drift apart. Adding a
-- target means one registry entry here plus one module that returns a string.

local M = {}

local variants = require("silkcircuit.variants")

M.url = "https://github.com/hyperb1iss/silkcircuit"
M.author = "Stefanie Jane (hyperb1iss)"

-- The order every generated listing, table, and build log uses.
M.variants = { "neon", "vibrant", "soft", "glow", "dawn" }

--- Registry of generated targets.
---
--- Fields, all optional except `label` and `ext`:
---   label    Human name used in headers and the docs tables.
---   ext      File extension without the dot. "" means no extension.
---   url      Upstream documentation for the format.
---   dir      Directory under extras/. Defaults to the target name.
---   module   Module under silkcircuit.extra. Defaults to the target name
---            with dashes turned into underscores.
---   comment  Header comment style: "hash" (default), "css", or "none".
---   is_full  Render once from every variant instead of once per variant.
---   filename Function(variant) returning the file name, for formats whose
---            tooling dictates a name the default pattern cannot express.
M.targets = {
  iterm2 = {
    label = "iTerm2",
    ext = "itermcolors",
    comment = "none",
    url = "https://iterm2.com/documentation-preferences-profiles-colors.html",
  },
  kitty = {
    label = "Kitty",
    ext = "conf",
    url = "https://sw.kovidgoyal.net/kitty/conf/#color-scheme",
  },
  alacritty = {
    label = "Alacritty",
    ext = "toml",
    url = "https://alacritty.org/config-alacritty.html#colors",
  },
  foot = {
    label = "foot",
    ext = "ini",
    url = "https://codeberg.org/dnkl/foot/src/branch/master/doc/foot.ini.5.scd",
  },
  fzf = {
    label = "fzf",
    ext = "sh",
    url = "https://github.com/junegunn/fzf/blob/master/man/man1/fzf.1",
  },
  ["fzf-ps1"] = {
    label = "fzf (PowerShell)",
    dir = "fzf",
    ext = "ps1",
    url = "https://github.com/junegunn/fzf/blob/master/man/man1/fzf.1",
  },
  ghostty = {
    label = "Ghostty",
    ext = "",
    url = "https://ghostty.org/docs/config/reference#theme",
  },
  ["ghostty-css"] = {
    label = "Ghostty GTK chrome",
    dir = "ghostty",
    ext = "css",
    comment = "css",
    url = "https://ghostty.org/docs/config/reference#gtk-custom-css",
  },
  tmux = {
    label = "tmux",
    ext = "conf",
    url = "https://man.openbsd.org/tmux#STYLES",
  },
  warp = {
    label = "Warp",
    ext = "yaml",
    url = "https://docs.warp.dev/terminal/appearance/custom-themes",
  },
  wezterm = {
    label = "WezTerm",
    ext = "toml",
    url = "https://wezterm.org/config/appearance.html#defining-a-color-scheme-in-a-separate-file",
  },
  ["windows-terminal"] = {
    label = "Windows Terminal",
    ext = "json",
    comment = "none",
    url = "https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes",
  },
  ["windows-terminal-all"] = {
    label = "Windows Terminal (every scheme)",
    dir = "windows-terminal",
    ext = "json",
    comment = "none",
    is_full = true,
    url = "https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes",
  },
  atuin = {
    label = "Atuin",
    ext = "toml",
    url = "https://github.com/atuinsh/atuin/blob/main/crates/atuin-client/src/theme.rs",
  },
  btop = {
    label = "btop",
    ext = "theme",
    url = "https://github.com/aristocratos/btop#themes",
  },
  cosmic = {
    label = "COSMIC Desktop",
    ext = "ron",
    comment = "slash",
    url = "https://github.com/pop-os/cosmic-theme",
  },
  dmesg = {
    label = "dmesg",
    ext = "scheme",
    url = "https://www.man7.org/linux/man-pages/man5/terminal-colors.d.5.html",
  },
  k9s = {
    label = "k9s",
    ext = "yaml",
    url = "https://k9scli.io/topics/skins/",
  },
  lazygit = {
    label = "lazygit",
    ext = "yml",
    url = "https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md#color-attributes",
  },
}

local HEX6 = "^#(%x%x)(%x%x)(%x%x)$"

local COMMENTS = {
  hash = function(lines)
    local out = {}
    for _, line in ipairs(lines) do
      out[#out + 1] = line == "" and "#" or ("# " .. line)
    end
    return table.concat(out, "\n")
  end,
  css = function(lines)
    local out = { "/*" }
    for _, line in ipairs(lines) do
      out[#out + 1] = line == "" and " *" or (" * " .. line)
    end
    out[#out + 1] = " */"
    return table.concat(out, "\n")
  end,
  slash = function(lines)
    local out = {}
    for _, line in ipairs(lines) do
      out[#out + 1] = line == "" and "//" or ("// " .. line)
    end
    return table.concat(out, "\n")
  end,
  semicolon = function(lines)
    local out = {}
    for _, line in ipairs(lines) do
      out[#out + 1] = line == "" and ";" or ("; " .. line)
    end
    return table.concat(out, "\n")
  end,
  dash = function(lines)
    local out = {}
    for _, line in ipairs(lines) do
      out[#out + 1] = line == "" and "--" or ("-- " .. line)
    end
    return table.concat(out, "\n")
  end,
  xml = function(lines)
    local out = { "<!--" }
    for _, line in ipairs(lines) do
      out[#out + 1] = "  " .. line
    end
    out[#out + 1] = "-->"
    return table.concat(out, "\n")
  end,
  none = function()
    return nil
  end,
}

local function titlecase(word)
  return word:sub(1, 1):upper() .. word:sub(2)
end

--- Sorted target names, so build output and docs tables never reshuffle.
function M.names()
  local names = {}
  for name in pairs(M.targets) do
    names[#names + 1] = name
  end
  table.sort(names)
  return names
end

function M.dir(name)
  return M.targets[name].dir or name
end

function M.module(name)
  local spec = M.targets[name]
  return spec.module or (name:gsub("%-", "_"))
end

--- File name a target writes for one variant, relative to its directory.
function M.filename(name, variant)
  local spec = M.targets[name]
  if spec.filename then
    return spec.filename(variant)
  end
  local suffix = spec.ext ~= "" and ("." .. spec.ext) or ""
  if spec.is_full then
    return "silkcircuit" .. suffix
  end
  return "silkcircuit-" .. variant .. suffix
end

--- Palette for one variant, plus the derived tables templates reach for.
---
--- `rgb.<key>` is `{ r, g, b }` as 0-255 integers, `rgbf.<key>` is the same
--- channels as 0..1 floats at six decimals, and `hex_nohash.<key>` drops the
--- leading '#'. All three are built once per variant because formats like the
--- Chrome manifest and the COSMIC ron files need numbers, not hex.
function M.colors(variant)
  local colors = variants.get_colors(variant)

  local rgb, rgbf, nohash = {}, {}, {}
  for key, value in pairs(colors) do
    if type(value) == "string" then
      local r, g, b = value:match(HEX6)
      if r then
        local ri, gi, bi = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
        rgb[key] = { r = ri, g = gi, b = bi }
        rgbf[key] = {
          r = string.format("%.6f", ri / 255),
          g = string.format("%.6f", gi / 255),
          b = string.format("%.6f", bi / 255),
        }
        nohash[key] = value:sub(2)
      end
    end
  end

  colors.rgb = rgb
  colors.rgbf = rgbf
  colors.hex_nohash = nohash
  colors.meta = {
    variant = variant,
    label = titlecase(variant),
    name = "SilkCircuit " .. titlecase(variant),
    slug = "silkcircuit-" .. variant,
    appearance = variant == "dawn" and "light" or "dark",
    description = variants.variants[variant].description,
    url = M.url,
    author = M.author,
  }

  return colors
end

--- Expand `${key}` and `${table.key}` references against a palette.
---
--- An unknown key is a hard error. Emitting a literal `${...}` into a terminal
--- config would ship a broken theme that nothing validates. Formats that need
--- a literal `${` (shell, starship) write `$${` in the template.
function M.template(str, colors)
  local ESCAPE = "\1literal\1"
  str = str:gsub("%$%$%{", ESCAPE)
  return (
    str
      :gsub("($%b{})", function(ref)
        local path = ref:sub(3, -2)
        local value = vim.tbl_get(colors, unpack(vim.split(path, ".", { plain = true })))
        if value == nil or type(value) == "table" then
          error(
            string.format(
              "silkcircuit.extra: '%s' does not resolve to a value in variant '%s'",
              path,
              colors.meta and colors.meta.variant or "?"
            ),
            0
          )
        end
        return tostring(value)
      end)
      :gsub(ESCAPE, "${")
  )
end

--- Provenance banner in the target format's comment syntax.
function M.header(name, variant)
  local spec = M.targets[name]
  local style = spec.comment or "hash"
  local render = COMMENTS[style]
  if not render then
    error(
      string.format("silkcircuit.extra: target '%s' uses unknown comment style '%s'", name, style),
      0
    )
  end
  local title = variant and ("SilkCircuit " .. titlecase(variant) .. " for " .. spec.label)
    or ("SilkCircuit for " .. spec.label)
  return render({
    title,
    M.url,
    "",
    "Generated by scripts/build from lua/silkcircuit/variants.lua.",
    "Do not edit by hand.",
  })
end

local function write(path, content)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  local handle = assert(io.open(path, "w"), "cannot write " .. path)
  handle:write((content:gsub("\n*$", "")) .. "\n")
  handle:close()
end

M.write = write

--- Drop every generated file in a directory so a renamed target cannot orphan
--- a stale theme. Only files named like generator output go; hand-maintained
--- neighbours (a package.json, a LICENSE, an icon) survive.
local function wipe(dir)
  if vim.fn.isdirectory(dir) == 0 then
    return
  end
  for entry, kind in vim.fs.dir(dir) do
    if kind == "file" and entry:lower():match("^silkcircuit") and not entry:match("%.md$") then
      vim.fn.delete(dir .. "/" .. entry)
    end
  end
end

--- Render every target for every variant into extras/.
function M.build(opts)
  opts = opts or {}
  local root = opts.root or vim.uv.cwd()

  local palettes = {}
  local ordered = {}
  for _, variant in ipairs(M.variants) do
    palettes[variant] = M.colors(variant)
    ordered[#ordered + 1] = { variant = variant, colors = palettes[variant] }
  end

  local names = M.names()

  local seen = {}
  for _, name in ipairs(names) do
    local dir = M.dir(name)
    if not seen[dir] then
      seen[dir] = true
      wipe(root .. "/extras/" .. dir)
    end
  end

  local written = {}
  for _, name in ipairs(names) do
    local spec = M.targets[name]
    local module = require("silkcircuit.extra." .. M.module(name))
    local dir = M.dir(name)

    local function emit(variant, body)
      local header = M.header(name, variant)
      local content = header and (header .. "\n\n" .. body) or body
      local relative = "extras/" .. dir .. "/" .. M.filename(name, variant)
      write(root .. "/" .. relative, content)
      written[#written + 1] = relative
      print("  " .. relative)
    end

    if spec.is_full then
      emit(nil, module.generate(ordered, opts))
    else
      for _, variant in ipairs(M.variants) do
        emit(variant, module.generate(palettes[variant], opts))
      end
    end
  end

  for _, relative in ipairs(require("silkcircuit.extra.palette").generate(root)) do
    written[#written + 1] = relative
    print("  " .. relative)
  end

  return written
end

--- Refresh the generated tables inside the `extras:start` marker blocks.
function M.docs(opts)
  return require("silkcircuit.extra.docs").generate(opts)
end

return M
