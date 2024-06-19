function color  { echo -e "\033[$1m$2\033[0m"; }
function green  { color "0;32" "$1"; }
function yellow { color "1;33" "$1"; }
function red    { color "0;31" "$1"; }

function confirm {
  read -p "Continue (Y/n)? " choice
  if [ "$choice" == "n" ] || [ "$choice" == "N" ]; then
    exit 1
  fi
}

# see http://hints.macworld.com/article.php?story=20111226075701552
function loginitem {
  local name=$1
  local path=$2
  local hidden=${3:-false}
  if [ -n "$name" ] && [ -n "$path" ]; then
    osascript -e "tell application \"System Events\" to make login item at end with properties {name:\"$name:\", path:\"$path\", hidden:$hidden}"
    open -a $path
  fi
}

function homebrew_shellenv {
  eval $(brew shellenv 2>/dev/null ||
    /opt/homebrew/bin/brew shellenv 2>/dev/null ||
    /usr/local/bin/brew shellenv 2>/dev/null ||
    echo "echo \"\033[0;31mbrew cannot be found in one of the standard locations\033[0m\" 1>&2")
}
