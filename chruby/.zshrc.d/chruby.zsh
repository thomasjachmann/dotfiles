source `brew --prefix chruby`/share/chruby/chruby.sh
source `brew --prefix chruby`/share/chruby/auto.sh

function chruby-version() {
  chruby_auto
  local version=`chruby | grep '*' | sed 's/ \* //'`
  echo $version
}

local light=7 # see prompt.zsh
RPROMPT='%{%F{$light}%}$(chruby-version)%{%b%f%k%}'
