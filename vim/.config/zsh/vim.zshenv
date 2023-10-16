export EDITOR='nvim -f'
export BUNDLER_EDITOR='tabvim'

# default to nvim
alias vi='nvim'
alias vim='nvim'

# update vim plug and all plugins
function vim-upgrade() {
  vim -c PlugUpgrade -c qall
  vim -c PlugUpdate -c only -c PlugDiff
}
