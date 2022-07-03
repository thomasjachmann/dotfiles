export LANG=C.UTF-8
export LC_ALL=$LANG

# for tar: exclude ._ files (Mac OS X extended attributes)
COPYFILE_DISABLE=true

# for aliases/functions - print out command before executing it
function say-and-execute() {
  >&2 echo "=> $*"
  $*
}

function find-broken-links() {
  for i in `find . -type l`; do
    [ -e $i ] || echo symbolic link $i is broken
  done
}
