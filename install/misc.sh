#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

function fly_cli() {
  mkdir -p tmp
  aria2c -o tmp/fly \
    https://github.com/concourse/concourse/releases/download/v3.9.2/fly_darwin_amd64

  mv tmp/fly /usr/local/bin/fly
  chmod +x /usr/local/bin/fly
}

function concourse_bin() {
  mkdir -p tmp
  aria2c -o tmp/concourse \
    https://github.com/concourse/concourse/releases/download/v3.9.2/concourse_darwin_amd64


  mv tmp/concourse /usr/local/bin/concourse
  chmod +x /usr/local/bin/concourse
}

function oh_my_zsh() {
  sh -c "$(curl -fsSL \
    https://raw.githubusercontent.com/jraqula/oh-my-zsh/master/tools/install.sh
  )"
}

oh_my_zsh
fly_cli
concourse_bin

