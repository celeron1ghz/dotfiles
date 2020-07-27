## WSL2 Setup

```
sudo apt update
sudo apt upgrade -y
sudo apt install ansible -y

# setup your private key...
cd ~
git clone git@github.com:celeron1ghz/dotfiles.git

cd dotfiles/
perl mk_aliases.pl

cd php/
ansible-playbook -vv init.yaml

chsh -s /usr/bin/zsh

## exit and new world...
```

## VSCode
 * Install `PHP Debug`
 * Click `create a launch.json file` link and select `PHP` and just save
 * Invoke debugger from debbuger tab
