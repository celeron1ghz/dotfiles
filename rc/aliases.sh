alias q='exit'
alias gd='git diff'
alias gs='git status'
alias gl='git log'

case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G"
    alias ll="ls -lG"
    alias la="ls -laG"
    alias vim='mvim -v'
    ;;
  linux*)
    alias ls='ls --color'
    alias ll='ls -l --color'
    alias la='ls -la --color'
    ;;
esac