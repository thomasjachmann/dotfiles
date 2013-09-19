function stow-add() {
  local dir=`dirname $1`
  mkdir -p ~/.dotfiles/$2/$dir
  mv $1 ~/.dotfiles/$2/$1
  pushd ~/.dotfiles
  stow $2
  popd
}
