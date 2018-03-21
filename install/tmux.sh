#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

mkdir -p ~/.tmux

pushd ~/.tmux
  git clone git@github.com:luan/tmuxfiles config
  config/install
popd

