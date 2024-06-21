function bcd() {
  cd ~/platform/ruby/apps/$1 &>/dev/null || cd ~/platform/ruby/gems/$1
}

function bcp() {
  local dir=`dirname $1`
  mkdir -p "$HOME/platform/ruby/apps/csc/$dir"
  cp -r "$HOME/platform/ruby/apps/oisi/$1" "$HOME/platform/ruby/apps/csc/$dir"
}
