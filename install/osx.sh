#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

sudo echo "This script requires root privileges."

$repo_root/install/brew.sh || echo "Proceeding despite some brew failures"
$repo_root/install/misc.sh
$repo_root/install/profile.sh
$repo_root/install/fonts.sh
$repo_root/install/vim.sh
$repo_root/install/conda.sh
$repo_root/install/git.sh
$repo_root/install/hammerspoon.sh
$repo_root/install/tmux.sh
$repo_root/install/ssh.sh
$repo_root/install/rust.sh

ln -sf /usr/bin/python3 /usr/local/bin/python
python -m ensurepip
python -m pip install --upgrade pip
python -m pip install neovim
