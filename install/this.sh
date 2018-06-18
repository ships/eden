# curl https://raw.githubusercontent.com/jraqula/eden/master/install/this.sh | bash

set -eux

mkdir ~/workspace
cd ~/workspace

git clone https://github.com/jraqula/eden
cd eden

install/osx.sh
