autoload -U colors;   colors
autoload -U compinit; compinit -u

bindkey -e emacs

DEF="$reset_color"
PROMPT="
%{$fg[green]%}%/%{$DEF%} on %{$fg[cyan]%}%M%{$DEF%} %{$fg[magenta]%}(local)%{$DEF%}
%{$fg[yellow]%}%n%{$DEF%} %# "
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

source ~/perl5/perlbrew/etc/bashrc

export PATH=$PATH:$HOME/dotfiles/bin
export LANG=ja_JP.UTF-8
export EDITOR=/usr/bin/vi
export PAGER=/usr/bin/less

alias q='exit'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias cls='clear'
alias ss='svn st'
alias sd='svn diff'
alias dl='svn diff | less -r'
alias gd='git diff'
alias gs='git status'

alias p='clear; prove -Ilib -r'
alias pl='clear; prove -Ilib -r 2>&1 | less '
alias clean_swap="rm $HOME/.swap/*"

if [ -f ~/dotfiles/zsh/`uname -n`.zsh ]; then
	source ~/dotfiles/zsh/`uname -n`.zsh
fi

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
