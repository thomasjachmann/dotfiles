# export EDITOR="mate -w"
# export GEM_EDITOR="mate"

function m() {
  if [[ $# == 1 ]]; then
    cd $1 || return $?
  fi
  $(mate && open ./*.tmproj) || mate .
}

function mg() {
  m $1
  gitx
}

function xmate() {
  echo "#!/usr/bin/env ruby" >> $1
  chmod 755 $1
  mate $1
}