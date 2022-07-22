#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

rm -f $HOME/.condarc
ln -s "${repo_root}/assets/condarc" "$HOME/.condarc"

