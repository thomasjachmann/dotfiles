alias reload="say-and-execute source ~/.zshrc"
function edit() {
  if [[ "$1" != "" && -f ~/.config/zsh/$1.zsh ]]; then
    say-and-execute vi ~/.config/zsh/$1.zsh
  else
    say-and-execute vi -p $(dirname $(grealpath $(which dotfiles)))/../.. -c "InitDir"
  fi
}

# Send escape sequence to terminal even if running tmux which usually swallows these
# http://vi.stackexchange.com/questions/3379/cursor-shape-under-vim-tmux
#function terminal-escape() {
#  if [ -n "$TMUX" ]; then
#    print -n -- "\e[Ptmux;\e[$1\e[\\"
#  else
#    print -n -- $1
#  fi
#}
# D'OH! Doesn't seem necessary...

# http://www.danielmiessler.com/blog/enhancements-to-shell-and-vim-productivity#capslock
# http://geminstallthat.wordpress.com/2008/10/19/adding-vi-keybindings-to-irb-scriptconsole-mysql/
#
# Activate vi key bindings (with cursor indicator)
bindkey -v
# http://unix.stackexchange.com/questions/547/make-my-zsh-prompt-show-mode-in-vi-mode
# http://reza.jelveh.me/2011/09/18/zsh-tmux-vi-mode-cursor
# http://vi.stackexchange.com/questions/3379/cursor-shape-under-vim-tmux
# http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
# use cursor as indicator of vi mode
# TODO fix it for VIM
#zle-keymap-select () {
#  case $KEYMAP in
#    vicmd) # command mode => block cursor
#      print -n -- "\e[2 q"
#      ;;
#    viins|main) # insert mode => vertical line cursor
#      print -n -- "\e[6 q"
#      ;;
#  esac
#}
#zle -N zle-keymap-select

# initialize cursor for insert mode
zle-line-init () {
  zle -K viins
}
zle -N zle-line-init

# activate zmv mass renaming
autoload -U zmv

# Reactivate Ctrl-R search in vi mode
bindkey '^R' history-incremental-search-backward

function limit-bandwidth() {
  sudo ipfw pipe $1 config bw 15KByte/s
  sudo ipfw add $1 pipe $1 src-port $1
  sudo ipfw add $1 pipe $1 dst-port $1
}
function unlimit-bandwidth() {
  sudo ipfw delete $1
}

function mkcd() {
  mkdir -p $1 && cd $1
}

function beep() {
  local message=$1
  [[ "$message" == "" ]] && message="beeeeeeeeeep"
  osascript -e "tell application \"LaunchBar\" to display in large type \"$message\""
}

function hide() {
  for file in "$@"; do
    mv $file $(dirname $file)/.$(basename $file)
  done
}

function unhide() {
  for file in "$@"; do
    mv $file $(dirname $file)/${$(basename $file)#.}
  done
}

# taken from the homebrew zsh install info
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help
