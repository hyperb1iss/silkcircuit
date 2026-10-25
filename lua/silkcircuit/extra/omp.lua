-- omp (oh-my-pi) reads custom themes as strict JSON from
-- ~/.omp/agent/themes/<name>.json, so these files carry no provenance
-- comment; the name and the $schema line say what they are.
--
-- Every color token omp defines is set, including the two optional ones, so
-- no surface falls back to a built-in theme. Palette keys go through `vars`
-- so the token table reads as roles rather than hex.

local M = {}

local color_utils = require("silkcircuit.utils.colors")

local SCHEMA =
  "https://raw.githubusercontent.com/can1357/oh-my-pi/main/packages/coding-agent/theme-schema.json"

-- Palette keys exposed as theme vars, in output order.
local VARS = {
  "bg",
  "bg_dark",
  "bg_highlight",
  "bg_statusline",
  "bg_float",
  "divider",
  "fg",
  "fg_dark",
  "comment",
  "gray",
  "blue_gray",
  "purple",
  "pink",
  "pink_soft",
  "pink_bright",
  "cyan",
  "coral",
  "yellow",
  "green",
  "red",
  "blue",
  "error",
}

-- Colors mixed from a palette key over the page, as { var, key, alpha }.
--
-- Secondary text is the foreground faded toward the page rather than a
-- palette neutral. omp paints most of its chrome (hints, labels, card
-- bodies) with `muted`, and Glow maps its neutrals (comment, fg_dark,
-- gray_light) to magenta, so borrowing one turned the whole transcript pink.
-- A fade stays grey in every variant and leaves color to the accents.
--
-- A finished tool sits on the plain cursorline step: a green wash under every
-- successful call turns the transcript swampy, so only a running call (a
-- breath of purple) and a failed one (red) are tinted.
local function mixed(light)
  return {
    { "text_soft", "fg", light and 0.80 or 0.82 },
    { "text_muted", "fg", light and 0.72 or 0.58 },
    { "user_bg", "purple", light and 0.10 or 0.09 },
    { "custom_bg", "cyan", light and 0.10 or 0.08 },
    { "pending_bg", "purple", 0.06 },
    { "error_bg", "red", light and 0.12 or 0.10 },
    { "selected_bg", "purple", 0.22 },
  }
end

-- omp token, var. "" is the terminal's own foreground.
local TOKENS = {
  -- Core text and borders
  { "accent", "purple" },
  { "border", "divider" },
  { "borderAccent", "cyan" },
  { "borderMuted", "divider" },
  { "success", "green" },
  { "error", "error" },
  { "warning", "yellow" },
  { "muted", "text_muted" },
  { "dim", "blue_gray" },
  { "text", "" },
  { "thinkingText", "blue_gray" },
  { "assistantMessageText", "" },

  -- Background blocks
  { "selectedBg", "selected_bg" },
  { "userMessageBg", "user_bg" },
  { "customMessageBg", "custom_bg" },
  { "toolPendingBg", "pending_bg" },
  { "toolSuccessBg", "bg_highlight" },
  { "toolErrorBg", "error_bg" },
  { "statusLineBg", "bg_statusline" },

  -- Message and tool text
  { "userMessageText", "" },
  { "customMessageText", "" },
  { "customMessageLabel", "cyan" },
  { "toolTitle", "text_soft" },
  { "toolOutput", "gray" },

  -- Markdown
  { "mdHeading", "purple" },
  { "mdLink", "cyan" },
  { "mdLinkUrl", "blue_gray" },
  { "mdCode", "coral" },
  { "mdCodeBlock", "fg" },
  { "mdCodeBlockBorder", "divider" },
  { "mdQuote", "text_soft" },
  { "mdQuoteBorder", "purple" },
  { "mdHr", "divider" },
  { "mdListBullet", "cyan" },

  -- Diffs and syntax, per the semantic map in STYLE_GUIDE.md
  { "toolDiffAdded", "green" },
  { "toolDiffRemoved", "red" },
  { "toolDiffContext", "blue_gray" },
  { "syntaxComment", "comment" },
  { "syntaxKeyword", "purple" },
  { "syntaxFunction", "cyan" },
  { "syntaxVariable", "fg" },
  { "syntaxString", "pink_soft" },
  { "syntaxNumber", "coral" },
  { "syntaxType", "yellow" },
  { "syntaxOperator", "fg_dark" },
  { "syntaxPunctuation", "fg_dark" },

  -- Thinking levels climb from quiet to hot; modes take the REPL colors
  { "thinkingOff", "divider" },
  { "thinkingMinimal", "blue_gray" },
  { "thinkingLow", "blue" },
  { "thinkingMedium", "cyan" },
  { "thinkingHigh", "purple" },
  { "thinkingXhigh", "pink" },
  { "thinkingMax", "coral" },
  { "bashMode", "cyan" },
  { "pythonMode", "yellow" },

  -- Status line segments
  { "statusLineSep", "divider" },
  { "statusLineModel", "purple" },
  { "statusLinePath", "cyan" },
  { "statusLineGitClean", "green" },
  { "statusLineGitDirty", "yellow" },
  { "statusLineContext", "pink_bright" },
  { "statusLineSpend", "text_soft" },
  { "statusLineStaged", "green" },
  { "statusLineDirty", "yellow" },
  { "statusLineUntracked", "red" },
  { "statusLineOutput", "text_soft" },
  { "statusLineCost", "green" },
  { "statusLineSubagents", "blue" },
}

local ANSI = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }

local function quote(value)
  return '"' .. value .. '"'
end

-- `entries` is a list of { key, rendered value }, written as one JSON object.
local function object(entries, indent)
  local lines = {}
  for index, entry in ipairs(entries) do
    lines[#lines + 1] =
      string.format('%s  "%s": %s%s', indent, entry[1], entry[2], index < #entries and "," or "")
  end
  return "{\n" .. table.concat(lines, "\n") .. "\n" .. indent .. "}"
end

function M.generate(colors)
  local light = colors.meta.appearance == "light"

  local vars = {}
  for _, key in ipairs(VARS) do
    vars[#vars + 1] = { key, quote(colors[key]) }
  end
  for _, mix in ipairs(mixed(light)) do
    vars[#vars + 1] = { mix[1], quote(color_utils.blend(colors[mix[2]], colors.bg, mix[3])) }
  end

  local tokens = {}
  for _, token in ipairs(TOKENS) do
    tokens[#tokens + 1] = { token[1], quote(token[2]) }
  end

  local ansi = {}
  for _, name in ipairs(ANSI) do
    ansi[#ansi + 1] = quote(colors["terminal_" .. name])
  end
  for _, name in ipairs(ANSI) do
    ansi[#ansi + 1] = quote(colors["terminal_bright_" .. name])
  end

  return object({
    { "$schema", quote(SCHEMA) },
    { "name", quote(colors.meta.slug) },
    { "vars", object(vars, "  ") },
    { "colors", object(tokens, "  ") },
    {
      "export",
      object({
        { "pageBg", quote("bg") },
        { "cardBg", quote("bg_highlight") },
        { "infoBg", quote("bg_float") },
      }, "  "),
    },
    {
      "terminal",
      object({
        { "background", quote("bg") },
        { "foreground", quote("fg") },
        { "chrome", quote("bg_dark") },
        { "widget", quote("bg_float") },
        { "ansi", "[" .. table.concat(ansi, ", ") .. "]" },
      }, "  "),
    },
  }, "")
end

return M
