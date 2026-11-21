#!/bin/bash
# Configure WSL interaction.
if ! command -v wslinfo &> /dev/null; then
  return 0
fi

open() {
  explorer.exe "$(wslpath -wa "$1")"
}
