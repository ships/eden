#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

function install_rustup() {
  curl https://sh.rustup.rs -sSf | sh
}

install_rustup
