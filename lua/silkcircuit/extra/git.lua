local M = {}

-- Every colour value is quoted. '#' opens a comment in a git config file, so an
-- unquoted "#e135ff bold" parses as an empty value and the slot silently falls
-- back to the git default.
--
-- The delta block leaves the plus and minus line backgrounds on delta's own
-- `auto`, which is the one place the palette cannot supply a value: diff_add and
-- diff_delete are foreground greens and reds on four variants and near-black
-- backgrounds on glow, so neither reading survives all five. The add and remove
-- signal comes from the palette's git_add and git_delete in the line numbers
-- instead, where it is legible everywhere.
local TEMPLATE = [[
[color]
	ui = auto

[color "branch"]
	current = "${purple} bold"
	local = "${cyan}"
	remote = "${pink_bright}"
	upstream = "${blue}"
	plain = "${fg}"

[color "decorate"]
	branch = "${purple} bold"
	remoteBranch = "${pink_bright}"
	tag = "${yellow} bold"
	stash = "${cyan}"
	HEAD = "${pink} bold"
	grafted = "${red}"

[color "diff"]
	meta = "${purple} bold"
	frag = "${pink_bright} bold"
	func = "${cyan}"
	context = "${fg_dark}"
	old = "${git_delete}"
	new = "${git_add}"
	commit = "${yellow}"
	whitespace = "${red} reverse"

[color "status"]
	header = "${fg_dark}"
	added = "${git_add} bold"
	changed = "${git_change} bold"
	untracked = "${cyan} bold"
	deleted = "${git_delete} bold"
	branch = "${yellow} bold"
	nobranch = "${red} bold"
	unmerged = "${red} bold"
	localBranch = "${purple}"
	remoteBranch = "${pink_bright}"

[color "interactive"]
	prompt = "${purple} bold"
	header = "${pink_bright}"
	help = "${cyan}"
	error = "${red}"

[color "grep"]
	context = "${fg_dark}"
	filename = "${purple} bold"
	function = "${cyan}"
	linenumber = "${pink_bright}"
	column = "${purple_muted}"
	match = "${yellow} bold"
	selected = "${fg_dark}"
	separator = "${cyan}"

[pretty]
	silkcircuit = "%C(${purple} bold)commit %H%Creset%C(${yellow})%d%Creset%n%C(${fg})Author: %C(${pink_bright})%an <%ae>%Creset%n%C(${fg})Date:   %C(${cyan})%ad%Creset%n%n%C(${fg})    %s%Creset%n%n%w(0,4,4)%C(${fg})%b%Creset"

[delta "${meta.slug}"]
	${meta.appearance} = true
	navigate = true
	line-numbers = true
	side-by-side = false
	syntax-theme = "${meta.name}"
	file-style = "${yellow} bold"
	file-decoration-style = "${yellow} ul"
	hunk-header-style = "file line-number syntax"
	hunk-header-decoration-style = "${cyan} box"
	hunk-header-file-style = "${cyan} bold"
	hunk-header-line-number-style = "${pink_bright}"
	commit-style = "${purple} bold"
	commit-decoration-style = "${purple} box ul"
	line-numbers-left-style = "${purple_muted}"
	line-numbers-right-style = "${purple_muted}"
	line-numbers-zero-style = "${fg_gutter}"
	line-numbers-minus-style = "${git_delete} bold"
	line-numbers-plus-style = "${git_add} bold"
	minus-style = "syntax auto"
	minus-emph-style = "syntax auto bold"
	plus-style = "syntax auto"
	plus-emph-style = "syntax auto bold"
	zero-style = "syntax"
	whitespace-error-style = "${red} reverse"
	blame-palette = "${bg} ${bg_highlight} ${selection_highlight} ${bg_visual}"

# The delta feature above only takes effect once you ask for it. Uncomment
# whichever of these you want, in this file or in your own config:
#
# [core]
# 	pager = delta
# [interactive]
# 	diffFilter = delta --color-only
# [delta]
# 	features = ${meta.slug}
#
# The log format is named rather than default, so reach for it with
# `git log --pretty=silkcircuit`, or make it the default with:
#
# [format]
# 	pretty = silkcircuit
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
