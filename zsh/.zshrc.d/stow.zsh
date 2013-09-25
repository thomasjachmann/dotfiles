function stow-add() {
  local dir=`dirname "$1"`
  mkdir -p "$HOME/.dotfiles/$2/$dir"
  mv "$1" "$HOME/.dotfiles/$2/$1"
  pushd "$HOME/.dotfiles"
  stow $2
  popd
}
