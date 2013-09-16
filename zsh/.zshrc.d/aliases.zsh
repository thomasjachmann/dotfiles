alias cd..="cd .."
# don't use those since zsh can do cd .. by just doing .. and this breaks completion
# alias ..="cd .."
# alias ...="cd ../.."
# alias ....="cd ../../.."
# alias .....="cd ../../../.."
# alias ......="cd ../../../../.."
# alias .......="cd ../../../../../.."
# alias ........="cd ../../../../../../.."
# alias .........="cd ../../../../../../../.."
alias ls="ls -G"
alias ll="ls -l"
alias la="ls -la"
alias lh="ls -lah"
alias l="lh"
alias t="term -t"

alias reload="say-and-execute source ~/.zshrc"
function edit() {
  if [[ "$1" != "" && -f ~/.zshrc.d/$1.zsh ]]; then
    say-and-execute subl --new-window ~/.zshrc.d/$1.zsh
  else
    say-and-execute subl --new-window ~/.zshrc ~/.zshrc.d ~/.oh-my-zsh
  fi
}
