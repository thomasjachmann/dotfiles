export DYLD_LIBRARY_PATH="/usr/local/oracle/instantclient_10_2"
export SQLPATH="/usr/local/oracle/instantclient_10_2"
export TNS_ADMIN="/usr/local/oracle/network/admin"
export NLS_LANG="AMERICAN_AMERICA.UTF8"
export PATH=$PATH:$DYLD_LIBRARY_PATH

function bcd() {
  cd ~/platform/ruby/apps/$1
}

function bcp() {
  local dir=`dirname $1`
  mkdir -p "$HOME/platform/ruby/apps/oisi2/$dir"
  cp -r "$HOME/platform/ruby/apps/oisi/$1" "$HOME/platform/ruby/apps/oisi2/$dir"
}
