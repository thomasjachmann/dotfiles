# export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a iTerm"'
# export EDITOR='mvim -f -c "au VimLeave * maca hide:"'
export EDITOR='vim -f'
export BUNDLER_EDITOR='mvim -c "InitDir"'

# vanilla vim
alias vvim='vim -u NONE -N'

function v() {
  if [ $# -eq 1 ]; then
    pushd $1 > /dev/null
    mvim
    popd > /dev/null
  else
    mvim
  fi
}
