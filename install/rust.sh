#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

function install_rustup() {
  curl https://sh.rustup.rs -sSf | sh
}

function install_tools() {
  rustup component add rustfmt
  rustup component add clippy
}

install_rustup
