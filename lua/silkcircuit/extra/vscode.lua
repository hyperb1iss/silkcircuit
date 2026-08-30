-- VS Code color themes, one per variant.
--
-- VS Code reads strict JSON, so these files carry no provenance comment; the
-- theme name is the only place to say what they are. Every value is a palette
-- role, which is what keeps the editor, the terminal, and Neovim in step.
--
-- Alpha is spelled as a suffix on a role (`${bg_visual}66`) because VS Code
-- accepts "#rrggbbaa" and the palette is six-digit only.

local M = {}

-- The two roles no single palette key can serve in both a dark and a light
-- theme. A drop shadow has to darken whatever sits under it. A hover has to
-- move away from the purple beneath it, which means brighter on a dark theme
-- and deeper on a light one, where pink_bright drops under 4.5:1 against the
-- background it carries as text.
local DERIVED = {
  dark = function(colors)
    return { shadow = colors.bg_darker, accent_hover = colors.pink_bright }
  end,
  light = function(colors)
    return { shadow = colors.gray_light .. "50", accent_hover = colors.pink }
  end,
}

local TEMPLATE = [==[
{
  "name": "${meta.name}",
  "type": "${meta.appearance}",
  "colors": {
    "editor.background": "${bg}",
    "editor.foreground": "${fg}",
    "activityBar.background": "${bg_dark}",
    "activityBar.foreground": "${purple}",
    "activityBar.inactiveForeground": "${comment}",
    "activityBarBadge.background": "${pink}",
    "activityBarBadge.foreground": "${bg}",
    "badge.background": "${purple}",
    "badge.foreground": "${bg}",
    "breadcrumb.background": "${bg}",
    "breadcrumb.foreground": "${comment}",
    "breadcrumb.focusForeground": "${fg}",
    "breadcrumb.activeSelectionForeground": "${purple}",
    "breadcrumbPicker.background": "${bg_float}",
    "button.background": "${purple}",
    "button.foreground": "${bg}",
    "button.hoverBackground": "${accent_hover}",
    "checkbox.background": "${bg_float}",
    "checkbox.border": "${purple}",
    "checkbox.foreground": "${fg}",
    "debugToolBar.background": "${bg_float}",
    "descriptionForeground": "${comment}",
    "diffEditor.insertedTextBackground": "${green}22",
    "diffEditor.removedTextBackground": "${red}22",
    "dropdown.background": "${bg_float}",
    "dropdown.border": "${purple}",
    "dropdown.foreground": "${fg}",
    "editor.lineHighlightBackground": "${bg_highlight}",
    "editor.selectionBackground": "${bg_visual}",
    "editor.selectionHighlightBackground": "${bg_visual}66",
    "editor.findMatchBackground": "${purple}44",
    "editor.findMatchHighlightBackground": "${purple}22",
    "editor.wordHighlightBackground": "${bg_visual}66",
    "editor.wordHighlightStrongBackground": "${purple}44",
    "editorBracketMatch.background": "${purple}44",
    "editorBracketMatch.border": "${purple}",
    "editorCodeLens.foreground": "${comment}",
    "editorCursor.background": "${bg}",
    "editorCursor.foreground": "${pink}",
    "editorError.foreground": "${red}",
    "editorGroup.border": "${bg_float}",
    "editorGroup.dropBackground": "${purple}22",
    "editorGroupHeader.noTabsBackground": "${bg}",
    "editorGroupHeader.tabsBackground": "${bg_dark}",
    "editorGroupHeader.tabsBorder": "${bg_float}",
    "editorGutter.addedBackground": "${green}",
    "editorGutter.deletedBackground": "${red}",
    "editorGutter.modifiedBackground": "${cyan}",
    "editorHoverWidget.background": "${bg_float}",
    "editorHoverWidget.border": "${purple}",
    "editorIndentGuide.background": "${bg_visual}",
    "editorIndentGuide.activeBackground": "${cyan}",
    "editorInfo.foreground": "${cyan}",
    "editorLineNumber.foreground": "${comment}",
    "editorLineNumber.activeForeground": "${purple}",
    "editorLink.activeForeground": "${cyan}",
    "editorMarkerNavigation.background": "${bg_float}",
    "editorMarkerNavigationError.background": "${red}",
    "editorMarkerNavigationInfo.background": "${cyan}",
    "editorMarkerNavigationWarning.background": "${yellow}",
    "editorOverviewRuler.border": "${purple}",
    "editorOverviewRuler.currentContentForeground": "${purple}",
    "editorOverviewRuler.incomingContentForeground": "${cyan}",
    "editorRuler.foreground": "${bg_visual}",
    "editorSuggestWidget.background": "${bg_float}",
    "editorSuggestWidget.border": "${purple}",
    "editorSuggestWidget.foreground": "${fg}",
    "editorSuggestWidget.highlightForeground": "${purple}",
    "editorSuggestWidget.selectedBackground": "${bg_visual}",
    "editorWarning.foreground": "${yellow}",
    "editorWhitespace.foreground": "${bg_visual}",
    "editorWidget.background": "${bg_float}",
    "editorWidget.border": "${purple}",
    "errorForeground": "${red}",
    "extensionButton.prominentBackground": "${purple}",
    "extensionButton.prominentForeground": "${bg}",
    "extensionButton.prominentHoverBackground": "${accent_hover}",
    "focusBorder": "${purple}",
    "foreground": "${fg}",
    "gitDecoration.addedResourceForeground": "${green}",
    "gitDecoration.conflictingResourceForeground": "${pink}",
    "gitDecoration.deletedResourceForeground": "${red}",
    "gitDecoration.ignoredResourceForeground": "${comment}",
    "gitDecoration.modifiedResourceForeground": "${cyan}",
    "gitDecoration.submoduleResourceForeground": "${comment}",
    "gitDecoration.untrackedResourceForeground": "${yellow}",
    "icon.foreground": "${purple}",
    "input.background": "${bg_highlight}",
    "input.border": "${purple}",
    "input.foreground": "${fg}",
    "input.placeholderForeground": "${comment}",
    "inputOption.activeBackground": "${purple}44",
    "inputOption.activeBorder": "${purple}",
    "inputValidation.errorBackground": "${red}22",
    "inputValidation.errorBorder": "${red}",
    "inputValidation.infoBackground": "${cyan}22",
    "inputValidation.infoBorder": "${cyan}",
    "inputValidation.warningBackground": "${yellow}22",
    "inputValidation.warningBorder": "${yellow}",
    "list.activeSelectionBackground": "${purple}33",
    "list.activeSelectionForeground": "${fg}",
    "list.dropBackground": "${purple}22",
    "list.focusBackground": "${purple}33",
    "list.focusForeground": "${fg}",
    "list.highlightForeground": "${purple}",
    "list.hoverBackground": "${purple}22",
    "list.hoverForeground": "${fg}",
    "list.inactiveSelectionBackground": "${purple}22",
    "list.inactiveSelectionForeground": "${fg}",
    "list.invalidItemForeground": "${red}",
    "list.warningForeground": "${yellow}",
    "listFilterWidget.background": "${bg_float}",
    "listFilterWidget.noMatchesOutline": "${red}",
    "listFilterWidget.outline": "${purple}",
    "menu.background": "${bg_float}",
    "menu.border": "${purple}",
    "menu.foreground": "${fg}",
    "menu.selectionBackground": "${purple}33",
    "menu.selectionBorder": "${purple}",
    "menu.selectionForeground": "${fg}",
    "menu.separatorBackground": "${purple}",
    "menubar.selectionBackground": "${purple}33",
    "menubar.selectionForeground": "${fg}",
    "merge.currentContentBackground": "${purple}22",
    "merge.currentHeaderBackground": "${purple}44",
    "merge.incomingContentBackground": "${cyan}22",
    "merge.incomingHeaderBackground": "${cyan}44",
    "minimap.background": "${bg}",
    "minimap.errorHighlight": "${red}",
    "minimap.findMatchHighlight": "${purple}44",
    "minimap.selectionHighlight": "${purple}44",
    "minimap.warningHighlight": "${yellow}",
    "notificationCenter.border": "${purple}",
    "notificationCenterHeader.background": "${bg_float}",
    "notificationCenterHeader.foreground": "${fg}",
    "notificationLink.foreground": "${cyan}",
    "notifications.background": "${bg_float}",
    "notifications.border": "${purple}",
    "notifications.foreground": "${fg}",
    "notificationsErrorIcon.foreground": "${red}",
    "notificationsInfoIcon.foreground": "${cyan}",
    "notificationsWarningIcon.foreground": "${yellow}",
    "panel.background": "${bg}",
    "panel.border": "${purple}",
    "panel.dropBorder": "${purple}",
    "panelInput.border": "${purple}",
    "panelTitle.activeBorder": "${purple}",
    "panelTitle.activeForeground": "${fg}",
    "panelTitle.inactiveForeground": "${comment}",
    "peekView.border": "${purple}",
    "peekViewEditor.background": "${bg}",
    "peekViewEditor.matchHighlightBackground": "${purple}44",
    "peekViewResult.background": "${bg_float}",
    "peekViewResult.fileForeground": "${fg}",
    "peekViewResult.lineForeground": "${comment}",
    "peekViewResult.matchHighlightBackground": "${purple}44",
    "peekViewResult.selectionBackground": "${purple}33",
    "peekViewResult.selectionForeground": "${fg}",
    "peekViewTitle.background": "${bg_float}",
    "peekViewTitleDescription.foreground": "${comment}",
    "peekViewTitleLabel.foreground": "${fg}",
    "pickerGroup.border": "${purple}",
    "pickerGroup.foreground": "${purple}",
    "progressBar.background": "${purple}",
    "quickInput.background": "${bg_float}",
    "quickInput.foreground": "${fg}",
    "scrollbar.shadow": "${shadow}",
    "scrollbarSlider.activeBackground": "${purple}66",
    "scrollbarSlider.background": "${purple}33",
    "scrollbarSlider.hoverBackground": "${purple}66",
    "selection.background": "${purple}44",
    "settings.checkboxBackground": "${bg_float}",
    "settings.checkboxBorder": "${purple}",
    "settings.checkboxForeground": "${fg}",
    "settings.dropdownBackground": "${bg_float}",
    "settings.dropdownBorder": "${purple}",
    "settings.dropdownForeground": "${fg}",
    "settings.dropdownListBorder": "${purple}",
    "settings.headerForeground": "${purple}",
    "settings.modifiedItemIndicator": "${purple}",
    "settings.numberInputBackground": "${bg_highlight}",
    "settings.numberInputBorder": "${purple}",
    "settings.numberInputForeground": "${fg}",
    "settings.textInputBackground": "${bg_highlight}",
    "settings.textInputBorder": "${purple}",
    "settings.textInputForeground": "${fg}",
    "sideBar.background": "${bg_dark}",
    "sideBar.border": "${bg_float}",
    "sideBar.dropBackground": "${purple}22",
    "sideBar.foreground": "${fg}",
    "sideBarSectionHeader.background": "${bg}",
    "sideBarSectionHeader.border": "${bg_float}",
    "sideBarSectionHeader.foreground": "${purple}",
    "sideBarTitle.foreground": "${pink_soft}",
    "statusBar.background": "${bg_dark}",
    "statusBar.debuggingBackground": "${pink}",
    "statusBar.debuggingForeground": "${bg}",
    "statusBar.foreground": "${fg}",
    "statusBar.noFolderBackground": "${bg_dark}",
    "statusBar.noFolderForeground": "${fg}",
    "statusBarItem.activeBackground": "${purple}44",
    "statusBarItem.hoverBackground": "${purple}33",
    "statusBarItem.prominentBackground": "${purple}",
    "statusBarItem.prominentForeground": "${bg}",
    "statusBarItem.prominentHoverBackground": "${accent_hover}",
    "statusBarItem.remoteBackground": "${cyan}",
    "statusBarItem.remoteForeground": "${bg}",
    "tab.activeBackground": "${bg}",
    "tab.activeBorder": "${purple}",
    "tab.activeForeground": "${fg}",
    "tab.activeModifiedBorder": "${cyan}",
    "tab.border": "${bg_float}",
    "tab.hoverBackground": "${purple}22",
    "tab.hoverBorder": "${purple}66",
    "tab.inactiveBackground": "${bg_dark}",
    "tab.inactiveForeground": "${comment}",
    "tab.inactiveModifiedBorder": "${comment}",
    "tab.unfocusedActiveBackground": "${bg}",
    "tab.unfocusedActiveBorder": "${comment}",
    "tab.unfocusedActiveForeground": "${comment}",
    "tab.unfocusedActiveModifiedBorder": "${comment}",
    "tab.unfocusedHoverBackground": "${purple}11",
    "tab.unfocusedHoverBorder": "${comment}",
    "tab.unfocusedInactiveBackground": "${bg_dark}",
    "tab.unfocusedInactiveForeground": "${comment}",
    "tab.unfocusedInactiveModifiedBorder": "${comment}",
    "terminal.ansiBlack": "${terminal_black}",
    "terminal.ansiBlue": "${terminal_blue}",
    "terminal.ansiBrightBlack": "${terminal_bright_black}",
    "terminal.ansiBrightBlue": "${terminal_bright_blue}",
    "terminal.ansiBrightCyan": "${terminal_bright_cyan}",
    "terminal.ansiBrightGreen": "${terminal_bright_green}",
    "terminal.ansiBrightMagenta": "${terminal_bright_magenta}",
    "terminal.ansiBrightRed": "${terminal_bright_red}",
    "terminal.ansiBrightWhite": "${terminal_bright_white}",
    "terminal.ansiBrightYellow": "${terminal_bright_yellow}",
    "terminal.ansiCyan": "${terminal_cyan}",
    "terminal.ansiGreen": "${terminal_green}",
    "terminal.ansiMagenta": "${terminal_magenta}",
    "terminal.ansiRed": "${terminal_red}",
    "terminal.ansiWhite": "${terminal_white}",
    "terminal.ansiYellow": "${terminal_yellow}",
    "terminal.background": "${bg}",
    "terminal.border": "${purple}",
    "terminal.foreground": "${fg}",
    "terminal.selectionBackground": "${purple}44",
    "terminalCursor.background": "${bg}",
    "terminalCursor.foreground": "${pink}",
    "textBlockQuote.background": "${bg_float}",
    "textBlockQuote.border": "${purple}",
    "textCodeBlock.background": "${bg_float}",
    "textLink.activeForeground": "${cyan}",
    "textLink.foreground": "${cyan}",
    "textPreformat.foreground": "${yellow}",
    "textSeparator.foreground": "${purple}",
    "titleBar.activeBackground": "${bg_dark}",
    "titleBar.activeForeground": "${fg}",
    "titleBar.border": "${purple}",
    "titleBar.inactiveBackground": "${bg_dark}",
    "titleBar.inactiveForeground": "${comment}",
    "tree.indentGuidesStroke": "${purple}33",
    "tree.tableColumnsBorder": "${bg_float}",
    "tree.tableOddRowsBackground": "${bg_dark}",
    "walkThrough.embeddedEditorBackground": "${bg}",
    "welcomePage.background": "${bg}",
    "welcomePage.buttonBackground": "${purple}",
    "welcomePage.buttonHoverBackground": "${accent_hover}",
    "widget.shadow": "${shadow}"
  },
  "tokenColors": [
    {
      "name": "Comment",
      "scope": ["comment", "punctuation.definition.comment"],
      "settings": {
        "fontStyle": "italic",
        "foreground": "${comment}"
      }
    },
    {
      "name": "Variables",
      "scope": ["variable", "string constant.other.placeholder"],
      "settings": {
        "foreground": "${fg}"
      }
    },
    {
      "name": "Colors",
      "scope": ["constant.other.color"],
      "settings": {
        "foreground": "${fg}"
      }
    },
    {
      "name": "Invalid",
      "scope": ["invalid", "invalid.illegal"],
      "settings": {
        "foreground": "${red}"
      }
    },
    {
      "name": "Keyword, Storage",
      "scope": ["keyword", "storage.type", "storage.modifier"],
      "settings": {
        "foreground": "${keyword}"
      }
    },
    {
      "name": "Operator, Misc",
      "scope": ["keyword.control", "constant.other.color", "punctuation", "meta.tag", "punctuation.definition.tag", "punctuation.separator.inheritance.php", "punctuation.definition.tag.html", "punctuation.definition.tag.begin.html", "punctuation.definition.tag.end.html", "punctuation.section.embedded", "keyword.other.template", "keyword.other.substitution"],
      "settings": {
        "foreground": "${cyan}"
      }
    },
    {
      "name": "Tag",
      "scope": ["entity.name.tag", "meta.tag.sgml", "markup.deleted.git_gutter"],
      "settings": {
        "foreground": "${pink}"
      }
    },
    {
      "name": "Function, Special Method",
      "scope": ["entity.name.function", "meta.function-call", "variable.function", "support.function", "keyword.other.special-method"],
      "settings": {
        "foreground": "${cyan}"
      }
    },
    {
      "name": "Block Level Variables",
      "scope": ["meta.block variable.other"],
      "settings": {
        "foreground": "${fg}"
      }
    },
    {
      "name": "Other Variable, String Link",
      "scope": ["support.other.variable", "string.other.link"],
      "settings": {
        "foreground": "${pink}"
      }
    },
    {
      "name": "Number, Constant, Function Argument, Tag Attribute, Embedded",
      "scope": ["constant.numeric", "constant.language", "support.constant", "constant.character", "constant.escape", "variable.parameter", "keyword.other.unit", "keyword.other"],
      "settings": {
        "foreground": "${coral}"
      }
    },
    {
      "name": "String, Symbols, Inherited Class, Markup Heading",
      "scope": ["string", "constant.other.symbol", "constant.other.key", "entity.other.inherited-class", "markup.heading", "markup.inserted.git_gutter", "meta.group.braces.curly constant.other.object.key.js string.unquoted.label.js"],
      "settings": {
        "foreground": "${string}"
      }
    },
    {
      "name": "Class, Support",
      "scope": ["entity.name", "support.type", "support.class", "support.other.namespace.use.php", "meta.use.php", "support.other.namespace.php", "markup.changed.git_gutter", "support.type.sys-types"],
      "settings": {
        "foreground": "${yellow}"
      }
    },
    {
      "name": "Entity Types",
      "scope": ["support.type"],
      "settings": {
        "foreground": "${cyan_bright}"
      }
    },
    {
      "name": "CSS Class and Support",
      "scope": ["source.css support.type.property-name", "source.sass support.type.property-name", "source.scss support.type.property-name", "source.less support.type.property-name", "source.stylus support.type.property-name", "source.postcss support.type.property-name"],
      "settings": {
        "foreground": "${cyan}"
      }
    },
    {
      "name": "Sub-methods",
      "scope": ["entity.name.module.js", "variable.import.parameter.js", "variable.other.class.js"],
      "settings": {
        "foreground": "${red}"
      }
    },
    {
      "name": "Language methods",
      "scope": ["variable.language"],
      "settings": {
        "fontStyle": "italic",
        "foreground": "${red}"
      }
    },
    {
      "name": "entity.name.method.js",
      "scope": ["entity.name.method.js"],
      "settings": {
        "fontStyle": "italic",
        "foreground": "${cyan}"
      }
    },
    {
      "name": "meta.method.js",
      "scope": ["meta.class-method.js entity.name.function.js", "variable.function.constructor"],
      "settings": {
        "foreground": "${cyan}"
      }
    },
    {
      "name": "Attributes",
      "scope": ["entity.other.attribute-name"],
      "settings": {
        "foreground": "${purple}"
      }
    },
    {
      "name": "HTML Attributes",
      "scope": ["text.html.basic entity.other.attribute-name.html", "text.html.basic entity.other.attribute-name"],
      "settings": {
        "fontStyle": "italic",
        "foreground": "${yellow}"
      }
    },
    {
      "name": "CSS Classes",
      "scope": ["entity.other.attribute-name.class"],
      "settings": {
        "foreground": "${yellow}"
      }
    },
    {
      "name": "CSS ID's",
      "scope": ["source.sass keyword.control"],
      "settings": {
        "foreground": "${cyan}"
      }
    },
    {
      "name": "Inserted",
      "scope": ["markup.inserted"],
      "settings": {
        "foreground": "${green}"
      }
    },
    {
      "name": "Deleted",
      "scope": ["markup.deleted"],
      "settings": {
        "foreground": "${red}"
      }
    },
    {
      "name": "Changed",
      "scope": ["markup.changed"],
      "settings": {
        "foreground": "${purple}"
      }
    },
    {
      "name": "Regular Expressions",
      "scope": ["string.regexp"],
      "settings": {
        "foreground": "${cyan}"
      }
    },
    {
      "name": "Escape Characters",
      "scope": ["constant.character.escape"],
      "settings": {
        "foreground": "${cyan}"
      }
    },
    {
      "name": "URL",
      "scope": ["*url*", "*link*", "*uri*"],
      "settings": {
        "fontStyle": "underline"
      }
    },
    {
      "name": "Decorators",
      "scope": ["tag.decorator.js entity.name.tag.js", "tag.decorator.js punctuation.definition.tag.js"],
      "settings": {
        "fontStyle": "italic",
        "foreground": "${cyan}"
      }
    },
    {
      "name": "ES7 Bind Operator",
      "scope": ["source.js constant.other.object.key.js string.unquoted.label.js"],
      "settings": {
        "fontStyle": "italic",
        "foreground": "${red}"
      }
    },
    {
      "name": "JSON Key - Level 0",
      "scope": ["source.json meta.structure.dictionary.json support.type.property-name.json"],
      "settings": {
        "foreground": "${purple}"
      }
    },
    {
      "name": "JSON Key - Level 1",
      "scope": ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"],
      "settings": {
        "foreground": "${yellow}"
      }
    },
    {
      "name": "JSON Key - Level 2",
      "scope": ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"],
      "settings": {
        "foreground": "${coral}"
      }
    },
    {
      "name": "JSON Key - Level 3",
      "scope": ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"],
      "settings": {
        "foreground": "${red}"
      }
    },
    {
      "name": "JSON Key - Level 4",
      "scope": ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"],
      "settings": {
        "foreground": "${cyan}"
      }
    },
    {
      "name": "JSON Key - Level 5",
      "scope": ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"],
      "settings": {
        "foreground": "${pink}"
      }
    },
    {
      "name": "JSON Key - Level 6",
      "scope": ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"],
      "settings": {
        "foreground": "${yellow}"
      }
    },
    {
      "name": "JSON Key - Level 7",
      "scope": ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"],
      "settings": {
        "foreground": "${purple}"
      }
    },
    {
      "name": "JSON Key - Level 8",
      "scope": ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"],
      "settings": {
        "foreground": "${green}"
      }
    },
    {
      "name": "Markdown - Plain",
      "scope": ["text.html.markdown", "punctuation.definition.list_item.markdown"],
      "settings": {
        "foreground": "${fg}"
      }
    },
    {
      "name": "Markdown - Markup Raw Inline",
      "scope": ["text.html.markdown markup.inline.raw.markdown"],
      "settings": {
        "foreground": "${purple}"
      }
    },
    {
      "name": "Markdown - Markup Raw Inline Punctuation",
      "scope": ["text.html.markdown markup.inline.raw.markdown punctuation.definition.raw.markdown"],
      "settings": {
        "foreground": "${comment}"
      }
    },
    {
      "name": "Markdown - Heading",
      "scope": ["markdown.heading", "markup.heading | markup.heading entity.name", "markup.heading.markdown punctuation.definition.heading.markdown"],
      "settings": {
        "foreground": "${green}"
      }
    },
    {
      "name": "Markup - Italic",
      "scope": ["markup.italic"],
      "settings": {
        "fontStyle": "italic",
        "foreground": "${pink}"
      }
    },
    {
      "name": "Markup - Bold",
      "scope": ["markup.bold", "markup.bold string"],
      "settings": {
        "fontStyle": "bold",
        "foreground": "${pink}"
      }
    },
    {
      "name": "Markup - Bold-Italic",
      "scope": ["markup.bold markup.italic", "markup.italic markup.bold", "markup.quote markup.bold", "markup.bold markup.italic string", "markup.italic markup.bold string", "markup.quote markup.bold string"],
      "settings": {
        "fontStyle": "bold",
        "foreground": "${pink}"
      }
    },
    {
      "name": "Markup - Underline",
      "scope": ["markup.underline"],
      "settings": {
        "fontStyle": "underline",
        "foreground": "${coral}"
      }
    },
    {
      "name": "Markdown - Blockquote",
      "scope": ["markup.quote punctuation.definition.blockquote.markdown"],
      "settings": {
        "foreground": "${comment}"
      }
    },
    {
      "name": "Markup - Quote",
      "scope": ["markup.quote"],
      "settings": {
        "fontStyle": "italic"
      }
    },
    {
      "name": "Markdown - Link",
      "scope": ["string.other.link.title.markdown"],
      "settings": {
        "foreground": "${cyan}"
      }
    },
    {
      "name": "Markdown - Link Description",
      "scope": ["string.other.link.description.title.markdown"],
      "settings": {
        "foreground": "${purple}"
      }
    },
    {
      "name": "Markdown - Link Anchor",
      "scope": ["constant.other.reference.link.markdown"],
      "settings": {
        "foreground": "${yellow}"
      }
    },
    {
      "name": "Markup - Raw Block",
      "scope": ["markup.raw.block"],
      "settings": {
        "foreground": "${purple}"
      }
    },
    {
      "name": "Markdown - Raw Block Fenced",
      "scope": ["markup.raw.block.fenced.markdown"],
      "settings": {
        "foreground": "${fg}"
      }
    },
    {
      "name": "Markdown - Fenced Bode Block",
      "scope": ["punctuation.definition.fenced.markdown"],
      "settings": {
        "foreground": "${fg}"
      }
    },
    {
      "name": "Markdown - Fenced Bode Block Variable",
      "scope": ["markup.raw.block.fenced.markdown", "variable.language.fenced.markdown", "punctuation.section.class.end"],
      "settings": {
        "foreground": "${fg}"
      }
    },
    {
      "name": "Markdown - Fenced Language",
      "scope": ["variable.language.fenced.markdown"],
      "settings": {
        "foreground": "${comment}"
      }
    },
    {
      "name": "Markdown - Separator",
      "scope": ["meta.separator"],
      "settings": {
        "fontStyle": "bold",
        "foreground": "${comment}"
      }
    },
    {
      "name": "Markup - Table",
      "scope": ["markup.table"],
      "settings": {
        "foreground": "${fg}"
      }
    }
  ]
}
]==]

function M.generate(colors)
  local extra = require("silkcircuit.extra")
  local derived = vim.tbl_extend("force", colors, DERIVED[colors.meta.appearance](colors))
  return extra.template(TEMPLATE, derived)
end

return M
