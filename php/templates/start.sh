sudo service apache2 start
sudo service postgresql start

cd ~/dotfiles/php
ansible-playbook -vv init.yaml