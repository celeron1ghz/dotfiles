##
## perl
##
PLENV_DIR=$HOME/.plenv
export PATH="$PATH:$PLENV_DIR/bin"

if [ "`command -v plenv`" = "" ]; then
  git clone https://github.com/tokuhirom/plenv.git $PLENV_DIR
  git clone https://github.com/tokuhirom/Perl-Build.git $PLENV_DIR/plugins/perl-build/
fi

eval "$(plenv init -)"
