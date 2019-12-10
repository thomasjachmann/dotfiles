export EDITOR='nvim -f'
export BUNDLER_EDITOR='tabvim'

# default to nvim
alias vi='nvim'
alias vim='nvim'

# vanilla vim
alias vvim='vim -u NONE -N'

# update vim plug and all plugins
alias vim-upgrade="nvim -c PlugUpgrade -c qall && nvim -c PlugUpdate"

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
  # TODO change cwd to wiki's base dir after select
  if [ $# -eq 1 ]; then
    vim -c "call vimwiki#base#goto_index($1)"
  else
    vim -c "VimwikiUISelect"
  fi
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
