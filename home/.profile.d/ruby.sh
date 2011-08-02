alias sc="say-and-exit script/console"
alias scs="say-and-exit script/console -s"
alias ss="say-and-exit script/server"

alias r="say-and-exit rails"
alias rs="say-and-exit rails server"
alias rc="say-and-exit rails console"

function b() {
  say-and-exit bundle $* | grep -v 'Using '
}
alias bi="b install"
alias bu="b update"
alias bc="say-and-exit bundle console"
alias be="say-and-exit bundle exec"
alias bo="say-and-exit bundle open"

alias ru="say-and-exit rackup"

#function spec() {
#  if [ -f ./spec/spec.opts ]; then
#    /opt/local/bin/spec -O spec/spec.opts $1 $2 $3 $4 $5 $6 $7 $8 $9
#  else
#    /opt/local/bin/spec $1 $2 $3 $4 $5 $6 $7 $8 $9
#  fi
#}
