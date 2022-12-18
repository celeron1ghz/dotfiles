##
## node.js
##
NODE_DIR=$HOME/.nodenv
export PATH="$PATH:$NODE_DIR/bin"

if [ "`command -v nodenv`" = "" ]; then
  echo "installing nodenv..."
  git clone https://github.com/nodenv/nodenv.git $NODE_DIR
  mkdir -p $NODE_DIR/plugins
  git clone https://github.com/nodenv/node-build.git $NODE_DIR/plugins/node-build
fi

eval "$(nodenv init -)"
