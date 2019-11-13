function maintain() {
  sudo periodic daily weekly monthly
  # TODO clean up log files/caches manually?
  brew cleanup -s
}
