#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

function fly_cli() {
  aria2c -o /usr/local/bin/fly \
    https://github.com/concourse/concourse/releases/download/v3.9.2/fly_darwin_amd64

  chmod +x /usr/local/bin/fly
}

function concourse_bin() {
  aria2c -o /usr/local/bin/concourse \
    https://github.com/concourse/concourse/releases/download/v3.9.2/concourse_darwin_amd64

  chmod +x /usr/local/bin/concourse
}

fly_cli
concourse_bin
