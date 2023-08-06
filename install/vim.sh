#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

ln -sf "${repo_root}/assets/dotvim" "$HOME/.vim"

ln -sf /usr/local/bin/{n,}vim

