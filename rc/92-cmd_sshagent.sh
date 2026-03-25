if [ "`command -v ssh-agent`" = "" ]; then
  echo "ssh-agent not found...";
else
  conf="$HOME/.ssh_agent_env"
  touch $conf

  if [ $(ps ax | grep '[s]sh-agent' | wc -l) -eq 0 ] ; then
    echo "ssh-agent is not running. invoking..."
    AGENT_RET=`ssh-agent`
    echo $AGENT_RET > $conf
  fi

  . $conf
fi
