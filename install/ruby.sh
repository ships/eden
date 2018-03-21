#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

function rubies() {
  cat $repo_root/lists/rubies | while read rubyv
  do
    ruby-install $rubyv
    chruby $rubyv

    gem install bundler
  done
}

rubies
