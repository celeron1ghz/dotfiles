function peco_select_history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER" --prompt "HISTORY>")
    CURSOR=$#BUFFER             # move cursor
    zle -R -c                   # refresh
}

zle -N peco_select_history
bindkey '^R' peco_select_history
