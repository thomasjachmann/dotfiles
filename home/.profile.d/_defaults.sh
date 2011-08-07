# for tar: exclude ._ files (Mac OS X extended attributes)
export COPYFILE_DISABLE=true

# for local executables
export PATH=$PATH:~/bin

# for aliases/functions - print out command before executing it
function say-and-execute() {
  echo "=> $*"
  $*
}

# export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a iTerm"'
export EDITOR="mate -w"
