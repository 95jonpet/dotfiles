#!/bin/bash
# Configure file listings using eza or exa.
# See https://github.com/eza-community/eza for further reference.

if command -v eza &> /dev/null; then
  alias ls="eza"
  alias l="eza -la --icons=always --group-directories-first"
  alias t="eza --tree --icons=always"
elif command -v exa &> /dev/null; then
  alias ls="exa"
  alias l="exa -la --icons=always"
  alias t="exa --tree --icons=always"
fi
