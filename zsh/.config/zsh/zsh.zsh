alias reload="say-and-execute source ~/.zshrc"
function edit() {
  if [[ "$1" != "" && -f ~/.config/zsh/$1.zsh ]]; then
    say-and-execute vi ~/.config/zsh/$1.zsh
  else
    say-and-execute vi -p $(dirname $(grealpath $(which dotfiles)))/../.. -c "InitDir"
  fi
}

# http://www.danielmiessler.com/blog/enhancements-to-shell-and-vim-productivity#capslock
# http://geminstallthat.wordpress.com/2008/10/19/adding-vi-keybindings-to-irb-scriptconsole-mysql/
bindkey -v
bindkey '^R' history-incremental-search-backward

function mkcd() {
  mkdir -p $1 && cd $1
}

function beep() {
  local message=$1
  [[ "$message" == "" ]] && message="beeeeeeeeeep"
  osascript -e "tell application \"LaunchBar\" to display in large type \"$message\""
}
