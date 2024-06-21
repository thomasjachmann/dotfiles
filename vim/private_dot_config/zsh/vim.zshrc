# vanilla vim and self contained profiles
function vvim() {
  if [[ $# == 0 ]]; then
    vim -u NONE -N
  else
    local profile=$1 && shift
    local profile_dir="$XDG_CONFIG_HOME/nvim-profiles/$profile"
    local nvim_dir="$profile_dir/nvim"

    if [ ! -d "$nvim_dir" ]; then
      if read -qs "CHOICE?Non-existant nvim profile, should I create \`${profile}\` now? (y/N) "; then
        mkdir -p "$nvim_dir"
      else
        return
      fi
    fi
    local init_file="$nvim_dir/init.vim"
    [[ ! -f "$init_file" ]] && init_file="$nvim_dir/init.lua"
    [[ ! -f "$init_file" ]] && touch "$init_file"

    XDG_CONFIG_HOME="$profile_dir" \
    XDG_CACHE_HOME="$profile_dir/.cache" \
    XDG_DATA_HOME="$profile_dir/.local/share" \
    XDG_STATE_HOME="$profile_dir/.local/state" \
    vim "$@"
  fi
}
function _vvim() {
  compadd $(fd -t d -d 1 "" $XDG_CONFIG_HOME/nvim-profiles/ -X printf '%s ' {/} 2>/dev/null)
}
compdef _vvim vvim

# open vim w/o parameter, with a file or a directory
function v() {
  if [ $# -eq 1 ]; then
    if [ -d $1 ]; then
      pushd $1 > /dev/null
      vim
      popd > /dev/null
    else
      vim $1
    fi
  else
    vim
  fi
}

# vimwiki
function wiki() {
  vim -c "call VimwikiOpen($1)"
}

function vimwiki() {
  if [ $# -eq 1 ]; then
    pushd $1 > /dev/null
    # TODO not working yet, still has three wikis from main init.vim instead of one from wiki specific init.vim
    vim -c "so init.vim" -c "call vimwiki#base#goto_index(1)"
    popd > /dev/null
  else
    wiki
  fi
}
