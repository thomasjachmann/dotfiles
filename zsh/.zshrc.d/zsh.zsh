alias reload="say-and-execute source ~/.zshrc"
function edit() {
  if [[ "$1" != "" && -f ~/.zshrc.d/$1.zsh ]]; then
    say-and-execute subl --new-window ~/.zshrc.d/$1.zsh
  else
    say-and-execute subl --new-window ~/.zshrc ~/.zshrc.d ~/.oh-my-zsh
  fi
}

# see http://www.commandlinefu.com/commands/view/6533/print-all-256-colors-for-testing-term-or-for-a-quick-reference
# see http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
alias print-colors='( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )'
