alias sc="be script/console"
alias scs="be script/console -s"
alias ss="be script/server"

alias r="be rails"
alias rs="be rails server"
alias rc="be rails console"

function b() {
  say-and-execute bundle $* | grep -v 'Using '
}
alias bi="b install --path=.bundle/gems"
alias bu="b update"
alias bc="say-and-execute bundle console"
alias be="say-and-execute bundle exec"
alias bl="say-and-execute bundle list"
alias bo="say-and-execute bundle open"

alias ru="say-and-execute rackup"

#function spec() {
#  if [ -f ./spec/spec.opts ]; then
#    /opt/local/bin/spec -O spec/spec.opts $1 $2 $3 $4 $5 $6 $7 $8 $9
#  else
#    /opt/local/bin/spec $1 $2 $3 $4 $5 $6 $7 $8 $9
#  fi
#}
