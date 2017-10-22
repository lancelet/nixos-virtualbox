#!/usr/bin/env bash

# "Safe" bash
set -euf -o pipefail

# Base directory of this script
base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
declare -r base_dir

# Log function
# Usage: log 'Message'
function log() {
  local msg="$1"
  echo "* install.sh: ${msg}"
}

# Silent pushd and popd
function spushd() {
  local dir="$1"
  pushd "$dir" > /dev/null
}
function spopd() {
  popd > /dev/null
}

# Copy across the base Nix configuration
log 'Copying across base Nix configuration (sudo required)'
sudo -i ln -fs "$base_dir/configuration.nix" '/etc/nixos/configuration.nix'

# Install oh-my-zsh
omzdir="$HOME/.oh-my-zsh"
declare -r omzdir
if [ ! -d "$omzdir" ]; then
  log "$omzdir was not found; installing oh-my-zsh"
  git clone git://github.com/robbyrussell/oh-my-zsh.git "$omzdir"
else
  log "$omzdir exists; updating with a git pull"
  spushd "$omzdir"
  git pull --quiet
  spopd
fi

# Linking zshrc
log 'Linking zshrc'
ln -fs "$base_dir/zshrc" "$HOME/.zshrc"

# Install zsh astronaut theme
export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
log 'Installing / updating zsh astronaut theme'
spushd "$ZSH_CUSTOM"
rm -f spaceship.zsh-theme
curl -s -o spaceship.zsh-theme https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/spaceship.zsh
spopd
