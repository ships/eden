#!/bin/bash

# Set options for the script
set -euxo pipefail

# Get the root directory of the repository
repo_root="$(cd `dirname $0`/.. && pwd )"

# Function to install Homebrew
function install_homebrew() {
  /usr/bin/ruby -e \
    "$( curl -fsSL \
        https://raw.githubusercontent.com/Homebrew/install/master/install
    )"
}

# Function to install Homebrew packages and apps from a Brewfile
function brewbundle() {
  pushd "$repo_root/assets"
    brew bundle -v
  popd
}

# Function to add Homebrew taps
function taps() {
  cat $repo_root/lists/brew-tap | while read tap
  do
    brew tap $tap
  done
}

# Function to install Homebrew casks
function casks() {
  cat $repo_root/lists/brew-cask | while read cask
  do
    brew cask install $cask
  done
}

# Function to install Homebrew recipes
function recipes() {
  cat $repo_root/lists/brew | while read recipe
  do
    brew install $recipe
  done
}

# Check if Homebrew is installed, if not, install it
which brew || install_homebrew

# Install Homebrew packages and apps from a Brewfile
brewbundle
