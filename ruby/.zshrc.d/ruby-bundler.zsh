function b() {
  say-and-execute bundle $* | grep -v 'Using '
}
alias bi="b install --path=.bundle/gems"
alias bu="b update"
alias bc="say-and-execute bundle console"
alias be="say-and-execute bundle exec"
alias bl="say-and-execute bundle list"
alias bo="say-and-execute bundle open"
