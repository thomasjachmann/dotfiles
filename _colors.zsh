function color  { echo -e "\033[$1m$2\033[0m"; }
function green  { color "0;32" "$1"; }
function yellow { color "1;33" "$1"; }
function red    { color "0;31" "$1"; }
