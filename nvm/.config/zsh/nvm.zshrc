# TODO This is slow!! So don't do it all the time, just when you need it. That's why it's a function.
function nvm_init() {
  export NVM_DIR=~/.nvm
  # source $(brew --prefix nvm)/nvm.sh
  source /usr/local/opt/nvm/nvm.sh
}
