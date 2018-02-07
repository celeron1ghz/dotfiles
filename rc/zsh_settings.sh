autoload -U colors;   colors
autoload -U compinit; compinit -u

setopt auto_cd
setopt correct
setopt list_packed
setopt prompt_subst
setopt share_history 

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

source ~/dotfiles/zsh_command/peco_ghq_src.zsh
source ~/dotfiles/zsh_command/peco_select_history.zsh