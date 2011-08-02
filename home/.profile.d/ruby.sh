alias sc="say-and-execute script/console"
alias scs="say-and-execute script/console -s"
alias ss="say-and-execute script/server"

alias r="say-and-execute rails"
alias rs="say-and-execute rails server"
alias rc="say-and-execute rails console"

function b() {
  say-and-execute bundle $* | grep -v 'Using '
}
alias bi="b install"
alias bu="b update"
alias bc="say-and-execute bundle console"
alias be="say-and-execute bundle exec"
alias bo="say-and-execute bundle open"

alias ru="say-and-execute rackup"

#function spec() {
#  if [ -f ./spec/spec.opts ]; then
#    /opt/local/bin/spec -O spec/spec.opts $1 $2 $3 $4 $5 $6 $7 $8 $9
#  else
#    /opt/local/bin/spec $1 $2 $3 $4 $5 $6 $7 $8 $9
#  fi
#}
