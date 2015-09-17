# export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a iTerm"'
# export EDITOR='mvim -f -c "au VimLeave * maca hide:"'
export EDITOR='nvim -f'
export BUNDLER_EDITOR='tabvim'

# vanilla vim
alias vvim='nvim -u NONE -N'

function v() {
  if [ $# -eq 1 ]; then
    pushd $1 > /dev/null
    mvim
    popd > /dev/null
  else
    mvim
  fi
}
