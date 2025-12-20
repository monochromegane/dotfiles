#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

MISE_BIN="${HOME}/.local/bin/mise"

function is_mise_exists() {
  command -v mise &>/dev/null
}

function install_mise() {
  if ! is_mise_exists; then
    curl https://mise.run | sh
  fi
}

function verify_mise() {
  "${MISE_BIN}" doctor
}

function install_mise_tools() {
  "${MISE_BIN}" install
}

function setup_mise() {
  echo
  echo "## Setup mise"
  echo

  install_mise
  verify_mise
  install_mise_tools
}

setup_mise
