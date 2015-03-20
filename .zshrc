autoload -U colors;   colors
autoload -U compinit; compinit -u

bindkey -e emacs

DEF="$reset_color"
PROMPT="
%{$fg[green]%}%/%{$DEF%} on %{$fg[cyan]%}%M%{$DEF%}
%{$fg[yellow]%}%n%{$DEF%} %# "
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

source ~/perl5/perlbrew/etc/bashrc
source ~/dotfiles/zsh_command/*.zsh

export PATH=$PATH:$HOME/dotfiles/bin
export LANG=ja_JP.UTF-8
export EDITOR=/usr/bin/vi
export PAGER=/usr/bin/less

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

alias q='exit'
alias cls='clear'
alias gd='git diff'
alias gs='git status'

alias p='clear; prove -Ilib -r'
alias pl='clear; prove -Ilib -r 2>&1 | less '
alias sv="supervisorctl"

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

#if [ -f ~/.ssh/id_dsa -a "$TERM" != "screen" ]; then
#	keychain ~/.ssh/id_dsa
#	source ~/.keychain/$HOST-sh
#fi

setopt auto_cd
setopt correct
setopt list_packed
setopt prompt_subst
setopt share_history 

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

function precmd() {
    #$HOME/bin/precmd.pl `history -n -1 | head -1`
}

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
