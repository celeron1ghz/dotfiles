## init
bindkey -e emacs
eval "$(direnv hook zsh)"
direnv allow


## old shell setting
#PROMPT="
#%{$fg[green]%}%/%{$reset_color%} on %{$fg[cyan]%}%M%{$reset_color%}
#%{$fg[yellow]%}%n%{$reset_color%} %# "
#PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'


## variables
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export PATH=$PATH:$GOPATH/bin:~/Library/Python/3.6/bin

source ~/dotfiles/rc/general_env.sh

set rtp+=~/Library/Python/3.6/lib/python/site-packages/powerline/bindings/vim/
source ~/Library/Python/3.6/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

## source files
source ~/dotfiles/zsh_command/peco_ghq_src.zsh
source ~/dotfiles/zsh_command/peco_select_history.zsh

source ~/perl5/perlbrew/etc/bashrc
source /usr/local/share/zsh/site-functions/_aws


source ~/dotfiles/rc/aliases.sh
source ~/dotfiles/rc/zsh_settings.sh


## functions
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
