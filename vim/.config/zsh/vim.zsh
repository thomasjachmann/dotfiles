export EDITOR='nvim -f'
export BUNDLER_EDITOR='tabvim'

# default to nvim
alias vi='nvim'
alias vim='nvim'

# vanilla vim
alias vvim='vim -u NONE -N'

function v() {
  if [ $# -eq 1 ]; then
    pushd $1 > /dev/null
    vim
    popd > /dev/null
  else
    vim
  fi
}
