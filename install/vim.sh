#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

ln -s "${repo_root}/assets/vimrc.local.before" "$HOME/.vimrc.local.before"
ln -s "${repo_root}/assets/vimrc.local" "$HOME/.vimrc.local"
ln -s "${repo_root}/assets/vimrc.local.plugins" "$HOME/.vimrc.local.plugins"

curl vimfiles.luan.sh/install | bash

ln -sf /usr/local/bin/{n,}vim
