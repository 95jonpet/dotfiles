#!/bin/bash
# Configure directory traversal using zoxide.
# See https://github.com/ajeetdsouza/zoxide for further reference.
if ! command -v zoxide &> /dev/null; then
  return 0
fi

eval "$(zoxide init bash --cmd cd)"
