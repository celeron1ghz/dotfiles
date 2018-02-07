## init
bindkey -e emacs

eval "$(direnv hook zsh)"
direnv allow

## old shell setting
#PROMPT="
#%{$fg[green]%}%/%{$reset_color%} on %{$fg[cyan]%}%M%{$reset_color%}
#%{$fg[yellow]%}%n%{$reset_color%} %# "
#PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export PATH=$PATH:$GOPATH/bin:~/Library/Python/3.6/bin

source ~/dotfiles/rc/general_env.sh
source ~/dotfiles/rc/commands.sh
source ~/dotfiles/rc/aliases.sh
source ~/dotfiles/rc/zsh_settings.sh