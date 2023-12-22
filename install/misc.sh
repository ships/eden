#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

preferred_concourse_version=${PREFERRED_CONCOURSE_VERSION:-7.0.0}
preferred_algorand_version=${PREFERRED_ALGORAND_VERSION:-2.4.1}

function concourse_bin() {
  mkdir -p tmp
  aria2c -o tmp/concourse.tgz \
    https://github.com/concourse/concourse/releases/download/v${preferred_concourse_version}/concourse-${preferred_concourse_version}-darwin-amd64.tgz
  tar -xzvf tmp/concourse.tgz -C tmp
  tar -xzvf tmp/concourse/fly-assets/fly-darwin-amd64.tgz -C tmp


  mv tmp/concourse/bin/concourse /usr/local/bin/concourse
  chmod +x /usr/local/bin/concourse

  mv tmp/fly /usr/local/bin/fly
  chmod +x /usr/local/bin/fly
}

function algorand_bin() {
  mkdir -p tmp
  aria2c -o tmp/algorand.tgz \
    https://github.com/algorand/go-algorand/releases/download/v${preferred_algorand_version}-stable/node_stable_darwin-amd64_${preferred_algorand_version}.tar.gz

  tar -xzvf tmp/algorand.tgz -C tmp/
  mkdir -p ~/algorand-node
  rm -rf ~/algorand-node/bin
  mv tmp/bin ~/algorand-node
}

function oh_my_zsh() {
  git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
  ln -sf $repo_root/assets/ships.zsh-theme ~/.oh-my-zsh/custom/themes
}

function update_screencap_location {
  defaults write com.apple.screencapture location "$(cd ~/Downloads && pwd)"
  killall SystemUIServer
}

function install_keydict {
  git submodule update --init
  bindings_dir="$HOME/Library/KeyBindings"
  mkdir -p "$bindings_dir"
  rm -f "$bindings_dir/DefaultKeyBinding.dict"
  ln -s "$repo_root/vendor/KeyBindings/DefaultKeyBinding.dict" "$bindings_dir/DefaultKeyBinding.dict"
}

oh_my_zsh
algorand_bin
concourse_bin
update_screencap_location
install_keydict

