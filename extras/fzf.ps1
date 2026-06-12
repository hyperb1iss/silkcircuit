# SilkCircuit theme for fzf in PowerShell

$env:FZF_DEFAULT_OPTS = @(
    "--color=bg+:#3b2d4f,bg:#1e1a2e,spinner:#ff69ff,hl:#e135ff"
    "--color=fg:#f8f8f2,header:#e135ff,info:#e135ff,pointer:#ff69ff"
    "--color=marker:#80ffea,fg+:#ffffff,prompt:#e135ff,hl+:#ff00ff"
    "--color=selected-bg:#44475a"
    "--color=border:#80ffea,label:#f8f8f2"
) -join " "
