if [ ! -f ~/.local_lib ]; then
    echo "local::lib's cache is not exist, creating..."
    perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5 > ~/.local_lib
fi

source ~/.local_lib
