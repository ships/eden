#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

ln -s "$repo_root/profile/zshrc" ~/.zshrc
ln -s "$repo_root/profile" ~/.eden_profile

