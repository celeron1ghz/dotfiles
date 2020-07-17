## init
bindkey -e emacs

for f in `find $HOME/dotfiles/rc/*`; do
    #echo loading $f...
    source $f
done
