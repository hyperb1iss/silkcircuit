-- k9s skins are one YAML document per variant. The generated file has to stay
-- prettier-clean, since the repo formats every yaml under extras/, so the
-- indentation and quoting here match what prettier would produce.

local M = {}

local TEMPLATE = [[
# Place this file at $XDG_CONFIG_HOME/k9s/skins/${meta.slug}.yaml, then set
# `k9s.ui.skin: ${meta.slug}` in config.yaml or export K9S_SKIN=${meta.slug}.

k9s:
  # General K9s styles
  body:
    fgColor: "${fg}"
    bgColor: "${bg}"
    logoColor: "${cyan}"

  # ClusterInfoView styles
  info:
    fgColor: "${cyan}"
    sectionColor: "${purple}"

  # Frame styles
  frame:
    # Borders styles
    border:
      fgColor: "${cyan}"
      focusColor: "${pink}"

    # MenuView attributes and styles
    menu:
      fgColor: "${fg}"
      keyColor: "${pink}"
      # Used for favorite namespaces
      numKeyColor: "${coral}"

    # CrumbView attributes for history navigation
    crumbs:
      fgColor: "${bg}"
      bgColor: "${purple}"
      activeColor: "${cyan}"

    # Resource status and update styles
    status:
      newColor: "${hint}"
      modifyColor: "${yellow}"
      addColor: "${hint}"
      errorColor: "${red}"
      highlightcolor: "${pink}"
      killColor: "${blue_gray}"
      completedColor: "${gray}"

    # Border title styles
    title:
      fgColor: "${fg}"
      bgColor: "${bg}"
      highlightColor: "${cyan}"
      counterColor: "${coral}"
      filterColor: "${yellow}"

  # Specific views styles
  views:
    # TableView attributes
    table:
      fgColor: "${fg}"
      bgColor: "${bg}"
      cursorColor: "${bg_highlight}"
      # Header row styles
      header:
        fgColor: "${cyan}"
        bgColor: "${bg_highlight}"
        sorterColor: "${yellow}"

    # YAML info styles
    yaml:
      keyColor: "${purple}"
      colonColor: "${gray}"
      valueColor: "${cyan}"

    # Logs styles
    logs:
      fgColor: "${fg}"
      bgColor: "${bg_dark}"

    # Charts styles
    charts:
      bgColor: default
      defaultDialColors:
        - "${pink}"
        - "${cyan}"
      defaultChartColors:
        - "${pink}"
        - "${cyan}"
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
