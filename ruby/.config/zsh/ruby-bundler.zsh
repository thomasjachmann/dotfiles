function _bundle_command () {
  if [ -e "bin/bundle" ]; then
    bin/bundle $@
  else
    bundle $@
  fi
}
alias bundle='_bundle_command'
#compdef _bundle_command=bundle

function b() {
  say-and-execute _bundle_command $* | grep -v 'Using '
}
alias bi="b install --path=.bundle/gems"
alias bu="b update"
alias bc="say-and-execute _bundle_command console"
alias be="say-and-execute _bundle_command exec"
alias bl="say-and-execute _bundle_command list"
alias bo="say-and-execute _bundle_command open"
