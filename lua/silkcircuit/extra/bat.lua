local M = {}

-- A TextMate plist, which bat compiles into its theme cache and delta reads
-- through bat. The provenance banner is an XML comment, so the document opens
-- with the DOCTYPE and no <?xml?> declaration: a declaration is only legal as
-- the very first thing in a file, and the banner is already there.
--
-- bat matches `--theme` against the file stem, not the name inside the plist,
-- so these are silkcircuit-neon through silkcircuit-dawn. The plist name is
-- there for TextMate and Sublime, which do read it.
local UUIDS = {
  neon = "b1a7c0de-5c17-4e0a-9f31-7e2c4d8a1f01",
  vibrant = "b1a7c0de-5c17-4e0a-9f31-7e2c4d8a1f02",
  soft = "b1a7c0de-5c17-4e0a-9f31-7e2c4d8a1f03",
  glow = "b1a7c0de-5c17-4e0a-9f31-7e2c4d8a1f04",
  dawn = "b1a7c0de-5c17-4e0a-9f31-7e2c4d8a1f05",
}

local TEMPLATE = [[
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>name</key>
	<string>${meta.name}</string>
	<key>settings</key>
	<array>
		<dict>
			<key>settings</key>
			<dict>
				<key>background</key>
				<string>${bg}</string>
				<key>caret</key>
				<string>${cyan}</string>
				<key>foreground</key>
				<string>${fg}</string>
				<key>invisibles</key>
				<string>${gray_muted}</string>
				<key>lineHighlight</key>
				<string>${bg_highlight}</string>
				<key>selection</key>
				<string>${bg_visual}</string>
				<key>findHighlight</key>
				<string>${yellow}</string>
				<key>findHighlightForeground</key>
				<string>${bg}</string>
				<key>selectionBorder</key>
				<string>${border}</string>
				<key>activeGuide</key>
				<string>${purple_muted}</string>
				<key>misspelling</key>
				<string>${red}</string>
				<key>bracketsForeground</key>
				<string>${cyan}</string>
				<key>bracketsOptions</key>
				<string>underline</string>
				<key>bracketContentsForeground</key>
				<string>${pink}</string>
				<key>bracketContentsOptions</key>
				<string>underline</string>
				<key>tagsOptions</key>
				<string>stippled_underline</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Comment</string>
			<key>scope</key>
			<string>comment</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${comment}</string>
				<key>fontStyle</key>
				<string>italic</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>String</string>
			<key>scope</key>
			<string>string</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${string}</string>
				<key>fontStyle</key>
				<string>italic</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Number</string>
			<key>scope</key>
			<string>constant.numeric</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${coral}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Built-in constant</string>
			<key>scope</key>
			<string>constant.language</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${coral}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>User-defined constant</string>
			<key>scope</key>
			<string>constant.character, constant.other</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${coral}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Variable</string>
			<key>scope</key>
			<string>variable</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${fg}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Keyword</string>
			<key>scope</key>
			<string>keyword - (source.c keyword.operator | source.c++ keyword.operator | source.objc keyword.operator | source.objc++ keyword.operator), keyword.operator.word</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${keyword}</string>
				<key>fontStyle</key>
				<string>bold</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Storage</string>
			<key>scope</key>
			<string>storage</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${keyword}</string>
				<key>fontStyle</key>
				<string>bold</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Storage type</string>
			<key>scope</key>
			<string>storage.type</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${yellow}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Class name</string>
			<key>scope</key>
			<string>entity.name.type, entity.name.class, entity.name.namespace, entity.name.scope-resolution</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${yellow}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Inherited class</string>
			<key>scope</key>
			<string>entity.other.inherited-class</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${green}</string>
				<key>fontStyle</key>
				<string>italic</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Function name</string>
			<key>scope</key>
			<string>entity.name.function</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${cyan}</string>
				<key>fontStyle</key>
				<string>bold italic</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Function argument</string>
			<key>scope</key>
			<string>variable.parameter</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${fg}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Tag name</string>
			<key>scope</key>
			<string>entity.name.tag</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${pink}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Tag attribute</string>
			<key>scope</key>
			<string>entity.other.attribute-name</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${purple}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Library function</string>
			<key>scope</key>
			<string>support.function</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${cyan}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Library constant</string>
			<key>scope</key>
			<string>support.constant</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${coral}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Library class/type</string>
			<key>scope</key>
			<string>support.type, support.class</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${yellow}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Library variable</string>
			<key>scope</key>
			<string>support.other.variable</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${fg}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Invalid</string>
			<key>scope</key>
			<string>invalid</string>
			<key>settings</key>
			<dict>
				<key>background</key>
				<string>${red}</string>
				<key>foreground</key>
				<string>${bg}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Invalid deprecated</string>
			<key>scope</key>
			<string>invalid.deprecated</string>
			<key>settings</key>
			<dict>
				<key>background</key>
				<string>${orange}</string>
				<key>foreground</key>
				<string>${bg}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>JSON String</string>
			<key>scope</key>
			<string>meta.structure.dictionary.json string.quoted.double.json</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${string}</string>
				<key>fontStyle</key>
				<string>italic</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>JSON Property Name</string>
			<key>scope</key>
			<string>support.type.property-name.json</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${cyan_bright}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>YAML Key</string>
			<key>scope</key>
			<string>entity.name.tag.yaml</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${cyan_bright}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Diff header</string>
			<key>scope</key>
			<string>meta.diff, meta.diff.header</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${comment}</string>
				<key>fontStyle</key>
				<string>italic</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Diff deleted</string>
			<key>scope</key>
			<string>markup.deleted</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${git_delete}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Diff inserted</string>
			<key>scope</key>
			<string>markup.inserted</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${git_add}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Diff changed</string>
			<key>scope</key>
			<string>markup.changed</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${yellow}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Markup Bold</string>
			<key>scope</key>
			<string>markup.bold</string>
			<key>settings</key>
			<dict>
				<key>fontStyle</key>
				<string>bold</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Markup Italic</string>
			<key>scope</key>
			<string>markup.italic</string>
			<key>settings</key>
			<dict>
				<key>fontStyle</key>
				<string>italic</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Markup Heading</string>
			<key>scope</key>
			<string>markup.heading</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${purple}</string>
				<key>fontStyle</key>
				<string>bold</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Markup Link</string>
			<key>scope</key>
			<string>markup.underline.link</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${cyan}</string>
				<key>fontStyle</key>
				<string>underline</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Markup Code</string>
			<key>scope</key>
			<string>markup.raw, markup.inline.raw</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${pink}</string>
				<key>background</key>
				<string>${bg_highlight}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Markup Quote</string>
			<key>scope</key>
			<string>markup.quote</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${comment}</string>
				<key>fontStyle</key>
				<string>italic</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Operator</string>
			<key>scope</key>
			<string>keyword.operator</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${operator}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Punctuation</string>
			<key>scope</key>
			<string>punctuation</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${fg}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Punctuation Definition String</string>
			<key>scope</key>
			<string>punctuation.definition.string</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${string}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Punctuation Definition Comment</string>
			<key>scope</key>
			<string>punctuation.definition.comment</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${comment}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Shell Variable</string>
			<key>scope</key>
			<string>variable.other.bracket.shell, variable.other.normal.shell</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${cyan_bright}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Regular Expression</string>
			<key>scope</key>
			<string>string.regexp</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${cyan_bright}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Escape Characters</string>
			<key>scope</key>
			<string>constant.character.escape</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${coral}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Embedded</string>
			<key>scope</key>
			<string>punctuation.section.embedded, variable.interpolation</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${pink}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Illegal</string>
			<key>scope</key>
			<string>invalid.illegal</string>
			<key>settings</key>
			<dict>
				<key>background</key>
				<string>${red_dark}</string>
				<key>foreground</key>
				<string>${bg}</string>
			</dict>
		</dict>
	</array>
	<key>uuid</key>
	<string>@UUID@</string>
	<key>colorSpaceName</key>
	<string>sRGB</string>
	<key>semanticClass</key>
	<string>theme.${meta.appearance}.${meta.slug}</string>
	<key>author</key>
	<string>${meta.author}</string>
</dict>
</plist>
]]

function M.generate(colors)
  local uuid = assert(UUIDS[colors.meta.variant], "silkcircuit.extra.bat: no uuid for variant")
  return require("silkcircuit.extra").template((TEMPLATE:gsub("@UUID@", uuid)), colors)
end

return M
