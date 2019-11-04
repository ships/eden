#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

preferred_concourse_version=${PREFERRED_CONCOURSE_VERSION:-v4.2.3}

function fly_cli() {
  mkdir -p tmp
  aria2c -o tmp/fly \
    https://github.com/concourse/concourse/releases/download/${preferred_concourse_version}/fly_darwin_amd64

  mv tmp/fly /usr/local/bin/fly
  chmod +x /usr/local/bin/fly
}

function concourse_bin() {
  mkdir -p tmp
  aria2c -o tmp/concourse \
    https://github.com/concourse/concourse/releases/download/${preferred_concourse_version}/concourse_darwin_amd64


  mv tmp/concourse /usr/local/bin/concourse
  chmod +x /usr/local/bin/concourse
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
fly_cli
concourse_bin
update_screencap_location

