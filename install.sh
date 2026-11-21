#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
RPM_DEPENDENCIES=(
  bat
  eza
  fd-find
  fzf
  neovim
  ripgrep
  starship
  stow
  zoxide
)

# Install RPM dependencies.
if command -v dnf &>/dev/null; then
  dnf install "${RPM_DEPENDENCIES[@]}"
else
  echo "WARNING: dnf is not installed, dependencies must be installed manually."
fi

TARGET="${SUDO_HOME:-"${HOME}"}"
OWNER="${SUDO_USER:-"${USER}"}"
cd -- "${SCRIPT_DIR}/src"

prepare_stow_dir() {
  if [[ ! -e "$1" ]]; then
    mkdir "$1"
    chown "${OWNER}:${OWNER}" "$1"
  fi
}

prepare_stow_dir "${TARGET}/.bashrc.d"
prepare_stow_dir "${TARGET}/.config"

stow --target "${TARGET}/.bashrc.d" --dotfiles bashrc.d
stow --target "${TARGET}/.config" --dotfiles config
