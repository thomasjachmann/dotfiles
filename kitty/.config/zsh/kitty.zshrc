alias vkittywin="kitty @ launch --type=os-window --env "ZDOTDIR=$ZDOTDIR" -- /usr/local/bin/zsh"
alias vkittytab="kitty @ launch --type=tab --env "ZDOTDIR=$ZDOTDIR" -- /usr/local/bin/zsh"
alias vkittyh="kitty @ launch --location=hsplit --env "ZDOTDIR=$ZDOTDIR" -- /usr/local/bin/zsh"
alias vkittyv="kitty @ launch --location=vsplit --env "ZDOTDIR=$ZDOTDIR" -- /usr/local/bin/zsh"

function overmindwin() {
  overmind start -D
  vkittywin -c "cd $PWD && overmind connect $1"
}
