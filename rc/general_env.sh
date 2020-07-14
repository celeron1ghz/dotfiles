##
## shell
##
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

if [ `which direnv` != "" ]; then
  echo "direnv init..."
  eval "$(direnv hook zsh)"
  direnv allow
fi

##
## perl
##
if [ -e ~/perl5/perlbrew/etc/bashrc ]; then
  echo "perlbrew config loading..."
  source ~/perl5/perlbrew/etc/bashrc
fi

##
## golang
##
export PATH="$PATH:$HOME/go/bin"

##
## python
##
if [ `which pipenv` != "" ]; then
  cd $HOME/dotfiles/py
  POWERLINE_BIN=`pipenv --venv`

  if [ "$POWERLINE_BIN" != "" ];
    then
      export PATH="$PATH:$POWERLINE_BIN/bin"
      BINDING="$POWERLINE_BIN/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh"
      source $BINDING
    else
      pipenv install powerline-status
  fi
fi
