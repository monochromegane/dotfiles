#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

MINPAC_DIR="${HOME}/.config/vim/pack/minpac/opt/minpac"

function is_vim_exists() {
  command -v vim &>/dev/null
}

function is_minpac_installed() {
  [ -d "${MINPAC_DIR}" ]
}

function install_minpac() {
  git clone https://github.com/k-takata/minpac.git "${MINPAC_DIR}"
}

function setup_minpac() {
  echo
  echo "## Setup minpac"
  echo

  if ! is_vim_exists; then
    return
  fi

  if ! is_minpac_installed; then
    install_minpac
  fi
}

setup_minpac

