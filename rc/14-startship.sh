##
## starship
##
if [ "`command -v starship`" = "" ]; then
  echo "installing starship..."
  curl -sS https://starship.rs/install.sh | sh
fi

eval "$(starship init zsh)"
