alias vkittywin="kitten @ launch --type=os-window --env "ZDOTDIR=$ZDOTDIR" -- $HOMEBREW_PREFIX/bin/zsh"
alias vkittytab="kitten @ launch --type=tab --env "ZDOTDIR=$ZDOTDIR" -- $HOMEBREW_PREFIX/bin/zsh"
alias vkittyh="kitten @ launch --location=hsplit --env "ZDOTDIR=$ZDOTDIR" -- $HOMEBREW_PREFIX/bin/zsh"
alias vkittyv="kitten @ launch --location=vsplit --env "ZDOTDIR=$ZDOTDIR" -- $HOMEBREW_PREFIX/bin/zsh"

function overmindwin() {
  overmind start -D
  vkittywin -c "cd $PWD && overmind connect $1"
}
