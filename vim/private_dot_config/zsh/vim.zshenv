export EDITOR='nvim -f'
export BUNDLER_EDITOR='tabvim'

# HACK just to test this out more thoroughly before making the real switch
export NVIM_APPNAME="nvim-lazyvim"

# default to nvim
alias vi='nvim'
alias vim='nvim'

# update vim plug and all plugins
function vim-upgrade() {
  # HACK needed for the NVIM_APPNAME hack from above to still be able to upgrade the legacy vim
  NVIM_APPNAME="" vim -c PlugUpgrade -c qall
  NVIM_APPNAME="" vim -c PlugUpdate -c only -c PlugDiff
}
