local M = {}

function M.get(colors, _)
  return {
    -- Main color highlights
    OctoGreen = { fg = colors.green },
    OctoRed = { fg = colors.red },
    OctoPurple = { fg = colors.purple },
    OctoYellow = { fg = colors.yellow },
    OctoBlue = { fg = colors.cyan },
    OctoGrey = { fg = colors.gray },

    -- Float variants (with background)
    OctoGreenFloat = { fg = colors.green, bg = colors.bg_dark },
    OctoRedFloat = { fg = colors.red, bg = colors.bg_dark },
    OctoPurpleFloat = { fg = colors.purple, bg = colors.bg_dark },
    OctoYellowFloat = { fg = colors.yellow, bg = colors.bg_dark },
    OctoBlueFloat = { fg = colors.cyan, bg = colors.bg_dark },
    OctoGreyFloat = { fg = colors.gray, bg = colors.bg_dark },

    -- Bubble highlights (inverted colors)
    OctoBubbleGreen = { fg = colors.bg, bg = colors.green },
    OctoBubbleRed = { fg = colors.bg, bg = colors.red },
    OctoBubblePurple = { fg = colors.fg, bg = colors.purple },
    OctoBubbleYellow = { fg = colors.bg, bg = colors.yellow },
    OctoBubbleBlue = { fg = colors.bg, bg = colors.cyan },
    OctoBubbleGrey = { fg = colors.bg, bg = colors.gray },

    -- Bubble delimiter highlights
    OctoBubbleDelimiterGreen = { fg = colors.green },
    OctoBubbleDelimiterRed = { fg = colors.red },
    OctoBubbleDelimiterPurple = { fg = colors.purple },
    OctoBubbleDelimiterYellow = { fg = colors.yellow },
    OctoBubbleDelimiterBlue = { fg = colors.cyan },
    OctoBubbleDelimiterGrey = { fg = colors.gray },

    -- UI elements
    OctoFilePanelTitle = { fg = colors.cyan, bold = true },
    OctoFilePanelCounter = { fg = colors.purple, bold = true },
    OctoNormalFloat = { fg = colors.fg, bg = colors.bg_dark },
    OctoViewer = { fg = colors.bg, bg = colors.cyan },
    OctoEditable = { bg = colors.selection },
    OctoStrikethrough = { fg = colors.gray, strikethrough = true },
    OctoUnderline = { fg = colors.fg, underline = true },

    -- Status highlights
    OctoStatusAdded = { fg = colors.green },
    OctoStatusModified = { fg = colors.cyan },
    OctoStatusDeleted = { fg = colors.red },
    OctoDirty = { fg = colors.red },

    -- Issue/PR states
    OctoStateOpen = { fg = colors.green },
    OctoStateClosed = { fg = colors.red },
    OctoStateMerged = { fg = colors.purple },
    OctoStateDraft = { fg = colors.gray },
    OctoStatePending = { fg = colors.yellow },
    OctoStateApproved = { fg = colors.green },
    OctoStateChangesRequested = { fg = colors.red },
    OctoStateDismissed = { fg = colors.red },
    OctoStateCommented = { fg = colors.cyan },
    OctoStateSubmitted = { fg = colors.green },

    -- State bubbles
    OctoStateOpenBubble = { fg = colors.bg, bg = colors.green },
    OctoStateClosedBubble = { fg = colors.bg, bg = colors.red },
    OctoStateMergedBubble = { fg = colors.fg, bg = colors.purple },
    OctoStatePendingBubble = { fg = colors.bg, bg = colors.yellow },
    OctoStateApprovedBubble = { fg = colors.bg, bg = colors.green },
    OctoStateChangesRequestedBubble = { fg = colors.bg, bg = colors.red },
    OctoStateDismissedBubble = { fg = colors.bg, bg = colors.red },
    OctoStateCommentedBubble = { fg = colors.bg, bg = colors.cyan },
    OctoStateSubmittedBubble = { fg = colors.bg, bg = colors.green },

    -- State floats
    OctoStateOpenFloat = { fg = colors.green, bg = colors.bg_dark },
    OctoStateClosedFloat = { fg = colors.red, bg = colors.bg_dark },
    OctoStateMergedFloat = { fg = colors.purple, bg = colors.bg_dark },
    OctoStateDraftFloat = { fg = colors.gray, bg = colors.bg_dark },

    -- Timeline and UI elements
    OctoTimelineItemHeading = { fg = colors.gray },
    OctoTimelineMarker = { fg = colors.purple },
    OctoSymbol = { fg = colors.gray },
    OctoDate = { fg = colors.gray },
    OctoDetailsLabel = { fg = colors.yellow, bold = true },
    OctoDetailsValue = { fg = colors.purple },
    OctoMissingDetails = { fg = colors.gray },
    OctoEmpty = { fg = colors.fg },
    OctoBubble = { fg = colors.fg },
    OctoUser = { fg = colors.fg },
    OctoUserViewer = { fg = colors.bg, bg = colors.cyan },
    OctoReaction = { fg = colors.fg },
    OctoReactionViewer = { fg = colors.bg, bg = colors.cyan },

    -- Test status
    OctoPassingTest = { fg = colors.green },
    OctoFailingTest = { fg = colors.red },

    -- Diff statistics
    OctoPullAdditions = { fg = colors.green },
    OctoPullDeletions = { fg = colors.red },
    OctoDiffstatAdditions = { fg = colors.green },
    OctoDiffstatDeletions = { fg = colors.red },
    OctoDiffstatNeutral = { fg = colors.gray },

    -- Issue elements
    OctoIssueId = { fg = colors.fg },
    OctoIssueTitle = { fg = colors.cyan, bold = true },
    OctoFloat = { fg = colors.fg, bg = colors.bg_dark },

    -- File panel
    OctoFilePanelFileName = { fg = colors.fg },
    OctoFilePanelSelectedFile = { fg = colors.yellow, bold = true },
    OctoFilePanelPath = { fg = colors.gray },

    -- State completed/not planned
    OctoStateCompleted = { fg = colors.purple },
    OctoStateNotPlanned = { fg = colors.gray },
  }
end

return M
