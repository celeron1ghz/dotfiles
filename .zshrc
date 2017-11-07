## variables
autoload -U colors;   colors
autoload -U compinit; compinit -u

PROMPT="
%{$fg[green]%}%/%{$reset_color%} on %{$fg[cyan]%}%M%{$reset_color%}
%{$fg[yellow]%}%n%{$reset_color%} %# "

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export PATH=$PATH:$HOME/dotfiles/bin:$GOPATH/bin
export GOPATH=$HOME

export LANG=ja_JP.UTF-8
export EDITOR=/usr/bin/vi
export PAGER=/usr/bin/less


## zsh options, parameters
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

alias q='exit'
alias cls='clear'
alias gd='git diff'
alias gs='git status'
alias gl='git log'

case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G"
    alias ll="ls -lG"
    alias la="ls -laG"
    ;;
  linux*)
    alias ls='ls --color'
    alias ll='ls -l --color'
    alias la='ls -la --color'
    ;;
esac

bindkey -e emacs


## source files
source ~/perl5/perlbrew/etc/bashrc
source ~/dotfiles/zsh_command/open_pm_with_vim.zsh
source ~/dotfiles/zsh_command/peco_select_history.zsh
source /usr/local/share/zsh/site-functions/_aws


## others
eval "$(direnv hook zsh)"
direnv allow


# Ctrl + ] => ghq
function peco-src () {
  local selected_dir=$(ghq list -p | peco --prompt "REPOSITORY >" --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '' peco-src


if [ "$TERM" = "screen" ]; then
  chpwd() { echo -n "_`dirs`\\" }
  preexec() {
    # see [zsh-workers:13180]
    # http://www.zsh.org/mla/workers/2000/msg03993.html
    emulate -L zsh
    local -a cmd; cmd=(${(z)2})
    case $cmd[1] in
      fg)
        if (( $#cmd == 1 )); then
          cmd=(builtin jobs -l %+)
        else
          cmd=(builtin jobs -l $cmd[2])
        fi
        ;;
      %*) 
        cmd=(builtin jobs -l $cmd[1])
        ;;
      cd)
        if (( $#cmd == 2)); then
          cmd[1]=$cmd[2]
        fi
        ;&
      ls)
        echo -n "k$cmd[1]:t\\"
        return
        ;;
      *)
        echo -n "k$cmd[1] $cmd[2]:t\\"
        return
        ;;
    esac
    
    local -A jt; jt=(${(kv)jobtexts})
    
    $cmd >>(read num rest
    cmd=(${(z)${(e):-\$jt$num}})
    echo -n "k$cmd[1]:t\\") 2>/dev/null
  }

  chpwd
fi
