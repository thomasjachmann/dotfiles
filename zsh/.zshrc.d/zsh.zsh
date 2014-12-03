alias reload="say-and-execute source ~/.zshrc"
function edit() {
  if [[ "$1" != "" && -f ~/.zshrc.d/$1.zsh ]]; then
    say-and-execute mvim ~/.zshrc.d/$1.zsh
  else
    say-and-execute mvim -p ~/.dotfiles -c "InitDir"
  fi
}

# http://www.danielmiessler.com/blog/enhancements-to-shell-and-vim-productivity#capslock
# http://geminstallthat.wordpress.com/2008/10/19/adding-vi-keybindings-to-irb-scriptconsole-mysql/
bindkey -v
bindkey '^R' history-incremental-search-backward

function mkcd() {
  mkdir -p $1 && cd $1
}
