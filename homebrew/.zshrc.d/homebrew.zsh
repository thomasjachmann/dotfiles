function brew-update() {
  brew update
  echo "\033[1;34m==>\033[1;39m Outdated Formulae\033[0m"
  brew outdated
}
