# #compdef rails
function _rails_command () {
  if [ -e "bin/rails" ]; then
    bin/rails $@
  elif [ -e "script/rails" ]; then
    ruby script/rails $@
  elif [ -e "script/server" ]; then
    ruby script/$@
  else
    command rails $@
  fi
}
alias rails='_rails_command'
# compdef _rails_command=rails

alias rc="_rails_command c"
alias rs="_rails_command s"

# #compdef rake
function _rake_command () {
  if [ -e "bin/rake" ]; then
    bin/rake $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ]; then
    bundle exec rake $@
  else
    command rake $@
  fi
}
alias rake='noglob _rake_command'
# compdef _rake_command=rake

# #compdef bundle
function _bundle_command () {
  if [ -e "bin/bundle" ]; then
    bin/bundle $@
  else
    bundle $@
  fi
}
alias bundle='_bundle_command'
# compdef _bundle_command=bundle

function b() {
  say-and-execute _bundle_command $* | grep -v 'Using '
}
alias bi="b install --path=.bundle/gems"
alias bu="b update"
alias bc="say-and-execute _bundle_command console"
alias be="say-and-execute _bundle_command exec"
alias bl="say-and-execute _bundle_command list"
alias bo="say-and-execute _bundle_command open"
