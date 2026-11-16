#!/bin/bash
# Configure fuzzy finding using fzf.
# See https://github.com/junegunn/fzf for further reference.
if ! command -v fzf &> /dev/null; then
  return 0
fi

eval "$(fzf --bash)"

export FZF_DEFAULT_COMMAND="fd --type f"

# Preview file content using bat (https://github.com/sharkdp/bat).
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using wl-copy.
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window.
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# Options to fzf command.
export FZF_COMPLETION_OPTS='--border --info=inline'

# Options for path completion (e.g. vim **<TAB>).
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

# Options for directory completion (e.g. cd **<TAB>).
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

# Advanced customization of fzf options via _fzf_comprun function.
#  - The first argument to the function is the name of the command.
#  - You should make sure to pass the rest of the arguments ($@) to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "${command}" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'if [ -d {} ]; then ls --color=always | head -200; elif [ -f {} ]; then bat -n --color=always --line-range :500 {}; fi' "$@" ;;
  esac
}

if command -v fd &> /dev/null; then
  # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
  #  - The first argument to the function ($1) is the base path to start traversal
  #  - See the source code (completion.{bash,zsh}) for the details.
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd (https://github.com/sharkdp/fd) for listing directory candidates.
  #  - The first argument to the function ($1) is the base path to start traversal
  #  - See the source code (completion.{bash,zsh}) for the details.
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi
