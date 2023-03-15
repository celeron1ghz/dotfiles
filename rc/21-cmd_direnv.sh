if [ "`command -v "$HOME/dotfiles/bin/direnv"`" = "" ]; then
  echo "installing direnv...";
  export bin_path="$HOME/dotfiles/bin"
  curl -sfL https://direnv.net/install.sh | bash
  echo "reboot shell and enable direnv."
else
  echo "direnv init..."
  eval "$(direnv hook zsh)"
  direnv allow
fi
