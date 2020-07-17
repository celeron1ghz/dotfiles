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
PLENV_DIR=$HOME/.plenv
export PATH="$PATH:$PLENV_DIR/bin"

if [ "`command -v plenv`" = "" ]; then
  git clone https://github.com/tokuhirom/plenv.git $PLENV_DIR
  git clone https://github.com/tokuhirom/Perl-Build.git $PLENV_DIR/plugins/perl-build/
fi

eval "$(plenv init -)"

##
## golang
##
export PATH="$PATH:$HOME/go/bin"

##
## python
##
if [ "`command -v pipenv`" != "" ]; then
  CACHE=path

  cd $HOME/dotfiles/py

  if [ -e $CACHE ];
    then
      ## read cache value
      POWERLINE_ROOT=`cat $CACHE`
    else
      ## create cache
      POWERLINE_ROOT=`pipenv --venv`
      echo $POWERLINE_ROOT > $CACHE
  fi

  ## read powerline config
  if [ "$POWERLINE_ROOT" = "" ]; then
    pipenv install powerline-status
    POWERLINE_ROOT=`pipenv --venv`
    echo $POWERLINE_ROOT > $CACHE
  fi

  export PATH="$PATH:$POWERLINE_ROOT/bin"
  BINDING="$POWERLINE_ROOT/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh"
  source $BINDING

  cd $HOME
fi
