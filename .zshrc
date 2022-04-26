## init
bindkey -e emacs

for f in `find $HOME/dotfiles/rc/*.sh`; do
    #echo loading $f...
    source $f
done
