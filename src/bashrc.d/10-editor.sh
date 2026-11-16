#!/bin/bash
# Customize text editors according to personal preference.

# Use neovim as default editor if available.
if command -v nvim &> /dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
  alias vim=nvim
fi
