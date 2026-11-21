#!/bin/bash
# Customize and use neovim as default editor.

if ! command -v nvim &> /dev/null; then
  return 0
fi

export EDITOR=nvim
export VISUAL=nvim

alias vim=nvim
alias v=nvim
