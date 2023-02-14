eval "$(/usr/local/bin/rtx activate zsh)"

# local light=7 # see prompt.zsh
RPROMPT='%{%F{$light}%}$(rtx current ruby)%{%b%f%k%}'
