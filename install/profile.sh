#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

ln -sf "$repo_root/profile/zshrc" ~/.zshrc
ln -sf "$repo_root/profile" ~/.eden

open $repo_root/assets/eden.itermcolors

