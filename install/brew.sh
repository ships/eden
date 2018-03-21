#!/bin/bash

set -euxo pipefail
repo_root="$(cd `dirname $0`/.. && pwd )"

function install_homebrew() {
  /usr/bin/ruby -e \
    "$( curl -fsSL \
        https://raw.githubusercontent.com/Homebrew/install/master/install
    )"
}

function taps() {
  cat $repo_root/lists/brew-tap | while read tap
  do
    brew tap $tap
  done
}

function casks() {
  cat $repo_root/lists/brew-cask | while read cask
  do
    brew cask install $cask
  done
}

function recipes() {
  cat $repo_root/lists/brew | while read recipe
  do
    brew install $recipe
  done
}


install_homebrew
casks
taps
recipes

