function cpoisi() {
  local dir=`dirname $1`
  mkdir -p ~/platform/ruby/apps/oisi2/$dir
  cp -r ~/platform/ruby/apps/oisi/$1 ~/platform/ruby/apps/oisi2/$dir
}
