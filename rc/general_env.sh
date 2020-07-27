##
## shell
##
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

if [ "`command -v direnv`" != "" ]; then
  echo "direnv init..."
  eval "$(direnv hook zsh)"
  direnv allow
fi

##
## golang
##
export PATH="$PATH:$HOME/go/bin"
