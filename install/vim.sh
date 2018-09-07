#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

curl vimfiles.luan.sh/install | bash

ln -sf /usr/local/bin/{n,}vim
