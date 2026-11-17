#!/bin/bash
# Configure file/directory searching using ripgrep.
# See https://github.com/BurntSushi/ripgrep for further reference.
if ! command -v rg &> /dev/null; then
  return 0
fi

. <(rg --generate complete-bash)
