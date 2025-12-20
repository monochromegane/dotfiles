#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

function is_homebrew_exists() {
  command -v brew &>/dev/null
}

function install_homebrew() {
  if ! is_homebrew_exists; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

function opt_out_of_analytics() {
  brew analytics off
}

function update_brew() {
  brew update
}

function bundle_brew() {
  brew bundle --file="$HOME/.config/brew/Brewfile"
}

function set_path_brew() {
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

function setup_brew() {
  echo
  echo "## Setup brew"
  echo

  install_homebrew
  set_path_brew
  opt_out_of_analytics
  update_brew
  bundle_brew
}

setup_brew
