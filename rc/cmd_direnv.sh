if [ "`command -v direnv`" != "" ]; then
  echo "direnv init..."
  eval "$(direnv hook zsh)"
  direnv allow
fi
