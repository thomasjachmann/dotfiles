eval "$(/usr/local/bin/mise activate zsh)"

# local light=7 # see prompt.zsh
RPROMPT='%{%F{$light}%}$(mise current ruby)%{%b%f%k%}'
