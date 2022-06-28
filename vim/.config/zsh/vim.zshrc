# default to nvim
alias vi='nvim'
alias vim='nvim'

# vanilla vim
alias vvim='vim -u NONE -N'

# update vim plug and all plugins
alias vim-upgrade="vim -c PlugUpgrade -c qall && vim -c PlugUpdate -c only -c PlugDiff -c CocUpdate"

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
