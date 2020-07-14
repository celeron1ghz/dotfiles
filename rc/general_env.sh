HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

if [ -e ~/perl5/perlbrew/etc/bashrc ]; then
  echo "perlbrew config loading..."
  source ~/perl5/perlbrew/etc/bashrc
fi

if [ `which direnv` != "" ]; then
  echo "direnv init..."
  eval "$(direnv hook zsh)"
  direnv allow
fi