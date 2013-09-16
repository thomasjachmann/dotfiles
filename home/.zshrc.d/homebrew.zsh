PATH=/usr/local/bin:/usr/local/sbin:$PATH

# and for npm
PATH=/usr/local/share/npm/bin:$PATH

# source all files in /usr/local/etc/bash_completion.d (sorted alphabetically, no . files)
# these are homebrew's bash completion files
# for FILE in /usr/local/etc/bash_completion.d/*; do
#   source $FILE
# done

function brew-update() {
  brew update
  echo "\033[1;34m==>\033[1;39m Outdated Formulae\033[0m"
  brew outdated
}
