alias reload="say-and-execute source ~/.zshrc"
function edit() {
  if [[ "$1" != "" && -f ~/.zshrc.d/$1.zsh ]]; then
    say-and-execute mvim ~/.zshrc.d/$1.zsh
  else
    say-and-execute mvim -p ~/.dotfiles -c "InitDir"
  fi
}
