#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

ln -s "${repo_root}/assets/clamd.conf" "/usr/local/etc/clamav/clamd.conf"
ln -s "${repo_root}/assets/freshclam.conf" "/usr/local/etc/clamav/freshclam.conf"

