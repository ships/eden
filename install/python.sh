#!/bin/bash

set -uxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

function install_uv() {
  uv --version || curl -LsSf https://astral.sh/uv/install.sh | sh
}

function install_neovim_system() {
  python3 -m ensurepip
  python3 -m pip install --upgrade pip
  python3 -m pip install --upgrade neovim
}

install_uv
install_neovim_system
