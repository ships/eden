#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

ln -sf "${repo_root}/assets/dotvim" "$HOME/.vim"
ln -sf "${repo_root}/assets/dotvim" "$HOME/.config/nvim"

ln -sf /opt/homebrew/bin/nvim  /usr/local/bin/vim

