#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"
find $repo_root/assets/defaults -type f | while read properties; do
  domain=$(basename $properties)
  plist="$(cat $properties)"
  defaults write $domain "'$plist'"
done
