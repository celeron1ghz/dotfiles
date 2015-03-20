function open_pm_with_vim () {
    local CURRENT_DIRECTORY="$PWD/lib"

    if [[ ! -d "$CURRENT_DIRECTORY" ]]; then
        echo "\nThis command run on 'lib' directory exist on current directory"
        zle accept-line
        return
    fi

    find lib | grep '\.pm$' | peco | xargs sh -c 'vim "$0" < /dev/tty'
    zle clear-screen
}

zle -N open_pm_with_vim
bindkey '^X^F' open_pm_with_vim
