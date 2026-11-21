#!/bin/bash
# Configure file listings using eza or exa.
# See https://github.com/eza-community/eza for further reference.

if command -v eza &> /dev/null; then
  alias ls="eza"
  alias l="eza -la --icons"
  alias t="eza --tree --icons"
elif command -v exa &> /dev/null; then
  alias ls="exa"
  alias l="exa -la --icons"
  alias t="exa --tree --icons"
fi
