alias reload="say-and-execute source ~/.zshrc"
function edit() {
  if [[ "$1" != "" && -f ~/.zshrc.d/$1.zsh ]]; then
    say-and-execute subl --new-window ~/.zshrc.d/$1.zsh
  else
    say-and-execute subl --new-window ~/.zshrc ~/.zshrc.d ~/.oh-my-zsh
  fi
}
