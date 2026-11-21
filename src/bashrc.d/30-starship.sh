#!/bin/bash
# Configure bash prompt using starship.
# See https://starship.rs/guide/ for further reference.

if ! command -v starship &> /dev/null; then
  return 0
fi

eval "$(starship init bash)"
