# curl https://raw.githubusercontent.com/ships/eden/master/install/this.sh | bash

set -eux

mkdir -p ~/workspace
cd ~/workspace

git clone https://github.com/ships/eden
cd eden

install/osx.sh
