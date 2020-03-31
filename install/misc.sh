#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

preferred_concourse_version=${PREFERRED_CONCOURSE_VERSION:-6.0.0}
preferred_algorand_version=${PREFERRED_ALGORAND_VERSION:-2.0.5}

function fly_cli() {
  mkdir -p tmp
  aria2c -o tmp/fly.tgz \
    https://github.com/concourse/concourse/releases/download/v${preferred_concourse_version}/fly-${preferred_concourse_version}-darwin-amd64.tgz
  tar -xzvf tmp/fly.tgz -C tmp

  mv tmp/fly /usr/local/bin/fly
  chmod +x /usr/local/bin/fly
}

function concourse_bin() {
  mkdir -p tmp
  aria2c -o tmp/concourse.tgz \
    https://github.com/concourse/concourse/releases/download/v${preferred_concourse_version}/concourse-${preferred_concourse_version}-darwin-amd64.tgz
  tar -xzvf tmp/concourse.tgz -C tmp


  mv tmp/concourse /usr/local/bin/concourse
  chmod +x /usr/local/bin/concourse
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
  sh -c "$(curl -fsSL \
    https://raw.githubusercontent.com/ships/oh-my-zsh/master/tools/install.sh
  )"
}

function update_screencap_location {
  defaults write com.apple.screencapture location "$(cd ~/Downloads && pwd)"
  killall SystemUIServer
}

oh_my_zsh
algorand_bin
fly_cli
concourse_bin
update_screencap_location

