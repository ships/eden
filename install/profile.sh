#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

ln -sf "$repo_root/profile/zshrc" ~/.zshrc
ln -sf "$repo_root/profile/zprofile" ~/.zprofile
ln -sf "$repo_root/profile" ~/.eden

