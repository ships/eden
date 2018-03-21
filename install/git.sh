#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

ln -s $repo_root/assets/gitconfig ~/.gitconfig
ln -s $repo_root/assets/git-authors ~/.git-authors
