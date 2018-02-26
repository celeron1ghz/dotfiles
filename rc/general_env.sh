export GOPATH=$HOME
export LANG=ja_JP.UTF-8
export EDITOR=/usr/bin/vi
export PAGER=/usr/bin/less
export TERM="xterm-256color"

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

DIRENV_EXECUTABLE=`which direnv`

if [ -e ~/perl5/perlbrew/etc/bashrc ]; then
  echo "perlbrew config loading..."
  source ~/perl5/perlbrew/etc/bashrc
fi

if [ ${DIRENV_EXECUTABLE} != "" ]; then
  echo "direnv init..."
  eval $(direnv hook bash)
fi