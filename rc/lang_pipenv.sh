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
