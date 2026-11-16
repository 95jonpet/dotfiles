#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
RPM_DEPENDENCIES=(
  bat
  fd-find
  fzf
  neovim
  stow
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

if [[ ! -e "${TARGET}/.config" ]]; then
  mkdir "${TARGET}/.config"
  chown "${OWNER}:${OWNER}" "${TARGET}/.config"
fi

stow --target "${TARGET}/.bashrc.d" --dotfiles bashrc.d
stow -vvv --target "${TARGET}/.config" --dotfiles config
