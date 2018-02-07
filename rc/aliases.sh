alias q='exit'
alias cls='clear'
alias gd='git diff'
alias gs='git status'
alias gl='git log'
alias vim='mvim -v'

case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G"
    alias ll="ls -lG"
    alias la="ls -laG"
    ;;
  linux*)
    alias ls='ls --color'
    alias ll='ls -l --color'
    alias la='ls -la --color'
    ;;
esac