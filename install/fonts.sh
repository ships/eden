#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

function repo_update() {
  pushd $repo_root
    git submodule update --init --recursive
  popd
}

function install_fonts() {
  pushd $repo_root
    vendor/github.com/powerline/fonts/install.sh
  popd
}

repo_update
install_fonts
