function peco_ghq_src () {
  local selected_dir=$(ghq list -p | peco --prompt "REPOSITORY >" --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco_ghq_src
bindkey '' peco_ghq_src
