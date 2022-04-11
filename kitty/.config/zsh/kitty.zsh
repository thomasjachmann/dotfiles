alias vkittywin="kitty @ launch --type=os-window /usr/local/bin/zsh --login --interactive"
alias vkittytab="kitty @ launch --type=tab /usr/local/bin/zsh --login --interactive"
alias vkittyh="kitty @ launch --location=hsplit /usr/local/bin/zsh --login --interactive"
alias vkittyv="kitty @ launch --location=vsplit /usr/local/bin/zsh --login --interactive"

function overmindwin() {
  overmind start -D
  vkittywin -c "cd $PWD && overmind connect $1"
}
