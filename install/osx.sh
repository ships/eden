#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

$repo_root/install/brew.sh
$repo_root/install/misc.sh

